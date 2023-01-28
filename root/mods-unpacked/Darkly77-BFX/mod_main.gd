extends Node

const MOD_DIR = "Darkly77-BFX/"
const BFX_LOG = "Darkly77-BFX"

var dir = ""
var ext_dir = ""

func _init(modLoader = ModLoader):
	ModLoaderUtils.log_info("Init", BFX_LOG)
	dir = modLoader.UNPACKED_DIR + MOD_DIR
	ext_dir = dir + "extensions/"

	# Add translations
	modLoader.add_translation_from_resource(dir + "translations/bfx.en.translation")

	# Add extensions [old approach]
	# modLoader.install_script_extension(ext_dir + "entities/units/player/player.gd")
	# modLoader.install_script_extension(ext_dir + "singletons/debug_service.gd")
	# modLoader.install_script_extension(ext_dir + "singletons/run_data.gd")

	# Add extensions
	var extensions = [
		# Setup
		"singletons/debug_service.gd",  # SETUP: Installs extender for "res://ui/menus/shop/shop.gd"
		"singletons/run_data.gd",       # SETUP: Keys for all BFX's custom effects
		"singletons/text.gd",           # SETUP: Keys needing operators/percent

		# Effects
		"main.gd",                              # EFFECTS: end of wave, level up
		"entities/structures/turret/turret.gd", # EFFECTS: turret attack speed
		"entities/units/enemies/boss/boss.gd",  # EFFECTS: boss HP
		"entities/units/enemies/enemy.gd",      # EFFECTS: dmg vs. burning enemies
		"entities/units/player/player.gd",      # EFFECTS: on take damage/dodge, iframes
		"singletons/item_service.gd",           # EFFECTS: free reroll chance

		# Fixes
		"singletons/temp_stats.gd", # FIX: Allow using secondary stats in temp_stat
	]

	for path in extensions:
		modLoader.install_script_extension(ext_dir + path)


func _ready():
	ModLoaderUtils.log_info("Done", BFX_LOG)
