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
# @todo: This isn't used/implemented fully yet
func _bfx_effect_bfx_free_reroll_chance(price)->int:
	if RunData.effects["bfx_free_reroll_chance"] > 0:
		var chance = max(1, RunData.effects["bfx_free_reroll_chance"] / 100) # eg 20 gives 0.2 (20% chance)
		var rand = rand_range(0.0, 1.0)
		if rand >= chance:
			RunData.tracked_item_effects["bfx_effect_bfx_free_reroll_chance_savings"] += price
			RunData.tracked_item_effects["bfx_effect_bfx_free_reroll_chance_free_rerolls"] += 1
			price = 0

	return price
