--[[ Home:header
# Element: Reputation

Adds support for an element that updates and displays the player's reputation and standing with a
tracked faction as a StatusBar widget.

## Widgets

- `Repuration`
	A statusbar which displays the player's current reputation with the tracked faction.
- `Reputation.Reward`
	An optional widget that is visible if the tracked faction has a pending reward.

## Options

- `inAlpha` - Alpha used when the mouse is over the element (default: `1`)
- `outAlpha` - Alpha used when the mouse is outside of the element (default: `1`)
- `tooltipAnchor` - Anchor for the tooltip (default: `"ANCHOR_BOTTOMRIGHT"`)

## Extras

- [Callbacks](Callbacks)
- [Overrides](Overrides)
- [Tags](Tags)

## Colors

This plug-in adds another color to `oUF.colors.reaction` for paragon support, after exalted.

## Notes

- A default texture will be applied if the element is a StatusBar and doesn't have a texture set.
- A default texture will be applied to the `Reward` sub-widget if it's a Texture and doesn't have a texture set.
- Tooltip and mouse interaction options are only enabled if the element is mouse-enabled.
- Remember to set the plug-in as an optional dependency for the layout if not embedding.

## Example implementation

```lua
-- Position and size
local Reputation = CreateFrame('StatusBar', nil, self)
Reputation:SetPoint('BOTTOM', 0, -50)
Reputation:SetSize(200, 20)
Reputation:EnableMouse(true) -- for tooltip/fading support

-- Position and size the Reward sub-widget
local Reward = Reputation:CreateTexture(nil, 'OVERLAY')
Reward:SetPoint('LEFT')
Reward:SetSize(20, 20)

-- Text display
local Value = Reputation:CreateFontString(nil, 'OVERLAY')
Value:SetAllPoints(Reputation)
Value:SetFontObject(GameFontHighlight)
self:Tag(Value, '[reputation:cur] / [reputation:max]')

-- Add a background
local Background = Reputation:CreateTexture(nil, 'BACKGROUND')
Background:SetAllPoints(Reputation)
Background:SetTexture('Interface\\ChatFrame\\ChatFrameBackground')

-- Register with oUF
self.Reputation = Reputation
self.Reputation.Reward = Reward
```
--]]
local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'oUF Reputation was unable to locate oUF install')

local function GetReputation()
	local pendingReward
	local name, standingID, min, max, cur, factionID = GetWatchedFactionInfo()

	local friendID, _, _, _, _, _, standingText, _, nextThreshold = GetFriendshipReputation(factionID)
	if(friendID) then
		if(not nextThreshold) then
			min, max, cur = 0, 1, 1 -- force a full bar when maxed out
		end
		standingID = 5 -- force friends' color
	else
		local value, nextThreshold, _, hasRewardPending = C_Reputation.GetFactionParagonInfo(factionID)
		if(value) then
			cur = value % nextThreshold
			min = 0
			max = nextThreshold
			pendingReward = hasRewardPending
			standingID = MAX_REPUTATION_REACTION + 1 -- force paragon's color
			standingText = PARAGON
		end
	end

	max = max - min
	cur = cur - min
	-- cur and max are both 0 for maxed out factions
	if(cur == max) then
		cur, max = 1, 1
	end
	standingText = standingText or GetText('FACTION_STANDING_LABEL' .. standingID, UnitSex('player'))

	return cur, max, name, factionID, standingID, standingText, pendingReward
end

--[[ Tags:header
A few basic tags are included:
- `[reputation:cur]`      - the player's current reputation with the faction
- `[reputation:max]`      - the player's maximum reputation with the faction
- `[reputation:per]`      - the player's percentage of reputation with the faction
- `[reputation:standing]` - the player's current standing with the faction
- `[reputation:faction]`  - the name of the player's currently tracked faction

See the [Examples](./#example-implementation) section on how to use the tags.
--]]
for tag, func in next, {
	['reputation:cur'] = function()
		return (GetReputation())
	end,
	['reputation:max'] = function(unit, runit)
		local _, max = GetReputation()
		return max
	end,
	['reputation:per'] = function()
		local cur, max = GetReputation()
		return math.floor(cur / max * 100 + 1/2)
	end,
	['reputation:standing'] = function()
		local _, _, _, _, _, standingText = GetReputation()
		return standingText
	end,
	['reputation:faction'] = function()
		local _, _, name = GetReputation()
		return name
	end,
} do
	oUF.Tags.Methods[tag] = func
	oUF.Tags.Events[tag] = 'UPDATE_FACTION'
end

oUF.Tags.SharedEvents.UPDATE_FACTION = true
oUF.colors.reaction[MAX_REPUTATION_REACTION + 1] = {0, 0.5, 0.9} -- paragon color

local function UpdateTooltip(element)
	local cur, max, name, factionID, standingID, standingText, pendingReward = GetReputation()
	local rewardAtlas = pendingReward and "|A:ParagonReputation_Bag:0:0:0:0|a" or ""
	local _, desc = GetFactionInfoByID(factionID)
	local color = element.__owner.colors.reaction[standingID]

	GameTooltip:SetText(name, color[1], color[2], color[3])
	GameTooltip:AddLine(desc, nil, nil, nil, true)
	if(cur ~= max) then
		GameTooltip:AddLine(format("%s (%s / %s)  %s", standingText, BreakUpLargeNumbers(cur), BreakUpLargeNumbers(max), rewardAtlas), 1, 1, 1)
	else
		GameTooltip:AddLine(standingText, 1, 1, 1)
	end
	GameTooltip:Show()
end

local function OnEnter(element)
	element:SetAlpha(element.inAlpha)
	GameTooltip:SetOwner(element, element.tooltipAnchor)

	--[[ Overrides:header
	### element:OverrideUpdateTooltip()

	Used to completely override the internal function for updating the tooltip.

	- `self` - the Reputation element
	--]]
	if(element.OverrideUpdateTooltip) then
		element:OverrideUpdateTooltip()
	elseif(element.UpdateTooltip) then -- DEPRECATED
		element:UpdateTooltip()
	else
		UpdateTooltip(element)
	end
end

local function OnLeave(element)
	GameTooltip:Hide()
	element:SetAlpha(element.outAlpha)
end

local function OnMouseUp()
	ToggleCharacter("ReputationFrame")
end

local function Update(self, event, unit)
	local element = self.Reputation
	if(element.PreUpdate) then
		--[[ Callbacks:header
		### element:PreUpdate(_unit_)

		Called before the element has been updated.

		- `self` - the Reputation element
		- `unit` - the unit for which the update has been triggered _(string)_
		--]]
		element:PreUpdate(unit)
	end

	local cur, max, name, factionID, standingID, standingText, pendingReward = GetReputation()
	if(name) then
		element:SetMinMaxValues(0, max)
		element:SetValue(cur)

		if(element.colorStanding) then
			local colors = self.colors.reaction[standingID]
			element:SetStatusBarColor(colors[1], colors[2], colors[3])
		end

		if(element.Reward) then
			-- no idea what this function actually does, but Blizzard uses it as well
			C_Reputation.RequestFactionParagonPreloadRewardData(factionID)
			element.Reward:SetShown(pendingReward)
		end
	end

	if(element.PostUpdate) then
		--[[ Callbacks:header
		### element:PostUpdate(_unit, cur, max, factionName, factionID, standingID, standingText, pendingReward_)

		Called after the element has been updated.

		- `self`          - the Reputation element
		- `unit`          - the unit for which the update has been triggered _(string)_
		- `cur`           - the current reputation with the tracked faction _(number)_
		- `max`           - the maximum reputation with the tracked faction _(number)_
		- `factionName`   - the name of the tracked faction _(string)_
		- `factionID`     - the identifier for the tracked faction _(number)_
		- `standingID`    - the identifier for the standing for the tracked faction _(number)_
		- `standingText`  - the name of the standing for the tracked faction _(string)_
		- `pendingReward` - indicates if there's a pending paragon reward with the faction _(boolean)_
		--]]
		return element:PostUpdate(unit, cur, max, name, factionID, standingID, standingText, pendingReward)
	end
end

local function Path(self, ...)
	--[[ Overrides:header
	### element.Override(_self, event, unit_)

	Used to completely override the internal update function.  
	Overriding this function also disables the [Callbacks](Callbacks).

	- `self`  - the parent object
	- `event` - the event triggering the update _(string)_
	- `unit`  - the unit accompanying the event _(variable(s))_
	--]]
	return (self.Reputation.Override or Update) (self, ...)
end

local function ElementEnable(self)
	local element = self.Reputation
	self:RegisterEvent('UPDATE_FACTION', Path, true)

	element:Show()
	element:SetAlpha(element.outAlpha or 1)

	Path(self, 'ElementEnable', 'player')
end

local function ElementDisable(self)
	self:UnregisterEvent('UPDATE_FACTION', Path)

	self.Reputation:Hide()

	Path(self, 'ElementDisable', 'player')
end

local function Visibility(self, event, unit, selectedFactionIndex)
	local shouldEnable
	if(selectedFactionIndex ~= nil) then
		if(selectedFactionIndex > 0) then
			shouldEnable = true
		end
	elseif(not not (GetWatchedFactionInfo())) then
		shouldEnable = true
	end

	if(shouldEnable) then
		ElementEnable(self)
	else
		ElementDisable(self)
	end
end

local function VisibilityPath(self, ...)
	--[[ Overrides:header
	### element.OverrideVisibility(_self, event, unit_)

	Used to completely override the element's visibility update process.  
	The internal function is also responsible for (un)registering events related to the updates.

	- `self`  - the parent object
	- `event` - the event triggering the update _(string)_
	- `unit`  - the unit accompanying the event _(variable(s))_
	--]]
	return (self.Reputation.OverrideVisibility or Visibility)(self, ...)
end

local function ForceUpdate(element)
	return VisibilityPath(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local function Enable(self, unit)
	local element = self.Reputation
	if(element) then
		element.__owner = self
		element.ForceUpdate = ForceUpdate

		hooksecurefunc('SetWatchedFactionIndex', function(selectedFactionIndex)
			if(self:IsElementEnabled('Reputation')) then
				VisibilityPath(self, 'SetWatchedFactionIndex', 'player', selectedFactionIndex or 0)
			end
		end)

		if(not element:GetStatusBarTexture()) then
			element:SetStatusBarTexture([[Interface\TargetingFrame\UI-StatusBar]])
		end

		if(element.Reward and element.Reward:IsObjectType('Texture') and not element.Reward:GetTexture()) then
			element.Reward:SetAtlas('ParagonReputation_Bag')
		end

		if(element:IsMouseEnabled()) then
			element.tooltipAnchor = element.tooltipAnchor or 'ANCHOR_BOTTOMRIGHT'
			element.inAlpha = element.inAlpha or 1
			element.outAlpha = element.outAlpha or 1

			if(not element:GetScript('OnEnter')) then
				element:SetScript('OnEnter', OnEnter)
			end

			if(not element:GetScript('OnLeave')) then
				element:SetScript('OnLeave', OnLeave)
			end

			if(not element:GetScript('OnMouseUp')) then
				element:SetScript('OnMouseUp', OnMouseUp)
			end
		end

		return true
	end
end

local function Disable(self)
	if(self.Reputation) then
		ElementDisable(self)
	end
end

oUF:AddElement('Reputation', VisibilityPath, Enable, Disable)
