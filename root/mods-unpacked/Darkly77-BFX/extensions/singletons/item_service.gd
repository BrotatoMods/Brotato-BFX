extends "res://singletons/item_service.gd"


# Extensions
# =============================================================================

func get_reroll_price(wave:int, last_reroll_value:int)->int:
	var price = .get_reroll_price(wave, last_reroll_value)
	price = _bfx_effect_bfx_free_reroll_chance(price)
	return price


# Custom
# =============================================================================

# Chance for a reroll to be free
# @todo: Atm triggering a free reroll also resets the rerol price back to 0, can
# we store the last reroll price and re-apply it after we've given the free reroll?
# (might need to do this in shop.gd instead)
# see: `set_reroll_button_price`

# @todo: Would this be better as "reduce reroll cost"?
func _bfx_effect_bfx_free_reroll_chance(price)->int:
	if RunData.effects["bfx_free_reroll_chance"] > 0:
		# var chance = max(1, RunData.effects["bfx_free_reroll_chance"] / 100.0) # eg 20 gives 0.2 (20% chance)
		if Utils.bfx_rng_chance_int(RunData.effects["bfx_free_reroll_chance"], 0.9):
			# @todo: add tracking
			# RunData.tracked_item_effects["bfx_effect_bfx_free_reroll_chance_savings"] += price
			# RunData.tracked_item_effects["bfx_effect_bfx_free_reroll_chance_free_rerolls"] += 1
			price = 0

	return price
