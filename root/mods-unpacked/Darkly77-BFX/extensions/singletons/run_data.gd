extends "res://singletons/run_data.gd"

const BFX_LOG_RUN_DATA = "Darkly77-BFX"


# Extensions
# =============================================================================

func _ready()->void:
	_bfx_effect_keys_full_serialization()

func init_effects()->Dictionary:
	return _bfx_add_custom_effects(.init_effects())


# Custom
# =============================================================================

# Adds BFX's custom effects to the vanilla set
func _bfx_add_custom_effects(vanilla_effects:Dictionary)->Dictionary:
	ModLoaderLog.info("Adding custom effects", BFX_LOG_RUN_DATA)

	# Note: Some effects will need their keys adding to the extended text.gd
	# See: mods-unpacked/Darkly77-BFX/extensions/singletons/text.gd
	# (keys_needing_operator, keys_needing_percent)
	var custom_effects = {
		# Gain a random item (or multiple items) when a wave ends.
		# This array is cleared when the wave ends
		# text_key: effect_bfx_gain_items_end_of_wave
		"bfx_gain_items_end_of_wave": 0, # int (number of random items to gain)

		# Increase/decrease duration of iframes by a %
		"bfx_iframes_duration_multiplier": 0, # int (eg. `25` gives +25% duration)

		# On level up: Gain a random stat
		"bfx_on_levelup_gain_random_stat": 0, # int (number of random stats to gain)

		# % discount/increase to rerolls
		"bfx_reroll_cost": 0, # int

		# Same as vanilla `temp_stats_on_hit`, but doesn't proc if bypassing invulnerability (Sick/Blood Donation)
		"bfx_temp_stats_on_hit": [], # array

		# Same as `temp_stats_on_hit` but for dodge
		"bfx_temp_stats_on_dodge": [], # array

		# Same as vanilla's `explode_on_hit`, but doesn't ignore the chance %, and doesn't proc if bypassing invulnerability
		"bfx_explode_on_hit_chance": [], # array

		# Boss HP modifier
		"bfx_boss_hp": 0, # int

		# Damage against burning enemies
		"bfx_damage_to_burning_enemies": 0, #int

		# Explode when you collect a consumable/fruit/crate (consumable = both fruit and crate)
		"bfx_explode_on_consumable_collect": [], # array
		"bfx_explode_on_crate_collect": [], # array
		"bfx_explode_on_fruit_collect": [], # array

		# Turret stats
		"bfx_turret_attack_speed": 0, #int (%)
		"bfx_turret_crit_chance": 0, #int (%)
		"bfx_turret_damage": 0, #int (%)

		# Gain +x materials when you collect a fruit (similar to Bag)
		"bfx_gain_materials_on_fruit_collect": 0, #int

		"bfx_starting_difficulty_item": [], # array (string)
		"bfx_starting_difficulty_weapon": [], # array (string)
	}

	return Utils.merge_dictionaries(vanilla_effects, custom_effects)


# Adds BFX's effects that have data that's not just ints, so needs full
# serialization
func _bfx_effect_keys_full_serialization()->void:
	# @todo: Work out why this doesn't work, and fix it
	# effect_keys_full_serialization.push_back("bfx_explode_on_hit_chance")
	pass



# New API Methods
# =============================================================================

# Adds methods to RunData, to be accessed from other files

# Same as `RunData.add_starting_items_and_weapons()`, but is triggered after
# selecting a difficulty (difficulty_selection.gd), rather than a weapon like
# in vanilla (difficulty_selection.gd)
#@todo: Could we make it so that you don't have to add the item to ItemService?
func bfx_add_starting_difficulty_items_and_weapons()->void :
	if effects["bfx_starting_difficulty_item"].size() > 0:
		for item_id in effects["bfx_starting_difficulty_item"]:
			for i in item_id[1]:
				var item = ItemService.get_element(ItemService.items, item_id[0])
				add_item(item)

	if effects["bfx_starting_difficulty_weapon"].size() > 0:
		for weapon_id in effects["bfx_starting_difficulty_weapon"]:
			for i in weapon_id[1]:
				var weapon = ItemService.get_element(ItemService.weapons, weapon_id[0])
				var _weapon = add_weapon(weapon)
