extends "res://singletons/text.gd"

const LOG_NAME = "BFX"


# Extensions
# =============================================================================

func init():
	_bfx_add_keys_needing_operator()
	_bfx_add_keys_needing_percent()



# Custom
# =============================================================================

# Adds +/-, eg stat_max_hp
func _bfx_add_keys_needing_operator()->void:
	keys_needing_operator["bfx_gain_items_end_of_wave"] = [0]

# Adds %, eg number_of_enemies
func _bfx_add_keys_needing_percent()->void:
	keys_needing_operator["bfx_iframes_duration_multiplier"] = [0]
	keys_needing_operator["bfx_free_reroll_chance"] = [0]
