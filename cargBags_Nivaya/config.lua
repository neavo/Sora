local addon, ns = ...

local defaultFont = STANDARD_TEXT_FONT

ns.options = {
	filterArtifactPower = true, --set to 'false' to disable the category for items that give Artifact Power
	itemSlotSize = 36, -- Size of item slots
	sizes = {
		bags = {
			columnsSmall = 8,
			columnsLarge = 10,
			largeItemCount = 64 -- Switch to columnsLarge when >= this number of items in your bags
		},
		bank = {
			columnsSmall = 12,
			columnsLarge = 14,
			largeItemCount = 96 -- Switch to columnsLarge when >= this number of items in the bank
		}
	},
	--------------------------------------------------------------
	-- Anything below this is only effective when not using RealUI
	--------------------------------------------------------------

	fonts = {
		-- Font to use for bag captions and other strings
		standard = {
			defaultFont, -- Font path
			12, -- Font Size
			"THINOUTLINE" -- Flags
		},
		--Font to use for the dropdown menu
		dropdown = {
			defaultFont, -- Font path
			12, -- Font Size
			"THINOUTLINE" -- Flags
		},
		-- Font to use for durability and item level
		itemInfo = {
			defaultFont, -- Font path
			12, -- Font Size
			"THINOUTLINE" -- Flags
		},
		-- Font to use for number of items in a stack
		itemCount = {
			defaultFont, -- Font path
			12, -- Font Size
			"THINOUTLINE" -- Flags
		}
	},
	colors = {
		background = {0.05, 0.05, 0.05, 0.8} -- r, g, b, opacity
	}
}
