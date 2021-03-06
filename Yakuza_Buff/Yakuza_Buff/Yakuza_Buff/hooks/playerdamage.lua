function PlayerDamage:set_health(health)
	self:_check_update_max_health()
	self._max_health_reduction = self._max_health_reduction or 1

	local max_health = self:_max_health() * self._max_health_reduction
	health = math.min(health, max_health)
	
	
	if health <= 0 and managers.player:has_category_upgrade("temporary", "shallow_grave") then
		
		local player_armor = managers.blackmarket:equipped_armor(true, true)
		local armors_allowed = {"level_2", "level_3", "level_4", "level_5", "level_6", "level_7"}
		
		if table.contains(armors_allowed, player_armor) and managers.player:inactive_shallow_grave() == 1 then
			health, self._can_take_dmg_timer = managers.player:activate_shallow_grave()
		end
	end
	
	
	local prev_health = self._health and Application:digest_value(self._health, false) or health
	self._health = Application:digest_value(math.clamp(health, 0, max_health), true)

	self:_send_set_health()
	self:_set_health_effect()

	if self._said_hurt and self:get_real_health() / self:_max_health() > 0.2 then
		self._said_hurt = false
	end

	if self:health_ratio() < 0.3 then
		self._heartbeat_start_t = TimerManager:game():time()
		self._heartbeat_t = self._heartbeat_start_t + tweak_data.vr.heartbeat_time
	end

	managers.hud:set_player_health({
		current = self:get_real_health(),
		total = self:_max_health(),
		revives = Application:digest_value(self._revives, false)
	})

	return prev_health ~= Application:digest_value(self._health, false)
end