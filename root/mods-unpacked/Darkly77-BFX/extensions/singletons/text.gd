extends "res://singletons/text.gd"

const BFX_LOG = "Darkly77-BFX"

#@todo: These don't seem to be working?

# I need to investigate, and see if:
#   a) they do what I'm expecting them to here,
#   b) check if it's too late to apply the change, and
#   c) check if there's anywhere else where these keys are checked (eg. `ItemService.effects`).
# Also worth working out what the arrays are for


# Extensions
# =============================================================================

# @todo: Try to check if another mod has already added it; if so, we'll need to
# call it so we don't break the mod chain
func _ready()->void:
	_bfx_add_keys_needing_operator()
	_bfx_add_keys_needing_percent()


# Custom
# =============================================================================

#@note: These use `text_key`, not just `key`

# Adds +/-, eg `stat_max_hp`
func _bfx_add_keys_needing_operator()->void:
	keys_needing_operator["effect_bfx_damage_to_burning_enemies"] = [0]
	keys_needing_operator["effect_bfx_gain_items_end_of_wave"] = [0]
	keys_needing_operator["effect_bfx_reroll_cost"] = [0]
	keys_needing_operator["effect_bfx_turret_crit_chance"] = [0]


# Adds %, eg `number_of_enemies`
func _bfx_add_keys_needing_percent()->void:
	keys_needing_percent["effect_bfx_boss_hp"] = [0]
	keys_needing_percent["effect_bfx_damage_to_burning_enemies"] = [0]
	keys_needing_percent["effect_bfx_iframes_duration_multiplier"] = [0]
	keys_needing_percent["effect_bfx_reroll_cost"] = [0]
	keys_needing_percent["effect_bfx_turret_crit_chance"] = [0]
