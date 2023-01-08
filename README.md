# Brotato-BFX

BFX is a library of effects (FX) and utility funcs for modding Brotato. It's used with ModLoader, acting as a dependancy for other mods to build off of.

Originally built for [Invasion](https://github.com/BrotatoMods/Brotato-Invasion-Mod), but can be used with other Brotato mods too.


## Effects

Use these like regular effects with *effect.gd*:

| key   | Type | Description |
| ----- | ---- | ----------- |
| `bfx_free_reroll_chance`          | int | Gives `x`% chance to gain a free reroll |
| `bfx_gain_items_end_of_wave`      | int | Gain `x` random items when a wave ends. |
| `bfx_iframes_duration_multiplier` | int | Increase duration of iframes by `x`% (eg `25` = +25% duration). |
| `bfx_on_levelup_gain_random_stat` | int | Gain +1 to `x` random stats when you level up. |

These effects use custom/modified gd scripts:

| key   | Script | Description |
| ----- | ------ | ----------- |
| `bfx_explode_on_hit_chance` | item_exploding_effect.gd | Same as vanilla's `explode_on_hit`, but doesn't ignore the `chance` value, and doesn't trigger with items/traits that don't give invulnerability time |
| `bfx_temp_stats_on_dodge`   | stat_effect.gd           | Same as vanilla's `temp_stats_on_hit`, but for dodge: `key` is the target stat, `value` is the stat value, and `effect_key` is `bfx_temp_stats_on_dodge`. |

### Text Keys

To keep the table above tidy, effect keys have not been specified. They are always `EFFECT_{effect_key}`:

| key   | text_key   |
| ----- | ---------- |
| `bfx_free_reroll_chance`          | `EFFECT_BFX_FREE_REROLL_CHANCE` |
| `bfx_gain_items_end_of_wave`      | `EFFECT_BFX_GAIN_ITEMS_END_OF_WAVE`      |
| `bfx_iframes_duration_multiplier` | `EFFECT_BFX_IFRAMES_DURATION_MULTIPLIER` |
| `bfx_on_levelup_gain_random_stat` | `EFFECT_BFX_ON_LEVELUP_GAIN_RANDOM_STAT` |
| `bfx_explode_on_hit_chance`       | `EFFECT_BFX_EXPLODE_ON_HIT_CHANCE` |
| `bfx_temp_stats_on_dodge`         | `EFFECT_BFX_TEMP_STATS_ON_DODGE` |


## Utility Functions

Usage: `Utils.method`. These are all defined in [utils.gd](root/mods-unpacked/Darkly77-BFX/extensions/singletons/utils.gd).

```
# General
bfx_join_array(arr, separator = "")->String
bfx_text_color(text:String, clr:String)->String

# Get Stats
bfx_get_primary_stat_keys(exclude_explosions:bool = true)->Array
bfx_get_random_primary_stat_key(exclude_explosions:bool = true)->bool
bfx_get_primary_stats_by_sign(target_stat_sign:int)->Array
bfx_get_positive_primary_stats()->Array
bfx_get_negative_primary_stats()->Array
bfx_get_neutral_primary_stats()->Array

# Character/Player
bfx_get_current_character()->CharacterData
bfx_current_character_is(character_id:String)->bool
bfx_get_player()->Player
```


## Fixes

BFX includes some small patches to vanilla:

- Temp stats now includes most secondary stats. In vanilla, you could only use temp_stats with primary stats (eg. `stat_max_hp`), now you can use it with secondary stats too (eg. `knockback`). View the list of supported secondary stats in [temp_stats.gd](root/mods-unpacked/Darkly77-BFX/extensions/singletons/temp_stats.gd).
