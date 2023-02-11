extends "res://singletons/item_service.gd"


# Extensions
# =============================================================================

func get_reroll_price(wave:int, last_reroll_value:int)->int:
	var price = .get_reroll_price(wave, last_reroll_value)
	price = _bfx_effect_bfx_reroll_cost(price)
	return price


# Custom
# =============================================================================

func _bfx_effect_bfx_reroll_cost(price)->int:
	if RunData.effects["bfx_reroll_cost"] != 0:
		var discount = Utils.brotils_cap_above(RunData.effects["bfx_reroll_cost"], -90)
		var newprice = Utils.brotils_int_percent_increase(price, discount)
		price = newprice

	return price
