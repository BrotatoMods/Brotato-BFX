extends "res://ui/menus/shop/shop.gd"

# Nothing here is used, this is just a reference for later

func _ready():
	pass
	# print("TEST2=OK: res://ui/menus/shop/shop.gd")

# Set the reroll button cost to 9999 (takes effect after the first reroll)
func set_reroll_button_price()->void:
	.set_reroll_button_price()
	# _reroll_button.init(9999)

# Log when an item is purchased
func on_shop_item_bought(shop_item:ShopItem)->void:
	.on_shop_item_bought(shop_item)
	# print(str("BOUGHT_ITEM: ", shop_item))
