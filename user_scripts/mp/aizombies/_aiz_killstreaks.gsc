#include user_scripts\mp\aizombies\_aiz;
#include user_scripts\mp\aizombies\_aiz_hud;
#include user_scripts\mp\aizombies\_aiz_bot_util;
#include common_scripts\utility;
#include maps\mp\_utility;

init()
{
    if (getDvarInt("aiz_enabled") == 0)
        return;

    level.nukeInbound = false;
    level.nukeTime = 10;

    if (!isDefined(level.botAnims))
    {
        level.botAnims = [];
    }
    level.botAnims["idle"] = "mp_stand_idle";
    level.botAnims["idleRPG"] = "mp_rpg_idle";
    level.botAnims["idleMG"] = "mp_stand_idle";
    level.botAnims["idlePistol"] = "mp_pistol_stand_idle";
    level.botAnims["run"] = "pb_sprint_assault";
    level.botAnims["runSMG"] = "pb_sprint_smg";
    level.botAnims["runMG"] = "pb_sprint_lmg";
    level.botAnims["runPistol"] = "mp_pistol_sprint";
    level.botAnims["runSniper"] = "pb_sprint_sniper";
    level.botAnims["runShotgun"] = "pb_sprint_shotgun";
    level.botAnims["runRPG"] = "mp_rpg_sprint";
    level.botAnims["shoot"] = "pt_stand_shoot";
    level.botAnims["shootRPG"] = "pt_stand_shoot_RPG";
    level.botAnims["shootMG"] = "pt_stand_shoot_auto";
    level.botAnims["shootPistol"] = "pt_stand_shoot_pistol";
    level.botAnims["reload"] = "mp_stand_reload";
    level.botAnims["reloadRPG"] = "mp_rpg_reload";
    level.botAnims["reloadPistol"] = "mp_pistol_stand_reload";
    level.botAnims["reloadMG"] = "mp_stand_reload";
    level.botWeaponModel_subBot = "h2_ump45_mp";
    level.botWeapon_subBot = "h2_ump45_mp";
    level.botWeaponModel_LMGBot = "h2_sa80_mp";
    level.botWeapon_LMGBot = "h2_sa80_mp";

    level.heliHeight = 1500;
    level.airstrikeOut = false;
    level.UAVModel = undefined;

    level.visionRestored = false;

    thread initUAVRig();
}

checkKillstreak(bypassSound)
{
    if (isDefined(bypassSound)) self playLocalSound("mp_level_up");
    streak = self.kills;
    if (streak == 25)
    {
        self thread textPopup2(level.gameStrings[177]);
    }
    else if (streak == 50)
    {
        self thread maps\mp\gametypes\_hardpoints::hardpointNotify("predator_mp", streak);
        self giveWeapon("predator_mp", 0, false);
        self setActionSlot(4, "weapon", "predator_mp");
        self addKillstreakToList("predator_missile");
        announcement(self.name + " ^3has got the Predator Missile");
    }
    else if (streak == 75)
    {
        self iPrintLnBold(level.gameStrings[178]);
        self thread giveRandomKillstreak(1, false);
    }
    else if (streak == 100)
    {
        self thread maps\mp\gametypes\_hardpoints::hardpointNotify("sentry_mp", streak);
        self giveWeapon("sentry_mp", 0, false);
        self setActionSlot(4, "weapon", "sentry_mp");
        self addKillstreakToList("sentry");
        announcement(self.name + " ^3has got a Sentry Gun");
    }
    else if (streak == 125)
    {
        if (isIndoorMap())
        {
            self thread giveRandomKillstreak(1, false);
        }
        else
        {
            self thread maps\mp\gametypes\_hardpoints::hardpointNotify("airstrike_mp", streak);
            self giveWeapon("counter_radar_mp", 0, false);
            self setActionSlot(4, "weapon", "counter_radar_mp");
            self addKillstreakToList("airstrike");
            announcement(self.name + " ^3has got the Airstrike");
        }
    }
    else if (streak == 150)
    {
        self iPrintLnBold(level.gameStrings[179]);
        self thread giveRandomKillstreak(4, false);
    }
    else if (streak == 250)
    {
        self thread maps\mp\gametypes\_hardpoints::hardpointNotify("emp_mp", streak);
        self giveWeapon("emp_mp", 0, false);
        self setActionSlot(4, "weapon", "emp_mp");
        self addKillstreakToList("emp");
        announcement(self.name + " ^3has got the Vision Restorer");
    }
    else if (streak == 275)
    {
        if (isIndoorMap())
        {
            self thread giveRandomKillstreak(1, false);
        }
        else
        {
            self thread maps\mp\gametypes\_hardpoints::hardpointNotify("stealth_airstrike_mp", streak);
            self giveWeapon("helicopter_mp", 0, false);
            self setActionSlot(4, "weapon", "helicopter_mp");
            self addKillstreakToList("super_airstrike");
            announcement(self.name + " ^3has got the Super Airstrike");
        }
    }
    else if (streak == 400)
    {
        if (isIndoorMap())
        {
            self thread giveRandomKillstreak(1, false);
        }
        else
        {
            self thread maps\mp\gametypes\_hardpoints::hardpointNotify("pavelow_mp", streak);
            self giveWeapon("pavelow_mp", 0, false);
            self setActionSlot(4, "weapon", "pavelow_mp");
            self addKillstreakToList("overwatch");
            announcement(self.name + " ^3has got an Overwatch");
        }
    }
    else if (streak == 650)
    {
        self thread maps\mp\gametypes\_hardpoints::hardpointNotify("nuke_mp", streak);
        self giveWeapon("nuke_mp", 0, false);
        self setActionSlot(4, "weapon", "nuke_mp");
        self addKillstreakToList("nuke");
        announcement(self.name + " ^3has earned the Tactical Nuke");
    }
    /*
    else if (streak == 1000 && !self.ownsBot)
    {
        self.ownsBot = true;
        self iPrintLnBold(level.gameStrings[216]);
        self spawnBotForPlayer();
        wait(1);
        self iPrintLnBold(level.gameStrings[217]);
    }
    */
    else if (streak == 175)
    {
        //self iPrintLnBold(level.gameStrings[218], level.gameStrings[226]);
        self thread textPopup2(level.gameStrings[236]);
        self playLocalSound("mp_killstreak_radar");
        self giveWeapon("radar_mp", 0, false);
        self setActionSlot(4, "weapon", "radar_mp");
        self addKillstreakToList("sub_bot");
        announcement(self.name + " ^3Has got the Sub Team");
    }
    else if (streak == 300)
    {
        //self iPrintLnBold(level.gameStrings[218], level.gameStrings[227]);
        self thread textPopup2(level.gameStrings[237]);
        self playLocalSound("mp_killstreak_juggernaut");
        self giveWeapon("radar_mp", 0, false);
        self setActionSlot(4, "weapon", "radar_mp");
        self addKillstreakToList("lmg_bot");
        announcement(self.name + " ^3Has got the LMG Team");
    }

    self shuffleStreaks();//update HUD
}

addKillstreakToList(streakName)
{
    firstOpenSlot = undefined;
    for (i = 0; i < self.killstreaksList.size; i++)
    {
        if (self.killstreaksList[i] == "none")
        {
            firstOpenSlot = i;
            break;
        }
    }

    if (!isDefined(firstOpenSlot))
    {
        //Shuffle all streaks back one, removing the last one
        for (i = 0; i < self.killstreaksList.size - 1; i++)
        {
            self.killstreaksList[i] = self.killstreaksList[i + 1];
        }
        self.killstreaksList[self.killstreaksList.size - 1] = "none";
        firstOpenSlot = self.killstreaksList.size - 1;
    }

    self.killstreaksList[firstOpenSlot] = streakName;
}
removeLastKillstreak(streakName)
{
    lastValidSlot = undefined;
    for (i = self.killstreaksList.size - 1; i >= 0; i--)
    {
        if (isDefined(streakName))
        {
            if (self.killstreaksList[i] == streakName)
            {
                lastValidSlot = i;
                break;
            }
        }
        else if (self.killstreaksList[i] != "none")
        {
            lastValidSlot = i;
            break;
        }
    }

    if (!isDefined(lastValidSlot))
        return;

    self.killstreaksList[lastValidSlot] = "none";
}
getNextAvailableStreak()
{
    for (i = self.killstreaksList.size - 1; i >= 0; i--)
    {
        if (self.killstreaksList[i] != "none")
        {
            return self.killstreaksList[i];
        }
    }

    return "none";
}
hasKillstreak(streakName)
{
    for (i = self.killstreaksList.size - 1; i >= 0; i--)
    {
        if (self.killstreaksList[i] == streakName)
        {
            return true;
        }
    }

    return false;
}
giveRandomKillstreak(streaks, bought)
{
    for (i = 0; i < streaks; i++)
    {
        if (!bought) wait(3);

        randomKS = randomIntRange(0, 8);
        if (isIndoorMap())
        {
            while (randomKS == 2 || randomKS == 3 || randomKS == 4)
                randomKS = randomIntRange(0, 8);
        }
        self giveKillstreak(randomKS);
    }

    suffix = "";
    if (streaks > 1)
        suffix = "s";
    if (bought)
        announcement(self.name + " Bought a " + getKillstreakName(randomKS));
    else announcement(self.name + " ^3has got " + streaks + " random killstreak" + suffix);
}
giveKillstreak(streak)
{
    oldStreak = self.kills;
    switch (streak)
    {
        case 0:
            streak = 50;
            break;
        case 1:
            streak = 100;
            break;
        case 2:
            streak = 125;
            break;
        case 3:
            streak = 275;
            break;
        case 4:
            streak = 400;
            break;
        case 5:
            streak = 650;
            break;
        case 6:
            streak = 175;
            break;
        case 7:
            streak = 300;
            break;
        default:
            return;
    }
    self.kills = streak;
    self checkKillstreak(false);
    self.kills = oldStreak;
}
getKillstreakName(streak)
{
    switch (streak)
    {
        case 0:
            return level.gameStrings[305];
        case 1:
            return level.gameStrings[303];
        case 2:
            return level.gameStrings[315];
        case 3:
            return level.gameStrings[306];
        case 4:
            return level.gameStrings[222];
        case 5:
            return level.gameStrings[307];
        case 6:
            return "Sub Team";
        case 7:
            return "LMG Team";
        default:
            return "";
    }
}
takeKillstreakWeapon(killstreakName)
{
    weapon = undefined;
    if (killstreakName == "predator_missile")
        weapon = "predator_mp";
    else if (killstreakName == "airstrike")
        weapon = "counter_radar_mp";
    else if (killstreakName == "sentry")
        weapon = "sentry_mp";
    else if (killstreakName == "emp")
        weapon = "emp_mp";
    else if (killstreakName == "nuke")
        weapon = "nuke_mp";
    else if (killstreakName == "lmg_bot" || killstreakName == "sub_bot")
        weapon = "radar_mp";
    else if (killstreakName == "overwatch")
        weapon = "pavelow_mp";
    else if (killstreakName == "super_airstrike")
        weapon = "helicopter_mp";

    wait(0.8);

    if (!self hasKillstreak(killstreakName))
    {
        if ((killstreakName == "lmg_bot" || killstreakName == "sub_bot") && (self hasKillstreak("sub_bot") || self hasKillstreak("lmg_bot")))//Do not take the weapon if we still have a bot to use
            return;

        self takeWeapon(weapon);
    }
}

executeKillstreak(newWeap)
{
    if (!isDefined(self.isDown)) return;
    if (level.gameEnded) return;

    self user_scripts\mp\aizombies\_aiz_hud::updateAmmoHud(false);
    if (newWeap != self getCurrentWeapon()) return;

    if (self hasKillstreak("predator_missile") && newWeap == "predator_mp")
    {
        self thread launchMissile();
        self switchToWeapon(self.lastDroppableWeapon);
        self thread takeKillstreakWeapon("predator_missile");
    }
    else if (self hasKillstreak("sentry") && newWeap == "sentry_mp")
    {
        self spawnSentry(false);
        //sentryModel = self spawnSentry();
        //if (isDefined(sentryModel))
        //self thread sentryHoldWatcher(sentryModel, true);
        self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
        //self disableWeapons();
    }
    else if (self hasKillstreak("emp") && newWeap == "emp_mp")
    {
        self thread visionRestore();
        self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
        self thread takeKillstreakWeapon("emp");
    }
    else if (self hasKillstreak("nuke") && newWeap == "nuke_mp")
    {
        success = self nuke();

        if (!success)
        {
            self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
            return;
        }

        self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
        self thread takeKillstreakWeapon("nuke");
    }
    else if (newWeap == "radar_mp" && self getNextAvailableStreak() == "lmg_bot")
    {
        if (isDefined(self.bot))
        {
            self iPrintLnBold(level.gameStrings[219]);
            self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
            return;
        }

        self spawnBotForPlayer(level.botWeapon_LMGBot, 90);
        self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
        self thread takeKillstreakWeapon("lmg_bot");
    }
    else if (newWeap == "radar_mp" && self getNextAvailableStreak() == "sub_bot")
    {
        if (isDefined(self.bot))
        {
            self iPrintLnBold(level.gameStrings[219]);
            self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
            return;
        }

        self spawnBotForPlayer(level.botWeapon_subBot, 120);
        self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
        self thread takeKillstreakWeapon("sub_bot");
    }
    else if (self hasKillstreak("airstrike") && newWeap == "counter_radar_mp")
    {
        if (level.airstrikeOut)
        {
            self iPrintLnBold(level.gameStrings[220]);
            self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
            return;
        }

        self airStrike();
        self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
        self thread takeKillstreakWeapon("airstrike");
    }
    else if (self hasKillstreak("super_airstrike") && newWeap == "helicopter_mp")
    {
        if (level.airstrikeOut)
        {
            self iPrintLnBold(level.gameStrings[220]);
            self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
            return;
        }

        self superAirStrike();
        self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
        self thread takeKillstreakWeapon("super_airstrike");
    }
    else if (self hasKillstreak("overwatch") && newWeap == "pavelow_mp")
    {
        if (self.overwatchOut)
        {
            self iPrintLnBold(level.gameStrings[220]);
            self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
            return;
        }

        self callOverwatch();
        self thread switchToWeapon_delay(self.lastDroppableWeapon, 0.75);
        self thread takeKillstreakWeapon("overwatch");
    }
}

shuffleStreaks()
{
    nextStreak = getNextAvailableStreak();

    if (nextStreak == "none")
    {
        slot = self.hud_killstreakSlot;
        //slot setShader("weapon_missing_image", 24, 24);
        slot.alpha = 0;
        return;
    }

    self giveNextStreakWeapon(nextStreak);

    //Set the HUD for this
    streakIcon = "";
    if (nextStreak == "predator_missile")
        streakIcon = "dpad_killstreak_hellfire_missile";
    else if (nextStreak == "airstrike")
        streakIcon = "dpad_killstreak_precision_airstrike";
    else if (nextStreak == "sentry")
        streakIcon = "dpad_killstreak_sentry_minigun";
    else if (nextStreak == "sub_bot")
        streakIcon = "group_icon";
    else if (nextStreak == "emp")
        streakIcon = "dpad_killstreak_emp";
    else if (nextStreak == "nuke")
        streakIcon = "dpad_killstreak_nuke";
    else if (nextStreak == "lmg_bot")
        streakIcon = "group_icon";
    else if (nextStreak == "overwatch")
        streakIcon = "dpad_killstreak_helicopter_flares";
    else if (nextStreak == "super_airstrike")
        streakIcon = "dpad_killstreak_stealth_bomber";

    if (!self.aizHud_created) return;

    slot = self.hud_killstreakSlot;
    slot.alpha = 1;
    slot setShader(streakIcon, 24, 24);
}
giveNextStreakWeapon(nextStreak)
{
    if (nextStreak == "predator_missile")
    {
        self giveWeapon("predator_mp");
        self setActionSlot(4, "weapon", "predator_mp");
    }
    else if (nextStreak == "airstrike")
    {
        self giveWeapon("counter_radar_mp");
        self setActionSlot(4, "weapon", "counter_radar_mp");
    }
    else if (nextStreak == "sentry")
    {
        self giveWeapon("sentry_mp");
        self setActionSlot(4, "weapon", "sentry_mp");
    }
    else if (nextStreak == "sub_bot")
    {
        self giveWeapon("radar_mp");
        self setActionSlot(4, "weapon", "radar_mp");
    }
    else if (nextStreak == "emp")
    {
        self giveWeapon("emp_mp");
        self setActionSlot(4, "weapon", "emp_mp");
    }
    else if (nextStreak == "nuke")
    {
        self giveWeapon("nuke_mp");
        self setActionSlot(4, "weapon", "nuke_mp");
    }
    else if (nextStreak == "lmg_bot")
    {
        self giveWeapon("radar_mp");
        self setActionSlot(4, "weapon", "radar_mp");
    }
    else if (nextStreak == "overwatch")
    {
        self giveWeapon("pavelow_mp");
        self setActionSlot(4, "weapon", "pavelow_mp");
    }
    else if (nextStreak == "super_airstrike")
    {
        self giveWeapon("helicopter_mp");
        self setActionSlot(4, "weapon", "helicopter_mp");
    }
}

spawnSentry()
{
    if (self.isCarryingSentry) return;

    weapon = "sentry_minigun_mp";
    model = "sentry_minigun";

    turret = spawnTurret("misc_turret", self.origin, weapon);
    turret.angles = (0, self getPlayerAngles()[1], 0);
    turret setModel(model);
    turret.baseModel = model;
    //turret.health = 1000;
    //turret setCanDamage(true);
    turret makeTurretInOperable();
    turret setRightArc(80);
    turret setLeftArc(80);
    turret setBottomArc(50);
    turret makeUnUsable();
    turret setDefaultDropPitch(-89.0);
    turret setTurretModeChangeWait(true);
    turret setMode("sentry_offline");
    turret.owner = self;
    turret setTurretTeam("allies");
    turret setSentryOwner(self);
    turret.isSentry = true;

    turret setTurretMinimapVisible(true);
    objID = maps\mp\gametypes\_gameobjects::getNextObjID();
    turret.objID = objID;

    turret.isBeingCarried = false;
    turret.canBePlaced = true;
    turret.timeLeft = 90;
    turret.target = turret;
    turret.sentryType = "sentry_minigun";
    turret.momentum = 0;
    trigger = spawn("script_origin", turret.origin);
    turret.trigger = trigger;
    trigger linkTo(turret, "tag_origin");
    trigger.turret = turret;
    trigger user_scripts\mp\aizombies\_aiz_map_edits::addUsable("sentryPickup", 96);

    turret thread sentry_timer();
    turret thread sentry_targeting();
    self pickupSentry(turret, true);

    self thread watchPlayerDisconnect(turret);
}

watchPlayerDisconnect(sentry)
{
    sentry endon("sentry_destroyed");

    self waittill_any("death", "disconnect");

    sentry thread destroySentry();
}
pickupSentry(sentry, canCancel)
{
    if (sentry.isBeingCarried || self.isCarryingSentry || self != sentry.owner) return;

    sentry clearTargetEntity();
    sentry setMode("sentry_offline");
    sentry.isBeingCarried = true;
    self.isCarryingSentry = true;
    self.isCarryingSentry_alt = true;//Used to fix a bug allowing players to 'faux-cancel' a placement causing a persistant sentry being held
    sentry.canBePlaced = true;
    self disableWeapons();
    //sentry setCanDamage(false);
    sentry setSentryCarrier(self);
    sentry setModel(sentry.baseModel + "_obj");

    self thread sentryHoldWatcher(sentry, canCancel);
}
sentryHoldWatcher(sentry, canCancel)
{
    level endon("game_ended");
    self endon("death");
    self endon("disconnect");

    sentry endon("death");

    lastCanBePlaced = sentry.canBePlaced;

    while (true)
    {
        wait(0.05);

        placement = self canPlayerPlaceSentry();
        sentry.canBePlaced = self isOnGround() && placement["result"];
        if (level._mapname == "mp_fuel2" && level.mapVariation == 0) sentry.canBePlaced = true;
        sentry.origin = placement["origin"];
        sentry.angles = placement["angles"];

        if (sentry.canBePlaced != lastCanBePlaced)
        {
            if (sentry.canBePlaced)
            {
                sentry setModel(sentry.baseModel + "_obj");
            }
            else
            {
                sentry setModel(sentry.baseModel + "_obj_red");
            }

            lastCanBePlaced = sentry.canBePlaced;
        }

        if (sentry.canBePlaced && self.isCarryingSentry && self attackButtonPressed() && self isOnGround())
        {
            self enableWeapons();
            if (canCancel)
            {
                self teamSplash("callout_used_sentry");
                self takeWeapon("sentry_mp");
                self switchToWeapon(self.lastDroppableWeapon);
                self removeLastKillstreak("sentry");
                self shuffleStreaks();
            }
            self.isCarryingSentry = false;
            self.isCarryingSentry_alt = undefined;
            sentry setSentryCarrier(undefined);
            sentry.isBeingCarried = false;
            sentry setModel(sentry.baseModel);
            sentry playSound("sentry_gun_plant");
            sentry setMode("sentry");
            return;
        }
    }
}

sentry_timer()
{
    level endon("game_ended");
    self endon("sentry_destroyed");

    while (true)
    {
        wait(1);

        if (level.gameEnded)
        {
            self thread destroySentry();
            break;
        }
        if (!self.isBeingCarried)
        {
            self.timeLeft--;
            if (self.timeLeft <= 0 || !isDefined(self.owner) || !self.owner.isAlive)
            {
                self thread destroySentry();
                break;
            }
        }
    }
}
sentry_targeting()
{
    level endon("game_ended");
    self endon("death");
    self endon("sentry_destroyed");

    while (true)
    {
        if (level.gameEnded) break;
        if (self.timeLeft > 0)
        {
            wait(0.1);

            if (!self.isBeingCarried)
            {
                self.targetEnt = undefined;
                foreach (b in level.botsInPlay)
                {
                    if (!b.isAlive) continue;

                    botHitbox = b.hitbox;

                    tracePass = sightTracePassed(self getTagOrigin("tag_flash"), botHitbox.origin, false, botHitbox);
                    if (!tracePass)
                        continue;

                    yaw = vectorToAngles(botHitbox.origin - self.origin)[1];
                    clamp = yaw - self.angles[1];
                    if (clamp < 290 && clamp > 70)
                        continue;

                    self.targetEnt = botHitbox;
                    break;
                }

                if (isDefined(self.targetEnt))
                {
                    self setTargetEntity(self.targetEnt);
                    self shootTurret();
                    /*
                    if (self.momentum == 0)
                    {
                        self thread maps\mp\h2_killstreaks\_autosentry::sentry_spinUp();
                        self StartBarrelSpin();
                    }
                    */
                }
                else
                {
                    self clearTargetEntity();
                    //self maps\mp\h2_killstreaks\_autosentry::sentry_spinDown();
                    //self StopBarrelSpin();
                }
            }
        }
        else break;
    }
}

destroySentry()
{
    if (!isDefined(self.isSentry))
        return;

    self.timeLeft = 0;

    self notify("sentry_destroyed");

    trigger = self.trigger;
    if (isDefined(trigger))
        trigger user_scripts\mp\aizombies\_aiz_map_edits::removeUsable();

    //fx = self.flashFx;
    //if (isDefined(fx))
        //fx delete();

    self clearTargetEntity();
    self setCanDamage(false);
    self setDefaultDropPitch(40);
    self setMode("sentry_offline");
    self.health = 0;
    self setModel(self.baseModel + "_destroyed");
    self playSound("sentry_explode");

    owner = self.owner;
    if (isDefined(owner) && owner.isAlive)
    {
        owner playLocalSound("US_1mc_sentry_gone");
    }

    wait(7);

    playFX(level.fx_sentryExplode, self);

    //objID = self.objID;
    self.objID = undefined;
    self.owner = undefined;
    self.isSentry = undefined;
    self delete();
}

launchMissile()
{
    self thread textPopup2(level.gameStrings[302]);
    self removeLastKillstreak("predator_missile");
    //foreach (player in level.players) 
    self playSound("US_1mc_use_predator");
    self shuffleStreaks();

    if (level.botsInPlay.size != 0) randomTarget = randomInt(level.botsInPlay.size);
    else randomTarget = undefined;
    randomSpawn = randomInt(level.botSpawns.size);

    if (isDefined(randomTarget)) missile = spawn("script_model", level.botsInPlay[randomTarget].origin + (0, 0, 10000));
    else if (level.botSpawns.size > 0) missile = spawn("script_model", level.botSpawns[randomSpawn] + (0, 0, 10000));
    else missile = undefined;

    if (!isDefined(missile)) return;

    missile setModel("projectile_cbu97_clusterbomb");
    missile.angles = (90, 0, 0);
    missile moveTo(missile.origin - (0, 0, 9950), 4);
    missile playLoopSound("move_remotemissile_proj_flame");

    wait(4.05);

    physicsExplosionSphere(missile.origin, 400, 200, 7);
    playFX(level.fx_explode, missile.origin);
    //missile stopLoopSound();
    playSoundAtPos(missile.origin, "exp_remote_missile");
    radiusDamage(missile.origin, 1500, 100000, 100, self);
    missile delete();
}

visionRestore()
{
    self teamSplash("callout_used_emp");
        
    self removeLastKillstreak("emp");
    self shuffleStreaks();

    level.visionRestored = true;
    visionSetNaked(level.vision, 1);
    visionSetPain("near_death_mp");

    foreach (player in level.players)
    {
        if (!player.isAlive) continue;
        player playLocalSound("emp_activate");

        player visionSetNakedForPlayer("end_game2", 0.5);

        wait(0.8);
        if (!isMW2CRMap()) level.vision = level._mapname;
        if (level._mapname == "mp_subbase")//Fix bright vision
            level.vision = "armada_water";
        if (!player.isDown && !level.isBossWave) player visionSetNakedForPlayer(level.vision);
        else if (!player.isDown && (level.isBossWave || level.isCrawlerWave)) player visionSetNakedForPlayer(level.bossVision);
        else player visionSetNakedForPlayer("cheat_bw");
    }
}

initUAVRig()
{
    while(!isDefined(level.UAVRig))
        wait(0.05);

    if(level._mapname == "mp_highrise" && level.mapVariation == 0)
	{
	    level.UAVRig.origin = (-4162,12006,4954);
	}
	if(level._mapname == "mp_highrise" && level.mapVariation == 1)
	{
	    level.UAVRig.origin = (5395,8284,6450);
	}
	else if(level._mapname == "mp_invasion")
	{
	    level.UAVRig.origin = (9212,6628,3347);
	}
	else if(level._mapname == "mp_rust")
	{
	    level.UAVRig.origin = (1157,-7193,2164);
	}
	else if(level._mapname == "mp_brecourt")
	{
	    level.UAVRig.origin = (10154,10188,3550);
	}
	else if(level._mapname == "mp_afghan")
	{
	    level.UAVRig.origin = (-5668,-1769,1469);
	}
	else if(level._mapname == "mp_storm")
	{
	    level.UAVRig.origin = (4382,-4031,2282);
	}
	else if(level._mapname == "mp_fuel2")
	{
	    level.UAVRig.origin = (12014,29169,14071);
	}
	else if(level._mapname == "mp_complex")
	{
	    level.UAVRig.origin = (-834,994,1763);
	}
	else if(level._mapname == "mp_overgrown")
	{
	    level.UAVRig.origin = (-1933,-7601,1306);
	}
	else if(level._mapname == "mp_crash")
	{
	    level.UAVRig.origin = (-2029,-868,2390);
	}
}
airStrike()
{
    self removeLastKillstreak("airstrike");
    self shuffleStreaks();
    self playSound("US_1mc_use_airstrike");
    self teamSplash("callout_used_precision_airstrike");
    self thread textPopup2(level.gameStrings[315]);
    level thread doAirstrike(self, false);
}
superAirStrike()
{
    self removeLastKillstreak("super_airstrike");
    self shuffleStreaks();
    self playSound("US_1mc_use_ac130");
    self teamSplash("callout_used_ac130");
    self thread textPopup2(level.gameStrings[339]);
    level thread doAirstrike(self, true);
}
doAirstrike(owner, isSuper)
{
    level.airstrikeOut = true;

    origin = level.UAVRig getTagOrigin("tag_origin");
    level.UAVModel = spawn("script_model", origin);
	level.UAVModel setModel("vehicle_ac130_low_mp");
    level.UAVModel playLoopSound("veh_ac130_ext_dist");
    level.UAVModel.owner = owner;

    angle = randomInt(360);
	radiusOffset = randomInt(2000) + 5000;

	xOffset = cos(angle) * radiusOffset;
	yOffset = sin(angle) * radiusOffset;
    zOffset = randomIntRange(10000, 11000);
    angleVector = vectorNormalize((xOffset, yOffset, zOffset));
	angleVector = angleVector * randomIntRange(6000, 7000);
    level.UAVModel linkTo(level.UAVRig, "tag_origin", angleVector, (0, angle - 90, 0));

    level.UAVModel thread airstrikeTargeting(owner, isSuper);
}
airstrikeTargeting(owner, isSuper)
{
    level endon("game_ended");
    self endon("death");

    if (isSuper)
    {
        for(i = 0; i < 11; i++)
        {
            wait(1);

            targetEnt = undefined;
            tmpDist = 999999999;
            foreach (b in level.botsInPlay)
            {
                if (!b.isAlive) continue;

                botHitbox = b.hitbox;
                botOrigin = botHitbox.origin;
                dist = distanceSquared(botOrigin, self.origin);
                if (dist > tmpDist)
                    continue;

                tmpDist = dist;
                targetEnt = botHitbox;
                break;
            }

            if (isDefined(targetEnt))
            {
				switch(randomInt(5))
				{
					case 0:
                        for(c = 0; c < 3; c++)
                        {
                            rocket = magicBullet("ac130_105mm_mp", self.origin - (0, 0, 30), targetEnt.origin);
                            rocket.owner = owner;
                            wait(0.5);
                        }
					break;
					case 1:
                        for(a = 0; a < 10; a++)
                        {
                            rocket = magicBullet("ac130_40mm_mp", self.origin - (0, 0, 30), targetEnt.origin);
                            rocket.owner = owner;
                            wait(0.5);
                        }
					break;
					case 2:
                        for(b = 0; b < 20; b++)
                        {
                            rocket = magicBullet("ac130_25mm_mp", self.origin - (0, 0, 30), targetEnt.origin);
                            rocket.owner = owner;
                            wait(0.02);
                        }
					break;
					case 3:
                        for(d = 0; d < 10; d++)
                        {
                            rocket = magicBullet("javelin_mp", self.origin - (0, 0, 30), targetEnt.origin);
                            rocket.owner = owner;
                            wait(0.15);
                        }
					break;
					case 4:
                        for(e = 0; e < 10; e++)
                        {
                            rocket = magicBullet("at4_mp", self.origin - (0, 0, 30), targetEnt.origin);
                            rocket.owner = owner;
                            wait(0.15);
                        }
					break;
				}
                wait(1);
            }
            else
            {
                i--;
                wait(1);
            }
        }
    }
    else
    {
        for(i = 0; i < 15; i++)
        {
            wait(1);

            targetEnt = undefined;
            tmpDist = 999999999;
            foreach (b in level.botsInPlay)
            {
                if (!b.isAlive) continue;

                botHitbox = b.hitbox;
                botOrigin = botHitbox.origin;
                dist = distanceSquared(botOrigin, self.origin);
                if (dist > tmpDist)
                    continue;

                tmpDist = dist;
                targetEnt = botHitbox;
                break;
            }

            if (isDefined(targetEnt))
            {
                switch(randomInt(3))
                {
                    case 0:
                        rocket = magicBullet("ac130_105mm_mp", self.origin - (0, 0, 30), targetEnt.origin);
                        rocket.owner = owner;
                        wait(1.2);
                    break;
                    case 1:
                        for(a = 0; a < 3; a++)
                        {
                            rocket = magicBullet("ac130_40mm_mp", self.origin - (0, 0, 30), targetEnt.origin);
                            rocket.owner = owner;
                            wait(0.5);
                        }
                    break;
                    case 2:
                        for(b = 0; b < 10; b++)
                        {
                            rocket = magicBullet("ac130_25mm_mp", self.origin - (0, 0, 30), targetEnt.origin);
                            rocket.owner = owner;
                            wait(0.1);
                        }
                    break;
                }
                wait(1);
            }
            else
            {
                i--;
                wait(1);
            }
        }
    }

    self unlink();
    
    forward = anglesToForward(self.angles);
    self moveTo(self.origin + (forward * 25000), 5, 1, 0.05);

    wait(5);

    level.airstrikeOut = false;
    level.UAVModel = undefined;
    self delete();
}
callOverwatch()
{
    self removeLastKillstreak("overwatch");
    self shuffleStreaks();
    self playSound("US_1mc_use_littlebird");
    self teamSplash("callout_used_pavelow");
    self thread textPopup2(level.gameStrings[223]);
    level thread spawnOverwatchHeli(self);
}
spawnOverwatchHeli(player)
{
    player.overwatchOut = true;

    start = player.origin;
    if (level.heliHeight > start[2] && level.heliHeight - start[2] > 500)
        pathStart = (start[0] - 10000, start[1], level.heliHeight);
    else pathStart = start + (-10000, 0, 2000);

	overwatchHeli = spawnHelicopter(player, pathStart, (0, 0, 0), "pavelow_mp", "vehicle_little_bird_armed");
    overwatchHeli thread maps\mp\h2_killstreaks\_common::h2_sound_ent( "pavelow_engine_high" );
    overwatchHeli.owner = player;

	overwatchHeli.mgTurret = spawnTurret("misc_turret", overwatchHeli.origin, "pavelow_minigun_mp");
	overwatchHeli.mgTurret linkTo(overwatchHeli, "tag_minigun_attach_left", (0, 0, 0), (0, 0, 0));
	overwatchHeli.mgTurret setModel("weapon_minigun");
 	overwatchHeli.mgTurret makeTurretInoperable();
	overwatchHeli.mgTurret setMode("auto_nonai");
	overwatchHeli.mgTurret setDefaultDropPitch(0);
 	overwatchHeli.mgTurret.team = "allies";
	overwatchHeli.mgTurret setTurretTeam("allies");
	overwatchHeli.mgTurret.owner = player;

	overwatchHeli.mgTurret2 = spawnTurret("misc_turret", overwatchHeli.origin, "pavelow_minigun_mp");
	overwatchHeli.mgTurret2 linkTo(overwatchHeli, "tag_minigun_attach_right", (0, 0, 0), (0, 0, 0));
	overwatchHeli.mgTurret2 setModel("weapon_minigun");
 	overwatchHeli.mgTurret2 makeTurretInoperable();
	overwatchHeli.mgTurret2 setMode("auto_nonai");
	overwatchHeli.mgTurret2 setDefaultDropPitch(0);
 	overwatchHeli.mgTurret2.team = "allies";
	overwatchHeli.mgTurret2 setTurretTeam("allies");
	overwatchHeli.mgTurret2.owner = player;

	overwatchHeli vehicle_SetSpeed(50, 70);
    overwatchHeli setVehGoalPos(player.origin + (0, 0, 500), 1);

    overwatchHeli waittill("goal");

	overwatchHeli thread overwatch_fireTurrets();
	overwatchHeli thread overwatch_flyToTarget();
    overwatchHeli thread overwatch_flyToOwner();
	overwatchHeli thread overwatch_timer(player);
}
overwatch_timer(player)
{
	wait(90);

	self notify("heli_leaving");

	wait(1);
	self setYawSpeed(180, 180, 180);
	self thread overwatch_spin();
	self playLoopSound("cobra_helicopter_dying_loop");
	self vehicle_SetSpeed(30,35);
    self setVehGoalPos(self.origin + (randomIntRange(-2000, 2000), randomIntRange(-2000, 2000), randomIntRange(-500, 500)), 1);
	self playSound("cobra_helicopter_hit");

	playFxOnTag(level.fx_flamethrowerImpact, self, "tag_minigun_attach_right");
	playFxOnTag(level.fx_flamethrowerImpact, self, "tag_minigun_attach_left");
	playFxOnTag(level.fx_flamethrowerImpactUpgrade, self, "tag_engine");

	wait(6);

	deathAngles = self getTagAngles("tag_deathfx");
	self playSound("cobra_helicopter_crash");
	playFx(level.fx_endGameHeliExplosion, self getTagOrigin("tag_deathfx"), anglesToForward(deathAngles), anglesToUp(deathAngles));
	self stopLoopSound();
	self delete();
	self.mgTurret delete();
	self.mgTurret2 delete();

    player.overwatchOut = false;
}
overwatch_flyToTarget()
{
	self endon("heli_leaving");

	while(true)
	{
        if (level.botsInPlay.size == 0)
        {
            wait(1);
            continue;
        }

		tmpDist = 999999999;
		pTarget = undefined;
		helicopterToTarget = undefined;
        foreach(bot in level.botsInPlay)
        {
            dist = distanceSquared(self.origin, bot.origin);
            if(dist < tmpDist)
            {
                tmpDist = dist;
                pTarget = bot;
            }
        }

		helicopterToTarget = vectorToAngles(pTarget.origin - self.origin);
		self setYawSpeed(180, 180, 180);
		self setTargetYaw(helicopterToTarget[1]);
		wait(1);
	}
}
overwatch_flyToOwner()
{
	self endon("heli_leaving");

	while(true)
	{
        targetPos = self.owner.origin + (randomIntRange(-500, 500), randomIntRange(-500, 500), 500);
        if (sightTracePassed(self.origin, targetPos, false, self))
        {
            self vehicle_SetSpeed(50, 70);
            self setVehGoalPos(targetPos, 1);
        }
		wait(15);
	}
}
overwatch_fireTurrets()
{
	self endon("heli_leaving");
    
	while(true)
	{
		for(i = 0; i < 50; i++)
		{
			tmpDist = 999999999;
			targetBot = undefined;
			foreach(bot in level.botsInPlay)
			{
				if(!bulletTracePassed(self.origin - (0, 0, 80), bot.origin + (0, 0, 70), false, self))
					continue;
				
				if(!bot.isAlive)
					continue;
				
                dist = distanceSquared(self.origin, bot.origin);
                if(dist < tmpDist)
                {
                    tmpDist = dist;
                    targetBot = bot;
                }
			}
			if(isDefined(targetBot))
			{
				self.mgTurret setTargetEntity(targetBot.hitbox);
				self.mgTurret2 setTargetEntity(targetBot.hitbox);
				self.mgTurret shootTurret();
				self.mgTurret2 shootTurret();
				wait(0.1);
			}
			else
			{
				i--;
				wait(0.1);
			}
		}
		wait(4);
	}
}
overwatch_spin()
{
	while(isDefined(self))
	{
		self setTargetYaw(self.angles[1] + (180 * 0.9));
		wait(1);
	}
}

nuke()
{
    if (level.gameEnded) return false;

    if (level.nukeInbound)
    {
        self iPrintLnBold(level.gameStrings[224]);
        return false;
    }
    level.nukeInbound = true;
    level thread playNukeWhoosh();
    self thread detonateNukeAfterTime(11, true);
    //level thread nukeSloMo();

    self teamSplash("callout_used_nuke");
    self removeLastKillstreak("nuke");
    self shuffleStreaks();

    nukeTimer = newTeamHudElem("allies");
    nukeTimer.x = 0;
    nukeTimer.y = 0;
    nukeTimer.alignX = "center";
    nukeTimer.alignY = "middle";
    nukeTimer.horzAlign = "center";
    nukeTimer.vertAlign = "middle";
    //nukeTimer setPoint("CENTER", "CENTER", 0, -75);
    nukeTimer.foreground = true;
    nukeTimer.alpha = 1;
    nukeTimer.hideWhenInMenu = true;
    nukeTimer.font = "hudbig";
    nukeTimer.fontScale = 1;
    nukeTimer.label = level.gameStrings[225];
    nukeTimer setValue(10);
    nukeTimer.color = (.7, 0, 0);
    nukeTimer.glowColor = (0, 0, .5);
    nukeTimer.glowAlpha = .2;

    level.nukeTime = 10;
    level thread nukeCountdown(nukeTimer);

    foreach (player in level.players)
        player thread nuke_restorePlayerVision();

    return true;
}
detonateNukeAfterTime(time, isStreak)
{
    if (!isDefined(time))
        time = 11;

    wait(time);

    self thread nukeDetonation(true);
}
playNukeWhoosh()
{
    wait(8);

    foreach (player in level.players)
    {
        player playLocalSound("slomo_whoosh");
    }
}
nukeSloMo()
{
    setSlowMotion(1, .35, .5);

    wait(.5);

    wait(5);//Realtime wait, NOT slomo time

    setSlowMotion(.35, 1, .1);
}
nukeCountdown(nukeTimer)
{
    level endon("game_ended");

    while (true)
    {
        if (level.gameEnded)
        {
            nukeTimer destroy();
            break;
        }
        level thread nuke_fontPulse(nukeTimer);
        level.nukeTime--;
        playSoundAtPos((0, 0, 0), "h2_nuke_timer");

        wait(1);

        if (level.nukeTime > 0) continue;
        else
        {
            nukeTimer destroy();
            break;
        }
    }
}
nuke_fontPulse(nukeTimer)
{
    nukeTimer changeFontScaleOverTime(0.2);
    nukeTimer.fontScale = 1.25;
    wait(.2);

    nukeTimer setValue(level.nukeTime);
    nukeTimer changeFontScaleOverTime(0.2);
    nukeTimer.fontScale = 1;
}
nuke_restorePlayerVision()
{
    wait(9);

    if (level.gameEnded) return;
    self visionSetNakedForPlayer("mpnuke", 5);
    self playLocalSound("nuke_explosion");
    self playLocalSound("nuke_wave");
    wait(5);

    if (self.isAlive && self.isDown) self visionSetNakedForPlayer("cheat_bw", 1);
    else self visionSetNakedForPlayer(level.vision, 5);
}

spawnBotForPlayer(weapon, time)
{
    if (weapon == level.botWeapon_subBot)
    {
        self removeLastKillstreak("sub_bot");
    }
    else if (weapon == level.botWeapon_LMGBot)
    {
        self removeLastKillstreak("lmg_bot");
    }
    self shuffleStreaks();

    bot = spawn("script_model", self.origin);
    bot.angles = self.angles;
    //bot enableLinkTo();
    randomModel = randomInt(level.bodyModels.size);
    bot setModel(level.bodyModels[randomModel]);
    bot.isMoving = false;
    //bot.isShooting = false;//Moved to "state"
    bot.currentGun = "";

    weaponTag = bot getTagOrigin("tag_weapon_left");
    gun = spawn("script_model", weaponTag);
    gun setModel("tag_origin");
    bot.gun = gun;

    bothead = spawn("script_model", bot.origin);
    randomHead = randomInt(level.headModels.size);
    bothead setModel(level.headModels[randomHead]);
    bothead linkTo(bot, "j_spine4", (0, 0, 0), (0, 0, 0));
    bot.head = bothead;

    if (weapon == level.botWeapon_subBot || weapon == level.botWeapon_LMGBot)
    {
        headIcon = newHudElem();
        headIcon.x = bothead.origin[0];
        headIcon.y = bothead.origin[1];
        headIcon.z = bothead.origin[2] + 40;
        headIcon.alpha = 0.85;
        headIcon.archived = false;
        if (weapon == level.botWeapon_subBot)
            headIcon setShader("hud_icon_ump45", 10, 10);
        else if (weapon == level.botWeapon_LMGBot)
            headIcon setShader("hud_icon_sa80_lmg", 10, 10);
        headIcon setTargetEnt(bothead);
        headIcon setWaypoint(true, false, false);
        bot.icon = headIcon;
    }

    bot.state = "idle";
    bot.animType = "ar";
    bot.shots = 0;
    self.bot = bot;
    bot.owner = self;
    bot.targetEnt = undefined;
    bot playAnimOnBot("idle");

    bot thread playerBotMovement();
    if (!isDefined(weapon) || weapon == "") bot updateBotGun();
    else bot updateBotGun(weapon);
    bot thread personalBotTargeting();

    if (isDefined(time) && time > 0)
        self thread killPlayerBot(time);
}
playerBotMovement()
{
    level endon("game_ended");
    self endon("death");

    while (true)
    {
        if (level.gameEnded) break;
        if (self.state == "dead") break;

        wait(1);

        if (self.state != "shooting")
        {
            target = self.owner.origin;
            if (distanceSquared(self.origin, target) >= 40000)
            {
                self.state = "running";
                if (!self.isMoving)
                {
                    switch (self.animType)
                    {
                        case "pistol":
                            self playAnimOnBot("runPistol");
                            break;
                        case "mg":
                            self playAnimOnBot("runMG");
                            break;
                        case "rocketlauncher":
                            self playAnimOnBot("runRPG");
                            break;
                        case "spread":
                            self playAnimOnBot("runShotgun");
                            break;
                        case "sniper":
                            self playAnimOnBot("runSniper");
                            break;
                        case "smg":
                            self playAnimOnBot("runSMG");
                            break;
                        default:
                            self playAnimOnBot("run");
                            break;
                    }
                    self.isMoving = true;
                }
                angle = vectorToAngles(target - self.origin)[1];
                self moveTo((target[0], target[1], self.owner.origin[2]), (distance(self.origin, target) / 150));
                self rotateTo((0, angle, 0), 0.2);
            }
            else if (distanceSquared(self.origin, target) < 40000 && self.isMoving)
            {
                self.origin = self.origin;
                self.state = "idle";
                switch (self.animType)
                {
                    case "pistol":
                        self playAnimOnBot("idlePistol");
                        break;
                    case "mg":
                        self playAnimOnBot("idleMG");
                        break;
                    case "rocketlauncher":
                        self playAnimOnBot("idleRPG");
                        break;
                    default:
                        self playAnimOnBot("idle");
                        break;
                }
                self.isMoving = false;
            }
        }
    }
}
updateBotGun(weapon)
{
    if (self.state == "dead") return;

    owner = self.owner;
    if (!isDefined(weapon) || weapon == "")
        newBotWeapon = owner getCurrentWeapon();
    else newBotWeapon = weapon;

    if (self.currentGun != newBotWeapon && !isKillstreakWeapon(newBotWeapon) && !isRayGun(newBotWeapon) && newBotWeapon != "stinger_mp" && newBotWeapon != "javelin_mp")
    {
        gun = self.gun;
        if (newBotWeapon == level.botWeapon_subBot)
            weaponModel = getWeaponModel(level.botWeaponModel_subBot);
        else if (newBotWeapon == level.botWeapon_LMGBot)
            weaponModel = getWeaponModel(level.botWeaponModel_LMGBot);
        else weaponModel = getWeaponModel(newBotWeapon);

        if (!isDefined(weaponModel) || weaponModel == "") weaponModel = "tag_origin";
        gun setModel(weaponModel);
        self.currentGun = newBotWeapon;

        if (newBotWeapon == level.botWeapon_subBot)
            weaponClass = "smg";
        else if (newBotWeapon == level.botWeapon_LMGBot)
            weaponClass = "mg";
        else weaponClass = weaponClass(newBotWeapon);

        self.animType = weaponClass;
        clipCount = weaponClipSize(newBotWeapon);
        if (newBotWeapon == level.botWeapon_LMGBot)
            clipCount = 100;
        self.clipSize = clipCount;

        gun.angles = self getTagAngles("tag_weapon_left");
        switch (self.animType)
        {
            case "pistol":
            case "spread":
                gun linkTo(self, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
                break;
            default:
                gun linkTo(self, "tag_weapon_left", (0, 0, 0), (0, 0, 0));
                break;
        }
        if (self.state != "running")
        {
            switch (self.animType)
            {
                case "pistol":
                    self playAnimOnBot("idlePistol");
                    break;
                case "mg":
                    self playAnimOnBot("idleMG");
                    break;
                case "rocketlauncher":
                    self playAnimOnBot("idleRPG");
                    break;
                default:
                    self playAnimOnBot("idle");
                    break;
            }
        }
        else
        {
            switch (self.animType)
            {
                case "pistol":
                    self playAnimOnBot("runPistol");
                    break;
                case "mg":
                    self playAnimOnBot("runMG");
                    break;
                case "rocketlauncher":
                    self playAnimOnBot("runRPG");
                    break;
                case "spread":
                    self playAnimOnBot("runShotgun");
                    break;
                case "sniper":
                    self playAnimOnBot("runSniper");
                    break;
                case "smg":
                    self playAnimOnBot("runSMG");
                    break;
                default:
                    self playAnimOnBot("run");
                    break;
            }
        }
    }
}
personalBotTargeting()
{
    level endon("game_ended");
    self endon("death");
    self endon("killed");

    while (true)
    {
        wait(0.1);

        if (level.gameEnded) break;
        if (self.state == "dead") break;
        if (self.currentGun == "none") continue;
        if (isDefined(self.targetEnt)) continue;

        foreach (zombie in level.botsInPlay)
        {
            if (!zombie.isAlive) continue;

            tracePass = sightTracePassed(self.origin + (0, 0, 30), zombie.origin + (0, 0, 70), false, self);
            if (!tracePass) continue;

            self.targetEnt = zombie;
            break;
        }
        if (isDefined(self.targetEnt) && self.state != "shooting")
        {
            anglesY = vectorToAngles(self.targetEnt.origin - self.origin)[1];
            self rotateTo((0, anglesY, 0), 0.4);
            self.state = "shooting";
            self.origin = self.origin;
            switch (self.animType)
            {
                case "pistol":
                    waitForShot = 300;
                    break;
                case "smg":
                    waitForShot = 50;
                    break;
                case "rifle":
                    waitForShot = 100;
                    break;
                case "spread":
                    waitForShot = 1000;
                    break;
                case "mg":
                    waitForShot = 100;
                    break;
                case "sniper":
                    waitForShot = 1000;
                    break;
                case "rocketlauncher":
                    waitForShot = 2000;
                    break;
                default:
                    waitForShot = 100;
                    break;
            }

            //self.shots = 0;
            self thread fireBotWeapon(waitForShot);
        }
    }
}
fireBotWeapon(waitForShot)
{
    self endon("death");
    self endon("killed");

    while (true)
    {
        if (level.gameEnded) break;
        if (!isDefined(self) || self.state == "dead") break;
        if (!self.targetEnt.isAlive || !isDefined(self.targetEnt))
        {
            switch (self.animType)
            {
                case "pistol":
                    self playAnimOnBot("idlePistol");
                    break;
                case "mg":
                    self playAnimOnBot("idleMG");
                    break;
                case "rocketlauncher":
                    self playAnimOnBot("idleRPG");
                    break;
                default:
                    self playAnimOnBot("idle");
                    break;
            }
            self.state = "idle";
            self.isMoving = false;
            self.targetEnt = undefined;
            break;
        }

        botGun = self.currentGun;
        fireTime = weaponFireTime(botGun);
        if (fireTime < 0.05) fireTime = 0.05;
        wait(fireTime);

        self rotateTo((0, vectorToYaw(self.origin - self.targetEnt.origin), 0), 0.4);

        switch (self.animType)
        {
            case "pistol":
                self playAnimOnBot("shootPistol");
                break;
            case "mg":
                self playAnimOnBot("shootMG");
                break;
            case "rocketlauncher":
                self playAnimOnBot("shootRPG");
                break;
            default:
                self playAnimOnBot("shoot");
                break;
        }
        botGunEnt = self.gun;
        flashTag = botGunEnt getTagOrigin("tag_flash");
        level.lastAttackingBot = self;
        //This unfortunately is internally bugged. magicBullet will only report the attacker's weapon regardless of the weapon passed to it. If no attacker is set, the weapon is undefined. This causes the bot here to be shooting the player's weapon, and there isn't a way to detect the weapon name if given no attacker. InfinityScript did it better, fuck GSC.
        magicBullet(botGun, flashTag, self.targetEnt.origin + (randomFloat(30), randomFloat(30), randomFloatRange(25, 55)));

        self.shots++;
        ammo = self.clipSize;
        if (self.shots >= ammo)
        {
            /*
            clip = spawn("script_model", self.origin);
            clip setModel(level.getWeaponClipModel(botGun));
            clip linkTo(self, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
            */
            botGunEnt hidePart("tag_clip");
            switch (self.animType)
            {
                case "pistol":
                    self playAnimOnBot("reloadPistol");
                    self playSound("weap_usp45_reload_npc");
                    self thread resetBotWeaponAnimAfterTime(botGun, "idlePistol", 1.5);
                    break;
                case "mg":
                    self playAnimOnBot("reloadMG");
                    self playSound("weap_m60_reload_npc");
                    self thread resetBotWeaponAnimAfterTime(botGun, "idleMG", 4);
                    break;
                case "rocketlauncher":
                    self playAnimOnBot("reloadRPG");
                    self playSound("weap_rpg_reload_npc");
                    self thread resetBotWeaponAnimAfterTime(botGun, "idleRPG", 2.5);
                    break;
                default:
                    self playAnimOnBot("reload");
                    self playSound("weap_ak47_reload_npc");
                    self thread resetBotWeaponAnimAfterTime(botGun, "idle", 2);
                    break;
            }
            break;
        }
    }
}
resetBotWeaponAnimAfterTime(botGun, animName, waitTime)
{
    wait(waitTime);

    self resetBotWeaponAnim(botGun, animName);
}
resetBotWeaponAnim(oldGun, animName)
{
    if (self.state == "dead") return;
    if (!isDefined(self.gun)) return;
    botGunEnt = self.gun;
    self playAnimOnBot(animName);
    if (oldGun == self.currentGun) botGunEnt showPart("tag_clip");//Avoid trying to show the tag if we switched guns
    self.shots = 0;
    self.state = "idle";
    self.isMoving = false;
    self.targetEnt = undefined;
}

killPlayerBot(time)
{
    if (isDefined(time))
        wait(time);

    bot = self.bot;
    bot notify("killed");
    bot.state = "dead";
    //self.ownsBot = false;
    self.bot = undefined;
    bot playSound("generic_death_american_1");
    if (isDefined(bot.icon))
        bot.icon destroy();

    botGun = bot.gun;
    botGun delete();
    bot.gun = undefined;


    //randomAnim = randomInt(level.botAnims["z_deaths"].size);
    //bot playAnimOnBot("z_deaths", randomAnim);
    bot startRagdoll();
    physicsExplosionSphere(bot.origin, 75, 75, randomIntRange(1, 3));

    wait(5);

    head = bot.head;
    head delete();
    bot.head = undefined;
    bot delete();
}

getAirdropPoint()
{
	point = undefined;
	switch(level._mapname)
	{
		case "mp_afghan": point = (-2125, -780, -1444);
		break;
		case "mp_terminal": point = (1434, 3336, 1000);
		break;
		case "mp_quarry": point = (-2877, 2178, 500);
		break;
		case "mp_rust":
		if(level.mapVariation == 0)
			point = (1825, -9861, 300);
		if(level.mapVariation == 1)
			point = (1450, -4817, -134);
		break;
		case "mp_derail": point = (2653, 1573, 500);
		break;
		case "mp_highrise": 
		if(level.mapVariation == 0)
			point = (-857, 10067, 2184);
		if(level.mapVariation == 1)
			point = (4957, 2702, 2355);
        if(level.mapVariation == 2)
			point = (-8917, 5972, 3000);
		if(level.mapVariation == 3)
			point = (-13735, 4840, 6000);
		break;
		case "mp_brecourt": point = (9833, 6781, 700);
		break;
		case "mp_boneyard": point = (36, -1581, 329);
		break;
		case "mp_underpass": point = (3855, 2627, 400);
		break;
		case "mp_nightshift": 
		if(level.mapVariation == 0)
			point = (-1666, -644, 1000);
		if(level.mapVariation == 1)
			point = (686, -1273, 500);
		if(level.mapVariation == 2)
			point = (1779, -1129, 500);
		break;
		case "mp_estate": point = (-2980, -1090, -517);
		break;
		case "mp_favela": point = (2329, 2859, 800);
		break;
		case "mp_invasion": point = (2423, 10866, 16);
		break;
		case "mp_checkpoint": point = (2429, 2274, 11);
		break;
		case "mp_subbase": point = (-337, -4557, 600);
		break;
		case "mp_rundown": point = (876, 2593, 80);
		break;
		case "mp_compact": point = (2307, 2801, 600);
		break;
		case "mp_trailerpark": point = (1569, -2053, 600);
		break;
		case "mp_strike": point = (-2593, 1441, 13);
		break;
		case "mp_complex": point = (2884, -1426, 1051);
		break;
		case "mp_vacant": point = (-604, 1111, -98);
		break;
		case "mp_abandon": point = (-1338, 3444, 3);
		break;
		case "mp_storm": point = (3611, -1172, -48);
		break;
		case "mp_fuel2":
        if(level.mapVariation == 0)
			point = (22767, 21433, 6805);
		if(level.mapVariation == 1)
			point = undefined;
        break;
		case "mp_overgrown": point = (-1600, -5951, -156);
		break;
		case "mp_crash": point = (-1071, -2744, 92);
		break;
	}
	return point;
}
bonusAirdropFlyBy()
{
    dropSite = getAirdropPoint();
    if (!isDefined(dropSite))
        dropSite = level.players[0].origin;

    yaw = vectorToYaw(dropSite);
    direction = (0, yaw, 0);
    forward = anglesToForward(direction);
    start = dropSite + (forward * -15000);
    pathStart = (start[0], start[1], dropSite[2] + 1800);
    //c130 = spawnplane(level.players[0], "script_model", pathStart, "compass_objpoint_c130_friendly", "compass_objpoint_c130_friendly");
    c130 = spawn("script_model", pathStart);
    c130 setModel("vehicle_ac130_low_mp");

	if ( !isDefined(c130))
		return;

    c130.angles = direction;
    c130 thread airdropFly(dropSite, forward);
}
airdropFly(location, forward)
{
    dropLocation = (location[0], location[1], location[2] + 1800);
    self playLoopSound("veh_ac130_dist_loop");
    self moveTo(dropLocation, 7.5);

    wait(7);

    earthquake(0.15, 1.5, location, 1500);
    self playSound("veh_ac130_sonic_boom");

    wait(0.5);

    dropType = randomIntRange(1, 6);
    crate = user_scripts\mp\aizombies\_aiz_bonus_drops::spawnBonusDrop(dropType, dropLocation);
    crate thread dropTheCrate(dropLocation);

    self moveTo(dropLocation + (forward * 15000), 7.5);

    wait(7.5);

    self delete();
}
dropTheCrate(location)
{
    mover = spawn("script_origin", location);
    self linkTo(mover);
    ground = getGroundPosition(location - (0, 0, 1800), 25);
    mover moveTo(ground - (0, 0, 16), 4);

    wait(4);
    
    if (isDefined(self))
        self unlink();
    mover delete();
}