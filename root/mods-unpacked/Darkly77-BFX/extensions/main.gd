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

func _bfx_bfx_gain_items_end_of_wave():
	if RunData.effects["bfx_gain_items_end_of_wave"] > 0:
		# Add items
		for i in RunData.effects["bfx_gain_items_end_of_wave"]:
			var item_data = Utils.get_rand_element(ItemService.items)
			RunData.add_item(item_data)
			ModLoader.mod_log(str("[bfx_gain_items_end_of_wave] Added item: ", tr(item_data.name)), "BFX")

		# SFX and text popup
		SoundManager.play(level_up_sound, 0, 0, true)
		_floating_text_manager.display("FLOATING_GIFT_TEXT", _player.global_position, Color.limegreen)

		# Floating text `display` func reference:
		# Color can be any color - see https://docs.godotengine.org/en/stable/classes/class_color.html
		# Vanilla uses white for most text, Color.yellow for crits, and Color.darkgray for a "miss" (not sure what that means)
		# display(text, unit.global_position, color, icon, duration, always_display)

		# Reset items count
		RunData.effects["bfx_gain_items_end_of_wave"] = 0


func _bfx_bfx_on_levelup_gain_random_stat():
	if RunData.effects["bfx_on_levelup_gain_random_stat"] > 0:
		for i in RunData.effects["bfx_on_levelup_gain_random_stat"]:
			# Get a random (primary) stat
			var stat_keys = TempStats.stats.keys()
			var random_stat_key = stat_keys[randi() % stat_keys.size()] # src: https://www.reddit.com/r/godot/comments/h0447r/picking_a_random_dictionary_key/

			# Add stat
			TempStats.add_stat(random_stat_key, 1)

			# Display stat gain floating icon
			# Triggers `on_stat_added` in floating_text_manager.gd (stat:String, value:int, db_mod:float = 0.0)
			RunData.emit_signal("stat_added", random_stat_key, 1, -15.0)

			ModLoader.mod_log(str("[bfx_on_levelup_gain_random_stat] Gained +1 to random stat: ", random_stat_key), LOG_NAME)
