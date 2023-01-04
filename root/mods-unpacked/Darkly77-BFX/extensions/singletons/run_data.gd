extends "res://singletons/run_data.gd"

const LOG_NAME = "Darkly77-BFX"

# Note: Might also need to add effects to:
# Text.gd > keys_needing_operator
# Text.gd > keys_needing_percent

func init_effects()->Dictionary:
	var effects_edit = .init_effects()

	ModLoader.mod_log("Adding custom effects", LOG_NAME)

	# Gain a random item (or multiple items) when a wave ends
	effects_edit["gain_items_end_of_wave"] = []

	# ModLoader.mod_log(str("Edited effects", effects_edit), LOG_NAME)

	return effects_edit


# func reset(_restart:bool = false)->void :
	# .reset()
