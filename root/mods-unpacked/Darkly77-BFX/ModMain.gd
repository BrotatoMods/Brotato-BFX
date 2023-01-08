extends Node

const MOD_DIR = "Darkly77-BFX/"
const LOG_NAME = "BFX"

var dir = ""
var ext_dir = ""

func _init(modLoader = ModLoader):
	modLoader.mod_log("Init", LOG_NAME)
	dir = modLoader.UNPACKED_DIR + MOD_DIR
	ext_dir = dir + "extensions/"

	# Add translations
	modLoader.addTranslationFromResource(dir + "translations/bfx.en.translation")

	# Add extensions [old approach]
	# modLoader.installScriptExtension(ext_dir + "entities/units/player/player.gd")
	# modLoader.installScriptExtension(ext_dir + "singletons/debug_service.gd") # Installs extender for "res://ui/menus/shop/shop.gd"
	# modLoader.installScriptExtension(ext_dir + "singletons/run_data.gd")

	# Add extensions
	var extensions = [
		# Setup
		"singletons/utils.gd",             # SETUP: Utility funcs
		"singletons/debug_service.gd",     # SETUP: Installs extender for "res://ui/menus/shop/shop.gd"
		"singletons/run_data.gd",          # SETUP: Keys for all BFX's custom effects
		"singletons/text.gd",              # SETUP: Keys needing operators/percent

		# Effects
		"main.gd",                         # EFFECTS: end of wave, level up
		"entities/units/player/player.gd", # EFFECTS: take damage, iframes
		"singletons/item_service.gd",      # EFFECTS: free reroll chance

		# Fixes
		"singletons/temp_stats.gd",        # FIX: Allow using secondary stats in temp_stat
	]

	for path in extensions:
		modLoader.installScriptExtension(ext_dir + path)


func _ready():
	ModLoader.mod_log("Done", LOG_NAME)
