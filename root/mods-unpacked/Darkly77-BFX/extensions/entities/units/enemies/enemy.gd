extends "res://entities/units/enemies/enemy.gd"

const LOG_NAME = "BFX"

# Extra damage against burning enemies


# Extensions
# =============================================================================

func get_dmg_value(dmg_value:int, armor_applied:bool = true)->int:
	# Vanilla reference:
	# return max(1, dmg_value - current_stats.armor) as int if armor_applied else dmg_value
	var dmg = .get_dmg_value(dmg_value, armor_applied)

	dmg = _bfx_damage_to_burning_enemies(dmg)

	return dmg


# Custom
# =============================================================================

func _bfx_damage_to_burning_enemies(dmg:int)->int:
	if RunData.effects["bfx_damage_to_burning_enemies"] > 0:

		# Enemy is currently burning
		if _burning_particles.emitting:
			ModLoader.mod_log("@peem:Enemy is burning - APPLY EXTRA DMG", LOG_NAME)

			var dmg_old = dmg
			var dmg_add = RunData.effects["bfx_damage_to_burning_enemies"]
			var dmg_mod = 1 + (RunData.effects["bfx_damage_to_burning_enemies"] / 100.0)
			var new_dmg = dmg_old * dmg_mod

			ModLoader.mod_log("DMG_ADD=" + str(dmg_add), LOG_NAME)
			ModLoader.mod_log("dmg_OLD=" + str(dmg_old), LOG_NAME)
			ModLoader.mod_log("dmg_MOD=" + str(dmg_mod), LOG_NAME)
			ModLoader.mod_log("dmg_NEW=" + str(new_dmg), LOG_NAME)

			dmg = new_dmg

		else:
			# ModLoader.mod_log("@peem:Enemy is NOT burning", LOG_NAME)
			pass

	return dmg
