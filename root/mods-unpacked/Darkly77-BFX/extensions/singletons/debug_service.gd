extends "res://singletons/debug_service.gd"


func _ready():
	# Deferred extender for shop.gd. This is needed because you can't extend
	# shop.gd in mod_main.gd, because it uses `RunData.effects["free_rerolls"]`,
	# and RunData isn't initialised when mod_main's init func runs
	ModLoader.install_script_extension(ModLoader.UNPACKED_DIR + "Darkly77-BFX/extensions/ui/menus/shop/shop.gd") # "res://ui/menus/shop/shop.gd"
