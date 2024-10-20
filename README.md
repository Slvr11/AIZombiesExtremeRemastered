# AIZombies eXtreme Remastered

AIZombies eXtreme Remastered is a mod for H2M that remasters the origin AIZombies eXtreme mod from alterIWnet/IW4x into the newer H2M client. The mod features all of the weapons, features, and maps as the original mod with some extra enhancements and balancing.

### New Features/Balancing
There are many new features in the remaster that were not present in the original mod. These changes were made to smooth out gameplay and balance certain exploitable bugs.

- Many weapon bugs were fixed, including infinite weapon bugs and many others
- Ability to adjust weapon spawn type. Randomized or USP only
- Ability to adjust many health and damage values for bots and players using dvars
- Added all MW2 CR maps with unique maps
- Ability to set a limit on how many perks a player can have
- Killstreaks no longer give the player points with hits or kills. Bonus points are still awarded
- Added many new weapons to the game:
  - .44 Magnum Classic (MW2 Magnum)
  - FN FAL Classic (MW2 FAL)
  - Galil (BO2 Galil)
  - M240 Classic (MW2 M240)
  - Uzi Classic (CoD4 Uzi)
  - PP2000 Classic (MW2 PP2000)
  - Striker Classic (MW2 Striker)
  - Dragunov Classic (CoD4 Dragunov)
- Ability to use the AIZombies eXtreme 1.8 or the updated 1.8.1 intro sequence
- Ammo price increases exponentially with each use. This balances ammo by only giving players a set amount of ammo uses
- Zombies can be set to use the actual zombie models that are used in the Infected mode
- Overall better zombie movement and tracking
- All maps from AIZombies eXtreme 1.8 and 1.8.1 are included

...and many more small tweaks and improvements!

### Dvars/Tweaks
AIZombies eXtreme Remastered includes a list of dvars that can tweak the experience. These dvars are included to allow server hosters to customize the gameplay to make it easier or harder.

- `aiz_spawnType`: dictates the weapons that the player spawns with. Valid options are `0` (spawn all players with the USP) and `1` (spawn with a random weapon)
- `aiz_maxHealth`: max player health without juggernog
- `aiz_maxHealth_jugg`: max player health with juggernog
- `aiz_botStartingHealth`: starting health of regular zombies
- `aiz_crawlerHealth`: starting health of crawler zombies
- `aiz_bossHealth`: starting health of boss zombies
- `aiz_botHealthFactor`: health that will be added to zombies each round
- `aiz_botDamage`: how much damage a zombie does to a player
- `aiz_campaignMaps`: enable or disable the MW2 CR maps in the map rotation
- `aiz_perkLimit`: the limit to how many max perks a player can have. 0 is infinite
- `aiz_maxZombies`: the max amount of zombies that can be active at once
- `aiz_maxZombiesUnderLoad`: the max amount of zombies that can be active at once when there are 4 or more players in the game. This can be used to lower the zmax zombie counts with higher player counts to reduce server lag
- `aiz_showRadar`: enable or disable the minimap
- `aiz_botDamageDelay`: a grace period that dictates how long it takes to alow a player to be hurt again after getting hurt from a zombie
- `aiz_botMaxSpeed`: the maximum speed zombies can run at. Zombies randomly pick between this value and a minimum of 50
- `aiz_killstreaksGivePoints`: enables or disables the ability for killstreaks to give players points
- `aiz_enableMustangAndSally`: enabled or disables mustang and sally grenades
- `aiz_newWeapons`: enables or disables the new weapons that are listed above
- `aiz_introType`: dictates the type of intro the game will use. Valid options are `0` (AIZombies eXtreme 1.8.1 intro), `1` (AIZombies eXtreme 1.8 intro), or `2` (randomly select between the two)
- `aiz_upgradedRPGBurstCount`: how many rockets are shot out of the upgraded RPG. The original mod shoots a total of 10 however this dvar defaults to 3 rockets for balancing
- `aiz_ammoPriceIncrease`: enables or disables the ammo cost increase balance. When disabled, ammo price is always 4500. When enabled, ammo price increases exponentially with each buy
- `aiz_oldHurtAnimLoop`: enables or disables the old zombie damage animation type the original mod uses. When enabled, the zombies will play their hurt animation with each hit. When disabled, zombies will wait for their current damage animation to fully play before playing it again
- `aiz_zombieModels`: enables or disables using the actual zombie models used in the Infected mode. Valid options are `0` (do not use zombie models), `1` (use only zombie models), and `2` (add zombie models to the list of random models that zombies use)
- `aiz_showPerkDescriptions`: enables or disables a short text description of a perk when buying it

### How To Install
To install this mod into your server, move the contents of `user_scripts/mp` into your server's `user_scripts/mp` directory. If your server does not have this folder, create it.
To start the server in AIZombies mode, add this line to your server cfg:

`set aiz_enabled "1"`

Once added, start your server on Team Deathmatch and AIZombies should run as intended. AIZombies handles map rotation by itself so you may ignore map rotation in your server cfg.
