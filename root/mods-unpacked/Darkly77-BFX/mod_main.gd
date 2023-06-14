extends Node

const MOD_DIR = "Darkly77-BFX/"
const BFX_LOG_MOD_MAIN = "Darkly77-BFX"

var dir = ""
var ext_dir = ""

func _init(modLoader = ModLoader):
	ModLoaderUtils.log_info("Init", BFX_LOG_MOD_MAIN)
	dir = modLoader.UNPACKED_DIR + MOD_DIR
	ext_dir = dir + "extensions/"

	# Add translations
	modLoader.add_translation_from_resource(dir + "translations/mod_bfx.en.translation")

	# Add extensions [old approach]
	# modLoader.install_script_extension(ext_dir + "entities/units/player/player.gd")
	# modLoader.install_script_extension(ext_dir + "singletons/debug_service.gd")
	# modLoader.install_script_extension(ext_dir + "singletons/run_data.gd")

	# Add extensions
	var extensions = [
		# Setup
		"singletons/run_data.gd",       # SETUP: Keys for all BFX's custom effects
		"singletons/text.gd",           # SETUP: Keys needing operators/percent
		"singletons/debug_service.gd",  # SETUP: Installs extender for "res://ui/menus/shop/shop.gd"

		# Effects
		"main.gd",                              # EFFECTS: end of wave, level up
		"entities/structures/turret/turret.gd", # EFFECTS: turret attack speed
		"entities/units/enemies/boss/boss.gd",  # EFFECTS: boss HP
		"entities/units/enemies/enemy.gd",      # EFFECTS: dmg vs. burning enemies
		"entities/units/player/player.gd",      # EFFECTS: on take damage/dodge, iframes
		"singletons/item_service.gd",           # EFFECTS: free reroll chance

		# EFFECTS: `bfx_starting_difficulty_item`, `bfx_starting_difficulty_weapon`
		# (used for custom difficulties, to add items/weapons)
		"ui/menus/run/difficulty_selection/difficulty_selection.gd",
	]

	for path in extensions:
		modLoader.install_script_extension(ext_dir + path)


func _ready():
	ModLoaderUtils.log_info("Done", BFX_LOG_MOD_MAIN)
