Hooks:Add("LocalizationManagerPostInit", "Gambler Buff Localization", function(loc)
	LocalizationManager:add_localized_strings({
        ["menu_deck12_9_desc"] = "All berserker state effects in this perk deck will start at ##50%## health instead of ##25%##.\n\nShallow Grave:\nWhen you take lethal damage, you are instead left at ##1## health and are immune to damage for ##4## seconds. You are downed after the damage immunity ends unless your armor recovers.\n\nDeck Completion Bonus: Your chance of getting a higher quality item during a PAYDAY is increased by ##10%##."
    })
end)