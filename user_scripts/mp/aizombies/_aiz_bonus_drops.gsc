#include user_scripts\mp\aizombies\_aiz;
#include user_scripts\mp\aizombies\_aiz_hud;
#include maps\mp\_utility;
#include common_scripts\utility;

#define DROPTYPE_NONE 0
#define DROPTYPE_AMMO 1
#define DROPTYPE_NUKE 2
#define DROPTYPE_CASH 3
#define DROPTYPE_INFINITE_AMMO 4
#define DROPTYPE_ADRENALINE 5
#define DROPTYPE_GUN 6
#define DROPTYPE_FREEZE 7

checkForBonusDrop()
{
            randomInt = 0;
            if (level.wave <= 5) randomInt = randomInt(75);
            else if (level.wave <= 10) randomInt = randomInt(150);
            else randomInt = randomInt(200);

            if (randomInt == 5)
                return 1;
            else if (randomInt == 10)
                return 2;
            else if (randomInt == 15)
                return 3;
            else if (randomInt == 20 && level.infiniteAmmoTime == 0)
                return 4;
            else if (randomInt == 25)
                return 5;
            else if (randomInt == 30)
                return 6;
            else if (randomInt == 35 && !level.freezerActivated)
                return 7;
            else return 0;
}

activateBonusDrop(bonus)
{
    if (!isDefined(bonus.type))
    {
        printLn("Error activating a bonus drop: missing type field");
        return;
    }

    switch (bonus.type)
    {
        case 1:
            foreach (players in level.players)
                if (players.isAlive) players z_giveMaxAmmo();
            thread powerupText(level.gameStrings[207], 0.85, (25.5, 25.5, 25.5), (0.7, 0.7, 0.3), 0.2);
            thread powerupIcon("waypoint_ammo_friendly");
            break;
        case 2:
            level thread doNuke(bonus);
            break;
        case 3:
            bonus playSound("mp_level_up");
            foreach (players in level.players)
            {
                if (players.isAlive && players.aizHud_created)
                {
                    players.cash += 1000;
                    players thread scorePopup(1000);
                    players thread textPopup(level.gameStrings[97]);
                }
            }
            thread powerupText(level.gameStrings[97], 0.85, (25.5, 25.5, 25.5), (0.3, 0.9, 0.3), 0.2);
            thread powerupIcon("em_st_111");
            break;
        case 4:
            bonus playSound("mp_level_up");
            if (level.infiniteAmmoTime == 0) level.infiniteAmmoTime += 30;
            user_scripts\mp\aizombies\_aiz::startInfiniteAmmo();
            foreach (players in level.players)
            {
                if (!players.isAlive)
                    continue;
                    
                currentWeapon = self getCurrentWeapon();
                self setWeaponAmmoClip(currentWeapon, weaponMaxAmmo(currentWeapon));
            }
            thread powerupText(level.gameStrings[209], 0.85, (25.5, 25.5, 25.5), (0.3, 0.3, 0.9), 0.2);
            thread powerupIcon("dpad_killstreak_sentry_minigun");
            break;
        case 5:
            bonus playSound("mp_level_up");
            level.adrenalineTime += 30;
            user_scripts\mp\aizombies\_aiz::startAdrenaline();
            foreach (players in level.players)
            {
                if (!players.isAlive)
                    continue;

                players thread giveAdrenaline();
            }
            thread powerupText(level.gameStrings[215], 0.85, (25.5, 25.5, 25.5), (0.9, 0.3, 0.3), 0.2);
            thread powerupIcon("em_st_042");
            break;
        case 6:
            self playLocalSound("mp_level_up");
            self thread giveDeathMachine();
            self thread textPopup2(level.gameStrings[204]);
            break;
        case 7:
            level thread doFreezer(bonus);
            break;
        default:
            break;
    }
}
giveAdrenaline()
{
    if (!self.perksBought[2])
    {
        self givePerk("specialty_fastreload", false);
		self givePerk("specialty_quickdraw", false);
    }

    if (self _hasPerk("specialty_lightweight"))
    {
        self.moveSpeedScaler = 1.25;
        self maps\mp\gametypes\_weapons::updateMoveSpeedScale("primary");
    }
    else
    {
        self.moveSpeedScaler = 1.2;
        self maps\mp\gametypes\_weapons::updateMoveSpeedScale("primary");
    }

    level waittill("adrenaline_ended");

    if (self _hasPerk("specialty_lightweight"))
    {
        self.moveSpeedScaler = 1.1;
        self maps\mp\gametypes\_weapons::updateMoveSpeedScale("primary");
    }
    else
    {
        self.moveSpeedScaler = 1.0;
        self maps\mp\gametypes\_weapons::updateMoveSpeedScale("primary");
    }

    if (!self.perksBought[2])
    {
        self _unSetPerk("specialty_fastreload");
		self _unSetPerk("specialty_quickdraw");
    }
}
giveDeathMachine()
{
    currentWeapon = self getCurrentWeapon();
    weaponName = "h2_m240_mp_xmag_camo007";
    self giveWeapon(weaponName);
    self thread switchToWeapon_delay(weaponName, 0.2);
    self disableWeaponSwitch();

    wait(30);

    if (isDefined(self) && self.isAlive)
    {
        self takeWeapon(weaponName);
        self switchToWeapon(currentWeapon);
        self enableWeaponSwitch();
        self thread textPopup2(&"No more death machine!");
    }
}

spawnBonusDrop(type, loc)
{
    bonus = spawn("script_model", loc + (0, 0, 30));
    bonus.angles = (0, 0, 0);

    bonusIcon = "";

    if (type == DROPTYPE_AMMO)
    {
        bonus setModel("com_plasticcase_friendly");
        bonusIcon = "waypoint_ammo_friendly";
    }
    else if (type == DROPTYPE_NUKE)
    {
        bonus.origin = bonus.origin + (0, 0, 15);
        bonus setModel("projectile_cbu97_clusterbomb");
        bonus.angles = (-90, 0, 0);
        bonusIcon = "dpad_killstreak_nuke";
    }
    else if (type == DROPTYPE_FREEZE)
    {
        bonus.origin += (0, 0, 15);
        bonus setModel("projectile_cbu97_clusterbomb");
        bonus.angles = (-90, 0, 0);
        bonusIcon = "dpad_killstreak_emp";
    }
    else if (type == DROPTYPE_GUN)
    {
        bonus setModel("h2_weapon_m240");
        bonusIcon = "em_st_102";
    }
    else if (type == DROPTYPE_CASH)
    {
        bonus setModel("com_plasticcase_friendly");
        bonusIcon = "em_st_111";
    }
    else if (type == DROPTYPE_INFINITE_AMMO)
    {
        bonus setModel("com_plasticcase_friendly");
        bonusIcon = "dpad_killstreak_sentry_minigun";
    }
    else if (type == DROPTYPE_ADRENALINE)
    {
        bonus setModel("com_plasticcase_friendly");
        bonusIcon = "em_st_042";
    }

    bonus.type = type;
    bonus.isPowerupDrop = true;

    bonusIcon = bonus createPowerupHeadIcon(bonusIcon);
    if (type == DROPTYPE_FREEZE)
        bonusIcon.color = (0.1, 0.9, 0.9);
    bonus.icon = bonusIcon;

    bonus thread startBonusFlash();

    level thread checkForPowerupCollection(bonus);
    bonus thread rotatePowerup();

    return bonus;
}
rotatePowerup()
{
    self endon ("death");
    while (isDefined(self))
    {
        self rotateYaw(360, 4);
        wait(4);
    }
}
checkForPowerupCollection(bonus)
{
    level endon("game_ended");
    bonus endon("collected");
    bonus endon("death");

    while (true)
    {
        if (!isDefined(bonus) || !isDefined(bonus.type)) break;

        foreach (player in level.players)
        {
            if (!player.isAlive || distanceSquared(player.origin + (0, 0, 60), bonus.origin) > 4225 || player.sessionTeam != "allies") continue;
            if (bonus.type == DROPTYPE_GUN && (player.isDown || isWeaponDeathMachine(player getCurrentWeapon()))) continue;

            player thread activateBonusDrop(bonus);
            if (isDefined(bonus.attachedFX))
            {
                fx = bonus.attachedFX;
                fx delete();
            }
            if (bonus.type != DROPTYPE_NUKE && bonus.type != DROPTYPE_FREEZE)
            {
                bonus.isPowerupDrop = undefined;
                bonus.icon destroy();
                bonus delete();
            }

            bonus notify("collected");
            break;
        }

        wait(0.1);
    }
}
startBonusFlash()
{
    self endon("collected");

    wait(20);

    if (!isDefined(self)) return;

    self thread bonusFlash();

    wait(10);

    if (!isDefined(self)) return;
    if (isDefined(self.attachedFX))
    {
        self.attachedFX delete();
    }
    self.isPowerupDrop = undefined;
    self.icon destroy();
    self delete();
}
bonusFlash()
{
    self endon("collected");
    
    if (!isDefined(self)) return;

    while(isDefined(self.isPowerupDrop) && isDefined(self))
    {
        self hide();

        wait(1);

        if (!isDefined(self.isPowerupDrop))
            break;

        self show();

        wait(1);
    }
}

doNuke(bonus)
{
    bonus unlink();//In case this came from the AC130 and is attached to the mover
    bonus playSound("veh_mig29_sonic_boom");
    bonus moveTo(bonus.origin + (0, 0, 3000), 6);

    wait(6);

    physicsExplosionSphere(bonus.origin, 5000000, 5000000, 10);
    playFx(level.fx_explode, bonus.origin);

    level thread user_scripts\mp\aizombies\_aiz_bot_util::nukeDetonation(false);
    bonus delete();
    bonus.icon destroy();
    if (isPrivateMatch())
        setSlowMotion(1, 0.5, 0.4);
    else
		setDvar("timescale", 0.5);

    wait(2);

    foreach (player in level.players)
    {
        if (!player.isAlive || !isDefined(player.cash)) continue;

        if (player.hasDoublePoints)
        {
            player.cash += 800;
            player thread scorePopup(800);
        }
        else
        {
            player.cash += 400;
            player thread scorePopup(400);
        }
    }

    thread powerupText(level.gameStrings[208], 0.85, (25.5, 25.5, 25.5), (0.9, 0.9, 0.1), 0.2);
    thread powerupIcon("dpad_killstreak_nuke");

    if (isPrivateMatch())
        setSlowMotion(0.5, 1, 1);
    else
		setDvar("timescale", 1);
}
doFreezer(bonus)
{
    bonus unlink();//In case this came from the AC130 and is attached to the mover
    bonus playSound("veh_mig29_sonic_boom");
    bonus moveTo(bonus.origin + (0, 0, 3000), 5);
    thread powerupText(level.gameStrings[210], 0.85, (25.5, 25.5, 25.5), (0.1, 0.9, 0.9), 0.2);
    thread powerupIcon("dpad_killstreak_emp", (0.1, 0.9, 0.9));

    wait(5);

    playSoundAtPos(bonus.origin, "emp_activate");
    playFX(level.fx_nuke2, bonus.origin);
    level.freezerActivated = true;
    bonus delete();
    bonus.icon destroy();

    wait(10);
    
    level.freezerActivated = false;

    foreach (player in level.players)
    {
        if (!player.isAlive || !isDefined(player.cash)) continue;

        if (player.hasDoublePoints)
        {
            player.cash += 400;
            player thread scorePopup(400);
        }
        else
        {
            player.cash += 200;
            player thread scorePopup(200);
        }

        player thread textPopup(level.gameStrings[210]);
    }
}
giveRandomPerk(perk)
{
    ownedPerks = self getOwnedPerks();
    if (!array_contains(ownedPerks, false)) return;//Owns all perks, give up on life...

    if (!isDefined(perk))
    {
        perk = randomInt(7);
    }

    if (ownedPerks[perk])
    {
        //re-roll
        randomPerk = randomInt(7);
        randomPerk++;
        self thread giveRandomPerk(randomPerk);
        return;
    }

    self thread textPopup(level.gameStrings[99]);

    switch (perk)
    {
        case 0:
            self.maxHealth = 250;
            self.health = self.maxHealth;
            self.lastBoughtPerk = "em_st_087";
            break;
        case 1:
            self givePerk("specialty_lightweight", false);
            //self givePerk("specialty_marathon", false);
            self givePerk("specialty_longersprint", false);
            self.lastBoughtPerk = "em_st_207";
            break;
        case 2:
            self givePerk("specialty_fastreload", false);
            //self givePerk("specialty_quickswap", false);
            self givePerk("specialty_quickdraw", false);
            self.lastBoughtPerk = "em_st_208";
            break;
        case 3:
            self.ammoMatic = true;
            self.lastBoughtPerk = "em_st_039";
            break;
        case 4:
            self givePerk("specialty_bulletdamage", false);
            self.lastBoughtPerk = "em_st_212";
            break;
        case 5:
            self givePerk("specialty_bulletaccuracy", false);
            self.lastBoughtPerk = "em_st_218";
            break;
        case 6:
            self.autoRevive = true;
            self.lastBoughtPerk = "em_st_221";
            break;
        case 7:
            self.hasDoublePoints = true;
            self.lastBoughtPerk = "em_st_214";
            break;
    }

    if (perk != 6) self.perksBought[perk] = true;
    else self.perksBought[perk] += 1;

    perkIcon = newClientHudElem(self);
    perkIcon[0] = 0 * perk;
    perkIcon[1] = -54;
    perkIcon.alignX = "left";
    perkIcon.alignY = "bottom";
    perkIcon.vertAlign = "bottom_adjustable";
    perkIcon.horzAlign = "left";
    perkIcon setShader(self.lastBoughtPerk, 128, 128);
    perkIcon.foreground = true;
    perkIcon.hideWhenInMenu = true;
    perkIcon.alpha = 1;
    perkIcon scaleOverTime(1, 30, 30);

    wait(1);

    perkIcon destroy();
    self updatePerksHud(false, true);
}