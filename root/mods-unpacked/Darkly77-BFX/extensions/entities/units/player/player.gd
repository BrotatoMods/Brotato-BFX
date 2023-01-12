extends "res://entities/units/player/player.gd"

const LOG_NAME = "BFX"

var _bfx_explode_on_hit_stats = null
var _bfx_explode_on_consumable_collect_stats = null
var _bfx_explode_on_fruit_collect_stats = null
var _bfx_explode_on_crate_collect_stats = null

#@todo: MAYBE: Refactor the vars above ^ to use this dict instead, and init it
# with a func so it can be expanded with child mods;
# See also: `_bfx_explode_helper`
var _bfx_explosion_effects = {
	"bfx_explode_on_hit_chance": null,
	"bfx_explode_on_consumable_collect": null,
	"bfx_explode_on_fruit_collect": null,
	"bfx_explode_on_crate_collect": null,
}


# Extensions
# =============================================================================

func _ready()->void:
	._ready()
	_bfx_init_exploding_stats()


func update_player_stats()->void:
	.update_player_stats()
	_bfx_init_exploding_stats()


# Note: `bypass_invincibility` is true when triggered via `_on_LoseHealthTimer_timeout` (via effect "lose_hp_per_second" - Sick/Blood Donation)
# Note: `dodgeable` is true when true when ??? (see `current_stats.dodge`)
func take_damage(value:int, hitbox:Hitbox = null, dodgeable:bool = true, armor_applied:bool = true, custom_sound:Resource = null, base_effect_scale:float = 1.0, bypass_invincibility:bool = false)->Array:
	ModLoader.mod_log("take_damage", "BFX")

	if _invincibility_timer.is_stopped() or bypass_invincibility:
		var dmg_taken = .take_damage(value, hitbox, dodgeable, armor_applied, custom_sound, base_effect_scale)

		if dodgeable: # Attack was dodged
			_bfx_on_dodge()

		if dmg_taken[1] > 0:
			if RunData.effects["temp_stats_on_hit"].size() > 0:
				pass
				# Vanilla Reference:
				# for temp_stat_on_hit in RunData.effects["temp_stats_on_hit"]:
					# TempStats.add_stat(temp_stat_on_hit[0], temp_stat_on_hit[1])

			# Player took damage
			_bfx_on_take_damage(dmg_taken, value, hitbox, dodgeable, armor_applied, custom_sound, base_effect_scale, bypass_invincibility)

		return dmg_taken
	return [0, 0]


func get_iframes(damage_taken:float)->float:
	# Vanilla Reference:
	# var pct_dmg_taken = (damage_taken / max_stats.health)
	# var iframes = clamp((pct_dmg_taken * MAX_IFRAMES) / 0.15, MIN_IFRAMES, MAX_IFRAMES)
	return _bfx_modify_iframes_duration(.get_iframes(damage_taken))



# Custom: On...
# =============================================================================

# Player took damage
func _bfx_on_take_damage(_dmg_taken, _value:int, _hitbox:Hitbox = null, _dodgeable:bool = true, _armor_applied:bool = true, _custom_sound:Resource = null, _base_effect_scale:float = 1.0, bypass_invincibility:bool = false)->void:
	_bfx_temp_stats_on_hit(bypass_invincibility)
	_bfx_explode_on_hit_chance(bypass_invincibility)


# Player dodged an enemy's attack
func _bfx_on_dodge()->void:
	_bfx_temp_stats_on_dodge()



# Custom
# =============================================================================

# Change the duration of iframes
func _bfx_modify_iframes_duration(iframes):
	if RunData.effects["bfx_iframes_duration_multiplier"] != 0:
		iframes = Utils.bfx_int_percent_increase(iframes, RunData.effects["bfx_iframes_duration_multiplier"])
	return iframes


# BFX version of init_exploding_stats, but includes the effect check. Vanilla's
# check happens before its init_exploding_stats func gets called instead, this
# slight change just keeps everything in one place
func _bfx_init_exploding_stats()->void:
	if RunData.effects["bfx_explode_on_hit_chance"].size() > 0:
		_bfx_explode_on_hit_stats = WeaponService.init_base_stats(RunData.effects["bfx_explode_on_hit_chance"][0].stats, "", [], [ExplodingEffect.new()])

	if RunData.effects["bfx_explode_on_consumable_collect"].size() > 0:
		_bfx_explode_on_consumable_collect_stats = WeaponService.init_base_stats(RunData.effects["bfx_explode_on_consumable_collect"][0].stats, "", [], [ExplodingEffect.new()])

	if RunData.effects["bfx_explode_on_fruit_collect"].size() > 0:
		_bfx_explode_on_fruit_collect_stats = WeaponService.init_base_stats(RunData.effects["bfx_explode_on_fruit_collect"][0].stats, "", [], [ExplodingEffect.new()])

	if RunData.effects["bfx_explode_on_crate_collect"].size() > 0:
		_bfx_explode_on_crate_collect_stats = WeaponService.init_base_stats(RunData.effects["bfx_explode_on_crate_collect"][0].stats, "", [], [ExplodingEffect.new()])


func _bfx_temp_stats_on_hit(_bypass_invincibility:bool = false)->void:
	if RunData.effects["bfx_temp_stats_on_hit"].size() > 0:
		for temp_stat_on_hit in RunData.effects["bfx_temp_stats_on_hit"]:
			TempStats.add_stat(temp_stat_on_hit[0], temp_stat_on_hit[1])


# Basically identical to vanilla, except it also checks the chance%
# @TODO: This needs a bit of a rework, to loop over an array of effects, instead of just using the first one like vanilla does
func _bfx_explode_on_hit_chance(bypass_invincibility:bool = false)->void:
	if !bypass_invincibility: # doesn't trigger with "lose_hp_per_second" (Sick/Blood Donation)
		if RunData.effects["bfx_explode_on_hit_chance"].size() > 0:
			# effect  = Resource (item_exploding_effect.gd)
			# stats   = Resource (ranged_weapon_stats.gd)
			# e_stats = Resource (weapon_stats.gd)
			var effect = RunData.effects["bfx_explode_on_hit_chance"][0]
			var stats  = _bfx_explode_on_hit_stats
			var chance = effect.chance

			if (Utils.bfx_rng_chance_float(chance)):
				var _explosion = WeaponService.explode(effect, global_position, stats.damage, stats.accuracy, stats.crit_chance, stats.crit_damage, stats.burning_data)


# Gain temp stats when you dodge
func _bfx_temp_stats_on_dodge()->void:
	if RunData.effects["bfx_temp_stats_on_dodge"].size() > 0:
		for temp_stat_on_dodge in RunData.effects["bfx_temp_stats_on_dodge"]:
			TempStats.add_stat(temp_stat_on_dodge[0], temp_stat_on_dodge[1])
