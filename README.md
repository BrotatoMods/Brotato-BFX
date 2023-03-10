# Brotato-BFX

![GitHub all releases](https://img.shields.io/github/downloads/BrotatoMods/Brotato-BFX/total)

BFX is a library of effects (FX) for modding Brotato. It's used with [ModLoader](https://github.com/BrotatoMods/Brotato-ModLoader), acting as a dependancy for other mods to build off of.

Originally built for [Invasion](https://github.com/BrotatoMods/Brotato-Invasion-Mod), but can be used with other Brotato mods too.

## Requirements

* [ModLoader](https://github.com/GodotModding/godot-mod-loader) - v4.1+
* [Brotils](https://github.com/BrotatoMods/Brotato-Brotils/) - v1.0+

## Effects

### effect.gd

Use these like regular effects with *effect.gd*:

| key   | Type | Description |
| ----- | ---- | ----------- |
| `bfx_boss_hp`                     | int | Modify boss HP by `x`% (eg. `-20` = 80% HP) |
| `bfx_damage_to_burning_enemies`   | int | Deal `x`% more/less damage to enemies that are burning |
| `bfx_reroll_cost`                 | int | Gives `x`% discount/increase to rerolls (hardcoded max: 90%) |
| `bfx_gain_items_end_of_wave`      | int | Gain `x` random items when a wave ends. |
| `bfx_iframes_duration_multiplier` | int | Increase duration of iframes by `x`% (eg `25` = +25% duration). |
| `bfx_on_levelup_gain_random_stat` | int | Gain +1 to `x` random stats when you level up. |
| `bfx_turret_attack_speed`         | int | Turrets attack `x`% faster |
| `bfx_turret_crit_chance`          | int | Turrets gain +`x`% crit chance |
| `bfx_turret_damage`               | int | Turrets deal +`x`% more damage |
| `bfx_temp_stats_on_dodge`         | int | Similar to vanilla's `temp_stats_on_hit`, but for dodge |
| `bfx_temp_stats_on_hit`           | int | Same as vanilla's `temp_stats_on_hit`, but doesn't proc with no invulnerability time † |
| `bfx_gain_materials_on_fruit_collect` | int | Gain +x materials when you collect a fruit.<br>Similar to vanilla's `item_box_gold` (which only applies to crates) |

<small>† This means the effect won't trigger with items/traits that don't give invulnerability time (ie. Sick and Blood Donation)</small>

### item_exploding_effect.gd

All of these accept a chance%.

| key   | Description |
| ----- | ----------- |
| `bfx_explode_on_hit_chance`         | Same as vanilla's `explode_on_hit`, but doesn't ignore `chance` value, and doesn't proc with no invulnerability time |
| `bfx_explode_on_consumable_collect` | Consumables explode when you collect them (fruit/crate) |
| `bfx_explode_on_crate_collect`      | Consumables explode when you collect them (crate only) |
| `bfx_explode_on_fruit_collect`      | Consumables explode when you collect them (fruit only) |

### Custom Difficulties

These effects are only intended to be used with custom difficulties (eg. [CustomDifficultyModes](https://github.com/BrotatoMods/Darkly77-CustomDifficultyModes)). They let you add a reminder item for the current custom difficulty you're on, as the HUD simply shows the danger number.

They are needed because vanilla's `starting_item` effect triggers after choosing a weapon, which is too soon for it to have an effect after choosing a difficulty.

Note that the item/weapon still needs to be added to ItemService (ie. with [ContentLoader](https://github.com/BrotatoMods/Brotato-ContentLoader)).

For the `text_key`, use `[EMPTY]` if you want to hide the effect description, otherwise use `starting_item`.

| Key | Description |
| --- | ----------- |
| `bfx_starting_difficulty_item` | Start with a specific item |
| `bfx_starting_difficulty_weapon` | Start with a specific weapon |


## Effect Text Keys

Effect keys are always `EFFECT_{effect_key}`:

| key   | text_key   |
| ----- | ---------- |
| `bfx_reroll_cost`                   | `EFFECT_BFX_REROLL_COST` |
| `bfx_gain_items_end_of_wave`        | `EFFECT_BFX_GAIN_ITEMS_END_OF_WAVE`      |
| `bfx_iframes_duration_multiplier`   | `EFFECT_BFX_IFRAMES_DURATION_MULTIPLIER` |
| `bfx_on_levelup_gain_random_stat`   | `EFFECT_BFX_ON_LEVELUP_GAIN_RANDOM_STAT` |
| `bfx_explode_on_hit_chance`         | `EFFECT_BFX_EXPLODE_ON_HIT_CHANCE` |
| `bfx_temp_stats_on_dodge`           | `EFFECT_BFX_TEMP_STATS_ON_DODGE` |
| `bfx_boss_hp`                       | `EFFECT_BFX_BOSS_HP`<br>`EFFECT_BFX_BOSS_HP_INCREASE`<br>`EFFECT_BFX_BOSS_HP_DECREASE` |
| `bfx_damage_to_burning_enemies`     | `EFFECT_BFX_DAMAGE_TO_BURNING_ENEMIES` |
| `bfx_explode_on_consumable_collect` | `EFFECT_BFX_EXPLODE_ON_CONSUMABLE_COLLECT`<br>`EFFECT_BFX_EXPLODE_ON_CONSUMABLE_COLLECT_CHANCE` |
| `bfx_explode_on_crate_collect`      | `EFFECT_BFX_EXPLODE_ON_CRATE_COLLECT`<br>`EFFECT_BFX_EXPLODE_ON_CRATE_COLLECT_CHANCE` |
| `bfx_explode_on_fruit_collect`      | `EFFECT_BFX_EXPLODE_ON_FRUIT_COLLECT`<br>`EFFECT_BFX_EXPLODE_ON_FRUIT_COLLECT_CHANCE` |
| `bfx_turret_attack_speed`           | `EFFECT_BFX_TURRET_ATTACK_SPEED` |
| `bfx_turret_crit_chance`            | `EFFECT_BFX_TURRET_CRIT_CHANCE` |
| `bfx_turret_damage`                 | `EFFECT_BFX_TURRET_DAMAGE` |
| `bfx_gain_materials_on_fruit_collect` | `EFFECT_BFX_GAIN_MATERIALS_ON_FRUIT_COLLECT` |
