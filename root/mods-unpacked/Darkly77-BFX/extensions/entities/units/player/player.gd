extends "res://entities/units/player/player.gd"


func take_damage(value:int, hitbox:Hitbox = null, dodgeable:bool = true, armor_applied:bool = true, custom_sound:Resource = null, base_effect_scale:float = 1.0, bypass_invincibility:bool = false)->Array:

	var dmg_arr = .take_damage(value, hitbox, dodgeable, armor_applied, custom_sound, base_effect_scale, bypass_invincibility)

	ModLoader.mod_log("TOOK_DAMAGE", "Darkly77-BFX")
	ModLoader.mod_log(str("RunData.effects: ", RunData.effects), "Darkly77-BFX")

	return dmg_arr
