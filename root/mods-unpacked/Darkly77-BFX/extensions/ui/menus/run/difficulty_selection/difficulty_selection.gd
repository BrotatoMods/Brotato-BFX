extends "res://ui/menus/run/difficulty_selection/difficulty_selection.gd"

# This is used to trigger the two custom starting item/weapon effects:
#   bfx_starting_difficulty_item
#   bfx_starting_difficulty_weapon


func on_element_pressed(element:InventoryElement)->void :
	.on_element_pressed(element)
	# This is a custom method, defined in the extended run_data.gd.
	# See that extended file for more info
	RunData.bfx_add_starting_difficulty_items_and_weapons()
