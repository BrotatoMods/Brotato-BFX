extends "res://singletons/temp_stats.gd"

# Fixes an issue in vanilla where temp_stats can only uses primary stats

const _bfx_secondary_stats = {
	"xp_gain":0,
	"items_price":0,
	"number_of_enemies":0,
	# "no_melee_weapons":0,
	# "no_ranged_weapons":0,
	"consumable_heal":0,
	"burning_cooldown_reduction":0,
	"burning_spread":0,
	"piercing":0,
	"piercing_damage":0,
	# "hp_start_wave":100,
	# "hp_start_next_wave":100,
	# "pacifist":0,
	"pickup_range":0,
	"chance_double_gold":0,
	"bounce":0,
	"bounce_damage":0,
	"heal_when_pickup_gold":0,
	"enemy_speed":0,
	# "gain_pct_gold_start_wave":0,
	"item_box_gold":0,
	"knockback":0,
	# "torture":0,
	# "recycling_gains":0,
	# "one_shot_trees":0,
	"hp_cap":999999,
	# "lose_hp_per_second":0,
	# "cant_stop_moving":0,
	"map_size":0,
	"max_ranged_weapons":999,
	"max_melee_weapons":999,
	"dodge_cap":60,
	# "trees":0,
	# "trees_start_wave":0,
	"min_weapon_tier":0,
	"max_weapon_tier":99,
	"gold_drops":100,
	"harvesting_growth":5,
	"free_rerolls":0,
	"enemy_strength":0,
	"boss_strength":0,
	"double_boss":0,
	"explosion_size":0,
	"explosion_damage":0,
	"neutral_gold_drops":0,
	"enemy_gold_drops":0,
	"hit_protection":0,
	"weapons_price":0,
	"minimum_weapons_in_shop":0,
}


func init_stats()->Dictionary:
	var stats_vanilla = .init_stats()
	var stats_edit = Utils.merge_dictionaries(stats_vanilla, _bfx_secondary_stats)
	return stats_edit
