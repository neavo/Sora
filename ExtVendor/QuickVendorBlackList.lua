EXTVENDOR_QUICKVENDOR_DEFAULT_BLACKLIST = {

    19972,  -- Lucky Fishing Hat
    33820,  -- Weather-Beaten Fishing Hat
    50741,  -- Vile Fumigator's Mask
    12185,  -- Bloodsail Admiral's Hat
    33292,  -- Hallowed Helm
    38506,  -- Don Carlos' Famous Hat
    38276,  -- Haliscan Brimmed Hat
    63205,  -- Safety Goggles
    10542,  -- Goblin Mining Helmet
    23323,  -- Crown of the Fire Festival
    21154,  -- Festival Dress
    778,    -- Kobold Excavation Pick
    10036,  -- Tuxedo Jacket
    10035,  -- Tuxedo Pants
    6835,   -- Black Tuxedo Pants
    6836,   -- Dress Shoes

};

-- The mass vendor feature can break if these items are not
-- prohibited. Specifically, the new progress dialog; it will
-- get stuck in a loop trying to vendor the item(s) endlessly
-- until the vendor frame is closed. Not cool.
EXTVENDOR_INTERNAL_BLACKLIST = {
    108743,     -- Deceptia's Smoldering Boots
};