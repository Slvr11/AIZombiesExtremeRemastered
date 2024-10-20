#include user_scripts\mp\aizombies\_aiz;
#include common_scripts\utility;
#include maps\mp\_utility;


init()
{
    if (getDvarInt("aiz_enabled") == 0)
        return;

    level.botsInPlay = [];
    level.botPool = [];
    level.crawlerPool = [];
    level.bossPool = [];

    level.botsForWave = 0;
    //Set via dvar
    //level.botHealth = 100;
    //level.crawlerHealth = 100;
    //level.bossHealth = 2500;
    //level.botHealthScalar = 2;
    //level.botDmg = 50;
    //level.maxActiveBots = 25;
    level.spawnedBots = 0;

    level.botSpawns = [];
    level.botSpawnAngles = [];

    if (!isDefined(level.botAnims))
    {
        level.botAnims = [];
    }
    level.botAnims["z_lose"] = "mp_jug_maniac_flash_reactiona";
    level.botAnims["z_idle"] = "mp_jug_maniac_idle";
    level.botAnims["z_run"] = "mp_jug_maniac_run_f";
    level.botAnims["z_walk"] = "mp_jug_maniac_walk_f";
    level.botAnims["z_runHurt"] = "mp_jug_maniac_stand_2_sprint";
    level.botAnims["z_walkHurt"] = "mp_jug_maniac_stand_2_walk_f";
    level.botAnims["z_deaths"] = ["pb_stand_death_frontspin", "pb_stand_death_shoulderback", "pb_shotgun_death_legs", "pb_stand_death_tumbleback", "pb_stand_death_head_collapse", "pb_stand_death_nervedeath", "pb_stand_death_leg", "pb_stand_death_chest_spin" , "pb_stand_death_legs", "pb_stand_death_chest_blowback", "pb_stand_death_lowerback"];
    level.botAnims["z_attack"] = "jug_maniac_land_med_2_run_f";
    level.botAnims["z_death_explode"] = ["pb_explosion_death_B1", "pb_stand_death_leg_kickup"];
    level.botAnims["z_death_nuke"] = "pb_stand_death_stumbleforward";
    level.botAnims["crawlerAnim_idle"] = "pb_prone_hold";
    level.botAnims["crawlerAnim_death"] = "h1_prone_death_quickdeath";
    level.botAnims["crawlerAnim_attack"] = "mp_iw6_prone_2_prone_f";
    level.botAnims["crawlerAnim_walk"] = "pb_prone_crawl_hold";

    level.botModel = getBotModelsForLevel(false);
    level.botHeadModel = getBotModelsForLevel(true);
    level.botCrawlerModel = getCrawlerModelForLevel();

    level.freezerActivated = false;
    level.perkDropsEnabled = true;
    level.nukeOffsetScalar = 0;
}

startBotSpawn()
{
    level endon("game_ended");

    while(true)
    {
        if (level.gameEnded) break;

        if (level.botSpawns.size == 0 || level.botsInPlay.size >= level.maxActiveBots)
        {
            wait(0.5);
            continue;
        }
        else if (level.spawnedBots == level.botsForWave)
            break;
        else
        {
            randomSpawn = randomInt(level.botSpawns.size);
            if (level.isBossWave) 
            {
                if (user_scripts\mp\aizombies\_aiz_bots::spawnBossBot(randomSpawn))
                {
                    wait(0.5);
                    continue;
                }
                else break;
            }
            else if (level.isCrawlerWave) 
            {
                if (user_scripts\mp\aizombies\_aiz_bots::spawnBot(randomSpawn, true))
                {
                    wait(0.5);
                    continue;
                }
                else break;
            }
            else if(user_scripts\mp\aizombies\_aiz_bots::spawnBot(randomSpawn, false))
            {
                wait(0.5);
                continue;
            }
            else break;
        }
    }
}

killBotIfUnderMap()
{
    if (self.isAlive && self.origin[2] < level.mapHeight && (level._mapname != "mp_rust" && level.mapVariation == 1) && level._mapname != "mp_checkpoint" && level._mapname != "mp_invasion")
    {
        self thread killBotAndRespawn();
    }
}
//To kill off a bot but respawn them right after
killBotAndRespawn()
{
    self.isAlive = false;
    if (isDefined(self.isOnCompass) && self.isOnCompass)
    {
        _objective_delete(self.objID);
        self.isOnCompass = false;
    }
    hitbox = self.hitbox;
    hitbox setCanDamage(false);
    hitbox setCanRadiusDamage(false);
    hitbox setModel("tag_origin");//Change model to avoid the dead bot's hitbox blocking shots
    self moveTo(self.origin, 0.05);

    isCrawler = !isDefined(self.head);
    isBoss = isDefined(self.isBoss);

    if (isCrawler)
        self playAnimOnBot("crawlerAnim_death");
    else
        self playAnimOnBot("z_death_nuke");

    if (isCrawler && !isBoss) 
    {
        self thread crawlerDeathFloat();
    }
    wait(5.5);
    self despawnBot(isCrawler, isBoss);
    level.botsInPlay = array_remove(level.botsInPlay, self);

    level notify("bot_death");
    self notify("zombie_death");

    //onBotUpdate();

    if (level.botsForWave == level.spawnedBots)
    {
        level.spawnedBots--;
        level thread startBotSpawn();//Restart spawns with less spawnedBots if at the end of the round. This will spawn a new bot correctly. Else, the loop will be running and automatically respawn a bot.
    }
    else level.spawnedBots--;

    wait(1.5);
    user_scripts\mp\aizombies\_aiz_round_system::checkForCompass();//Re-apply compass if needed
}

despawnBot(isCrawler, isBoss)
{
    self hide();
    if (isDefined(self.head))
    {
        botHead = self.head;
        botHead hide();
    }
    self.origin = (0, 0, 0);
    self.isSpawned = false;
    /*
    if (isCrawler) level.crawlerPool[level.crawlerPool.size] = self;
    else if (isBoss) level.bossPool[level.bossPool.size] = self;
    else level.botPool[level.botPool.size] = self;
    */
}

getNextAvailableBotFromPool(isCrawler, isBoss)
{
    if (isCrawler) pool = level.crawlerPool;
    else if (isBoss) pool = level.bossPool;
    else pool = level.botPool;

    foreach (bot in pool)
    {
        if (!isDefined(bot) || !isDefined(bot.isSpawned) || bot.isSpawned)
            continue;

        return bot;
    }

    return undefined;
}

updateBotLastActiveTime()
{
    self.lastActiveTime = getTime();
}

createBot(isCrawler)
{
    bot = spawn("script_model", (0, 0, 0));
    bot.angles = (0, 0, 0);
    //bot enableLinkTo();
    if (isCrawler)
    {
        bot setModel(level.botCrawlerModel);
        bot playAnimOnBot("crawlerAnim_idle");
    }
    else
    {
        bothead = spawn("script_model", bot.origin);
        if (level.useZombieModels == 1 || (level.useZombieModels == 2 && randomInt(100) > 75))
        {
            bot setModel("body_infect");
            bot.model = "body_infect";
            bothead setModel("tag_origin");
        }
        else
        {
            randomModel = randomInt(level.botModel.size);
            bot setModel(level.botModel[randomModel]);
            randomHead = randomInt(level.botHeadModel.size);
            bothead setModel(level.botHeadModel[randomHead]);
        }
        bothead linkTo(bot, "j_spine4", (0, 0, 0), (0, 0, 0));
        bot.head = bothead;
        bothead hide();
        bot playAnimOnBot("z_idle");
    }
    bot.isAlive = false;
    bot hide();

    if (isCrawler) level.crawlerPool[level.crawlerPool.size] = bot;
    else level.botPool[level.botPool.size] = bot;

    botHitbox = spawn("script_model", bot.origin + (0, 0, 30));
    botHitbox setModel("com_plasticcase_enemy");
    botHitbox.angles = (0, 0, 0);
    botHitbox hide();
    botHitbox setCanDamage(false);
    botHitbox setCanRadiusDamage(false);
    if (isCrawler) botHitbox.currentHealth = level.crawlerHealth;
    else botHitbox.currentHealth = level.botHealth;
    botHitbox.damageTaken = 0;
    if (isCrawler)
    {
        botHitbox.origin = bot.origin + (0, 0, 5);
        botHitbox linkTo(bot);
    }
    else
    {
        botHitbox linkTo(bot, "j_mainroot", (0, 0, 0), (0, 0, -90));
    }
    botHitbox.parent = bot;
    bot.hitbox_linkOffset_y = 0;

    /*
    if (!isCrawler)
    {
        headOrigin = bot getTagOrigin("j_head");
        //headAngles = bot getTagAngles("j_head");
        headHitbox = Spawn("script_model", headOrigin);
        headHitbox setModel("weapon_oma_pack_viewmodel");
        headHitbox.angles = (0, 0, 0);
        //headHitbox hide();
        headHitbox setCanDamage(true);
        headHitbox setCanRadiusDamage(false);
        headHitbox linkTo(bot, "j_head", (0, 0, 0), (0, 0, 0));
        headHitbox.parent = bot;
        bot.headHitbox = headHitbox;

        headHitbox thread onBotDamage(isCrawler, false, true);
    }
    */

    bot.hitbox = botHitbox;
    bot.state = "idle";
    bot.isAttacking = false;
    bot.currentWaypoint = undefined;
    bot.isOnCompass = false;
    bot.isSpawned = false;
    bot.primedForNuke = false;
    bot.moveSpeed = 100;
    botHitbox.canBeDamaged = true;

    botHitbox thread onBotDamage(isCrawler, false, false);
    bot thread killBotOnNuke(isCrawler, false);
}
createBot_boss()
{
    bot = Spawn("script_model", (0, 0, 0));
    bot.angles = (0, 0, 0);
    //bot enableLinkTo();
    bot setModel("body_hazmat");
    bot playAnimOnBot("z_idle");
    bot.isAlive = false;
    bot hide();
    level.bossPool[level.bossPool.size] = bot;

    botHitbox = Spawn("script_model", bot.origin + (0, 0, 30));
    botHitbox setModel("com_plasticcase_enemy");
    botHitbox.angles = (90, bot.angles[1], 0);
    botHitbox setCanDamage(false);
    botHitbox setCanRadiusDamage(false);
    botHitbox linkTo(bot, "j_mainroot", (0, 0, 0), (0, 0, 0));
    botHitbox hide();
    botHitbox.currentHealth = level.bossHealth;
    botHitbox.damageTaken = 0;
    botHitbox.parent = bot;
    botHitbox.isBoss = true;
    bot.isBoss = true;
    bot.hitbox = botHitbox;
    bot.hitbox_linkOffset_y = 0;
    bot.state = "idle";
    bot.isAttacking = false;
    bot.currentWaypoint = undefined;
    bot.isOnCompass = false;
    bot.isSpawned = false;
    bot.primedForNuke = false;
    bot.moveSpeed = 170;
    botHitbox.canBeDamaged = true;

    bot thread killBotOnNuke(false, true);
    botHitbox thread onBotDamage(false, true, false);
}

onBotDamage(isCrawler, isBoss, isHeadshot)
{
    level endon("game_ended");

    while(true)
    {
        self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, iDFlags, weapon);

        if (!self.parent.isAlive) continue;

        if (!isDefined(weapon))
            weapon = "";

        if ((weapon == "h2_m9_mp_akimbo_xmag_camo008" && level.allowUpgradedM9) || ((weapon == "h2_tmp_mp_silencersmg_camo008" || weapon == "h2_tmp_mp_silencersmg_xmag_camo008") && type != "MOD_FLAME") ||
        ((isRayGun(weapon)) && type != "MOD_MELEE"))
            continue;

        currentBot = self.parent;
        botHitbox = self;
        if (!isDefined(botHitbox.damageTaken) || !isDefined(botHitbox.currentHealth))//This will be true if self is the head hitbox
        {
            botHitbox = self.parent.hitbox;
        }
        //if (!array_contains(level.botsInPlay, currentBot)) return;
        player = attacker;

        /*
        if (isHeadshot)
            type = "MOD_HEADSHOT";
        */

        if ((weapon == "sentry_minigun_mp" || weapon == "pavelow_minigun_mp") && isDefined(attacker.owner))//Sentry tweaks
        {
            player = attacker.owner;
            if (level.killstreaksGivePoints == 0) type = "MOD_PASSTHRU";
            damage = 15;
        }
        else if ((weapon == "ac130_25mm_mp" || weapon == "ac130_40mm_mp" || weapon == "ac130_105mm_mp" || weapon == "javelin_mp" || weapon == "stinger_mp" || weapon == "at4_mp") && !isPlayer(attacker) && isDefined(level.UAVModel))//Airstrike tweaks
        {
            player = level.UAVModel.owner;
            if (level.killstreaksGivePoints == 0) type = "MOD_PASSTHRU";
        }
        else if (isDefined(level.lastAttackingBot) && (weapon == level.botWeapon_subBot || weapon == level.botWeapon_LMGBot || weapon == "") && !isDefined(attacker.name))//Killstreak bot weapons. In GSC these report as empty strings
        {
            player = level.lastAttackingBot.owner;
            if (level.killstreaksGivePoints == 0) type = "MOD_PASSTHRU";
            if (level.isHellMap) damage = 10;//Hellmap damage
            else damage = 20;//Base damage
        }

        if (weapon != "sentry_minigun_mp") playFX(level.fx_blood, point);//Only play FX if the weapon isn't a script weapon
        doBotDamage(int(damage), player, weapon, botHitbox, type, point);

        botState = currentBot.state;
        if ((botState != "hurt" || (botState == "hurt" && level.legacyHurtAnims != 0)) && botState != "attacking")
        {
            if (!isCrawler && !isBoss)
            {
                currentBot playAnimOnBot(currentBot getHurtAnim());
            }
            else if (isBoss)
            {
                currentBot playAnimOnBot("z_runHurt");
            }
            currentBot.state = "hurt";

            currentBot thread postHurt();
        }

        if (!isBoss) currentBot updateBotLastActiveTime();

        if (botHitbox.damageTaken >= botHitbox.currentHealth)
        {
            currentBot.isAlive = false;
            if (isDefined(currentBot.isOnCompass) && currentBot.isOnCompass)
            {
                _objective_delete(currentBot.objID);
                currentBot.isOnCompass = false;
            }
            botHitbox setCanDamage(false);
            botHitbox setCanRadiusDamage(false);
            botHitbox setModel("tag_origin");//Change model to avoid the dead bot's hitbox blocking shots
            //if (isBoss) botHitbox delete();
            if (isDefined(currentBot.primedForNuke) && !currentBot.primedForNuke)
            {
                pointGain = 50;
                //if (type == "MOD_HEADSHOT") pointGain = 100;
                if (type == "MOD_MELEE") pointGain = 130;

                if (player.hasDoublePoints) pointGain = pointGain * 2;

                if (isDefined(player) && type != "MOD_PASSTHRU")
                {
                    player.cash += pointGain;
                    player thread user_scripts\mp\aizombies\_aiz_hud::scorePopup(pointGain);
                    player thread maps\mp\gametypes\_rank::giveRankXP( "kill", pointGain, weapon, type);
                }

                currentBot playSound("generic_death_enemy_" + randomIntRange(1, 9));
            }
            player.kills++;
            player user_scripts\mp\aizombies\_aiz_hud::updateBonusPoints(1);
            player user_scripts\mp\aizombies\_aiz_killstreaks::checkKillstreak();
            player thread user_scripts\mp\aizombies\_aiz_hud::updateMultikillCount();

            if (player.ammoMatic)
            {
                currentWeapon = player getCurrentWeapon();
                stock = player getWeaponAmmoStock(currentWeapon);
                player setWeaponAmmoStock(currentWeapon, stock + getWeaponAmmoMaticValue(weapon));
            }

            currentBot moveTo(currentBot.origin, 0.05);

            if (isFlameWeapon(weapon) && type != "MOD_MELEE")
            {
                if (weapon == "h2_cheytac_mp" || weapon == "h2_cheytac_mp_fmj_camo008")
                    playFx(level.fx_smallExplode, botHitbox.origin);
                else 
                    playFx(level.fx_flamethrowerDeathFX, botHitbox.origin);
				self playSound("explo_mine");
				physicsExplosionSphere(botHitbox.origin, 230, 0, 3);
            }

            if (isCrawler)
            {
                currentBot playAnimOnBot("crawlerAnim_death");
            }
            else
            {
                if (type == "MOD_EXPLOSIVE" || type == "MOD_GRENADE_SPLASH")
                {
                    currentBot.angles = vectorToAngles(point - currentBot.origin);
                    randomAnim = randomInt(level.botAnims["z_death_explode"].size);
                    currentBot playAnimOnBot("z_death_explode", randomAnim);
                }
                else
                {
                    randomAnim = randomInt(level.botAnims["z_deaths"].size);
                    currentBot playAnimOnBot("z_deaths", randomAnim);
                }
            }

            if (isCrawler)
            {
                currentBot thread crawlerDeathFloat();
            }

            level.botsInPlay = array_remove(level.botsInPlay, currentBot);
            level notify("bot_death");
            currentBot notify("zombie_death");

            //onBotUpdate();
            user_scripts\mp\aizombies\_aiz_round_system::checkForEndRound();
            if (isCrawler && level.isCrawlerWave && (level.botsInPlay.size == 0 && level.botsForWave == level.spawnedBots) && level.perkDropsEnabled && level.isHellMap) 
            {
                user_scripts\mp\aizombies\_aiz_bonus_drops::spawnBonusDrop(9, currentBot.origin); 
            }
            else if (!isBoss)
            {
                bonusType = user_scripts\mp\aizombies\_aiz_bonus_drops::checkForBonusDrop();
                if (bonusType != 0)
                    user_scripts\mp\aizombies\_aiz_bonus_drops::spawnBonusDrop(bonusType, currentBot.origin);
            }

            wait(5.5);
            currentBot despawnBot(isCrawler, isBoss);
        }
    }
}
crawlerDeathFloat()
{
    wait(0.5);
    self moveTo(self.origin + (0, 0, 2500), 5);
    wait(5);
    playFX(level.fx_smallExplode, self.origin);
}

postHurt()
{
    self notify("post_hurt");
    self endon("post_hurt");

    wait(0.5);

    self.state = "idle";
    if (level.freezerActivated)
        self.state = "idle_frozen";//Set to allow the stand-still code to properly transition the bot animation
}

killBotOnNuke(isCrawler, boss)
{
    while (true)
    {
        level waittill("zombie_nuke");

        self.primedForNuke = true;

        wait(randomFloatRange(0, 4) * level.nukeOffsetScalar);

        self.primedForNuke = false;
        if (!self.isAlive || !array_contains(level.botsInPlay, self)) continue;
        self.isAlive = false;
        botHitbox = self.hitbox;
        if (self.isOnCompass)
        {
            _objective_delete(self.objID);
            self.isOnCompass = false;
        }
        botHitbox setCanDamage(false);
        botHitbox setCanRadiusDamage(false);
        self moveTo(self.origin, 0.05);
        deathAnim = "z_death_nuke";
        if (isCrawler) deathAnim = "crawlerAnim_death";
        self playAnimOnBot(deathAnim);

        self moveTo(self.origin + (0, 0, 2500), 5);

        self playSound("generic_death_enemy_" + randomIntRange(1, 9));
        /*
        else if (boss)
        {
            wait(1);
            self startRagdoll();
        }
        */
        level.botsInPlay = array_remove(level.botsInPlay, self);

        level notify("bot_death");
        self notify("zombie_death");

        //onBotUpdate();
        user_scripts\mp\aizombies\_aiz_round_system::checkForEndRound();

        wait(5);

        self despawnBot(isCrawler, boss);
    }
}

doBotDamage(damage, player, weapon, botHitbox, MOD, point, skipFeedback)
{
    if (!isDefined(botHitbox.canBeDamaged) || !botHitbox.canBeDamaged)
    {
        printLn("a bot was damaged when it wasn't allowed to be.");
        //return;
    }

    hitDamage = 0;
    if (level.isHellMap) hitDamage = damage * 0.8;//Hellmap damage
    else hitDamage = damage;//Base damage

    //if (weaponIsUpgrade(weapon)) hitDamage = damage * 1.05;//Base upgraded damage
    
    if (player.perksBought[4]) hitDamage *= 1.4;

    if (isWeaponDeathMachine(weapon)) hitDamage = damage * 2;

    if (MOD != "MOD_MELEE")
    {
        //Weapon tweaks
        if (isShotgun(weapon))
        {
            hitDamage *= 4;//Shotgun multiplier
            botHitbox thread bot_setCanDamage();//Shotgun pellet delay. This fixes the bug where shotgun hits count every pellet for score
        }
        else if (isSniper(weapon)) hitDamage *= 2;//Sniper damage

        if (weapon == "h2_m240_mp_fmj_xmag_camo008") hitDamage *= 1.5;
        else if (weapon == "h2_deserteagle_mp_camo009") hitDamage *= 3;
    }

    //if (MOD == "MOD_HEADSHOT") hitDamage *= 2;
    //if (MOD == "MOD_PASSTHRU") hitDamage = damage;//Script usage

    botHitbox.damageTaken += int(hitDamage);

    if (!botHitbox.parent.primedForNuke)
    {
        pointGain = 5;
        if (level.isHellMap) pointGain = 10;
        if (player.hasDoublePoints > 0) pointGain *= 2;

        if (MOD != "MOD_PASSTHRU")
        {
            player.cash += pointGain;
            player thread user_scripts\mp\aizombies\_aiz_hud::scorePopup(pointGain);
            player thread maps\mp\gametypes\_rank::giveRankXP("kill", pointGain, weapon, MOD);
        }
    }

    if ((isDefined(skipFeedback) && skipFeedback)) return;

    /*
    combatHighFeedback = player.hud_damageFeedback;
    combatHighFeedback.Alpha = 1;
    player playLocalSound("MP_hit_alert");
    combatHighFeedback fadeOverTime(1);
    combatHighFeedback.Alpha = 0;
    */

    hitReason = "";
    if (botHitbox.damageTaken >= botHitbox.currentHealth)
        hitReason = "killshot";
    
    player maps\mp\gametypes\_damagefeedback::updateDamageFeedback(hitReason);
}

nukeDetonation(isStreak)
{
    if (isStreak && isDefined(self) && isPlayer(self))
    {
        total = level.botsInPlay.size;
        self.cash += (100 * total);
        self thread user_scripts\mp\aizombies\_aiz_hud::scorePopup(100 * total);
        self thread user_scripts\mp\aizombies\_aiz_hud::textPopup2(level.gameStrings[208]);
    }

    foreach(player in level.players)
    {
        earthquake(1, 1.5, player.origin + (0, 0, 40), 60);
        player playlocalsound("nuke_explosion");
        player playlocalsound("nuke_wave");
        playFXOnTagForClients(level.fx_nuke2, self, "tag_origin", player);
    }

    //bonusDrops.onNuke();
    level notify("zombie_nuke");

    wait(5);

    level.nukeInbound = false;
}

getHurtAnim()
{
    if (self.moveSpeed > 120)
        return "z_runHurt";
    else return "z_walkHurt";
}
playAnimOnBot(animName, animIndex)
{
    animName = level.botAnims[animName];

    assert(isDefined(animName));

    if (isDefined(animIndex))
    {
        animName = animName[animIndex];
    }

    self scriptModelPlayAnim(animName);

    /*
    if (animName == "z_walk" && isDefined(self.hitbox) && (isDefined(self.hitbox_linkOffset_y) && self.hitbox_linkOffset_y == 0))
    {
        botHitbox = self.hitbox;
        //botHitbox linkTo(self, "j_mainroot", (0, -10, 0), (0, 0, -90));
        self.hitbox_linkOffset_y = -10;
    }
    else if (isDefined(self.hitbox) && (isDefined(self.hitbox_linkOffset_y) && self.hitbox_linkOffset_y == -10))
    {
        isCrawler = !isDefined(self.head) && !isDefined(self.isBoss);
        botHitbox = self.hitbox;
        //botHitbox linkTo(self, "j_mainroot", (0, 0, 0), (0, 0, -90));
        self.hitbox_linkOffset_y = 0;
    }
    */
}

bot_setCanDamage(delay)
{
    self.canBeDamaged = false;

    if (isDefined(delay))
        wait(delay);
    else
        wait(0.05);

    self.canBeDamaged = true;
}