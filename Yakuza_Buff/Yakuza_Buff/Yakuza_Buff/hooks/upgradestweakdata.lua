local original_player_definitions = UpgradesTweakData._player_definitions

function UpgradesTweakData:_player_definitions(...)
	original_player_definitions(self, ...)
	
	self.definitions.temporary_shallow_grave = {
		name_id = "menu_temporary_shallow_grave",
		category = "temporary",
		upgrade = {
			value = 1,
			upgrade = "shallow_grave",
			category = "temporary"
		}
	}
	self.values.temporary.shallow_grave = {}
end