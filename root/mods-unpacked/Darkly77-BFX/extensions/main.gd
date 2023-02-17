extends "res://main.gd"

const BFX_LOG = "Darkly77-BFX"


# Extensions
# =============================================================================

# When the wave ends
func _on_WaveTimer_timeout()->void:
	._on_WaveTimer_timeout()
	_bfx_gain_items_end_of_wave()


# When you level up
func on_levelled_up()->void:
	.on_levelled_up()
	_bfx_on_levelup_gain_random_stat()


# When you collect a consumable
func on_consumable_picked_up(consumable:Node)->void:
	.on_consumable_picked_up(consumable)
	_bfx_on_consumable_collect(consumable)


#@todo: Add an effect that can replace consumables with a custom drop (eg. drop
#armor via Wooden Tools for SG's Robbie
# func spawn_consumables(unit:Unit)->void:
	# pass


# Custom
# =============================================================================

# @todo: Consider destroying the item after (or, actually, just add a custom
# effect that do can do this)
func _bfx_gain_items_end_of_wave():
	if RunData.effects["bfx_gain_items_end_of_wave"] > 0:
		# Add items
		for i in RunData.effects["bfx_gain_items_end_of_wave"]:
			var item_id = Utils.get_rand_element(ProgressData.items_unlocked) # used to use `ItemService.items`
			var item_data = ItemService.get_element(ItemService.items, item_id)
			RunData.add_item(item_data)
			ModLoaderUtils.log_info(str("[bfx_gain_items_end_of_wave] Added item: ", tr(item_data.name)), "BFX")

		# SFX
		SoundManager.play(level_up_sound, 0, 0, true)

		# Text popup
		# Floating text `display` func reference:
		#   display(text, unit.global_position, color, icon, duration, always_display)
		# Color can be any color - see https://docs.godotengine.org/en/stable/classes/class_color.html
		# Vanilla uses white for most text, Color.yellow for crits, and Color.darkgray for a "miss" (not sure what that means)
		_floating_text_manager.display("FLOATING_GIFT_TEXT", _player.global_position, Color.gold)

		RunData.effects["bfx_gain_items_end_of_wave"] = 0


# @todo: Rework? So the value is the random stat increase, rather than the
# number of stats to increase (no, make a new custom effect.gd with options for:
# chance, stat_name, is_random_primary, is_random_secondary, lose_stat
func _bfx_on_levelup_gain_random_stat():
	if RunData.effects["bfx_on_levelup_gain_random_stat"] > 0:
		for i in RunData.effects["bfx_on_levelup_gain_random_stat"]:
			# Get a random (primary) stat
			var random_stat_key = Utils.get_rand_element(Utils.brotils_get_primary_stat_keys())

			# Add stat
			# TempStats.add_stat(random_stat_key, 1) # oops, this shouldn't be temporary!
			RunData.add_stat(random_stat_key, 1)

			# Display stat gain floating icon
			# Triggers `on_stat_added` in floating_text_manager.gd (stat:String, value:int, db_mod:float = 0.0)
			RunData.emit_signal("stat_added", random_stat_key, 1, -15.0)

			ModLoaderUtils.log_info(str("[bfx_on_levelup_gain_random_stat] Gained +1 to random stat: ", random_stat_key), BFX_LOG)


# When you pick up a consumable (fruit/crate)
#@todo: Refactor this, as atm the code is duped for each effect
func _bfx_on_consumable_collect(consumable:Node)->void:
	# print("[_bfx_on_consumable_collect] Collected")
	if RunData.effects["bfx_explode_on_consumable_collect"].size() > 0:
		# print("[_bfx_on_consumable_collect] size ok")
		var effect = RunData.effects["bfx_explode_on_consumable_collect"][0]
		var stats  = _player._bfx_explode_on_consumable_collect_stats
		var chance = effect.chance

		if (Utils.brotils_rng_chance_float(chance)):
			var _explosion = WeaponService.explode(effect, consumable.global_position, stats.damage, stats.accuracy, stats.crit_chance, stats.crit_damage, stats.burning_data)

	if RunData.effects["bfx_explode_on_fruit_collect"].size() > 0:
		if (consumable.consumable_data.my_id != "consumable_item_box" and consumable.consumable_data.my_id != "consumable_legendary_item_box"):
			var effect = RunData.effects["bfx_explode_on_fruit_collect"][0]
			var stats  = _player._bfx_explode_on_fruit_collect_stats
			var chance = effect.chance

			if (Utils.brotils_rng_chance_float(chance)):
				var _explosion = WeaponService.explode(effect, consumable.global_position, stats.damage, stats.accuracy, stats.crit_chance, stats.crit_damage, stats.burning_data)

	if RunData.effects["bfx_explode_on_crate_collect"].size() > 0:
		if (consumable.consumable_data.my_id == "consumable_item_box" or consumable.consumable_data.my_id == "consumable_legendary_item_box"):
			var effect = RunData.effects["bfx_explode_on_crate_collect"][0]
			var stats  = _player._bfx_explode_on_crate_collect_stats
			var chance = effect.chance

			if (Utils.brotils_rng_chance_float(chance)):
				var _explosion = WeaponService.explode(effect, consumable.global_position, stats.damage, stats.accuracy, stats.crit_chance, stats.crit_damage, stats.burning_data)

	# +x materials when you pick up a fruit
	if RunData.effects["bfx_gain_materials_on_fruit_collect"] != 0:
		var gold_gain = RunData.effects["bfx_gain_materials_on_fruit_collect"]
		if gold_gain > 0:
			RunData.add_gold(gold_gain)
		else:
			RunData.remove_gold(gold_gain)


# Helpers
# =============================================================================

# @todo: Use this. But need to check that the un-refactored code above is working correctly first
# eg: _bfx_explode_helper("bfx_explode_on_consumable_collect", consumable.global_position, _player._bfx_explode_on_consumable_collect_stats)
func _bfx_explode_helper(effect_name:String, position: Vector2, explosion_stats:Array)->void:
	if RunData.effects[effect_name].size() > 0:
		var effect = RunData.effects[effect_name][0]
		var stats  = explosion_stats
		var chance = effect.chance

		if (Utils.brotils_rng_chance_float(chance)):
			var _explosion = WeaponService.explode(effect, position, stats.damage, stats.accuracy, stats.crit_chance, stats.crit_damage, stats.burning_data)
