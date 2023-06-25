extends "res://singletons/debug_service.gd"


func _ready():
	# Deferred extender for shop.gd. This is needed because you can't extend
	# shop.gd in mod_main.gd, because it uses `RunData.effects["free_rerolls"]`,
	# and RunData isn't initialised when mod_main's init func runs
	ModLoaderMod.install_script_extension(ModLoaderMod.get_unpacked_dir() + "Darkly77-BFX/extensions/ui/menus/shop/shop.gd") # "res://ui/menus/shop/shop.gd"
