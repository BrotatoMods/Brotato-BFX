extends "res://entities/structures/turret/turret.gd"

# Affects individual turret entities


# Extensions
# =============================================================================

func _ready()->void:
	_bfx_turret_stat_mods()


# Custom
# =============================================================================

func _bfx_turret_stat_mods()->void:
	if RunData.effects["bfx_turret_attack_speed"] != 0:
		stats.cooldown = Utils.brotils_cap_above(Utils.brotils_int_percent_decrease(stats.cooldown, RunData.effects["bfx_turret_attack_speed"]), 1)

	if RunData.effects["bfx_turret_crit_chance"] != 0:
		stats.crit_chance = Utils.brotils_cap_between(Utils.brotils_int_percent_increase(stats.crit_chance, RunData.effects["bfx_turret_crit_chance"]), 0, 1)

	if RunData.effects["bfx_turret_damage"] != 0:
		stats.damage = Utils.brotils_cap_above(Utils.brotils_int_percent_increase(stats.damage, RunData.effects["bfx_turret_damage"]), 1)
