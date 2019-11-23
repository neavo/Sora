--[[-------------------------------------------------------------------------
-- Configuration Panel Loader for SIA and STA
--
-- Copyright 2012-2019 BeathsCurse (Bowmore - Silvermoon EU)
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

-- Create frame for configuration panel
addon.panel = CreateFrame('Frame', addonName .. 'Panel')
addon.panel:Hide()
addon.panel.name = addonName

-- Local shorthand for accessing the panel
local panel = addon.panel

-- Add a title heading at the top
local title = panel:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLargeLeft')
title:SetPoint('TOPLEFT', 16, -16)
title:SetText(addonName)

-- Add a subtitle heading just below
local subTitle = panel:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmallLeft')
subTitle:SetPoint('TOPLEFT', title, 'BOTTOMLEFT', 0, -8)
subTitle:SetText(addon.version)

-- Load the addon with the configuration panel code when the panel is shown.
panel:SetScript('OnShow', function(self)
	local loaded, reason = LoadAddOn(addonName .. '_Config')

	if not loaded then
		-- Show error on panel
		if not self.errorText then
			self.errorText = self:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightLeft')
			self.errorText:SetPoint('TOPLEFT', 16, -76)
		end
		self.errorText:SetText('Unable to load ' .. addonName .. '_Config: ' .. (_G['ADDON_' .. reason] or '?'):lower())
	end
end)

-- Add our panel to the interface options addons menu
InterfaceOptions_AddCategory(panel)
