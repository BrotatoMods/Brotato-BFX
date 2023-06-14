extends "res://entities/units/enemies/enemy.gd"

const BFX_LOG_ENEMY = "Darkly77-BFX"

# Extra damage against burning enemies


# Extensions
# =============================================================================

func get_dmg_value(dmg_value:int, armor_applied:bool = true, is_crit:bool = false)->int:
	# Vanilla reference:
	# return max(1, dmg_value - current_stats.armor) as int if armor_applied else dmg_value
	var dmg = .get_dmg_value(dmg_value, armor_applied, is_crit)

	dmg = _bfx_damage_to_burning_enemies(dmg)

	return dmg


# Custom
# =============================================================================

func _bfx_damage_to_burning_enemies(dmg:int)->int:
	if RunData.effects["bfx_damage_to_burning_enemies"] > 0:

		# Enemy is currently burning
		if _burning_particles.emitting:
			# ModLoaderUtils.log_info("[bfx_damage_to_burning_enemies] Enemy is burning - APPLY EXTRA DMG", BFX_LOG_ENEMY)

			var dmg_old = dmg
			var dmg_add = RunData.effects["bfx_damage_to_burning_enemies"]
			var dmg_mod = 1 + (RunData.effects["bfx_damage_to_burning_enemies"] / 100.0)
			var new_dmg = dmg_old * dmg_mod

			# ModLoaderUtils.log_info("DMG_ADD=" + str(dmg_add), BFX_LOG_ENEMY)
			# ModLoaderUtils.log_info("dmg_OLD=" + str(dmg_old), BFX_LOG_ENEMY)
			# ModLoaderUtils.log_info("dmg_MOD=" + str(dmg_mod), BFX_LOG_ENEMY)
			# ModLoaderUtils.log_info("dmg_NEW=" + str(new_dmg), BFX_LOG_ENEMY)

			dmg = new_dmg

		else:
			# ModLoaderUtils.log_info("[bfx_damage_to_burning_enemies] Enemy is NOT burning", BFX_LOG_ENEMY)
			pass

	return dmg
