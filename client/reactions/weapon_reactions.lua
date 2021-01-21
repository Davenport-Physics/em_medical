
local function stun_gun_reaction()

	if PLAYER.SHORTERM_EFFECTS["Meth"] ~= nil then

		if math.random() <= 0.5 then
			apply_short_term_effect(EFFECTS.TAZED)
		end

	else
		apply_short_term_effect(EFFECTS.TAZED)
	end

end

register_weapon_reaction(WEAPON_HASHES.WEAPON_STUNGUN, stun_gun_reaction)