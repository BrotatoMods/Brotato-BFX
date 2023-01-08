extends "res://singletons/utils.gd"

# Extends the Utils class with many custom utility funcs.
# Use like any other util method, eg `Utils.bfx_join_array()`

const LOG_NAME = "BFX"

const _bfx_primary_stat_keys = [
	"stat_max_hp",
	"stat_armor",
	"stat_crit_chance",
	"stat_luck",
	"stat_attack_speed",
	"stat_elemental_damage",
	"stat_hp_regeneration",
	"stat_lifesteal",
	"stat_melee_damage",
	"stat_percent_damage",
	"stat_dodge",
	"stat_engineering",
	"stat_range",
	"stat_ranged_damage",
	"stat_speed",
	"stat_harvesting",
]


# Custom
# =============================================================================

# Join an array as a string
# https://godotengine.org/qa/20058/elegant-way-to-create-string-from-array-items
func bfx_join_array(arr, separator = "")->String:
	var output = "";
	for s in arr:
		output += str(s) + separator
	output = output.left( output.length() - separator.length() )
	return output


# see also: mods-unpacked/Darkly77-BFX/effects/effect_gain_items.gd
func bfx_text_color(text:String, clr:String)->String:
	var bbcode_color = "white"

	# `match` is godot's version of `switch`
	# https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html#match
	match clr:
		"white":
			bbcode_color = "white"
		"positive":
			bbcode_color = "#00ff00"
		"green":
			bbcode_color = "#00ff00"
		"negative":
			bbcode_color = "red"
		"red":
			bbcode_color = "red"
		"grey":
			bbcode_color = "#555555"
		"gray":
			bbcode_color = "#555555"
		"materials":
			bbcode_color = "#76FF76" # bright pastel green
		"secondary":
			bbcode_color = "#EAE2B0" # yellow/cream
		"tier1":
			bbcode_color = "#C8C8C8" # vanilla actually uses white for tier1, this grey is the wiki's color
		"tier2":
			bbcode_color = "#4A9BD1"
		"tier3":
			bbcode_color = "#AD5AFF"
		"tier4":
			bbcode_color = "#FF3B3B"

		# Custom
		"purple":
			bbcode_color = "#CA64EA"

	return str("[color=", bbcode_color, "]", text, "[/color]")


# Custom: Stats
# =============================================================================

func bfx_get_primary_stat_keys(exclude_explosions:bool = true)->Array:
	# var stat_keys = TempStats.stats.keys()
	# if exclude_explosions:
		# stat_keys.remove(stat_keys.find("explosion_size"))
		# stat_keys.remove(stat_keys.find("explosion_damage"))
	# return stat_keys
	return _bfx_primary_stat_keys

func bfx_get_random_primary_stat_key(exclude_explosions:bool = true)->bool:
	# var stat_keys = bfx_get_primary_stat_keys(exclude_explosions)
	# var random_stat_key = stat_keys[randi() % stat_keys.size()] # src: https://www.reddit.com/r/godot/comments/h0447r/picking_a_random_dictionary_key/
	# return random_stat_key
	return Utils.get_rand_element(_bfx_primary_stat_keys)

# target_stat_sign: -1 = neg, 0 = zero, 1 = pos
func bfx_get_primary_stats_by_sign(target_stat_sign:int)->Array:
	var found_stats = []
	var all_stat_keys = bfx_get_primary_stat_keys()
	for stat_key in all_stat_keys:
		var stat_val = RunData.effects[stat_key]
		var stat_sign = sign(stat_val) # -1 = neg, 0 = zero, 1 = pos
		if stat_sign == target_stat_sign:
			found_stats.push_back(stat_key)
	return found_stats

func bfx_get_positive_primary_stats()->Array:
	return bfx_get_primary_stats_by_sign(1)

func bfx_get_negative_primary_stats()->Array:
	return bfx_get_primary_stats_by_sign(-1)

func bfx_get_neutral_primary_stats()->Array:
	return bfx_get_primary_stats_by_sign(0)


# Custom: Character/Player
# =============================================================================

# Mostly just wrappers for ease of use

func bfx_get_current_character():
	return RunData.current_character

func bfx_current_character_is(character_id:String)->bool:
	return RunData.current_character.my_id == character_id

func bfx_get_player():
	return TempStats.player


# Custom: Misc
# =============================================================================

# RNG check. Pass an int. Returns true if it passes the check, false otherwise.
# For floats, just use `if randf() <= chance_float`
func bfx_rng_chance_int(chance_int:float)->bool:
	var chance = min(1, chance_int / 100) # eg 20 gives 0.2 (20% chance)
	return randf() >= chance

# For the sake of completeness
func bfx_rng_chance_float(chance_float:float)->bool:
	var chance = min(1, chance_float)
	return randf() >= chance