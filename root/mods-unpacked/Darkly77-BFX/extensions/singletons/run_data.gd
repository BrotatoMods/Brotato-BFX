extends "res://singletons/run_data.gd"

const LOG_NAME = "BFX"


# Extensions
# =============================================================================

func _ready()->void:
	._ready()
	_bfx_effect_keys_full_serialization()

func init_effects()->Dictionary:
	return _bfx_add_custom_effects(.init_effects())

func init_tracked_effects()->Dictionary:
	return _bfx_add_tracked_effects(.init_tracked_effects())


# Custom
# =============================================================================

# Adds BFX's custom effects to the vanilla set
func _bfx_add_custom_effects(effects_edit:Dictionary)->Dictionary:
	ModLoader.mod_log("Adding custom effects", LOG_NAME)

	# Note: Some effects will need their keys adding to the extended text.gd
	# See: mods-unpacked/Darkly77-BFX/extensions/singletons/text.gd
	# (keys_needing_operator, keys_needing_percent)

	# Gain a random item (or multiple items) when a wave ends.
	# This array is cleared when the wave ends
	# text_key: effect_bfx_gain_items_end_of_wave
	effects_edit["bfx_gain_items_end_of_wave"] = 0 # int (number of random items to gain)

	# Increase/decrease duration of iframes by a %
	effects_edit["bfx_iframes_duration_multiplier"] = 0 # int (eg. 25 = +25% duration)

	# On level up: Gain a random stat
	effects_edit["bfx_on_levelup_gain_random_stat"] = 0 # int (number of random stats to gain)

	# Gives a % chance to gain a free reroll (after rerolling once)
	effects_edit["bfx_free_reroll_chance"] = 0 # int

	# Same as vanilla's `explode_on_hit`, but doesn't ignore the chance %
	effects_edit["bfx_explode_on_hit_chance"] = [] # array

	# Same as `temp_stats_on_hit` but for dodge
	effects_edit["bfx_temp_stats_on_dodge"] = 0 # int

	return effects_edit


# Adds BFX's effects that have data that's not just ints, so needs full
# serialization
func _bfx_effect_keys_full_serialization()->void:
	# @todo: Work out why this doesn't work, and fix it
	# effect_keys_full_serialization.push_back("bfx_explode_on_hit_chance")
	pass


#@todo: Fix this. Atm, vanilla only accepts item IDs, see: items/global/item_parent_data.gd
# Allows items that use these effects to track their stats.
# Increase the stat with:
#   RunData.tracked_item_effects["NAME"] += 1
func _bfx_add_tracked_effects(effects_edit:Dictionary)->Dictionary:
	# bfx_free_reroll_chance
	effects_edit["bfx_effect_bfx_free_reroll_chance_savings"] = 0 # int
	effects_edit["bfx_effect_bfx_free_reroll_chance_free_rerolls"] = 0 # int

	return effects_edit
