extends "res://entities/units/enemies/boss/boss.gd"

# Applies the effect that modifies boss HP
# Note: `init_current_stats` is inherited from parent: unit.gd > enemy.gd > boss.gd

#@todo: Should this go in enemy.gd, with `if unit is Boss:`?


# Extensions
# =============================================================================

func init_current_stats()->void:
	.init_current_stats()
	_bfx_boss_hp()


# Custom
# =============================================================================

# Note: a value of `-100` would make -100%, which causes all sorts of bugs;
# So the effect is capped at -99% (which takes a boss HP of 28000 down to 280)
# Edit: Cap of 99% still seems to cause issues, probably because the code can't
# handle the boss dying so fast (ie. there are things that should be set up, but
# aren't yet). So the cap was changed to 90% (boss HP 28000 > 2800, ie 1/10th)
func _bfx_boss_hp()->void:
	if RunData.effects["bfx_boss_hp"] != 0:
		max_stats.copy_stats(stats)

		var hp_mod_perc = RunData.effects["bfx_boss_hp"] / 100.0

		if hp_mod_perc <= -1:
			# hp_mod_perc = -0.99 # causes crash
			hp_mod_perc = -0.9

		var new_hp_raw = stats.health * (1.0 + hp_mod_perc)
		var new_hp_round = round(new_hp_raw)

		max_stats.health = new_hp_round

		current_stats.copy(max_stats)
		reset_stats()
