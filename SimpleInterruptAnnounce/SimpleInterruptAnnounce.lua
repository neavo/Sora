--[[-------------------------------------------------------------------------
-- Simple Interrupt Announce
--
-- Copyright 2011-2019 BeathsCurse (Bowmore - Silvermoon EU)
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-------------------------------------------------------------------------]]--

local addonName, addon = ...
addon.version = GetAddOnMetadata(addonName, 'Version')

-- Expose our addon table through a global variable
_G[addonName] = addon

-- Configuration table with default values
-- Note: Valid values for own and other are: off, self, say, party, raid,
-- and instance (which work depends on status).
addon.cfg = {
	cfgversion = 1,
	isEnabled = true,
	soundOwn = '',
	soundOther = '',
	-- When solo, how to announce your own interrupts and those of others
	solo = { own = 'self', other = 'off' },
	-- When in an instance group
	instance = { own = 'self', other = 'self' },
	-- When in a party
	party = { own = 'self', other = 'self' },
	-- When in a raid
	raid = { own = 'say', other = 'self' },
}

-- Create frame for handling events
addon.frame = CreateFrame('Frame', addonName .. 'Frame')
addon.frame:Hide()

-- Local shorthands for accessing the configuration and frame
local cfg = addon.cfg
local frame = addon.frame

-- Function to enable addon
function addon:Enable()
	if not self.cfg.isEnabled then
		self.cfg.isEnabled = true
		self.frame:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
	end
end

-- Function to disable addon
function addon:Disable()
	if self.cfg.isEnabled then
		self.cfg.isEnabled = false
		self.frame:UnregisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
	end
end

-- Table for looking up raid icon id from destFlags
local raidIconLookup = {
	[COMBATLOG_OBJECT_RAIDTARGET1]=1,
	[COMBATLOG_OBJECT_RAIDTARGET2]=2,
	[COMBATLOG_OBJECT_RAIDTARGET3]=3,
	[COMBATLOG_OBJECT_RAIDTARGET4]=4,
	[COMBATLOG_OBJECT_RAIDTARGET5]=5,
	[COMBATLOG_OBJECT_RAIDTARGET6]=6,
	[COMBATLOG_OBJECT_RAIDTARGET7]=7,
	[COMBATLOG_OBJECT_RAIDTARGET8]=8,
}

-- Strings used to insert a raid icon in message to self
local raidIconMsgStrings = {
	'|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1.blp:0|t',
	'|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2.blp:0|t',
	'|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3.blp:0|t',
	'|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4.blp:0|t',
	'|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5.blp:0|t',
	'|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6.blp:0|t',
	'|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7.blp:0|t',
	'|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8.blp:0|t',
}

-- Strings used to insert a raid icon in chat message
local raidIconChatStrings = {
	'{rt1}', '{rt2}', '{rt3}', '{rt4}',
	'{rt5}', '{rt6}', '{rt7}', '{rt8}',
}

-- Table for looking up compact modes
local compactModeLookup = {
	o='off',
	m='self',
	s='say',
	p='party',
	r='raid',
	i='instance',
}

-- Variables used to prevent flooding on AoE interrupts
local lastTime, lastSpellID

-- Local names for globals used in CLEU handler
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local GetSpellLink = GetSpellLink
local IsInGroup = IsInGroup
local IsInRaid = IsInRaid
local PlaySoundFile = PlaySoundFile
local UnitClass = UnitClass
local UnitCreatureFamily = UnitCreatureFamily
local UnitName = UnitName

-- Update configuration table
-- Note: Assumes all keys are simple and values are tables or simple.
-- Will overwrite a non-table with a table, but not the other way around.
local function UpdateCfg(dst, src)
	for k, v in pairs(src) do
		if type(v) == 'table' then
			if type(dst[k]) == 'table' then
				-- Update a table with a table
				UpdateCfg(dst[k], v)
			else
				-- Overwrite a value with a table
				dst[k] = UpdateCfg({}, v)
			end
		elseif type(dst[k]) ~= 'table' then
			-- Update a value with a value
			dst[k] = v
		end
	end
	return dst
end

-- Split a string into whitespace delimited parts and return them as a list
-- Note: Simple and slow, but we only use it to parse the slash commands.
local function SplitString(s)
	local t = {}
	-- Loop over matches of non-whitespace sequences in s, adding them to t
	for w in s:gmatch('%S+') do
		t[#t + 1] = w
	end
	return unpack(t)
end

-- Create possessive form by appending 's to the string, unless it ends
-- with s, x, or z, in which case only ' is added.
local function StringOwns(s)
	if s:sub(-1):find('[sxzSXZ]') then
		return s .. '\''
	else
		return s .. '\'s'
	end
end

-- Get name of player
-- Note: We cannot read the name into a local variable on load since
-- UnitName may return UNKNOWNOBJECT until the player has fully loaded.
-- We could potentially use the GUID instead.
local GetPlayerName
do
	local playerName

	function GetPlayerName()
		if not playerName then
			local a = UnitName('player')
			if a and a ~= UNKNOWNOBJECT then
				playerName = a
			end
		end
		return playerName
	end
end

-- Get spell link for a spellID
local GetSpellLinkCached
do
	local spellLinkCache = {}

	function GetSpellLinkCached(spellID)
		local a = spellLinkCache[spellID]
		if not a then
			a = GetSpellLink(spellID)
			spellLinkCache[spellID] = a
		end
		return a
	end
end

-- Get string for raid icon based on chat mode
local function GetRaidIconString(raidIcon, mode)
	local s = ''

	if raidIcon then
		if mode == 'self' then
			s = raidIconMsgStrings[raidIcon]
		else
			s = raidIconChatStrings[raidIcon]
		end
	end

	return s
end

-- Event dispatcher
frame:SetScript('OnEvent', function(self, event, ...)
	local a = self[event]
	if a then
		a(self, ...)
	end
end)

-- Perform actions once all saved variables are loaded
function frame:ADDON_LOADED(name)
	if name ~= addonName then return end

	-- We do not have to be called for any further addons
	self:UnregisterEvent('ADDON_LOADED')

	-- Update current configuration table with saved
	if not SIACFG then SIACFG = {} end
	UpdateCfg(cfg, SIACFG)

	-- Register combat log event handling if announcing is on
	if cfg.isEnabled then
		self:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
	end
end

-- Perform actions as player is about to enter world
function frame:PLAYER_LOGIN()
	-- Add slash command
	SLASH_SIA1 = '/sia'
	SlashCmdList['SIA'] = function(msg)
		self:OnSlashCmd(SplitString((msg or ''):lower()))
	end
end

-- Perform actions as player is about to leave world
function frame:PLAYER_LOGOUT()
	-- Update saved configuration table with current
	UpdateCfg(SIACFG, cfg)
end

-- The actual combat log event handler
-- Note: Naming the args was faster than select, and Lua adjusts the number
-- of arguments automatically.
function frame:COMBAT_LOG_EVENT_UNFILTERED()
	local timeStamp, subEvent, _, _, sourceName, sourceFlags, _, _, destName, _, destRaidFlags, spellID, _, _, extraSpellID = CombatLogGetCurrentEventInfo()

	-- Check if event was a spell interrupt
	if subEvent ~= 'SPELL_INTERRUPT' then return end

	-- Check if time and ID was same as last
	-- Note: This is to prevent flooding announcements on AoE interrupts.
	if timeStamp == lastTime and spellID == lastSpellID then return end

	-- Update last time and ID
	lastTime, lastSpellID = timeStamp, spellID

	-- Figure out grouping status
	-- Note: Passing LE_PARTY_CATEGORY_INSTANCE to IsInGroup() and IsInRaid()
	-- appears to check if we are in a group assembled through the instance
	-- finder (LFG/LFR/BG/etc.), where the chat channel is now INSTANCE_CHAT.
	-- Passing LE_PARTY_CATEGORY_HOME checks if we are in a normal group. If
	-- you join the instance finder as a group, you will be in both the
	-- original group/raid and the instance group. Passing nothing checks for
	-- either.
	local inInstance = IsInGroup(LE_PARTY_CATEGORY_INSTANCE)
	local inGroup, inRaid = IsInGroup(), IsInRaid()

	local config

	-- Select config based on grouping status
	if inInstance then
		config = cfg.instance
	elseif inRaid then
		config = cfg.raid
	elseif inGroup then
		config = cfg.party
	else
		config = cfg.solo
	end

	-- Get id of raid icon on target, or nil if none
	local raidIcon = raidIconLookup[bit.band(destRaidFlags, COMBATLOG_OBJECT_RAIDTARGET_MASK)]

	-- Check if source was the player, player's pet, or other
	if sourceName == GetPlayerName() then
		-- If own is off for this config, return
		if config.own == 'off' then return end

		-- Announce interrupt
		self:AnnounceInterrupt(config.own, string.format('Interrupted %s%s %s', GetRaidIconString(raidIcon, config.own), StringOwns(destName or '?'), GetSpellLinkCached(extraSpellID)), cfg.soundOwn)
	elseif bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0 then
		-- If own is off for this config, return
		if config.own == 'off' then return end

		-- Announce interrupt
		self:AnnounceInterrupt(config.own, string.format('My %s interrupted %s%s %s', sourceName or '?', GetRaidIconString(raidIcon, config.own), StringOwns(destName or '?'), GetSpellLinkCached(extraSpellID)), cfg.soundOwn)
	else
		-- If other is off for this config, return
		if config.other == 'off' then return end

		-- Announce if source was a player/pet in our party/raid
		if (inRaid and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_RAID) ~= 0) or (inGroup and bit.band(sourceFlags, COMBATLOG_OBJECT_AFFILIATION_PARTY) ~= 0) then
			local name = sourceName or '?'

			-- Apply class color to name if announcing to self and source was a player
			if config.other == 'self' and bit.band(sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0 then
				local _, classFileName = UnitClass(name)
				name = '|c' .. RAID_CLASS_COLORS[classFileName or 'PRIEST'].colorStr .. name .. '|r'
			end

			self:AnnounceInterrupt(config.other, string.format('%s interrupted %s%s %s', name, GetRaidIconString(raidIcon, config.other), StringOwns(destName or '?'), GetSpellLinkCached(extraSpellID)), cfg.soundOther)
		end
	end
end

-- Register the events we handle
frame:RegisterEvent('ADDON_LOADED')
frame:RegisterEvent('PLAYER_LOGIN')
frame:RegisterEvent('PLAYER_LOGOUT')

-- Print with SIA prefix
function frame:Print(...)
	return print('|cFFF0F050SIA|r:', ...)
end

-- Formatted print with SIA prefix
function frame:Printf(s, ...)
	return print('|cFFF0F050SIA|r:', string.format(s, ...))
end

-- Announce message to self or channel based on mode
-- Note: mode has to be self, say, party, raid, or instance
function frame:AnnounceInterrupt(mode, msg, sound)
	if mode == 'self' then
		self:Print(msg)
	else
		-- If we are announcing to instance, change mode to INSTANCE_CHAT.
		if (mode == 'instance') then mode = 'INSTANCE_CHAT' end

		-- Here mode is say, party, raid, or INSTANCE_CHAT
		SendChatMessage(msg, mode:upper())
	end
	if sound ~= '' then
		PlaySoundFile(sound, 'MASTER')
	end
end

-- Print a line with own and other modes in config
function frame:PrintMode(mode, config)
	self:Printf('|cFF20E020%s|r modes: own -> |cFF20E020%s|r, other -> |cFF20E020%s|r', mode, config.own, config.other)
end

-- Update config with the modes from own and other
function frame:ParseCmdModes(cmd, config, own, other)
	-- Update own mode
	if own then
		if own == 'off' then
			config.own = 'off'
		elseif own == 'self' then
			config.own = 'self'
		elseif own == 'say' then
			config.own = 'say'
		elseif own == 'instance' and cmd == 'instance' then
			config.own = 'instance'
		elseif own == 'party' and (cmd == 'party' or cmd == 'raid') then
			config.own = 'party'
		elseif own == 'raid' and cmd == 'raid' then
			config.own = 'raid'
		else
			self:Print('invalid mode for |cFF20E020' .. cmd .. '|r own:', own)
			return
		end
	end

	-- Update other mode
	if other then
		if other == 'off' then
			config.other = 'off'
		elseif other == 'self' then
			config.other = 'self'
		elseif other == 'say' then
			config.other = 'say'
		elseif other == 'instance' and cmd == 'instance' then
			config.other = 'instance'
		elseif other == 'party' and (cmd == 'party' or cmd == 'raid') then
			config.other = 'party'
		elseif other == 'raid' and cmd == 'raid' then
			config.other = 'raid'
		else
			self:Print('invalid mode for |cFF20E020' .. cmd .. '|r other:', other)
			return
		end
	end
end

-- Update config with modes in compact form
function frame:ParseCompactCmdModes(cmd)
	if cmd:len() ~= 9 then
		self:Print('compact mode must contain 8 characters')
		return
	end
	self:ParseCmdModes('solo', cfg.solo, compactModeLookup[cmd:sub(2, 2)], compactModeLookup[cmd:sub(3, 3)])
	self:ParseCmdModes('instance', cfg.instance, compactModeLookup[cmd:sub(4, 4)], compactModeLookup[cmd:sub(5, 5)])
	self:ParseCmdModes('party', cfg.party, compactModeLookup[cmd:sub(6, 6)], compactModeLookup[cmd:sub(7, 7)])
	self:ParseCmdModes('raid', cfg.raid, compactModeLookup[cmd:sub(8, 8)], compactModeLookup[cmd:sub(9, 9)])
end

-- Slash command handler
function frame:OnSlashCmd(cmd, ...)
	if cmd == 'on' then
		-- Register combat log event handling to start announcing
		self:Print('Announce turned |cFF20E020on|r')
		addon:Enable()
	elseif cmd == 'off' then
		-- Unregister combat log event handling to stop announcing
		self:Print('Announce turned |cFFE02020off|r')
		addon:Disable()
	elseif cmd == 'solo' then
		self:ParseCmdModes(cmd, cfg.solo, ...)
		self:PrintMode(cmd, cfg.solo)
	elseif cmd == 'instance' then
		self:ParseCmdModes(cmd, cfg.instance, ...)
		self:PrintMode(cmd, cfg.instance)
	elseif cmd == 'party' then
		self:ParseCmdModes(cmd, cfg.party, ...)
		self:PrintMode(cmd, cfg.party)
	elseif cmd == 'raid' then
		self:ParseCmdModes(cmd, cfg.raid, ...)
		self:PrintMode(cmd, cfg.raid)
	elseif cmd and cmd:sub(1, 1) == '!' then
		self:ParseCompactCmdModes(cmd)
	elseif cmd == 'info' then
		-- Show a little profiling info
		UpdateAddOnMemoryUsage()
		local usedKB = GetAddOnMemoryUsage(addonName)
		self:Printf('Mem usage %.2f KB', usedKB)
		if GetCVar('scriptProfile') == '1' then
			UpdateAddOnCPUUsage()
			local addOnTime = GetAddOnCPUUsage(addonName)
			self:Printf('AddOn CPU usage %.2f (%.2f%%)', addOnTime, (100 * addOnTime) / GetScriptCPUUsage())
			local frameTime, frameCount = GetFrameCPUUsage(frame)
			self:Printf('Frame CPU usage %.2f in %d calls (%.4f per call)', frameTime, frameCount, frameTime / frameCount)
		end
	elseif cmd == 'help' then
		-- Show an explanation of status and modes
		self:Print('For each status (|cFF20E020solo instance party|r and |cFF20E020raid|r), own and')
		self:Print('other mode can be set to |cFF20E020off self say instance party|r or |cFF20E020raid|r.')
		self:Print('Own covers interrupts made by you or your pet, other covers')
		self:Print('interrupts made by any player or pet in your party/raid.')
		self:Print('Examples:')
		self:Print('  |cFF20E020/sia party|r - print current party modes')
		self:Print('  |cFF20E020/sia solo self|r - when solo, own interrupts to yourself')
		self:Print('  |cFF20E020/sia raid say self|r - when raid, own to say, others to self')
	else
		-- By default, show status and options
		self:Print(addonName, addon.version)
		self:Print('Syntax: /sia <command> [options]')
		self:Print('  |cFF20E020on/off|r - turn announcing on/off')
		self:Print('  |cFF20E020solo/instance/party/raid [own [other]]|r - set mode')
		self:Print('  |cFF20E020help|r - show more help')
		if cfg.isEnabled then
			self:Print('Announcing is |cFF20E020on|r')
		else
			self:Print('Announcing is |cFFE02020off|r')
		end
	end
end
