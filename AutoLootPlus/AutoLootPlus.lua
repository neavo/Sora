local addon = CreateFrame("Frame")

-- NOTE The event fires twice upon opening a lootable container
addon:RegisterEvent("LOOT_READY")

-- TODO Write description
addon:SetScript("OnEvent", function ()
	-- Check if auto loot is enabled xor its activation key is pressed
	if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
		-- Work backwards toward the built-in auto loot iterator
		for i = GetNumLootItems(), 1, -1 do
			LootSlot(i)
		end
	end
end)
