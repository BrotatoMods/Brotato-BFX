extends "res://singletons/text.gd"

const BFX_LOG = "Darkly77-BFX"

# @note: When adding your effects, they need to be prefixed with "effect_" in
# the arrays below

# @todo: Check if there's anywhere else where these keys are checked, eg:
# effect_keys_full_serialization, effect_keys_with_weapon_stats
# ..and maybe: `ItemService.effects`


# Extensions
# =============================================================================

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
	keys_needing_operator["effect_bfx_gain_materials_on_fruit_collect"] = [0]


# Adds %, eg `number_of_enemies`
func _bfx_add_keys_needing_percent()->void:
	keys_needing_percent["effect_bfx_boss_hp"] = [0]
	keys_needing_percent["effect_bfx_damage_to_burning_enemies"] = [0]
	keys_needing_percent["effect_bfx_iframes_duration_multiplier"] = [0]
	keys_needing_percent["effect_bfx_reroll_cost"] = [0]
	keys_needing_percent["effect_bfx_turret_crit_chance"] = [0]
