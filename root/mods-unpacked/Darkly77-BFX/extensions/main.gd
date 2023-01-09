extends "res://main.gd"

const LOG_NAME = "BFX"


# Extensions
# =============================================================================

# When the wave ends
func _on_WaveTimer_timeout()->void:
	._on_WaveTimer_timeout()
	_bfx_bfx_gain_items_end_of_wave()


# When you level up
func on_levelled_up()->void:
	.on_levelled_up()
	_bfx_bfx_on_levelup_gain_random_stat()


# Custom
# =============================================================================

# @todo: Consider destroying the item after (or, actually, just add a custom
# effect that do can do this)
func _bfx_bfx_gain_items_end_of_wave():
	if RunData.effects["bfx_gain_items_end_of_wave"] > 0:
		# Add items
		for i in RunData.effects["bfx_gain_items_end_of_wave"]:
			var item_id = Utils.get_rand_element(ProgressData.items_unlocked) # used to use `ItemService.items`
			var item_data = ItemService.get_element(ItemService.items, item_id)
			RunData.add_item(item_data)
			ModLoader.mod_log(str("[bfx_gain_items_end_of_wave] Added item: ", tr(item_data.name)), "BFX")

		# SFX
		SoundManager.play(level_up_sound, 0, 0, true)

		# Text popup
		# Floating text `display` func reference:
		#   display(text, unit.global_position, color, icon, duration, always_display)
		# Color can be any color - see https://docs.godotengine.org/en/stable/classes/class_color.html
		# Vanilla uses white for most text, Color.yellow for crits, and Color.darkgray for a "miss" (not sure what that means)
		_floating_text_manager.display("FLOATING_GIFT_TEXT", _player.global_position, Color.gold)

		RunData.effects["bfx_gain_items_end_of_wave"] = 0


# @todo: Rework? So the value is the random stat increase, rather than the number
# of stats to increase
func _bfx_bfx_on_levelup_gain_random_stat():
	if RunData.effects["bfx_on_levelup_gain_random_stat"] > 0:
		for i in RunData.effects["bfx_on_levelup_gain_random_stat"]:
			# Get a random (primary) stat
			var random_stat_key = Utils.get_rand_element(Utils.bfx_get_primary_stat_keys())

			# Add stat
			# TempStats.add_stat(random_stat_key, 1) # oops, this shouldn't be temporary!
			RunData.add_stat(random_stat_key, 1)

			# Display stat gain floating icon
			# Triggers `on_stat_added` in floating_text_manager.gd (stat:String, value:int, db_mod:float = 0.0)
			RunData.emit_signal("stat_added", random_stat_key, 1, -15.0)

			ModLoader.mod_log(str("[bfx_on_levelup_gain_random_stat] Gained +1 to random stat: ", random_stat_key), LOG_NAME)
