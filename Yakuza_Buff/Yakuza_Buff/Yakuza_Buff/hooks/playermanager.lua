local original_function = PlayerManager.update

function PlayerManager:update(...)
	original_function(self,...)
	self:upd_shallow_grave()
end



function PlayerManager:inactive_shallow_grave()
	if self.shallow_grave == 1 then
		return 0
	else
		return 1
	end
end

function PlayerManager:activate_shallow_grave()
	self:player_unit():sound():play("perkdeck_activate")
	self.shallow_grave = 1
	self.shallow_grave_activate_t = TimerManager:game():time()
	self.shallow_grave_revive = 0
	return 0.1, 3.5
end

function PlayerManager:upd_shallow_grave()
	
	self.can_be_downed = self.can_be_downed or 1
	local is_downed = game_state_machine:verify_game_state(GameStateFilters.downed)
	local swan_song_active = managers.player:has_activate_temporary_upgrade("temporary", "berserker_damage_multiplier")
	local player = self:player_unit()
	
	if self.shallow_grave == 1 then
	
		if player then
		
			if player:character_damage():armor_ratio() == 1 then
				self.shallow_grave_revive = 1
				self.shallow_grave = 0
				self.can_be_downed = 1
			end
			
			if self.shallow_grave_activate_t then
			
				if TimerManager:game():time() - self.shallow_grave_activate_t > 3.5 then
					
					if self.shallow_grave_revive == 1 then
						self.shallow_grave_revive = 0
					elseif is_downed or swan_song_active then
						--nothing
					elseif self.can_be_downed == 1 then
						player:character_damage():force_into_bleedout(true)
						self.can_be_downed = 0
					end
				end
			end
		end
	end
end