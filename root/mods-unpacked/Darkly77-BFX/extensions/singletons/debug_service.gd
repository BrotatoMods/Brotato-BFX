extends "res://singletons/debug_service.gd"


func _ready():
	# Deferred extender for shop.gd. This is needed because you can't extend
	# shop.gd in ModMain.gd, because it uses `RunData.effects["free_rerolls"]`,
	# and RunData isn't initialised when ModMain's init func runs
	ModLoader.installScriptExtension(ModLoader.UNPACKED_DIR + "Darkly77-BFX/extensions/ui/menus/shop/shop.gd") # "res://ui/menus/shop/shop.gd"
