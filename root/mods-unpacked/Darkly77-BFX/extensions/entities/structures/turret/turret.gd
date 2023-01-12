extends "res://entities/structures/turret/turret.gd"

const LOG_NAME = "BFX"

# Affects individual turret entities


# Extensions
# =============================================================================

func _ready()->void:
	._ready()
	_bfx_turret_stat_mods()


# Custom
# =============================================================================

func _bfx_turret_stat_mods()->void:
	if RunData.effects["bfx_turret_attack_speed"] != 0:
		stats.cooldown = Utils.cap_above(Utils.bfx_int_percent_decrease(stats.cooldown, RunData.effects["bfx_turret_attack_speed"]), 1)

	if RunData.effects["bfx_turret_crit_chance"] != 0:
		stats.crit_chance = Utils.cap_between(Utils.bfx_int_percent_increase(stats.crit_chance, RunData.effects["bfx_turret_crit_chance"]), 0, 1)

	if RunData.effects["bfx_turret_damage"] != 0:
		stats.damage = Utils.cap_above(Utils.bfx_int_percent_increase(stats.damage, RunData.effects["bfx_turret_damage"]), 1)
