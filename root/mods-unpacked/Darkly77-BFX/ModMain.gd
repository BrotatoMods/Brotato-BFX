extends Node

const MOD_DIR = "Darkly77-BFX/"
const LOG_NAME = "Darkly77-BFX"

var dir = ""
var ext_dir = ""

func _init(modLoader = ModLoader):
	modLoader.mod_log("Init", LOG_NAME)
	dir = modLoader.UNPACKED_DIR + MOD_DIR
	ext_dir = dir + "extensions/"

	# Add extensions
	modLoader.installScriptExtension(ext_dir + "singletons/run_data.gd")
	modLoader.installScriptExtension(ext_dir + "entities/units/player/player.gd")


func _ready():
	ModLoader.mod_log("Done", LOG_NAME)
