#include common_scripts\utility;
#include maps\mp\_utility;

//Upgrade models dont have camos
//Killstreak max sort does not function correctly
//Fix airport triggers
//Clean up any unused code
//Fix AT4
//Endgame has no music?
//Investigate walking ac130
//Add clips to underpass 

init()
{
    if (getDvarInt("aiz_enabled") == 0)
        return;

    setDvar("g_gametype", "zombies");

    if (getDvarInt("sv_maxclients") > 8 || getDvarInt("party_maxPlayers") > 8)
    {
        printLn("The current max players for AIZombies can only be 8 or below. The current setting is " + getDvar("sv_maxClients") + ". It has been set to 8.");
        setDvar("sv_maxClients", 8);
        setDvar("party_maxPlayers", 8);
        
        //map_restart(false);
        //return;
    }

    level.matchrules_switchteamdisabled = true;
    level.blockweapondrops = 1;

    loadConfig();

    h2m_patches();

    level.gameStrings = user_scripts\mp\aizombies\_aiz_game_text::initGameStrings();

    level._mapname = getMapname();
    level.zombieMapname = undefined;
    level.isHellMap = false;
    level.zState = "intermission";
    level.gameEnded = false;
    level.gameStarted = false;
    level.intermissionTimerNum = 30;
    //level.firstIntermission = true;
    level.timePlayedMinutes = 0;
    level.timePlayed = 0;
    //level.secondsTimerStarted = false;
    level.intermissionTimerStarted = false;
    level.zombieDeath = [];

    for (i = 0; i < 14; i++)
    {
        level.zombieDeath[i] = level.gameStrings[i];
    }

    level.bodyModels = getPlayerModelsForLevel(false);
    level.headModels = getPlayerModelsForLevel(true);
    //Set via dvar
    //level.maxPlayerHealth = 101;
    //level.maxPlayerHealth_Jugg = 251;
    level.powerActivated = false;
    level.version = "1.0";
    level.dev = "[IW]Slvr99";

    level.mapHeight = 0;
    level.totalWaves = 30;

    level.currentRayguns = 0;
    level.maxRayguns = 2;

    level.freezerActivated = false;
    level.infiniteAmmoTime = 0;
    level.infiniteAmmoTimerStarted = false;
    level.adrenalineTime = 0;
    level.adrenalineTimerStarted = false;

    user_scripts\mp\aizombies\_aiz_bot_util::init();
    user_scripts\mp\aizombies\_aiz_hud::init();
    user_scripts\mp\aizombies\_aiz_killstreaks::init();
    user_scripts\mp\aizombies\_aiz_map_edits::init();
    user_scripts\mp\aizombies\_aiz_round_system::init();

    user_scripts\mp\aizombies\_aiz_maps::setRandomMapVariation();
	
	level.mapHeight = 0;

    level.onPrecacheGameType = ::onPrecacheGameType;
    onPrecacheGameType();
    //level.onSpawnPlayer = ::onPlayerSpawn;
    level.onSpawnPlayer = ::patch_nullFunc;
    level.modifyPlayerDamage = ::modifyPlayerDamage;
    level.onNormalDeath = ::onNormalDeath;
	level.onPlayerKilled = ::onPlayerKilled;
    level.getSpawnPoint = ::getRandomSpawnpoint;
    level.callbackPlayerLastStand = ::onPlayerLastStand;
    level.bypassClassChoiceFunc = ::bypassClassChoice;
    level.streamPrimariesFunc = ::streamWeapons;
    level.gamemodemayspawn = ::gamemodeMaySpawn;

    setDvar("cg_drawCrosshair", 1);
    setDvar("ui_drawCrosshair", 1);
    setDvar("cg_crosshairDynamic", 1);

    initGameNotifies();

    setDvar("ui_gametype", "zombies");
    setDvar("ui_netGametypeName", "AIZombies");
    randomTip();
    //setDvar("ui_connectScreenTextGlowColor", (1, 0, 0));
    setDvar("ui_allow_teamchange", 0);
    setDvar("ui_allow_classchange", 0);
    setDvar("sv_disableCustomClasses", 1);
    setDvar("scr_skipclasschoice", 1);

    //Server netcode adjustments//
    //setDvar("com_maxfps", 0);
    //-IW5 server update rate-
    setDevDvar("sv_network_fps", 200);
    //-Turn off flood protection-
    //setDvar("sv_floodProtect", 0);
    //-Setup larger snapshot size and remove/lower delay-
    //Reverting
    setDvar("sv_hugeSnapshotSize", 4000);
    setDvar("sv_hugeSnapshotDelay", 200);
    //-Remove ping degradation-
    setDvar("sv_pingDegradation", 0);
    setDvar("sv_pingDegradationLimit", 9999);
    //-Improve ping throttle-
    setDvar("sv_acceptableRateThrottle", 9999);
    setDvar("sv_newRateThrottling", 0);
    setDvar("sv_newRateInc", 200);
    setDvar("sv_newRateCap", 500);
    //-Tweak ping clamps-
    setDvar("sv_minPingClamp", 50);
    //-Increase server think rate per frame-
    setDvar("sv_cumulThinkTime", 1000);
    //-Disable playlist checking-
    setDvar("playListUpdateCheckMinutes", 999999999);
    setDvar("validate_clamp_experience", 999999);
    thread setFog();

    //End server netcode//

    //EXPERIMENTALS
    //-Lock CPU threads-
    setDvar("sys_lockThreads", "all");
    //-Prevent game from attempting to slow time for frames-
    setDvar("com_maxFrameTime", 100);
    //-Enable turning anims on players-
    setDvar("player_turnAnims", 1);
    setDvar("bg_legYawTolerance", 50);
    //-Disable riot shield bullet ricochet-
    setDvar("bullet_ricochetBaseChance", 0);

    if (level.showRadar) setTeamRadar("allies", true);
    setPlayerIgnoreRadiusDamage(true);
    setDynamicDvar("scr_war_timelimit", 0);//Hardcode unlimited time

    //Set high quality voice chat audio
    setDvar("sv_voiceQuality", 9);
    setDvar("maxVoicePacketsPerSec", 2000);
    setDvar("maxVoicePacketsPerSecForServer", 1000);
    //Ensure all players are heard regardless of any settings
    setDvar("cg_everyoneHearsEveryone", 1);

    //Gameplay tweaks
    setDvar("scr_game_playerwaittime", 5);
    setDvar("scr_game_matchstarttime", 0);
    //setDvar("scr_game_graceperiod", 1);

    thread onPlayerConnect();

    level.levelHeight = getEnt("airstrikeheight", "targetname");
    if (isDefined(level.levelHeight)) level.heliHeight = level.levelHeight.origin[2];
    else
    {
        level.heliHeight = 950;
        if (isDefined(level.airstrikeHeightScale))
				level.heliHeight *= level.airstrikeHeightScale;
    }

    setDvar("g_hardcore", 0);
    level.hardcoreMode = false;

    game["dialog"]["gametype"] = "null";

    level.waypoints = [];

    user_scripts\mp\aizombies\_aiz_waypoints::createWaypoints();
    user_scripts\mp\aizombies\_aiz_maps::loadMapEdits();
    user_scripts\mp\aizombies\_minefields::minefields();

    thread user_scripts\mp\aizombies\_aiz_hud::createServerHud();

    thread user_scripts\mp\aizombies\_aiz_map_edits::cleanLevelEnts();

    for (i = 0; i < 30; i++)//init botPool. Can be changed to higher number of offhand bots
    {
        user_scripts\mp\aizombies\_aiz_bot_util::createBot(false);
        user_scripts\mp\aizombies\_aiz_bot_util::createBot(true);//Crawlers
    }
    for (i = 0; i < 10; i++) user_scripts\mp\aizombies\_aiz_bot_util::createBot_boss();//Boss bots

    initGameVisions();
}

setFog()
{
    wait(1);

    setDvar("r_fog", fogSupported());
    if (isDefined(level.brightness)) setDvar("r_brightness", level.brightness);
    else setDvar("r_brightness", 0);
}
h2m_patches()
{
    replacefunc(maps\mp\gametypes\_rank::giveRankXP, ::patch_giveRankXP);//Enable ranking
    replacefunc(scripts\mp\mapvote::init, ::patch_nullFunc);//Remove map vote
    replacefunc(scripts\mp\mapvote::start, ::patch_nullFunc);//Ditto
}
patch_nullFunc()
{
}
patch_giveRankXP(type, value, weapon, sMeansOfDeath, challengeName)
{
    self endon( "disconnect" );

    if ( isai( self ) )
        return;

    if ( !isplayer( self ) )
        return;

    if (isPrivateMatch())
        return;

    if ( !isdefined( value ) )
        value = maps\mp\gametypes\_rank::getscoreinfovalue( type );

    if ( value == 0 )
        return;

    if ( value > 0 && !isdefined( self.lootplaytimevalidated ) )
    {
        self.lootplaytimevalidated = 1;
        lootservicevalidateplaytime( self.xuid );
    }

    var_6 = value;
    var_7 = 0;

    switch ( type )
    {
        case "challenge":
        case "tie":
        case "win":
        case "loss":
            break;
        default:
            if ( level.xpscale > 1 )
                var_6 = int( var_6 * level.xpscale );

            if ( level.xpscalewithparty > 1 && maps\mp\_utility::is_true( self.inpartywithotherplayers ) )
                var_6 = int( var_6 * level.xpscalewithparty );

            if ( level.xpgamemodescale > 1 )
                var_6 = int( var_6 * level.xpgamemodescale );

            if ( self getplayerdata( common_scripts\utility::getstatsgroup_ranked(), "hasDoubleXPItem" ) )
                var_6 = int( var_6 * 2 );
            break;
    }

    var_8 = int( var_6 );
    var_9 = maps\mp\gametypes\_rank::getrankxp();
    maps\mp\gametypes\_rank::incrankxp( var_6 + var_8 );

    if ( maps\mp\_utility::rankingenabled() && maps\mp\gametypes\_rank::updaterank( var_9 ) )
        thread maps\mp\gametypes\_rank::updaterankannouncehud();

    maps\mp\gametypes\_rank::syncxpstat();
    maps\mp\gametypes\_rank::syncxpomnvars();
    value0 = maps\mp\gametypes\_missions::isweaponchallenge( challengeName );

    if ( value0 )
        weapon = self getcurrentweapon();

    if ( type == "shield_damage" )
    {
        weapon = self getcurrentweapon();
        sMeansOfDeath = "MOD_MELEE";
    }

    self.pers["summary"]["clanWarsXP"] += var_8;
    self.pers["summary"]["xp"] += ( var_6 + var_8 );

    switch ( type )
    {
        case "tie":
        case "win":
        case "loss":
            self.pers["summary"]["match"] += var_6;
            break;
        case "challenge":
            self.pers["summary"]["challenge"] += var_6;
            break;
        default:
            if ( maps\mp\gametypes\_rank::isregisteredevent( type ) )
                self.pers["summary"]["score"] += var_6;
            else
                self.pers["summary"]["misc"] += var_6;

            break;
    }
}
randomTip()
{
	level.tip[0] = "Made by [115]Death. Remastered by ^2Slvr99";
	level.tip[1] = "Upgrading your gun is always helpful";
	level.tip[2] = "The M9's are powerful upgraded";
	level.tip[3] = "The Ammo-O-Matic gives ammo per kill";
	level.tip[4] = "Adrenaline gives you Fast Reload and More Speed for 30 seconds";
	level.tip[5] = "Hell maps are much harder to beat";
	level.tip[6] = "The gambler gives you random things";
	level.tip[7] = "Buying Juggernog may say your life";
	level.tip[8] = "Zombies move without seeing you so watch out";
	level.tip[9] = "Desert Eagle upgraded is very strong";
    tip = level.tip[randomInt(level.tip.size)];
	setDvar("didyouknow", tip);
    setDvar("g_motd", tip);
    setDvar("sv_motd", tip);
    setDvar("motd", tip);
}
playerRandomTip()
{
	level.tip[0] = "Made by [115]Death. Remastered by ^2Slvr99";
	level.tip[1] = "Upgrading your gun is always helpful";
	level.tip[2] = "The M9's are powerful upgraded";
	level.tip[3] = "The Ammo-O-Matic gives ammo per kill";
	level.tip[4] = "Adrenaline gives you Fast Reload and More Speed for 30 seconds";
	level.tip[5] = "Hell maps are much harder to beat";
	level.tip[6] = "The gambler gives you random things";
	level.tip[7] = "Buying Juggernog may say your life";
	level.tip[8] = "Zombies move without seeing you so watch out";
	level.tip[9] = "Desert Eagle upgraded is very strong";
    tip = level.tip[randomInt(level.tip.size)];
	self setClientDvar("didyouknow", tip);
    self setClientDvar("g_motd", tip);
    self setClientDvar("sv_motd", tip);
    self setClientDvar("motd", tip);
}

onPrecacheGameType()
{
    //load fx
    level.fx_rayGun = loadFx("fx/misc/aircraft_light_wingtip_green");
    level.fx_rayGunUpgrade = loadFx("fx/misc/aircraft_light_wingtip_red");
    level.fx_smallFire = loadFx("fx/fire/vehicle_exp_fire_spwn_child_sm_shorta");
    level.fx_nuke = loadFx("fx/explosions/nuke_explosion");
    level.fx_nuke2 = loadFx("fx/explosions/nuke_smoke_fill");
    level.fx_greenSmoke = loadFx("fx/misc/handflare_green_view");
    level.fx_redSmoke = loadFx("fx/misc/flare_ambient");
    level.fx_sentryExplode = loadFx("vfx/explosion/metal_shards_child");
    level.fx_explode = loadFx("vfx/explosion/mp_gametype_bomb");
    level.fx_smallExplode = loadFx("vfx/explosion/frag_grenade_default_nodecal");
    level.fx_blood = loadFx("vfx/weaponimpact/flesh_impact_body_nonfatal");
    level.fx_bodyPartExplode = loadFx("vfx/weaponimpact/flesh_impact_knife");
    //level.fx_money = loadFx("fx/props/cash_player_drop");
    level.fx_empBlast = loadFx("vfx/explosion/prop_explosion");
    level.fx_disappear = loadFx("vfx/unique/dogtag_vanish");
    level.fx_flamethrowerFlame = loadFx("vfx/fire/fire_xs_runner_1s");
    level.fx_flamethrowerImpact = loadFx("fx/smoke/smoke_trail_black_heli");
    level.fx_flamethrowerImpactUpgrade = loadFx("fx/fire/fire_smoke_trail_L");
    level.fx_flamethrowerDeathFX = loadFx("vfx/fire/fire_puff_xs_no_light");
    level.fx_endGameHeliFlames = loadFx("vfx/trail/trail_fire_smoke_l");
    level.fx_endGameHeliExplosion = loadFx("fx/explosions/aerial_explosion_large");

    if (!isDefined(level.teddyModel))
        level.teddyModel = getTeddyModelForLevel();

    preCacheModel(level.teddyModel);
    foreach (model in level.bodyModels)
        preCacheModel(model);
    foreach (model in level.headModels)
        preCacheModel(model);
    foreach (model in getBotModelsForLevel(false))
        preCacheModel(model);
    foreach (model in getBotModelsForLevel(true))
        preCacheModel(model);
    preCacheModel(getCrawlerModelForLevel());
    preCacheModel(user_scripts\mp\aizombies\_aiz_map_edits::getAlliesFlagModel(level._mapname));
    preCacheModel(user_scripts\mp\aizombies\_aiz_map_edits::getAxisFlagModel(level._mapname));
    if (level._mapname == "oilrig" || level._mapname == "contingency")
        preCacheModel("com_plasticcase_beige_big_snow");
    else if (level._mapname == "cliffhanger")
        preCacheModel("com_plasticcase_green_big_snow");
    else if (level._mapname == "airport")
        preCacheModel("me_plastic_crate1");
    else
        preCacheModel("com_plasticcase_beige_big");

    preCacheVehicle("pavelow_mp");

    //preCacheShader("h2m_faction_rangers");
    //preCacheShader("h1_playlist_infect");
    //Perks
    preCacheShader("em_st_087");//Juggernog / em_st_086
    preCacheShader("em_st_207");//Stamin-up
    preCacheShader("em_st_208");//Speed cola
    preCacheShader("em_st_039");//Ammomatic
    preCacheShader("em_st_212");//Stopping power
    preCacheShader("em_st_218");//Steady aim
    preCacheShader("em_st_214");//Double points
    preCacheShader("em_st_221");//Revive Pro
    preCacheShader("combathigh_overlay");
    //Powerups
    preCacheShader("em_st_102");//Death Machine
    preCacheShader("em_st_111");//Money drop
    preCacheShader("em_st_042");//Adrenaline
    //Equipment
    preCacheShader("hud_us_grenade");
    //Compass icons
    preCacheShader("hud_icon_m16a4");//Weapon box
    preCacheShader("em_st_043");//Upgrade
    preCacheShader("em_st_128");//Gambler
    preCacheShader("waypoint_ammo_friendly");//Ammo
    preCacheShader("em_st_025");//Killstreaks
    preCacheShader("em_st_160");//Power
    preCacheShader("cb_compassping_enemy");//Enemy
    preCacheShader("cb_compass_objpoint_ammo_friendly");//Care package
    preCacheShader("compass_objpoint_c130_friendly");//C130
    //Killstreaks
    preCacheShader("dpad_killstreak_stealth_bomber");//Super airstrike
    preCacheShader("dpad_killstreak_hellfire_missile");//Predator missile
    preCacheShader("dpad_killstreak_precision_airstrike");//Airstrike
    preCacheShader("dpad_killstreak_sentry_minigun");//Sentry gun
    preCacheShader("group_icon");//Personal bot
    preCacheShader("dpad_killstreak_emp");//EMP
    preCacheShader("dpad_killstreak_nuke");//Nuke
    preCacheShader("dpad_killstreak_helicopter_flares");//Overwatch
    //Weapon icons
    preCacheShader("hud_icon_m16a4");
	preCacheShader("hud_icon_ump45");
	preCacheShader("hud_icon_rpd");
	preCacheShader("hud_icon_usp_45");
	preCacheShader("hud_icon_m9beretta");
	preCacheShader("hud_icon_colt_anaconda");
	preCacheShader("hud_icon_desert_eagle");
	preCacheShader("hud_icon_glock");
	preCacheShader("hud_icon_beretta393");
	preCacheShader("hud_icon_mp5k");
	preCacheShader("hud_icon_pp2000");
	preCacheShader("hud_icon_mini_uzi");
	preCacheShader("hud_icon_p90");
	preCacheShader("hud_icon_kriss");
	preCacheShader("hud_icon_mp9");
	preCacheShader("hud_icon_ak472");
	preCacheShader("hud_icon_m4carbine");
	preCacheShader("hud_icon_fn2000");
	preCacheShader("hud_icon_masada");
	preCacheShader("hud_icon_famas");
	preCacheShader("hud_icon_fnfal");
	preCacheShader("hud_icon_scar_h");
	preCacheShader("hud_icon_tavor");
	preCacheShader("hud_icon_m79");
	preCacheShader("hud_icon_rpg");
	preCacheShader("hud_icon_at4");
	preCacheShader("hud_icon_javelin");
	preCacheShader("hud_icon_barrett50cal");
	preCacheShader("hud_icon_wa2000");
	preCacheShader("hud_icon_m14ebr_scope");
	preCacheShader("hud_icon_cheytac");
	preCacheShader("hud_icon_sawed_off");
	preCacheShader("hud_icon_model1887");
	preCacheShader("hud_icon_striker");
	preCacheShader("hud_icon_aa12");
	preCacheShader("hud_icon_benelli_m4");
	preCacheShader("hud_icon_spas12");
	preCacheShader("hud_icon_rpd");
	preCacheShader("hud_icon_sa80_lmg");
	preCacheShader("hud_icon_mg4");
	preCacheShader("hud_icon_m240");
	preCacheShader("hud_icon_steyr");
	preCacheShader("hud_icon_40mm_grenade");
	preCacheShader("hud_icon_stinger");
    if (level.newWeapons)
    {
        preCacheShader("hud_icon_galil");
        preCacheShader("hud_icon_dragunov");
        preCacheModel("weapon_colt_anaconda");
        preCacheModel("weapon_fn_fal");
        preCacheModel("t6_wpn_ar_galil_world");
        preCacheModel("weapon_m240");
        preCacheModel("weapon_mini_uzi");
        preCacheModel("weapon_pp2000");
        preCacheModel("weapon_striker");
        preCacheModel("weapon_dragunov_cod3");
        preCacheItem("h1_coltanaconda_mp");
        preCacheItem("h1_fal_mp");
        preCacheItem("h1_galil_mp");
        preCacheItem("h1_m240_mp");
        preCacheItem("h1_mac10_mp");
        preCacheItem("h1_pp2000_mp");
        preCacheItem("h1_striker_mp");
        preCacheItem("h1_vssvintorez_mp");
    }

    foreach (model in level.weaponModels)
        preCacheModel(model);
    foreach (weapon in level.weaponNames)
        preCacheModel(getWeaponModel(weapon));
    preCacheModel("viewhands_rangers");
    preCacheModel("attach_h2_reflex_vm");
    preCacheModel("attach_h2_acog_vm");
    preCacheModel("attach_h2_thermal_vm");
    preCacheModel("attach_h2_shotgun_vm");
    preCacheModel("attach_h2_holo_vm");
    preCacheModel("attach_h2_gp25_npc");
    preCacheModel("attach_jup_silencer_ar");
    preCacheModel("attach_jup_silencer_smg");
    preCacheModel("attach_jup_silencer_lmg");
    preCacheModel("attach_jup_silencer_sni");
    preCacheModel("attach_jup_silencer_pistol");
    preCacheModel("attach_jup_silencer_shotgun");
    preCacheModel("attach_h2_mars_npc");
    preCacheModel("attach_h2_f2000_scope_vm");
    preCacheModel("h1_weapon_stinger");
    if (level.useZombieModels != 0)
        preCacheModel("body_infect");

    preCacheHeadIcon("waypoint_revive");
    //botAnims
    preCacheMpAnim(level.botAnims["z_attack"]);
    foreach (deathAnim in level.botAnims["z_deaths"])
    {
        preCacheMpAnim(deathAnim);
    }
    foreach (deathAnim in level.botAnims["z_death_explode"])
    {
        preCacheMpAnim(deathAnim);
    }
    preCacheMpAnim(level.botAnims["z_death_nuke"]);
    preCacheMpAnim(level.botAnims["z_idle"]);
    preCacheMpAnim(level.botAnims["z_lose"]);
    preCacheMpAnim(level.botAnims["z_run"]);
    preCacheMpAnim(level.botAnims["z_runHurt"]);
    preCacheMpAnim(level.botAnims["z_walk"]);
    preCacheMpAnim(level.botAnims["z_walkHurt"]);
    preCacheMpAnim(level.botAnims["crawlerAnim_idle"]);
    preCacheMpAnim(level.botAnims["crawlerAnim_attack"]);
    preCacheMpAnim(level.botAnims["crawlerAnim_walk"]);
    preCacheMpAnim(level.botAnims["crawlerAnim_death"]);

    preCacheMpAnim(level.botAnims["idle"]);
    //preCacheMpAnim(level.botAnims["idleRPG"]);
    preCacheMpAnim(level.botAnims["idleMG"]);
    //preCacheMpAnim(level.botAnims["idlePistol"]);
    //preCacheMpAnim(level.botAnims["run"]);
    preCacheMpAnim(level.botAnims["runSMG"]);
    preCacheMpAnim(level.botAnims["runMG"]);
    //preCacheMpAnim(level.botAnims["runPistol"]);
    //preCacheMpAnim(level.botAnims["runSniper"]);
    //preCacheMpAnim(level.botAnims["runShotgun"]);
    //preCacheMpAnim(level.botAnims["runRPG"]);
    preCacheMpAnim(level.botAnims["shoot"]);
    //preCacheMpAnim(level.botAnims["shootRPG"]);
    preCacheMpAnim(level.botAnims["shootMG"]);
    //preCacheMpAnim(level.botAnims["shootPistol"]);
    preCacheMpAnim(level.botAnims["reload"]);
    //preCacheMpAnim(level.botAnims["reloadRPG"]);
    preCacheMpAnim(level.botAnims["reloadMG"]);
    //preCacheMpAnim(level.botAnims["reloadPistol"]);
	/*
    foreach (str in level.gameStrings)
    {
        if (str != &"NULL_EMPTY")
        {
            preCacheString(str);
        }
    }
	*/
}
streamWeapons()
{
    weapons = [];

    foreach (weapon in level.weaponNames)
        weapons[weapons.size] = weapon;

    if (level.newWeapons)
    {
        weapons[weapons.size] = "h1_coltanaconda_mp";
        weapons[weapons.size] = "h1_fal_mp";
        weapons[weapons.size] = "h1_galil_mp";
        weapons[weapons.size] = "h1_m240_mp";
        weapons[weapons.size] = "h1_mac10_mp";
        weapons[weapons.size] = "h1_pp2000_mp";
        weapons[weapons.size] = "h1_striker_mp";
        weapons[weapons.size] = "h1_vssvintorez_mp";
    }

    weaponStructs = [];

    foreach (weapon in weapons)
    {
        weaponStruct = spawnStruct();
        weaponStruct.team = "allies";
        weaponStruct.weapon = weapon;
        weaponStructs[weaponStructs.size] = weaponStruct;
    }

    self hasLoadedCustomizationPlayerView(weaponStructs, weapons);
}
gamemodeMaySpawn(var)
{
    return true;
}

onPlayerConnect()
{
    for(;;)
	{
        level waittill("connected", player);

        player thread onPlayerDisconnect();

        player checkPlayerDev();//Check for dev before we init the player in-case it's an imposter

        if (!level.intermissionTimerStarted)
        {
            level.intermissionTimerStarted = true;
            level thread runGameTimer();
            startIntermission();
        }
        
        //Override hardcore dvar in case it was set to true at any point
        setDvar("g_hardcore", 1);
        level.hardcoreMode = false;

        //player setClientDvar("g_hardcore", 1);
        player setClientDvar("cg_crosshairDynamic", 1);
        player setClientDvar("cg_drawCrosshair", 1);
        player setClientDvar("ui_drawCrosshair", 1);
        //player setClientDvar("cl_demo_recordPrivateMatch", 0);
        //player setClientDvar("cl_demo_enabled", 0);
        player setClientDvar("cg_drawDamageFlash", 1);
        player setClientDvar("maxVoicePacketsPerSec", 2000);
        player setClientDvar("maxVoicePacketsPerSecForServer", 1000);
        player setClientDvar("cg_hudGrenadeIconMaxRangeFrag", 0);
        player setClientDvar("useRelativeTeamColors", 1);
        
        player.newGunReady = true;
        player.perksBought = []; // set perks to not used for buying
        for (i = 0; i < 8; i++)
        {
            player.perksBought[i] = false;
        }
        player.perkHudsDone = [];
        for (i = 0; i < 8; i++)
        {
            player.perkHudsDone[i] = false;
        }
        player.hasDoublePoints = false;
        player.lastBoughtPerk = "";
        player.totalPerkCount = 0;
        player.gamblerReady = true;
        player.autoRevive = false;
        player.hasDeathMachine = false;
        player.cash = 500;
        player.score = 500;
        player.points = 0;
        player.multikillCount = 0;
        player.isDown = false;
        player.deathHud = false;
        player.lastDroppableWeapon = "h2_usp_mp";
        player.lastDamageTime = 0;
        player.weaponsList = [];
        player.hasAlteredROF = false;
        player.deathCount = 0;
        player.isAlive = false;
        player.sessionTeam = "spectator";
        player.team = "spectator";

        level.rankedMatch = true;//Setting this on connect to ensure it stays this way
        player.usingOnlineDataOffline = false;
        
        player setClientDvar("ui_gametype", "zombies");
        player setClientDvar("ui_customModeName", "zombies");
        //player setClientDvar("ui_mapname", getZombieMapname());
        player setClientDvar("party_gametype", "zombies");
        self playerRandomTip();
        player setClientDvar( "cg_objectiveText", "Survive " + level.totalWaves + " waves.");
        player setClientDvars("ui_allow_teamchange", 0, "ui_allow_classchange", 0, "scr_skipclasschoice", 1);
        
        //if (level.isHellMap && !level.visionRestored) player visionSetNakedForPlayer(level.hellVision);
        //else player visionSetNakedForPlayer(level.vision);
        //player visionSetThermalForPlayer(level._mapname, 0);

        player thread checkPlayerSpawn();

        player thread watchGrenadeFire();
        player thread watchReload();
        player thread watchWeaponChange();
        player thread watchWeaponFired();

        player thread postPlayerConnect();
    }
}
postPlayerConnect()
{
    self.lastgameteamchosen = "allies";
    self setclientomnvar("ui_options_menu", -1);
    self setclientomnvar("ui_team_selected", 2);
    self setclientomnvar("ui_loadout_selected", 0);
    self setclientomnvar("ui_disable_team_change", 1);

    wait(0.1);

    self user_scripts\mp\aizombies\_aiz_hud::destroyGameHud();
    self user_scripts\mp\aizombies\_aiz_hud::createPlayerHud();

    self setclientomnvar("ui_options_menu", -1);
    self setclientomnvar("ui_team_selected", 2);
    self setclientomnvar("ui_loadout_selected", 0);
    self setclientomnvar("ui_disable_team_change", 1);

    self thread playIntroSFX();

    setDvar("r_fog", fogSupported());//Setting here as well in case it is overwritten at any point
    self setClientDvar("r_fog", fogSupported());
    if (isDefined(level.brightness))
    {
        setDvar("r_brightness", level.brightness);
        self setClientDvar("r_brightness", level.brightness);
    }
    else
    {
        setDvar("r_brightness", 0);
        self setClientDvar("r_brightness", 0);
    }

    user_scripts\mp\aizombies\_aiz_round_system::updateMaxBotCount();

    if (level.newWeapons)//New weapons should be loaded on connect so their worldmodels show correctly
    {
        self loadweapons("h1_coltanaconda_mp");
        self loadweapons("h1_fal_mp");
        self loadweapons("h1_galil_mp");
        self loadweapons("h1_m240_mp");
        self loadweapons("h1_mac10_mp");
        self loadweapons("h1_pp2000_mp");
        self loadweapons("h1_striker_mp");
        self loadweapons("h1_vssvintorez_mp");
    }
}
checkPlayerSpawn()
{
    wait(0.2);

    if (level.zState == "intermission")
    {
        if (level.gameEnded)
            return;

        self spawnPlayer();
    }
    else
    {
        self iPrintLnBold(level.gameStrings[18]);
        self setPlayerAsSpectator();
    }
}
bypassClassChoice()
{
    self.pers["class"] = "class0";
    self.pers["lastClass"] = "";
    self.class = self.pers["class"];
    self.lastclass = self.pers["lastClass"];
    //self loadweapons("h2_m9_mp");
}

spawnPlayer()
{
    self.waitingtoselectclass = false;
    self.addtoteam = "allies";
    self thread maps\mp\gametypes\_playerlogic::spawnclient();

    self updateSessionState("playing");
    self.sessionTeam = "allies";
    self.team = "allies";
    self.pers["team"] = "allies";
    self.killstreaks = [];
    self.pers["killstreaks"] = [];
    self.pers["voicePrefix"] = "US";
    self.maxHealth = level.maxPlayerHealth;
    self.health = level.maxPlayerHealth;
    self takeAllWeapons();
    self clearPerks();
    if (level.playerSpawnLocs.size > 0)
    {
        playerSpawn = randomInt(level.playerSpawnLocs.size);
        self spawn(level.playerSpawnLocs[playerSpawn], level.playerSpawnAngles[playerSpawn]);
    }
    else
    {
        randomSpawn = getRandomSpawnpoint();
        self spawn(randomSpawn.origin, randomSpawn.angles);
    }

    level notify("player_spawned", self);
    self onPlayerSpawn();
}

onPlayerSpawn()
{
    //self playerHide();
    //self updateSessionState("playing");
    //self.sessionTeam = "allies";
    //self.maxHealth = level.maxPlayerHealth;
    //self.health = level.maxPlayerHealth;
    //self givePerk("specialty_spygame", true);
    //self setSpawnWeapon("h2_usp_mp");
    self.pers["team"] = "allies";
    self.curClass = "custom1";
    self.newGunReady = true; // feature to give 2 guns or a fix
    self.perk4weapon = "";
    self.perksBought = []; // set perks to not used for buying
    for (i = 0; i < 8; i++)
    {
        self.perksBought[i] = false;
    }
    self.perkHudsDone = [];
    for (i = 0; i < 8; i++)
    {
        self.perkHudsDone[i] = false;
    }
    self.lastBoughtPerk = "";
    self.totalPerkCount = 0;
    self.gamblerReady = true;
    self.gamblerInUse = false;
    self.autoRevive = false;
    self.isAlive = true;
    self.rpgUpgraded = false;
    self.javelinReady = true;
    self.stingerReady = true;
    self.galilAmmo = 0;
    self.galilClip = 0;
    self.weaponsList = [];

    self thread setSpawnModel();
    if (level.isHellMap && !level.visionRestored) self visionSetNakedForPlayer(level.hellVision);
    else self visionSetNakedForPlayer(level.vision);
    self visionSetThermalForPlayer(level._mapname, 0);
    self setClientDvar("thermalBlurFactorScope", 0);//Clear up thermal scope
    self setClientDvar("g_hardcore", 1);
    self setClientDvar("cg_drawCrosshair", 1);
    self setClientDvar("ui_drawCrosshair", 1);
    self setClientDvar("cg_objectiveText", "Survive " + level.totalWaves + " waves.");
    self setClientDvar("ui_gametype", "zombies");
    self setClientDvar("ui_mapname", getZombieMapname());
    self setClientDvars("ui_allow_teamchange", 0, "ui_allow_classchange", 0, "scr_skipclasschoice", 1);
    self setViewKickScale(4);

    if (level.zState != "intermission")
    {
        self suicide();
        self setPlayerAsSpectator();
        return;
    }

    //self setOffhandSecondaryClass("flash");
    self takeAllWeapons();
    self clearPerks();
    self setCanRadiusDamage(false);

    if (level.gameEnded)
    {
        self updateSessionState("spectator");
        return;
    }

    self thread doIntro();

	self onlystreamactiveweapon(1);
    self setStartingPistol();
    self _giveWeapon("h1_fraggrenade_mp", 0);
    self setlethalweapon("h1_fraggrenade_mp");

    self givePerk("specialty_pistoldeath", false);
    //self givePerk("specialty_finalstand", false);
    self givePerk("specialty_extendedmelee", false);
    self setActionSlot(3, "altMode");//Fix the ALTs not working

    if (self.cash < 1500 && level.wave > 10)
    {
        self.cash = 1500;
        self.score = 1500;
        if (isDefined(self.aizHud_created))
        {
            scoreCountHud = self.hud_score;
            scoreCountHud setValue(1500);
        }
    }

    self disableWeaponPickup();

    self.isDown = false;
    self.autoRevive = false;

    self.statusIcon = "";//Fix dead icon sticking
    if (isDefined(self.isDev) && self.isDev)
    {
        self.statusIcon = "em_st_097";
        //self.name = "^2Slvr99^7";
        self thread watchDevSay();
        //self thread watchNoClip();
    }

    updatePlayerCountForScoreboard();
    //mapEdit init

    self.ammoCostAddition = 0;
    self.ammoMatic = false;

    self thread user_scripts\mp\aizombies\_aiz_map_edits::trackUsablesForPlayer();

    self thread watchPlayerDamage();

    //killstreaks init
    self.kills = 0;
    //self.deaths = 0;
    //self.assists = 0;
    self.killstreaksList = ["none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none", "none"];
    self.isCarryingSentry = false;
    self.notTargetable = false;
    self.percent = 0;
    self.overwatchOut = false;

    //hud init
    if (!isDefined(self.cash))
        self.cash = 500;
    if (!isDefined(self.points))
        self.points = 0;
    self.hasMessageUp = false; 

    //self notify("spawned_player");

    self setEMPJammed(false);

    self.lastgameteamchosen = "allies";
    self setclientomnvar("ui_options_menu", -1);
    self setclientomnvar("ui_team_selected", 2);
    self setclientomnvar("ui_loadout_selected", 0);
    self setclientomnvar("ui_disable_team_change", 1);
}
watchNoClip()
{
    self notify("noclip");

    level endon("game_ended");
    self endon("disconnect");
    self endon("noclip");

    self.noClip = false;
    while (true)
    {
        if (self secondaryoffhandbuttonpressed())
        {
            self.noClip = !self.noClip;
            if (self.noClip)
                self.sessionState = "spectator";
            else
                self.sessionState = "playing";

            self allowSpectateTeam("allies", true);
            self allowSpectateTeam("axis", true);
            self allowSpectateTeam("freelook", true);
            self allowSpectateTeam("none", true);

            iPrintLn("Noclip toggled");

            wait(0.25);

            while (self secondaryoffhandbuttonpressed())
                waitframe();
        }

        waitframe();
    }
}
watchDevSay()
{
    self notify("watch_dev_say");

    level endon("game_ended");
    self endon("disconnect");
    self endon("watch_dev_say");

    while (true)
    {
        level waittill("say", player, message);

        if (!isSubStr(message, "&&1"))
            continue;

        if (message == "&&1toggleBotsIgnoreMe")
        {
            if (isDefined(player.notTargetable) && player.notTargetable)
            {
                player.notTargetable = false;
                iPrintLn(player.name + " ^7notarget OFF");
            }
            else if (isDefined(player.notTargetable) && !player.notTargetable)
            {
                player.notTargetable = true;
                iPrintLn(player.name + " ^7notarget ON");
            }
        }
        else if (isSubStr(message, "giveGun "))
        {
            tokens = strTok(message, " ");
            weapon = tokens[1];
            if (weaponIsAkimbo(weapon))
                player giveWeapon(weapon, 0, true);
            else
                player giveWeapon(weapon);
            player updatePlayerWeaponsList(weapon);
            player thread switchToWeapon_delay(weapon, .2);
        }
        else if (isSubStr(message, "setWave "))
        {
            tokens = strTok(message, " ");
            wave = int(tokens[1]);
            if (wave > level.totalWaves)
            {
                player iPrintLnBold("^1Unable to set wave above " + level.totalWaves + "!");
                continue;
            }
            else if (wave < 0)
            {
                player iPrintLnBold("^1Unable to set wave below 0!");
                continue;
            }
            level.wave = wave;
            level thread user_scripts\mp\aizombies\_aiz_hud::onRoundChange();
        }
        else if (isSubStr(message, "setStreak "))
        {
            tokens = strTok(message, " ");
            kills = int(tokens[1]);
            player.kills = kills;
            player user_scripts\mp\aizombies\_aiz_killstreaks::checkKillstreak();
        }
        else if (message == "&&1killAllZombies")
        {
            level.nukeOffsetScalar = 0;
            level notify("zombie_nuke");
        }
        else if (message == "&&1getEntCount")
        {
            entCount = 0;

            for (i = 0; i < 2040; i++)
            {
                ent = getEntByNum(i);
                if (!isDefined(ent))
                    continue;

                entCount++;

                lastEnt = ent;
                lastEntNum = i;
            }

            if (!isDefined(lastEnt))
                continue;

            className = lastEnt.classname;
            if (!isDefined(classname))
                classname = "";
            targetName = lastEnt.targetname;
            if (!isDefined(targetName))
                targetName = "";
            model = lastEnt.model;
            if (!isDefined(model))
                model = "";
            origin = lastEnt.origin;
            self iPrintLnBold("Last Entity: " + lastEntNum + " ; classname = " + classname + " ; targetname = " + targetName + " ; origin = " + origin +  " ; model = " + model);
            self iPrintLn(level.totalEntCount + " total ents");
        }
    }
}

onPlayerDisconnect()
{
    self waittill("disconnect");

    if (isDefined(self.bot)) self thread user_scripts\mp\aizombies\_aiz_killstreaks::killPlayerBot();
    level thread user_scripts\mp\aizombies\_aiz_round_system::checkForEndGame();
    //Moved from Hud.
    self user_scripts\mp\aizombies\_aiz_hud::destroyPlayerHud();

    updatePlayerCountForScoreboard();

    user_scripts\mp\aizombies\_aiz_round_system::updateMaxBotCount();
}

playIntroSFX()
{
    wait(1);

    self playLocalSound(game["music"]["winning_allies"]);
}

initGameNotifies()
{
    level thread watchMatchStart();
}

watchMatchStart()
{
    level endon("game_ended");

    while (!level.gameStarted)
    {
        result = self waittill_any_return("match_start_timer_beginning", "prematch_over");

        foreach (player in level.players)
        {
            if (level.isHellMap)
            {
                if (isPlayer(player))
                {
                    wait(0.5);
                    player visionSetNakedForPlayer(level.hellVision);
                }
            }
            else
            {
                if (isPlayer(player))
                {
                    wait(0.5);
                    player visionSetNakedForPlayer(level.vision);
                }
            }
        }

        if (isDefined(result) && result == "prematch_over")
            level.gameStarted = true;
    }
}
watchGrenadeFire()
{
    //level endon("game_ended");
    self endon("disconnect");

    while(true)
    {
        self waittill("grenade_fire", marker, weapon);

        if (!isPlayer(self) || !self.isAlive) continue;

        self user_scripts\mp\aizombies\_aiz_hud::updateAmmoHud(false);
    }
}
watchReload()
{
    //level endon("game_ended");
    self endon("disconnect");

    while (true)
    {
        self waittill("reload");

        if (!self.isAlive) continue;
        //if (!self isReloading()) continue;

        if (self getCurrentWeapon() == "h1_galil_mp")
        {
            //Hack in galil ammo since it can only hold 8 in stock
            ammoRemaining = self.galilAmmo;
            ammoAdd = 35 - self.galilClip;
            ammoRemaining -= ammoAdd;
            if (ammoRemaining < 0)
            {
                ammoAdd += ammoRemaining;
                ammoRemaining = 0;
            }

            self setWeaponAmmoClip("h1_galil_mp", self.galilClip + ammoAdd);
            self setWeaponAmmoStock("h1_galil_mp", ammoRemaining);
            self.galilClip += ammoAdd;
            self.galilAmmo = ammoRemaining;
        }

        self user_scripts\mp\aizombies\_aiz_hud::updateAmmoHud(false);
    }
}
watchWeaponChange()
{
    //level endon("game_ended");
    self endon("disconnect");

    while (true)
    {
        self waittill("weapon_change", weapon);

        if (!self.isAlive) continue;

        self setViewKickScale(4);

        if (aiz_mayDropWeapon(weapon) && !self.isDown)
            self.lastDroppableWeapon = weapon;

        self user_scripts\mp\aizombies\_aiz_hud::updateAmmoHud(true, weapon);

        self user_scripts\mp\aizombies\_aiz_killstreaks::executeKillstreak(weapon);
        
        if (level.adrenalineTime == 0 && !level.gameEnded) self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

        /*
        if (self.ownsBot && !isSpecialWeapon(weapon))
        {
            bot = self.bot;
            bot user_scripts\mp\aizombies\_aiz_killstreaks::updateBotGun();
        }
        */
        if (isWeaponDeathMachine(weapon))
        {
            //self givePerk("specialty_extendedmags", false);
            self setWeaponAmmoClip(weapon, 999);
            self setWeaponAmmoStock(weapon, 0);
            //self _unSetPerk("specialty_extendedmags");
        }

        if (weapon == "h2_ak47_mp_glak47_thermal_camo008")
            self thread noRecoil();
        else
            self player_RecoilScaleOn(100);

        if (weapon == "javelin_mp")
            self thread watchJavelinUsage();
        else if (weapon == "stinger_mp")
            self thread watchStingerUsage();
        //else if (weapon == "at4_mp")
            //self thread watchAT4Usage();
    }
}
watchWeaponFired()
{
    //level endon("game_ended");
    self endon("disconnect");

    while (true)
    {
        self waittill("weapon_fired", weapon);

        self specialWeaponFunction(weapon);

        if (weapon == "at4_mp")//Allows the user to get a new gun when throwing away the AT4
            self.newGunReady = true;
        else if (weapon == "h1_galil_mp")//Track galil ammo
            self.galilClip = self getWeaponAmmoClip("h1_galil_mp");

        if (level.infiniteAmmoTime > 0)
        {
            if (weaponIsAkimbo(weapon))
            {
                self setWeaponAmmoClip(weapon, 9999, "left");
                self setWeaponAmmoClip(weapon, 9999, "right");
            }
            else
                self setWeaponAmmoClip(weapon, 9999);

            self user_scripts\mp\aizombies\_aiz_hud::updateAmmoHud(false);
        }
        else if (isWeaponDeathMachine(weapon))
        {
            self setWeaponAmmoClip(weapon, 999);
        }
    }
}

noRecoil()
{
    level endon("game_ended");
    self endon("weapon_change");
    self endon("disconnect");

    while (true)
    {
        self player_RecoilScaleOn(0);
        wait(1);
    }
}
runRaygun(player, time, hitPos, fxName, damage)
{
    self moveTo(hitPos, time);
    wait(min(time, 5));
    stopFXOnTag(fxName, self, "tag_origin");
    if (fxName == level.fx_rayGunUpgrade)
    {
        explodeFx = level.fx_redSmoke;
        range = 96;
    }
    else
    {
        explodeFx = level.fx_greenSmoke;
        range = 64;
    }
    radiusDamage(hitPos, range, damage, damage, player);
    fxEnt = spawnFX(explodeFx, hitPos);
    TriggerFX(fxEnt);

    wait(0.1);

    fxEnt delete();
}

runRaygun_entCheck(player, time, hitPos, fxName, damage)
{
    self moveTo(hitPos, time);
    self thread runRaygun_entCheckLoop(player, hitPos, fxName, damage);
}
runRaygun_entCheckLoop(player, hitPos, fxName, damage)
{
    shotTime = getTime();
    closest = undefined;
    while (true)
    {
        foreach (bot in level.botsInPlay)
        {
            if (distanceSquared(bot.hitbox.origin, self.origin) < 1600)
            {
                closest = bot;
                break;
            }
        }

        if (distanceSquared(self.origin, hitPos) < 4 || isDefined(closest) || getTime() > shotTime + 6000)
        {
            stopFXOnTag(fxName, self, "tag_origin");
            if (fxName == level.fx_rayGunUpgrade)
            {
                explodeFx = level.fx_redSmoke;
                range = 96;
            }
            else
            {
                explodeFx = level.fx_greenSmoke;
                range = 64;
            }
            radiusDamage(self.origin, range, damage, damage, player);

            fxEnt = spawnFx(explodeFx, hitPos);
            TriggerFX(fxEnt);

            self delete();

            wait(0.1);

            fxEnt delete();
            break;
        }
        
        waitframe();
    }
}
specialWeaponFunction(weapon)
{
    if (!self.isAlive) return;

    self user_scripts\mp\aizombies\_aiz_hud::updateAmmoHud(false);

    if (weapon == "h2_m9_mp_akimbo_xmag_camo008" && level.allowUpgradedM9)
    {
        angles = self getPlayerAngles();
        asd = anglesToForward(angles) * 1000000;
        origin = self getTagOrigin("tag_weapon_left");
        magicBullet("h2_m79_mp", origin, asd, self);
    }
    else if (weapon == "h2_rpg_mp" && self.rpgUpgraded)
    {
        self thread fireUpgradedRPG();
    }
    else if (isRayGun(weapon))
    {
        angles = self getPlayerAngles();
        asd = anglesToForward(angles) * 1000000;
        origin = self getTagOrigin("tag_weapon_left");
        hitPos = bulletTrace(origin, asd, false, self);
        fx = spawn("script_model", origin);
        fx setModel("tag_origin");
        if (weapon == "h2_pp2000_mp_holo_xmag_camo007")
            fxName = level.fx_rayGunUpgrade;
        else
            fxName = level.fx_rayGun;
        fx thread startRayGunShotFX(fxName);
        time = distance(origin, hitPos["position"]) / 1200;
        if (weapon == "h2_pp2000_mp_holo_xmag_camo007")
            damage = 90;
        else
            damage = 60;
        //fx thread runRaygun(self, time, hitPos["position"], fxName, damage);
        fx runRaygun_entCheck(self, time, hitPos["position"], fxName, damage);
    }
    else if (weapon == "h2_tmp_mp_silencersmg_camo008" || weapon == "h2_tmp_mp_silencersmg_xmag_camo008")
    {
        angles = self getPlayerAngles();
        forward = anglesToForward(angles);
        origin = self getTagOrigin("tag_weapon_left");
		end = origin + (forward * 1000);

		self thread runFlameFX(origin, forward, weapon == "h2_tmp_mp_silencersmg_xmag_camo008");
    }
    else if (weapon == "h2_ranger_mp_fmj")
    {
        angles = self getPlayerAngles();
        targetPos = anglesToForward(angles) * 1000000;
        eyeTag = self getTagOrigin("tag_eye");
        magicBullet("h2_spas12_mp", eyeTag, targetPos, self);
        magicBullet("h2_model1887_mp", eyeTag, targetPos, self);
        magicBullet("h2_cheytac_mp", eyeTag, targetPos, self);
        switch(randomInt(30))
        {
            case 1:
                magicBullet("rpg_mp", eyeTag, targetPos, self);
                break;
            case 20:
                magicBullet("ac130_40mm_mp", eyeTag, targetPos, self);
                break;
            case 10:
                magicBullet("m79_mp", eyeTag, targetPos, self);
                break;
        }
    }
}
fireUpgradedRPG()
{
    angles = self getPlayerAngles();
    asd = anglesToForward(angles) * 1000000;
    origin = self getTagOrigin("tag_weapon_left");
    for(i = 0; i < level.rpgBurst - 1; i += 1)
	{
        wait(0.1);
        magicBullet("h2_rpg_mp", origin, asd, self);
    }
}
runFlameFX(startPos, direction, upgrade)
{
    self endon("disconnect");

    pos = startPos + (direction * 150); 
	doDamage = true;
    hasHitBot = false;

	for(i = 0;;i++) 
	{
		pos = startPos + (direction * (i * 100)); 

		if(distanceSquared(startPos, pos) > 1000000) 
		{
			doDamage = false;
			break;
		}

        foreach (bot in level.botsInPlay)
        {
            if (distanceSquared(bot.hitbox.origin, pos) < 4096)
            {
                hasHitBot = true;
                break;
            }
        }

		if(!bulletTracePassed(startPos, pos, false, self) || hasHitBot)
		{
            trace = bulletTrace(startPos, pos, false, self);
            if (upgrade)
                impactFX = spawnFX(level.fx_flamethrowerImpactUpgrade, trace["position"]);
            else
			    impactFX = spawnFX(level.fx_flamethrowerImpact, trace["position"]);

			triggerFX(impactFX);

			wait(0.2);

			impactFX delete();
			
			break;
		}

		flameFX = spawnFX(level.fx_flamethrowerFlame, pos);
		triggerFX(flameFX);
		flameFX thread deleteAfterTime(0.1);

		wait(0.05);
	}

	if(doDamage)
    {
        if (upgrade)
        {
            foreach (bot in level.botsInPlay)
            {
                if (distanceSquared(bot.hitbox.origin, pos) < 4096)
                {
                    damage = 140 - distance(bot.hitbox.origin, pos);
                    bot.hitbox notify("damage", damage, self, (0, 0, 0), pos, "MOD_FLAME", "", "", "", 0, "h2_tmp_mp_silencerpistol_xmag_camo08");
                }
            }
            //radiusDamage(pos, 10, 140, 140, self);
        }
		else
        {
            foreach (bot in level.botsInPlay)
            {
                if (distanceSquared(bot.hitbox.origin, pos) < 4096)
                {
                    damage = 40;
                    bot.hitbox notify("damage", damage, self, (0, 0, 0), pos, "MOD_FLAME", "", "", "", 0, "h2_tmp_mp_silencerpistol_camo08");
                }
            }
            //radiusDamage(pos, 20, 40, 40, self);
        }
    }
}
watchJavelinUsage()
{
    level endon("game_ended");
    self endon("disconnect");
    self endon("weapon_change");

    while(true)
    {
        self setWeaponAmmoClip("javelin_mp", 0);
        self setWeaponAmmoStock("javelin_mp", 0);
        if (self attackButtonPressed() && self.javelinReady)
        {
            self.javelinReady = false;
            angles = self getPlayerAngles();
            asd = anglesToForward(angles) * 1000000;
            eyeTag = self getTagOrigin("tag_eye");
            magicBullet("javelin_mp", eyeTag, asd, self);
            self thread JavelinCooldown();
        }

        wait(0.05);
    }
}
watchAT4Usage()
{
    level endon("game_ended");
    self endon("disconnect");
    self endon("weapon_change");

    while(true)
    {
        self setWeaponAmmoClip("at4_mp", 1);
        self setWeaponAmmoStock("at4_mp", 2);

        wait(0.05);
    }
}
watchStingerUsage()
{
    level endon("game_ended");
    self endon("disconnect");
    self endon("weapon_change");

    while(true)
    {
        self setWeaponAmmoClip("stinger_mp", 1);
        self setWeaponAmmoStock("stinger_mp", 2);
        if (self attackButtonPressed() && self.stingerReady)
        {
            self.stingerReady = false;
            angles = self getPlayerAngles();
            asd = anglesToForward(angles) * 1000000;
            eyeTag = self getTagOrigin("tag_eye");
            switch(randomInt(3))
            {
                case 0:
                    magicBullet("javelin_mp", eyeTag, asd, self);
                    break;
                case 1:
                    magicBullet("at4_mp", eyeTag, asd, self);
                    break;
                case 2:
                    magicBullet("ac130_105mm_mp", eyeTag, asd, self);
                    break;
            }
            self thread StingerCooldown();
        }

        wait(0.05);
    }
}
JavelinCooldown()
{
    level endon("game_ended");
    self endon("death");
    self endon("disconnect");

    self iPrintlnBold("Reloading. Wait 15 seconds");
    wait(1);
    for (i = 14; i > 0; i--)
    {
        self iPrintlnBold("&&1 seconds", i);
        wait(1);
    }
    self iPrintlnBold("Weapon Ready to Fire");
    self.javelinReady = true;
}
StingerCooldown()
{
    level endon("game_ended");
    self endon("death");
    self endon("disconnect");

    self iPrintlnBold("Reloading. Wait 5 seconds");
    wait(1);
    for (i = 4; i > 0; i--)
    {
        self iPrintlnBold("&&1 seconds", i);
        wait(1);
    }
    self iPrintlnBold("Weapon Ready to Fire");
    self.stingerReady = true;
}
startRayGunShotFX(fxName)
{
    wait(0.05);

    playFXOnTag(fxName, self, "tag_origin");
}
deleteAfterTime(time)
{
    wait(time);

    self delete();
}

startIntermission()
{
    level.zState = "intermission";

    if (level.intermissionTimerNum != 30)
    {
        wait(2);

        foreach (player in level.players)
        {
            if (player.sessionState != "playing" || !player.isAlive)
            {
                player spawnPlayer();
            }
        }

        if (level.isBossWave)
        {
            announcement("^2Max Ammo for All Players And $2000");
            foreach (player in level.players)
            {
                if (!player.isAlive) continue;
                player.cash += 2000;
                player thread user_scripts\mp\aizombies\_aiz_hud::scorePopup(2000);
                player thread user_scripts\mp\aizombies\_aiz_hud::textWithIcon2("^3Max Ammo!", "^2$2000", "waypoint_ammo_friendly");
                player thread user_scripts\mp\aizombies\_aiz_hud::textPopup(level.gameStrings[207]);
                if (level.isHellMap) player thread maps\mp\gametypes\_hud_message::splashNotify("execution", 2000);
                player z_giveMaxAmmo();
            }
        }
        else if (level.isCrawlerWave)
        {
            announcement("^2Max Ammo for All Players And $500");
            foreach (player in level.players)
            {
                if (!player.isAlive) continue;
                player.cash += 500;
                player thread user_scripts\mp\aizombies\_aiz_hud::scorePopup(500);
                player thread user_scripts\mp\aizombies\_aiz_hud::textWithIcon2("^3Max Ammo!", "^2$500", "waypoint_ammo_friendly");
                player thread user_scripts\mp\aizombies\_aiz_hud::textPopup(level.gameStrings[207]);
                if (level.isHellMap) player thread maps\mp\gametypes\_hud_message::splashNotify("comeback", 500);
                player z_giveMaxAmmo();
            }
        }
        else
        {
            announcement("^2Bonus Cash $100");
            foreach (player in level.players)
            {
                if (!player.isAlive) continue;
                player.cash += 100;
                player thread user_scripts\mp\aizombies\_aiz_hud::scorePopup(100);
                player thread maps\mp\gametypes\_hud_message::splashNotify("revenge", 100);
            }
        }

        wait(2.5);

        user_scripts\mp\aizombies\_aiz_hud::roundEndHud();

        if (level.isCrawlerWave || level.isBossWave || level.isHellMap) user_scripts\mp\aizombies\_aiz_killstreaks::bonusAirdropFlyBy();
    }

    level.roundHud.label = level.gameStrings[22];
    level.roundHud setValue(level.wave + 1);
    level.roundHud.color = (0.3, 0.9, 0.3);
    level.zombieCounterHud.color = (0.3, 0.9, 0.3);
    intermission = self user_scripts\mp\aizombies\_aiz_hud::createIntermissionTimer();
    intermission.timerNum setValue(level.intermissionTimerNum);

    intermission thread runIntermissionTimer();
}

runIntermissionTimer()
{
    timerNum = self.timerNum;

    while (true)
    {
        wait(0.9);

        timerNum changeFontScaleOverTime(0.1);
        timerNum.fontScale = 1.2;

        wait(0.1);

        if (level.gameEnded) return false;
        level.intermissionTimerNum--;
        timerNum setValue(level.intermissionTimerNum);
        timerNum changeFontScaleOverTime(0.1);
        timerNum.fontScale = 1;

        if (level.intermissionTimerNum == 1)
        {
            timerNum fadeOverTime(1);
            timerNum.alpha = 0;

            wait(1);

            self fadeOverTime(1);
            self.alpha = 0;

            wait(1);

            level.intermissionHud = undefined;
            timerNum destroy();
            self destroy();

            level.intermissionTimerNum = 20;
            user_scripts\mp\aizombies\_aiz_round_system::startNextRound();
            level.zState = "ingame";
            break;
        }
    }
}

runInfiniteAmmoTimer()
{
    level endon ("game_ended");
    level endon ("infiniteammo_ended");

    while (true)
    {
        level.infiniteAmmoTime--;
        if (level.infiniteAmmoTime == 0)
        {
            level.infiniteAmmoTimerStarted = false;
            thread user_scripts\mp\aizombies\_aiz_hud::powerupText(level.gameStrings[205], 0.85, (25.5, 25.5, 25.5),(0.9, 0.3, 0.3), 0.6);
            thread user_scripts\mp\aizombies\_aiz_hud::powerupIcon("dpad_killstreak_sentry_minigun");
            level notify("infiniteammo_ended");
        }

        wait(1);
    }
}

startInfiniteAmmo()
{
    if (level.infiniteAmmoTime < 1) return;
    if (level.infiniteAmmoTimerStarted) return;
    level.infiniteAmmoTimerStarted = true;
    level thread runInfiniteAmmoTimer();
}
runAdrenalineTimer()
{
    level endon ("game_ended");
    level endon ("adrenaline_ended");

    while (true)
    {
        level.adrenalineTime--;
        if (level.adrenalineTime == 0)
        {
            level.adrenalineTimerStarted = false;
            thread user_scripts\mp\aizombies\_aiz_hud::powerupText(level.gameStrings[206], 0.85, (25.5, 25.5, 25.5),(0.9, 0.3, 0.3), 0.6);
            thread user_scripts\mp\aizombies\_aiz_hud::powerupIcon("em_st_042");
            level notify("adrenaline_ended");
        }

        wait(1);
    }
}

startAdrenaline()
{
    if (level.adrenalineTime < 1) return;
    if (level.adrenalineTimerStarted) return;
    level.adrenalineTimerStarted = true;
    level thread runAdrenalineTimer();
}

setStartingPistol()
{
    weapon = "h2_m9_mp";//Default

    if (level.spawnType == 1)
    {
        random = randomInt(4);
        if (level.newWeapons)
            random = randomInt(5);
			
        if (random == 1) weapon = "h2_usp_mp";
        else if (random == 2) weapon = "h2_deserteagle_mp";
        else if (random == 3) weapon = "h2_coltanaconda_mp";
        else if (random == 4) weapon = "h1_coltanaconda_mp";
        //else(0) keep the original set var
    }

    self giveWeapon(weapon);
    self setSpawnWeapon(weapon);
    self giveMaxAmmo(weapon);
    while (!self loadWeapons(weapon))
        waitframe();
    self updatePlayerWeaponsList(weapon);
    self switchToWeapon(weapon);
    self user_scripts\mp\aizombies\_aiz_hud::updateAmmoHud(true, weapon);
}

setSpawnModel()
{
    if (!isPlayer(self) || !self.isAlive)
        return;

    randomModel = randomInt(level.bodyModels.size);
    self setModel(level.bodyModels[randomModel]);
    waitframe();

    self setViewModel("viewhands_rangers");
    randomHead = randomInt(level.headModels.size);
    self attach(level.headModels[randomHead], "", true);
	self.headModel = level.headModels[randomHead];
    //self showPart("j_spine4");
    //self show();
}

doIntro()
{   
    if (level.introType == 0)
    {
        intros = [];
        currentIntroStringIndex = 78;
        for (i = 0; i < 5; i++)
        {
            if (i == 4 && isMW2CRMap())
            {
                if (level._mapname == "contingency" || level._mapname == "estate" || level._mapname == "oilrig")//Momo maps
                    currentIntroStringIndex++;
                else//Slvr maps
                    currentIntroStringIndex += 2;
            }

            intro = newClientHudElem(self);//self createFontString("objective", 10);
            intro.elemType = "font";
            intro.parent = level.uiParent;
            intro.children = [];
            intro.font = "objective";
            intro.fontScale = 10;
            intro.hideWhenInMenu = true;
            intro.archived = false;
            intro.sort = 1;
            intro maps\mp\gametypes\_hud_util::setPoint("TOP", "TOP", 0, 60 + (i * 16));
            intro.alpha = 0;
            intro.color = (1, 1, 1);
            if (i == 0)
                intro.glowColor = (0.3, 0.9, 0.3);
            else if (i == 1)
                intro.glowColor = (0.9, 0.3, 0.3);
            else if (i == 2)
                intro.glowColor = (1, 0.5, 0.3);
            else if (i == 3)
                intro.glowColor = (0.3, 0.9, 0.3);
            else if (i == 4)
                intro.glowColor = (0.5, 0.9, 0.9);
            intro.glowAlpha = 0.3;
            intro.label = level.gameStrings[currentIntroStringIndex];

            if (currentIntroStringIndex == 78)
                intro setPlayerNameString(self);
            else if (currentIntroStringIndex == 79)
                intro setText(level.version);
            else if (currentIntroStringIndex == 80)
                intro setText(getZombieMapname());

            intro changeFontScaleOverTime(0.25);
            intro fadeOverTime(0.25);
            intro.fontScale = 1.5;
            intro.alpha = 1;

            intros[intros.size] = intro;

            wait(0.5);

            currentIntroStringIndex++;
        }

        wait(6);

        foreach (intro in intros)
        {
            intro changeFontScaleOverTime(0.25);
            intro fadeOverTime(0.25);
            intro.alpha = 0;
            intro.fontScale = 10;
        }

        wait(1);

        foreach (intro in intros)
        {
            intro destroy();
        }
    }
    else if (level.introType == 1)
    {
        wait(5);

        introText1 = newClientHudElem(self);
        introText1.horzAlign = "center";
        introText1.vertAlign = "middle";
        introText1.alignX = "center";
        introText1.alignY = "middle";
        introText1.x = 600;
        introText1.y = -180;
        introText1.font = "objective";
        introText1.fontscale = 3;
        introText1.glowColor = (0, 0, 1);
        introText1.label = level.gameStrings[85];
        introText1.alpha = 1;
        introText1.glowAlpha = 0.25;
        introText1 moveOverTime(0.5);
        introText1.x = 0;
        introText1.y = -180;

        introText2 = newClientHudElem(self);
        introText2.horzAlign = "center";
        introText2.vertAlign = "middle";
        introText2.alignX = "center";
        introText2.alignY = "middle";
        introText2.x = 600;
        introText2.y = -140;
        introText2.font = "objective";
        introText2.fontscale = 3;
        introText2.glowColor = (0, 0, 1);
        introText2 setText(self.name);
        introText2.alpha = 1;
        introText2.glowAlpha = 0.25;
        introText2 moveOverTime(0.5);
        introText2.x = 100;
        introText2.y = -140;

        wait(0.5);

        introText1 moveOverTime(3);
        introText1.x = -200;
        introText1.y = -180;

        introText2 moveOverTime(3);
        introText2.x = -100;
        introText2.y = -140;
        self playLocalSound("mp_last_stand");

        wait(3);

        introText1 moveOverTime(0.5);
        introText1.x = -600;
        introText1.y = -180;

        introText2 moveOverTime(0.5);
        introText2.x = -600;
        introText2.y = -140;

        wait(0.5);

        introText1.x = 600;
        introText1.y = -180;
        introText1.label = level.gameStrings[86];
        
        introText2.x = 600;
        introText2.y = -140;
        introText2 setText(&"NULL_EMPTY");
        introText2.label = level.gameStrings[87];

        introText1 moveOverTime(0.5);
        introText1.x = 0;
        introText1.y = -180;

        introText2 moveOverTime(0.5);
        introText2.x = 100;
        introText2.y = -140;

        wait(0.5);

        introText1 moveOverTime(3);
        introText1.x = -200;
        introText1.y = -180;

        introText2 moveOverTime(3);
        introText2.x = -100;
        introText2.y = -140;
        self playLocalSound("mp_last_stand");

        wait(3);

        introText1 moveOverTime(0.5);
        introText1.x = -600;
        introText1.y = -180;

        introText2 moveOverTime(0.5);
        introText2.x = -600;
        introText2.y = -140;

        wait(0.5);

        introText1.x = 0;
        introText1.y = -700;
        introText1.font = "hudbig";
        introText1.fontScale = 2;
        introText1.color = (2, 1, 0);
        introText1.glowColor = (1, 0, 0);
        introText1.label = level.gameStrings[80];
        
        introText2.x = 0;
        introText2.y = 770;
        introText2.font = "hudbig";
        introText2.fontScale = 2;
        introText2.color = (1, 0, 0);
        introText2.glowColor = (1, 0, 0);
        introText2 setText(getZombieMapname());
        introText2.label = &"NULL_EMPTY";

        introText1 moveOverTime(0.5);
        introText1.x = 0;
        introText1.y = 0;

        introText2 moveOverTime(0.5);
        introText2.x = 0;
        introText2.y = 70;

        wait(0.5);

        self playLocalSound("mp_last_stand");

        wait(3);

        introText1 moveOverTime(0.5);
        introText1.x = -700;
        introText1.y = 0;

        introText2 moveOverTime(0.5);
        introText2.x = 700;
        introText2.y = 70;

        wait(0.6);

        introText1.x = 600;
        introText1.y = -180;
        introText1.font = "objective";
        introText1.fontscale = 3;
        introText1.color = (1, 1, 1);
        introText1.glowColor = (0, 0, 1);
        introText1.label = level.gameStrings[88];
        
        introText2.x = 600;
        introText2.y = -140;
        introText2.font = "objective";
        introText2.fontscale = 3;
        introText2.color = (1, 1, 1);
        introText2.glowColor = (0, 0, 1);
        introText2 setText(&"NULL_EMPTY");
        introText2.label = level.gameStrings[89];

        introText1 moveOverTime(0.5);
        introText1.x = 0;
        introText1.y = -180;

        introText2 moveOverTime(0.5);
        introText2.x = 100;
        introText2.y = -140;

        wait(0.5);

        introText1 moveOverTime(3);
        introText1.x = -200;
        introText1.y = -180;

        introText2 moveOverTime(3);
        introText2.x = -100;
        introText2.y = -140;
        self playLocalSound("mp_last_stand");

        wait(3);

        introText1 moveOverTime(0.5);
        introText1.x = -600;
        introText1.y = -180;

        introText2 moveOverTime(0.5);
        introText2.x = -600;
        introText2.y = -140;

        wait(0.5);

        introText1 destroy();
        introText2 destroy();
    }
}

watchPlayerDamage()
{
    level endon("game_ended");
    self endon("disconnect");
    self endon("death");

    while (true)
    {
        self waittill("damage");

        time = getTime();
        self.lastDamageTime = time;

        self thread onPlayerDamage(time);
    }
}
onPlayerDamage(time)
{
    level endon("game_ended");
    self endon("disconnect");
    self endon("death");
    self endon("damage");

    wait(7);

    if (self.lastDamageTime == time && self.sessionState == "playing")
        self.health = self.maxHealth;
}
modifyPlayerDamage(victim, attacker, damage, mod, weapon, point, dir, hitLoc, offsetTime)
{
    if (victim.notTargetable)
        return false;

    if (mod == "MOD_FALLING" || mod == "MOD_TRIGGER_HURT")
        return damage;

    if (!isDefined(weapon))
        return false;

    if (weapon == "sentry_minigun_mp" || weapon == level.botWeapon_subBot || weapon == level.botWeapon_LMGBot || weapon == "" || weapon == "none" || weapon == "ac130_25mm_mp" || weapon == "ac130_40mm_mp" || weapon == "ac130_105mm_mp"|| weapon == "at4_mp"|| weapon == "javelin_mp")
        return false;

    return damage;
}

onNormalDeath(victim, attacker, lifeId)
{
    victim onPlayerKilled();
}

onPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc, psOffsetTime, deathAnimDuration, lifeId)
{
    if (self hasRayGun())
        level.currentRayguns--;

    self takeAllWeapons();

    if (level.gameEnded) return;

    self thread onPlayerDeath();
}

onPlayerLastStand(inflictor, attacker, damage, mod, weapon, dir, hitLoc, timeOffset, deathAnimDuration)
{
    if (mod == "MOD_CRUSH" || (mod == "MOD_TRIGGER_HURT" && damage >= self.maxhealth))
    {
        self suicide();
        return;
    }

    if (self.isDown) return;
    self.isDown = true;
    self playSound("freefall_death");

    self disableOffhandWeapons();
    self disableWeaponSwitch();
    self freezeControls(false);
    self.deaths++;

    if (self.autoRevive)
    {
        pulse = self user_scripts\mp\aizombies\_aiz_hud::createReviveOverlayIcon();
        overlay = self user_scripts\mp\aizombies\_aiz_hud::createReviveOverlay();
        overlay fadeOverTime(20);
        overlay.alpha = 0;

        self.hud_perks[6] scaleOverTime(20, 0, 0);
        self thread autoRevive_pulseIcon(pulse);

        self thread autoRevive_revivePlayer(overlay);
        return;
    }

    if (!isDefined(self.allPerks))
    {
        for (i = 0; i < 7; i++)
        {
            if (self.perksBought[i])
            {
                if (i == 0)
                {
                    self.maxhealth = level.maxPlayerHealth;
                    self.health = level.maxPlayerHealth;
                }
                else if (i == 1)
                {
                    self _unSetPerk("specialty_lightweight");
                    //self _unSetPerk("specialty_marathon");
                    self _unSetPerk("specialty_longersprint");
                }
                else if (i == 2)
                {
                    self _unSetPerk("specialty_fastreload");
                    //self _unSetPerk("specialty_quickswap");
                    self _unSetPerk("specialty_quickdraw");
                }
                else if (i == 3)
                    self.ammoMatic = false;
                else if (i == 4)
                    self _unSetPerk("specialty_bulletdamage");
                else if (i == 5)
                    self _unSetPerk("specialty_bulletaccuracy");
                else if (i == 7)
                    self.hasDoublePoints = false;
                self.perksBought[i] = false;
            }
        }
        self.totalPerkCount = 0;
        self user_scripts\mp\aizombies\_aiz_hud::updatePerksHud(true);
    }

    reviveIcon = self user_scripts\mp\aizombies\_aiz_hud::createReviveHeadIcon();
    reviveIcon.color = (1, 1, 1);

    iPrintLn(level.gameStrings[23], self.name);

    //reviver = spawn("script_model", self.origin);
    //reviver setModel("tag_origin");
    reviver = spawn("script_origin", self.origin);
    reviver linkTo(self);
    reviver.usableType = "revive";
    reviver.range = 60;
    reviver.player = self;
    reviver.icon = reviveIcon;
    reviver.user = undefined;
    //reviver.isBeingUsed = false;
    //self.headIcon = "waypoint_revive";
    //self.headIconTeam = "allies";
    reviver user_scripts\mp\aizombies\_aiz_map_edits::addUsable("revive", 50);

    if (!self hasWeapon("h2_usp_mp"))
        self giveWeapon("h2_usp_mp");
    self giveMaxAmmo("h2_usp_mp");
    self switchToWeaponImmediate("h2_usp_mp");

    //red = 1;
    self.deathCount = 0;
    self thread startDeathCountdown(reviveIcon, reviver);
}
startDeathCountdown(reviveIcon, reviver)
{
    while (true)
    {
        wait(1);

        if (level.gameEnded || !isDefined(self))
        {
            reviveIcon destroy();
            reviver delete();
            return;
        }

        if (isDefined(reviver.user)) continue;

        if (!self.isDown)
        {
            break;
        }

        if (isPlayer(self)) self pingPlayer();
        self.deathCount++;

        if (self.deathCount == 15 && self.isDown) self visionSetNakedForPlayer("cheat_bw", 15);

        if (self.deathCount > 15)//Tint icon red
        {
            if (reviveIcon.color[1] >= 0.05)
                reviveIcon.color -= (0, 0.05, 0.05);
        }

        if (self.deathCount == 30)
        {
            self suicide();
            //Take score from other players
            foreach (player in level.players)
            {
                if (isDefined(player.isDown) && player.isAlive)
                {
                    if (player.isDown) continue;//Don't punish downed players
                    if (player.sessionState != "playing") continue;//Or spectators

                    amount = int(player.cash / 15);//Take a percent away
                    amount -= amount % 10;//Remove the difference
                    player.cash -= amount;
                    if (player.cash < 0) player.cash = 0;
                    player thread user_scripts\mp\aizombies\_aiz_hud::scorePopup(-amount);
                    player thread user_scripts\mp\aizombies\_aiz_hud::textPopup(level.gameStrings[24], self);
                }
                else continue;
            }
        }

        if (!self.isAlive)//Check for death after suicide
        {
            reviver user_scripts\mp\aizombies\_aiz_map_edits::removeUsable();
            reviveIcon destroy();
            break;
        }

        if (!self.isDown)
            break;
    }
}

onPlayerDeath()
{
    self.isAlive = false;

    //wait(0.2);

    if (isDefined(self.bot) && self.bot.state != "dead") self thread user_scripts\mp\aizombies\_aiz_killstreaks::killPlayerBot();
    if (!level.isHellMap || (level.isHellMap && level.visionRestored)) self visionSetNakedForPlayer(level.vision);

    self.autoRevive = false;
    self user_scripts\mp\aizombies\_aiz_hud::updatePerksHud(true);
    if (isDefined(self.aizHud_created))
    {
        ksList = self.hud_killstreakSlot;
        ksList.alpha = 0;
        //ksList setText("");
        //message = self.hud_message;
        //message setText("");
        self clearLowerMessage("usable_message");
    }

    updatePlayerCountForScoreboard();

    self clearPlayerWeaponsList();

    self.isDown = true;//Just in case it doesn't get set prior to this stage

    iPrintLn(level.gameStrings[26], self.name);

    //self thread playerDeathVisual(10);

    self updateSessionState("dead");
    self.statusIcon = "hud_status_dead";

    //self playSound("generic_death_friendly_" + randomIntRange(1, 9));

    self setPlayerAsSpectator();

    wait(0.5);

    self thread user_scripts\mp\aizombies\_aiz_hud::textPopup(level.gameStrings[25]);

    wait(0.5);

    self checkForPlayerRespawn();
}
setPlayerAsSpectator()
{
    wait(0.5);
    self detach(self.headModel, "");
    self updateSessionState("spectator");
    self allowSpectateTeam("allies", true);
    self allowSpectateTeam("axis", true);
    self allowSpectateTeam("freelook", true);
    self allowSpectateTeam("none", true);
    if (!level.gameEnded) self thread user_scripts\mp\aizombies\_aiz_hud::textPopup(level.gameStrings[18]);
    //self notify("menuresponse", "team_marinesopfor", "spectator");
    //wait(0.1);
    //self closeMenu("changeclass");
}
checkForPlayerRespawn()
{
    if (level.zState == "intermission")
        self spawnPlayer();
    else level thread user_scripts\mp\aizombies\_aiz_round_system::checkForEndGame();
}
playerDeathVisual(deathAnimDuration)
{
    self.body = self clonePlayer( deathAnimDuration );
    self.body startRagdoll();
    wait(deathAnimDuration);
    self.body delete();
    self.body = undefined;
}

autoRevive_revivePlayer(overlay)
{
    level endon("game_ended");
    self endon("death");
    self endon("disconnect");

    if (isDefined(overlay)) wait(20);

    if (isDefined(overlay)) overlay destroy();
    if (!self.isAlive) return;
    self lastStandRevive();
    self.isDown = false;
    self.autoRevive = false;
    self enableWeaponSwitch();
    self enableOffhandWeapons();
    weaponList = self.weaponsList;
    if (!array_contains(weaponList, "h2_usp_mp"))
    {
        self takeWeapon("h2_usp_mp");
        self switchToWeapon(self.lastDroppableWeapon);
    }
    if (self.perksBought[0])
        self.health = level.maxPlayerHealth_Jugg;
    else self.health = level.maxPlayerHealth;
    //self user_scripts\mp\aizombies\_aiz_hud::updatePerksHud(false);
    self.perkHudsDone[6] = false;
    if (isDefined(self.hud_perk7))
    {
        self.hud_perk7.alpha = 0;
        self.hud_perk7 scaleOverTime(0.5, 40, 40);
    }
    self.totalPerkCount--;
    if (weaponList.size != 0) self switchToWeapon(weaponList[0]);
    self visionSetNakedForPlayer(level.vision);
}
autoRevive_pulseIcon(pulse)
{
    level endon("game_ended");

    while (true)
    {
        pulse.alpha = 0.9;
        pulse scaleOverTime(0.6, 100, 100);
        pulse fadeOverTime(0.6);
        pulse.alpha = 0;

        if (!self.isDown || !self.isAlive)
        {
            pulse destroy();
            break;
        }

        wait(0.65);

        pulse setShader("em_st_221", 30, 30);

        wait(0.85);
    }
}

loadConfig()
{
    //setDvarIfUninitialized("aiz_language", "english");
    setDvarIfUninitialized("aiz_spawnType", 1);
    setDvarIfUninitialized("aiz_maxHealth", 100);
    setDvarIfUninitialized("aiz_maxHealth_jugg", 250);
    setDvarIfUninitialized("aiz_botStartingHealth", 90);
    setDvarIfUninitialized("aiz_crawlerHealth", 100);
    setDvarIfUninitialized("aiz_bossHealth", 5000);
    setDvarIfUninitialized("aiz_botHealthFactor", 15);
    setDvarIfUninitialized("aiz_botDamage", 50);
    setDvarIfUninitialized("aiz_campaignMaps", 0);
    setDvarIfUninitialized("aiz_perkLimit", 0);
    setDvarIfUninitialized("aiz_maxZombies", 25);
    setDvarIfUninitialized("aiz_maxZombiesUnderLoad", 25);
    setDvarIfUninitialized("aiz_showRadar", 0);
    setDvarIfUninitialized("aiz_botDamageDelay", 0);
    setDvarIfUninitialized("aiz_botMaxSpeed", 170);
    setDvarIfUninitialized("aiz_killstreaksGivePoints", 0);
    setDvarIfUninitialized("aiz_enableMustangAndSally", 1);
    setDvarIfUninitialized("aiz_newWeapons", 0);
    setDvarIfUninitialized("aiz_introType", 0);
    setDvarIfUninitialized("aiz_upgradedRPGBurstCount", 3);
    setDvarIfUninitialized("aiz_ammoPriceIncrease", 1);
    setDvarIfUninitialized("aiz_oldHurtAnimLoop", 0);
    setDvarIfUninitialized("aiz_zombieModels", 0);
    setDvarIfUninitialized("aiz_showPerkDescriptions", 0);

    setGameDvars();
}

setGameDvars()
{
    level.spawnType = getDvarInt("aiz_spawnType");
    level.maxPlayerHealth = getDvarInt("aiz_maxHealth");
    level.maxPlayerHealth_Jugg = getDvarInt("aiz_maxHealth_jugg");
    level.botHealth = getDvarInt("aiz_botStartingHealth");
    level.crawlerHealth = getDvarInt("aiz_crawlerHealth");
    level.bossHealth = getDvarInt("aiz_bossHealth");
    level.botHealthScalar = getDvarInt("aiz_botHealthFactor");
    level.botDmg = getDvarInt("aiz_botDamage");
    level.crMapsEnabled = getDvarInt("aiz_campaignMaps");
    level.perkLimit = getDvarInt("aiz_perkLimit");
    level.maxActiveBots = getDvarInt("aiz_maxZombies");
    level.showRadar = getDvarInt("aiz_showRadar");
    level.botDamageDelay = getDvarInt("aiz_botDamageDelay");
    level.botMaxMoveSpeed = getDvarFloat("aiz_botMaxSpeed");
    level.killstreaksGivePoints = getDvarInt("aiz_killstreaksGivePoints");
    level.allowUpgradedM9 = getDvarInt("aiz_enableMustangAndSally");
    level.newWeapons = getDvarInt("aiz_newWeapons");
    level.introType = getDvarInt("aiz_introType");
    if (level.introType == 2)
        level.introType = randomInt(2);

    if (getDvarInt("aiz_upgradedRPGBurstCount") > 10)
        setDvar("aiz_upgradedRPGBurstCount", 10);
    else if (getDvarInt("aiz_upgradedRPGBurstCount") < 0)
        setDvar("aiz_upgradedRPGBurstCount", 0);
        
    level.rpgBurst = getDvarInt("aiz_upgradedRPGBurstCount");
    level.ammoIncrease = getDvarInt("aiz_ammoPriceIncrease");
    level.legacyHurtAnims = getDvarInt("aiz_oldHurtAnimLoop");
    level.useZombieModels = getDvarInt("aiz_zombieModels");
    level.perkDescriptions = getDvarInt("aiz_showPerkDescriptions");
}

clipSpaces(input)
{
    newStr = "";
    tokenizedStr = strTok(input, " ");
    foreach (str in tokenizedStr)
    {
        newStr += str;
    }

    return newStr;
}

getPlayerWithMostKills()
{
    score = 0;
    currentPlayer = undefined;
    foreach (player in level.players)
    {
        if (isPlayer(player) && player.score > score)
        {
            score = player.score;
            currentPlayer = player;
        }
    }
    if (isDefined(currentPlayer)) return currentPlayer;
    else
        return getEnt("mp_global_intermission", "classname");
}
getRandomSpawnpoint()
{
    spawns = getEntArray("mp_tdm_spawn", "classname");
    return spawns[randomInt(spawns.size)];
}
getAllEntitiesWithName(targetname)
{
    ents = getEntArray(targetname, "targetname");
    return ents;
}
getZombieMapname()
{
    //The default names are now the actual mapnames, and all AIZ maps use level.zombieMapname now to save on string resources.
    //Pass through a custom name first before setting defaults
    if (isDefined(level.zombieMapname)) return level.zombieMapname;
    //If there's no custom, set defaults
    else
    {
        if (level._mapname == "mp_abandon") return level.gameStrings[110];
        else if (level._mapname == "mp_afghan") return level.gameStrings[111];
        else if (level._mapname == "mp_boneyard") return level.gameStrings[112];
        else if (level._mapname == "mp_brecourt") return level.gameStrings[113];
        else if (level._mapname == "mp_checkpoint") return level.gameStrings[114];
        else if (level._mapname == "mp_compact") return level.gameStrings[115];
        else if (level._mapname == "mp_complex") return level.gameStrings[116];
        else if (level._mapname == "mp_derail") return level.gameStrings[117];
        else if (level._mapname == "mp_estate") return level.gameStrings[118];
        else if (level._mapname == "mp_favela") return level.gameStrings[119];
        else if (level._mapname == "mp_fuel2") return level.gameStrings[120];
        else if (level._mapname == "mp_highrise") return level.gameStrings[121];
        else if (level._mapname == "mp_invasion") return level.gameStrings[122];
        else if (level._mapname == "mp_nightshift") return level.gameStrings[123];
        else if (level._mapname == "mp_quarry") return level.gameStrings[124];
        else if (level._mapname == "mp_rundown") return level.gameStrings[125];
        else if (level._mapname == "mp_rust") return level.gameStrings[126];
        else if (level._mapname == "mp_storm") return level.gameStrings[127];
        else if (level._mapname == "mp_subbase") return level.gameStrings[128];
        else if (level._mapname == "mp_terminal") return level.gameStrings[129];
        else if (level._mapname == "mp_trailerpark") return level.gameStrings[130];
        else if (level._mapname == "mp_underpass") return level.gameStrings[131];
        else return level.gameStrings[72];
    }
}

getMapname()
{
    return getDvar("mapname");
}

weaponIsAkimbo(weapon)
{
    if (isSubStr(weapon, "_akimbo")) return true;
    return false;
}
weaponIsClassic(weapon)
{
    if (weapon == "h1_coltanaconda_mp") return true;
    if (weapon == "h1_coltanaconda_mp_akimbo") return true;
    if (weapon == "h1_fal_mp") return true;
    if (weapon == "h1_galil_mp") return true;
    if (weapon == "h1_m240_mp") return true;
    if (weapon == "h1_mac10_mp") return true;
    if (weapon == "h1_pp2000_mp") return true;
    if (weapon == "h1_striker_mp") return true;
    if (weapon == "h1_vssvintorez_mp") return true;
    return false;
}
getClassicWeaponHideTags(weapon)
{
    if (!weaponIsClassic(weapon)) return undefined;

    if (weapon == "h1_fal_mp") return ["tag_acog_2", "tag_eotech", "tag_heartbeat", "tag_m203", "tag_red_dot", "tag_shotgun", "tag_silencer", "tag_thermal_scope"];
    if (weapon == "h1_m240_mp") return ["tag_acog_2", "tag_eotech", "tag_heartbeat", "tag_red_dot", "tag_foregrip", "tag_silencer", "tag_thermal_scope"];
    if (weapon == "h1_mac10_mp") return ["tag_acog", "tag_holo", "tag_reflex", "tag_sight_off", "tag_silencer"];
    if (weapon == "h1_pp2000_mp") return ["tag_eotech", "tag_red_dot", "tag_silencer", "tag_thermal_scope"];
    if (weapon == "h1_striker_mp") return ["tag_eotech", "tag_red_dot", "tag_silencer"];
    if (weapon == "h1_vssvintorez_mp") return ["tag_acog_2"];
    return undefined;
}
weaponIsUpgrade(weapon)
{
    weapon = trimWeaponScope(weapon);
    if (weapon == "h2_ump45_mp_holo_xmag_camo008") return true;
    else if (weapon == "h2_usp_mp_akimbo_xmag_camo008") return true;
    else if (weapon == "h2_m9_mp_akimbo_xmag_camo008") return true;
    else if (weapon == "h2_wa2000_mp_acog_xmag_camo008") return true;
    else if (weapon == "h2_m16_mp_fastfire_holo_xmag_camo008") return true;
    else if (weapon == "h2_famas_mp_acog_fmj_camo008") return true;
    else if (weapon == "h2_beretta393_mp_akimbo_xmag_camo008") return true;
    else if (weapon == "h2_ak47_mp_fmj_xmag_camo008") return true;
    else if (weapon == "h2_aa12_mp_foregrip_xmag_camo008") return true;
    else if (weapon == "h2_striker_mp_xmag_camo008") return true;
    else if (weapon == "h2_cheytac_mp_fmj_camo008") return true;
    else if (weapon == "h2_glock_mp_akimbo_xmag_camo008") return true;
    else if (weapon == "h2_rpd_mp_foregrip_holo_camo008") return true;
    else if (weapon == "h2_m240_mp_fmj_xmag_camo008") return true;
    else if (weapon == "h2_coltanaconda_mp_akimbo_fmj_camo008") return true;
    else if (weapon == "h2_m4_mp_holo_masterkeymwr_camo008") return true;
    else if (weapon == "h2_mp5k_mp_fmj_xmag_camo008") return true;
    else if (weapon == "h2_ak47_mp_glak47_thermal_camo008") return true;
    else if (weapon == "h2_barrett_mp_acog_xmag_camo008") return true;
    else if (weapon == "h2_sa80_mp_foregrip_xmag_camo008") return true;
    else if (weapon == "h2_m21_mp_acog_xmag_camo008") return true;
    else if (weapon == "h2_spas12_mp_foregrip_xmag_camo008") return true;
    else if (weapon == "h2_tmp_mp_akimbo_xmag_camo008") return true;
    else if (weapon == "h2_mg4_mp_holo_xmag_camo008") return true;
    else if (weapon == "h2_pp2000_mp_fmj_reflex_camo008") return true;
    else if (weapon == "h2_aug_mp_holo_xmag_camo008") return true;
    else if (weapon == "h2_m240_mp_holo_xmag_camo008") return true;
    else if (weapon == "h2_tavor_mp_fmj_mars_camo008") return true;
    else if (weapon == "h2_kriss_mp_fastfire_reflex_camo008") return true;
    else if (weapon == "h2_scar_mp_holo_xmag_camo008") return true;
    else if (weapon == "h2_ranger_mp_akimbo_fmj") return true;
    else if (weapon == "h2_p90_mp_akimbo_xmag_camo008") return true;
    else if (weapon == "h2_masada_mp_reflex_xmag_camo008") return true;
    else if (weapon == "h2_uzi_mp_acog_silencersmg_camo008") return true;
    else if (weapon == "h2_model1887_mp_akimbo_fmj") return true;
    else if (weapon == "h2_fn2000_mp_f2000scope_camo008") return true;
    else if (weapon == "h2_fal_mp_reflex_xmag_camo008") return true;
    else if (weapon == "h2_m1014_mp_xmag_camo008") return true;
    else if (weapon == "h2_tmp_mp_silencersmg_xmag_camo008") return true;
    else if (weapon == "h2_pp2000_mp_holo_xmag_camo007") return true;
    else if (weapon == "h2_coltanaconda_mp_akimbo_fmj_camo008") return true;
    else if (weapon == "h2_deserteagle_mp_camo009") return true;
    else if (weapon == "h2_m4_mp_acog_silencerar_camo008") return true;
    else if (weapon == "h2_ranger_mp_fmj") return true;
    else if (weapon == "h2_rpg_mp") return true;
    else if (weapon == "stinger_mp") return true;
    else if (weapon == "h1_coltanaconda_mp_akimbo") return true;
    else return false;
}

getWeaponUpgrade(weapon)
{
    if (weapon == "h2_ump45_mp") return "h2_ump45_mp_holo_xmag_camo008";
    else if (weapon == "h2_usp_mp") return "h2_usp_mp_akimbo_xmag_camo008";
    else if (weapon == "h2_m9_mp") return "h2_m9_mp_akimbo_xmag_camo008";
    else if (weapon == "h2_wa2000_mp_acog") return "h2_wa2000_mp_acog_xmag_camo008";
    else if (weapon == "h2_m16_mp_reflex") return "h2_m16_mp_fastfire_holo_xmag_camo008";
    else if (weapon == "h2_famas_mp") return "h2_famas_mp_acog_fastfire_fmj_camo008";
    else if (weapon == "h2_beretta393_mp") return "h2_beretta393_mp_akimbo_xmag_camo008";
    else if (weapon == "h2_ak47_mp") return "h2_ak47_mp_fmj_xmag_camo008";
    else if (weapon == "h2_aa12_mp") return "h2_aa12_mp_foregrip_xmag_camo008";
    else if (weapon == "h2_striker_mp") return "h2_striker_mp_xmag_camo008";
    else if (weapon == "h2_cheytac_mp") return "h2_cheytac_mp_fmj_camo008";
    else if (weapon == "h2_glock_mp") return "h2_glock_mp_akimbo_xmag_camo008";
    else if (weapon == "h2_rpd_mp") return "h2_rpd_mp_foregrip_holo_camo008";
    else if (weapon == "onemanarmy_mp") return "h2_m240_mp_fmj_xmag_camo008";
    else if (weapon == "h2_coltanaconda_mp") return "h2_coltanaconda_mp_akimbo_fmj_camo008";
    else if (weapon == "h2_m4_mp_reflex") return "h2_m4_mp_holo_masterkeymwr_camo008";
    else if (weapon == "h2_mp5k_mp") return "h2_mp5k_mp_fmj_xmag_camo008";
    else if (weapon == "at4_mp") return "h2_ak47_mp_glak47_thermal_camo008";
    else if (weapon == "h2_barrett_mp") return "h2_barrett_mp_acog_xmag_camo008";
    else if (weapon == "h2_sa80_mp") return "h2_sa80_mp_foregrip_xmag_camo008";
    else if (weapon == "h2_m21_mp_acog") return "h2_m21_mp_acog_xmag_camo008";
    else if (weapon == "h2_spas12_mp") return "h2_spas12_mp_foregrip_xmag_camo008";
    else if (weapon == "h2_tmp_mp") return "h2_tmp_mp_akimbo_xmag_camo008";
    else if (weapon == "h2_mg4_mp") return "h2_mg4_mp_holo_xmag_camo008";
    else if (weapon == "h2_pp2000_mp") return "h2_pp2000_mp_fmj_reflex_camo008";
    else if (weapon == "h2_aug_mp") return "h2_aug_mp_holo_xmag_camo008";
    else if (weapon == "h2_m240_mp_foregrip") return "h2_m240_mp_holo_xmag_camo008";
    else if (weapon == "h2_tavor_mp") return "h2_tavor_mp_fmj_mars_camo008";
    else if (weapon == "h2_kriss_mp") return "h2_kriss_mp_fastfire_reflex_camo008";
    else if (weapon == "h2_scar_mp") return "h2_scar_mp_holo_xmag_camo008";
    else if (weapon == "h2_ranger_mp") return "h2_ranger_mp_akimbo_fmj";
    else if (weapon == "h2_p90_mp") return "h2_p90_mp_akimbo_xmag_camo008";
    else if (weapon == "h2_masada_mp") return "h2_masada_mp_reflex_xmag_camo008";
    else if (weapon == "h2_uzi_mp") return "h2_uzi_mp_acog_silencersmg_camo008";
    else if (weapon == "h2_model1887_mp") return "h2_model1887_mp_akimbo_fmj";
    else if (weapon == "h2_fn2000_mp") return "h2_fn2000_mp_f2000scope_camo008";
    else if (weapon == "h2_fal_mp") return "h2_fal_mp_reflex_xmag_camo008";
    else if (weapon == "h2_m1014_mp") return "h2_m1014_mp_xmag_camo008";
    else if (weapon == "h2_tmp_mp_silencersmg_camo008") return "h2_tmp_mp_silencersmg_xmag_camo008";
    else if (weapon == "h2_pp2000_mp_holo_camo007") return "h2_pp2000_mp_holo_xmag_camo007";
    else if (weapon == "h2_coltanaconda_mp") return "h2_coltanaconda_mp_akimbo_fmj_camo008";
    else if (weapon == "h2_deserteagle_mp") return "h2_deserteagle_mp_camo009";
    else if (weapon == "h2_m4_mp_silencerar") return "h2_m4_mp_acog_silencerar_camo008";
    else if (weapon == "h2_model1887_mp_fmj") return "h2_ranger_mp_fmj";
    else if (weapon == "javelin_mp") return "stinger_mp";
    else if (weapon == "h2_rpg_mp") return "h2_rpg_mp";
    else if (weapon == "h1_coltanaconda_mp") return "h1_coltanaconda_mp_akimbo";
    else return "";
}

getWeaponAmmoMaticValue(weapon)
{
	value = 0;
    if (cointoss())
        return value;

	switch(weapon)
	{
		case "h2_m9_mp":
		    value = 4;
		break;
		case "h2_usp_mp":
		    value = 4;
		break;
		case "h2_deserteagle_mp":
		    value = 2;
		break;
		case "h2_coltanaconda_mp":
		    value = 2;
		break;
		case "h2_glock_mp":
		    value = 4;
		break;
		case "h2_beretta393_mp":
		    value = 4;
		break;
		case "h2_mp5k_mp":
		    value = 3;
		break;
		case "h2_pp2000_mp":
		    value = 2;
		break;
		case "h2_pp2000_mp_holo_camo007":
		    value = 1;
		break;
		case "h2_uzi_mp":
		    value = 2;
		break;
		case "h2_p90_mp":
		    value = 3;
		break;
		case "h2_kriss_mp":
		    value = 3;
		break;
		case "h2_ump45_mp":
		    value = 2;
		break;
		case "h2_tmp_mp":
		    value = 3;
		break;
		case "h2_ak47_mp":
		    value = 2;
		break;
		case "h2_m16_mp_reflex":
		    value = 2;
		break;
		case "h2_m4_mp_reflex":
		    value = 3;
		break;
		case "h2_fn2000_mp":
		    value = 3;
		break;
		case "h2_masada_mp":
		    value = 3;
		break;
		case "h2_famas_mp":
		    value = 2;
		break;
		case "h2_fal_mp":
		    value = 1;
		break;
		case "h2_scar_mp":
		    value = 2;
		break;
		case "h2_tavor_mp":
		    value = 3;
		break;
		case "h2_m79_mp":
		    value = 1;
		break;
		case "h2_rpg_mp":
		    value = 1;
		break;
		case "at4_mp":
		    value = 1;
		break;
		case "h2_barrett_mp":
		    value = 1;
		break;
		case "h2_wa2000_mp_acog":
		    value = 1;
		break;
		case "h2_m21_mp_acog":
		    value = 1;
		break;
		case "h2_cheytac_mp":
		    value = 1;
		break;
		case "h2_ranger_mp":
		    value = 1;
		break;
		case "h2_model1887_mp":
		    value = 1;
		break;
		case "h2_model1887_mp_fmj":
		    value = 1;
		break;
		case "h2_striker_mp":
		    value = 1;
		break;
		case "h2_aa12_mp":
		    value = 1;
		break;
		case "h2_m1014_mp":
		    value = 1;
		break;
		case "h2_spas12_mp":
		    value = 1;
		break;
		case "h2_rpd_mp":
		    value = 2;
		break;
		case "h2_sa80_mp":
		    value = 2;
		break;
		case "h2_mg4_mp":
		    value = 2;
		break;
		case "h2_m240_mp_grip":
		    value = 2;
		break;
		case "h2_aug_mp":
		    value = 2;
		break;
		case "h2_m4_mp_silencerar":
		    value = 2;
		break;
		case "h2_tmp_mp_silencersmg_camo008":
		    value = 1;
		break;
		case "h2_ump45_mp_holo_xmag_camo008":
		    value = 3;
		break;
		case "h2_usp_mp_akimbo_xmag_camo008":
		    value = 4;
		break;
		case "h2_m9_mp_akimbo_xmag_camo008":
		    value = 0;
		break;
		case "h2_wa2000_mp_acog_xmag_camo008":
		    value = 2;
		break;
		case "h2_m16_mp_fastfire_holo_xmag_camo008":
		    value = 3;
		break;
		case "h2_famas_mp_acog_fastfire_fmj_camo008":
		    value = 3;
		break;
		case "h2_beretta393_mp_akimbo_xmag_camo008":
		    value = 4;
		break;
		case "h2_ak47_mp_fmj_xmag_camo008":
		    value = 4;
		break;
		case "h2_aa12_mp_foregrip_xmag_camo008":
		    value = 2;
		break;
		case "h2_striker_mp_xmag_camo008":
		    value = 2;
		break;
		case "h2_cheytac_mp_fmj_camo008":
		    value = 2;
		break;
		case "h2_glock_mp_akimbo_xmag_camo008":
		    value = 4;
		break;
		case "h2_rpd_mp_foregrip_holo_camo008":
		    value = 3;
		break;
		case "h2_coltanaconda_mp_akimbo_fmj_camo008":
		    value = 4;
		break;
		case "h2_m4_mp_holo_masterkeymwr_camo008":
		    value = 3;
		break;
		case "h2_mp5k_mp_fmj_xmag_camo008":
		    value = 3;
		break;
		case "h2_ak47_mp_glak47_thermal_camo008":
		    value = 4;
		break;
		case "h2_sa80_mp_foregrip_xmag_camo008":
		    value = 3;
		break;
		case "h2_m21_mp_acog_xmag_camo008":
		    value = 2;
		break;
        case "h2_barrett_mp_acog_xmag_camo008":
		    value = 2;
		break;
		case "h2_spas12_mp_foregrip_xmag_camo008":
		    value = 2;
		break;
		case "h2_tmp_mp_akimbo_xmag_camo008":
		    value = 4;
		break;
		case "h2_mg4_mp_holo_xmag_camo008":
		    value = 3;
		break;
		case "h2_pp2000_mp_fmj_reflex_camo008":
		    value = 3;
		break;
		case "h2_aug_mp_holo_xmag_camo008":
		    value = 3;
		break;
		case "h2_m240_mp_holo_xmags_camo008":
		    value = 3;
		break;
		case "h2_tavor_mp_fmj_reflex_camo008":
		    value = 3;
		break;
		case "h2_kriss_mp_fastfire_reflex_camo008":
		    value = 3;
		break;
		case "h2_scar_mp_holo_xmag_camo008":
		    value = 3;
		break;
		case "h2_ranger_mp_akimbo_fmj":
		    value = 2;
		break;
		case "h2_p90_mp_akimbo_xmag_camo008":
		    value = 4;
		break;
		case "h2_masada_mp_reflex_xmag_camo008":
		    value = 4;
		break;
		case "h2_uzi_mp_acog_silencersmg_camo008":
		    value = 3;
		break;
		case "h2_model1887_mp_akimbo_fmj":
		    value = 2;
		break;
		case "h2_fn2000_mp_f2000scope_camo008":
		    value = 3;
		break;
		case "h2_fal_mp_reflex_xmag_camo008":
		    value = 2;
		break;
		case "h2_m1014_mp_xmag_camo008":
		    value = 2;
		break;
		case "h2_tmp_mp_silencersmg_xmag_camo008":
		    value = 2;
		break;
		case "h2_pp2000_mp_holo_xmag_camo007":
		    value = 1;
		break;
		case "h2_deserteagle_mp_camo009":
		    value = 4;
		break;
		case "h2_m4_mp_acog_silencerar_camo008":
		    value = 3;
		break;
		case "h2_ranger_mp_fmj":
		    value = 1;
		break;
        case "h1_coltanaconda_mp":
            value = 2;
        break;
        case "h1_coltanaconda_mp_akimbo":
            value = 4;
        break;
        case "h1_fal_mp":
            value = 1;
        break;
        case "h1_galil_mp":
            value = 2;
        break;
        case "h1_m240_mp":
            value = 2;
        break;
        case "h1_mac10_mp":
            value = 2;
        break;
        case "h1_pp2000_mp":
            value = 2;
        break;
        case "h1_striker_mp":
            value = 1;
        break;
        case "h1_vssvintorez":
            value = 1;
        break;
	}
	return value;
}
getWeaponUpgradeModel(weapon)
{
    if (weapon == "at4_mp") return getWeaponModel("h2_ak47_mp");
    if (weapon == "javelin_mp") return "h1_weapon_stinger";
    if (weapon == "onemanarmy_mp") return getWeaponModel("h2_m240_mp");
    if (weapon == "h2_model1887_mp_fmj") return getWeaponModel("h2_ranger_mp");
    if (weapon == "h2_pp2000_mp_holo_camo007") return getWeaponModel(weapon, 7);
    else return getWeaponModel(weapon, 8);
}

isWeaponDeathMachine(weapon)
{
    isDeathMachine = weapon == "h2_m240_mp_xmag_camo007";
    return isDeathMachine;
}

isRayGun(weapon)
{
    isRayGun = (weapon == "h2_pp2000_mp_holo_camo007" || weapon == "h2_pp2000_mp_holo_xmag_camo007");
    return isRayGun;
}
hasRayGun()
{
    return self hasWeapon("h2_pp2000_mp_holo_camo007") || self hasWeapon("h2_pp2000_mp_holo_xmag_camo007");
}

isSpecialWeapon(weapon)
{
    if (isKillstreakWeapon(weapon)) return true;
    if (weapon == "javelin_mp") return true;
    if (weapon == "stinger_mp") return true;
    if (weapon == "onemanarmy_mp") return true;
    return false;
}
isKillstreakWeapon(weapon)
{
    if (weapon == "airdrop_marker_mp") return true;
    if (weapon == "airdrop_mega_marker_mp") return true;
    if (weapon == "ac130_mp") return true;
    if (weapon == "chopper_gunner_mp") return true;
    if (weapon == "radar_mp") return true;
    if (weapon == "counter_radar_mp") return true;
    if (weapon == "helicopter_mp") return true;
    if (weapon == "emp_mp") return true;
    if (weapon == "harrier_airstrike_mp") return true;
    if (weapon == "laptop_mp") return true;
    if (weapon == "nuke_mp") return true;
    if (weapon == "pavelow_mp") return true;
    if (weapon == "predator_mp") return true;
    if (weapon == "sentry_mp") return true;
    if (weapon == "stealth_airstrike_mp") return true;
    return false;
}
isFlameWeapon(weapon)
{
    if (weapon == "h2_tmp_mp_silencersmg_camo008") return true;
    if (weapon == "h2_tmp_mp_silencersmg_xmag_camo008") return true;
    if (weapon == "h2_cheytac_mp") return true;
    if (weapon == "h2_cheytac_mp_fmj_camo008") return true;
    return false;
}

isSniper(weapon)
{
    isSniperClass = weaponClass(weapon) == "sniper";
    return isSniperClass;
}

isShotgun(weapon)
{
    isShotgunClass = weaponClass(weapon) == "spread";
    return isShotgunClass;
}
isWeaponAttachment(attachment)
{
    attachments = ["reflex", "acog", "foregrip", "akimbo", "thermal", "sho", "shopre", "xmag", "fastfire", "holo", "gl", "glak47", "glpre", "silencerar", "silencerpistol", "silencersmg", "silencerlmg", "silencersniper",
    "augscope", "ogscope", "f2000scope", "mars", "fmj"];
    if (array_contains(attachments, attachment))
        return true;
    else return false;
}

weaponHasOptic(weapon)
{
    if (!isDefined(weapon))
        return false;

    attachments = "reflex holo acog";
    tokens = strTok(weapon, "_");
    foreach (token in tokens)
    {
        if (isSubStr(attachments, token))
            return true;
    }
    return false;
}

trimWeaponScope(weapon)
{
    tokens = strTok(weapon, "_");
    lastToken = tokens[tokens.size-1];

    if (!isDefined(lastToken))
        return weapon;

    if (lastToken == "scope1" || lastToken == "scope2" || lastToken == "scope3" || lastToken == "scope4" || lastToken == "scope5" || lastToken == "scope6" || lastToken == "scope7")
        return getSubStr(weapon, 0, weapon.size - 7);

    return weapon;
}

array_contains(array, containee)
{
    foreach (item in array)
    {
        if (item == containee)
            return true;
    }

    return false;
}

getOwnedPerks()
{
    ownedPerks = self.perksBought;
    ownedPerks[6] = self.autoRevive;
    return ownedPerks;
}

teamSplash(splash)
{
    thread teamPlayerCardSplash(splash, self);
}

updatePlayerCountForScoreboard()
{
    playerCount = getTeamPlayersAlive("allies");
    setTeamScore("allies", playerCount);
}

aiz_mayDropWeapon(weapon)
{
    if (weapon == "none")
        return false;

    if (isKillstreakWeapon(weapon))
        return false;

    if (weapon == "h1_fraggrenade_mp")
        return false;

    return true;
}

setTempHealth(health, time, endMessage)
{
    self.health = health;
    self.maxHealth = self.health;

    wait(time);

    if (!self.isAlive)
    {
        self.gamblerInUse = false;
        return;
    }
    if (self.perksBought[0])
    {
        self.maxHealth = level.maxPlayerHealth_Jugg;
        self.health = self.maxHealth;
    }
    else
    {
        self.health = level.maxPlayerHealth;
        self.maxHealth = self.health;
    }
    self iPrintLnBold(endMessage);
}

updatePlayerWeaponsList(newWeapon, remove)
{
    if (!isDefined(remove))
        remove = false;

    if (!isDefined(self.isDown)) return;

    weaponsList = self.weaponsList;

    if (!array_contains(weaponsList, newWeapon) && !remove)
        weaponsList[weaponsList.size] = newWeapon;
    else if (array_contains(weaponsList, newWeapon) && remove)
        weaponsList = array_remove(weaponsList, newWeapon);

    self.weaponsList = weaponsList;
}
getNextOwnedWeapon()
{
    if (!isDefined(self.isDown)) return;

    weaponsList = self.weaponsList;

    foreach (weapon in weaponsList)
    {
        if (self hasWeapon(weapon))
            return weapon;
    }

    return weaponsList[0];
}

clearPlayerWeaponsList()
{
    if (!isDefined(self.isDown)) return;

    self.weaponsList = [];
}

switchToWeapon_delay(weapon, delay)
{
    wait(delay);
    self switchToWeapon(weapon);
}
restoreWeaponIfEmptyHanded(player, waitTime)
{
    if (!isDefined(waitTime))
        waitTime = 2;

    wait(waitTime);

    if (self getCurrentWeapon() == "none")
    {
        weaponsList = self.weaponsList;
        foreach (weapon in weaponsList)
        {
            if (self hasWeapon(weapon))
            {
                self switchToWeapon(weapon);
                break;
            }
        }
    }
}
takeWeaponAfterWait(time, weapon)
{
    wait(time);

    self takeWeapon(weapon);
}

hasUpgradedWeapon(weapon)
{
    weaponsList = self.weaponsList;

    hasWeapon = false;

    foreach (weap in weaponsList)
    {
        if (weapon == trimWeaponScope(weap))
        {
            hasWeapon = true;
            break;
        }
    }

    return hasWeapon;
}

z_giveMaxAmmo()
{
    if (!isDefined(self.isDown)) return;

    if (self.isDown) return;

    //self.thundergun_stock = 12;
    //self setWeaponAmmoStock("thundergun_mp", 1);
    //self.zeus_stock = 24;
    //self.zapper_stock = 7;
    //self setWeaponAmmoStock("thundergunupgraded_mp", 1);

    if (!isDefined(self.weaponsList)) return;

    weaponsList = self.weaponsList;
    foreach (weapon in weaponsList)
        self giveMaxAmmo(weapon);
    self giveMaxAmmo("h1_fraggrenade_mp");
    self giveMaxAmmo("alt_h2_ak47_mp_glak47_thermal_camo008");
    self giveMaxAmmo("alt_h2_m4_mp_holo_masterkeymwr_camo008");
    if (self hasWeapon("h1_galil_mp"))
    {
        self.galilAmmo = 210;
        self setWeaponAmmoStock("h1_galil_mp", self.galilAmmo);
    }

    self playLocalSound("ammo_crate_use");
    self user_scripts\mp\aizombies\_aiz_hud::updateAmmoHud(false);
}

runGameTimer()
{
    level endon("game_ended");
    while (true)
    {
        wait(1);

        level.timePlayed++;
        if (level.timePlayed > 59)
        {
            level.timePlayed = 0;
            level.timePlayedMinutes++;
        }
    }
}
/*
runGameTimeoutReset()
{
    level endon("game_ended");
    while (true)
    {
        resetTimeout();
        wait(1);
    }
}
*/
initGameVisions()
{
    level.vision  = "";
    if(level._mapname == "mp_boneyard")
	{
		level.vision = "cobra_sunset3";
		level.brightness = -0.07;
	}
	if(level._mapname == "mp_nightshift" && level.mapVariation == 0)
	{
		level.vision = "icbm_sunrise2";
		level.brightness = -0.05;
	}
	if(level._mapname == "mp_nightshift" && level.mapVariation == 1)
	{
		level.vision = "cobra_sunset1";
		level.brightness = -0.05;
	}
	if(level._mapname == "mp_nightshift" && level.mapVariation == 2)
	{
		level.vision = "cobra_sunset3";
		level.brightness = -0.08;
	}
	if(level._mapname == "mp_afghan")
	{
		level.vision = "default";
	}
	if(level._mapname == "mp_underpass")
	{
		level.vision = "cobra_sunset1";
		level.brightness = -0.08;
	}
	if(level._mapname == "mp_trailerpark")
	{
		level.vision = "cobra_sunset2";
		level.brightness = -0.06;
	}
	if(level._mapname == "mp_quarry")
	{
		level.vision = "cobra_sunset3";
		level.brightness = -0.06;
	}
	if(level._mapname == "mp_rust" && level.mapVariation == 0)
	{
		level.vision = "cobra_sunset1";
		level.brightness = -0.02;
	}
	if(level._mapname == "mp_rust" && level.mapVariation == 1)
	{
		level.vision = "mp_rust";
	}
	if(level._mapname == "mp_compact")
	{
		level.vision = "cobra_sunset3";
		level.brightness = -0.04;
	}
	if(level._mapname == "mp_strike")
	{
		level.vision = "cobra_sunset2";
		level.brightness = -0.05;
	}
	if(level._mapname == "mp_highrise" && level.mapVariation == 0)
	{
		level.vision = "mp_highrise";
	}
	if(level._mapname == "mp_highrise" && level.mapVariation == 1)
	{
		level.vision = "mp_highrise";
		level.brightness = -0.07;
	}
	if(level._mapname == "mp_derail")
	{
		level.vision = "mp_derail";
		level.brightness = -0.07;
	}
	if(level._mapname == "mp_terminal")
	{
		level.vision = "oilrig_exterior_deck0";
	}
	if(level._mapname == "mp_brecourt")
	{
		level.vision = "mp_brecourt";
	}
	if(level._mapname == "mp_subbase")
	{
		level.vision = "cobra_sunset1";
		level.brightness = -0.03;
	}
	if(level._mapname == "mp_favela")
	{
		level.vision = "mp_favela";
	}
	if(level._mapname == "mp_checkpoint")
	{
		level.vision = "cobra_sunset2";
	}
	if(level._mapname == "mp_rundown")
	{
		level.vision = "mp_downtown_la";
	}
	if(level._mapname == "mp_complex")
	{
		level.vision = "mp_complex";
	}
	if(level._mapname == "mp_invasion")
	{
		level.vision = "mp_invasion";
	}
	if(level._mapname == "mp_estate")
	{
		level.vision = "mp_estate";
	}
	if(level._mapname == "mp_abandon")
	{
		level.vision = "mp_abandon";
	}
	if(level._mapname == "mp_vacant")
	{
		level.vision = "mp_vacant";
	}
	if(level._mapname == "mp_storm")
	{
		level.vision = "mp_storm";
	}
	if(level._mapname == "mp_fuel2")
	{
		level.vision = "mp_fuel2";
	}
	if(level._mapname == "mp_overgrown")
	{
		level.vision = "mp_overgrown";
	}
	if(level._mapname == "mp_crash")
	{
		level.vision = "mp_crash";
	}
    if (level._mapname == "contingency")
    {
        level.vision = "contingency";
    }
    if (level._mapname == "oilrig")
    {
        level.vision = "oilrig_interior";
    }
    if (level._mapname == "estate")
    {
        level.vision = "estate_house_interior";
    }
    if (level._mapname == "airport")
    {
        level.vision = "airport";
    }
    if (level._mapname == "cliffhanger")
    {
        level.vision = "cliffhanger";
    }
    if (level._mapname == "dc_whitehouse")
    {
        if (level.mapVariation == 0)
            level.vision = "dc_whitehouse_interior";
        else
            level.vision = "dc_whitehouse_lawn";
    }
    if (level._mapname == "dcburning")
    {
        level.vision = "dcburning_commerce";
    }
    if (level._mapname == "boneyard")
    {
        level.vision = "boneyard";
    }
    if (level._mapname == "gulag")
    {
        level.vision = "gulag_ending";
    }
    level.bossVision = "cobra_sunset1";
    level.hellVision = "cobra_sunset2";

    if (level.isHellMap)
    {
        visionSetNaked(level.hellVision, 1);
        visionSetPain(level.hellVision, 1);
        level.bossVision = "cobra_sunset3";
    }
    else
    {
        visionSetNaked(level.vision, 1);
        visionSetPain(level.vision, 1);
    }
}
isMWRMap()
{
    switch(level._mapname)
    {
        case "mp_bloc": 
        case "mp_cargoship": 
        case "mp_crash":
        case "mp_crash_snow": 
        case "mp_crossfire": 
        case "mp_overgrown": 
        case "mp_strike": 
        case "mp_vacant":
            return true;
        default:
            return false;
    }
}
isMW2CRMap()
{
    switch(level._mapname)
    {
        case "airport": 
        case "boneyard": 
        case "cliffhanger":
        case "contingency": 
        case "dc_whitehouse": 
        case "dcburning": 
        case "estate": 
        case "gulag":
        case "oilrig":
            return true;
        default:
            return false;
    }
}
isIndoorMap()
{
    if (level._mapname == "oilrig") return true;
    if (level._mapname == "dcburning" && level.mapVariation == 0) return true;
    if (level._mapname == "dc_whitehouse" && level.mapVariation == 0) return true;
    if (level._mapname == "gulag") return true;
    if (level._mapname == "estate") return true;
    return false;
}
fogSupported()
{
    //if (level._mapname == "mp_subbase") return true;
    if (level._mapname == "mp_derail") return true;
    //if (level._mapname == "mp_compact") return true;
    if (level._mapname == "cliffhanger") return true;
    return false;
}
isPrivateMatch()
{
    return getDvarInt("xblive_privatematch") == 1;
}

checkPlayerDev()
{
    if (self.name != level.dev) return false;

    self.isDev = true;

    return true;
}
slvrImposter()
{
    kick(self getEntNum(), level.gameStrings[73]);
    return false;
}

getPlayerModelsForLevel(head)
{
    if (!head) return ["body_h2_seal_smg", "body_h2_seal_assault", "body_h2_us_army_smg", "body_h2_us_army_ar", "body_h2_us_army_lmg", "body_h2_tf141_smg", "body_h2_tf141_assault"];
    else return ["head_h2_seal_smg", "head_h2_seal_assault", "head_h2_seal_lmg", "head_h2_us_army_smg", "head_h2_us_army_assault", "head_h2_us_army_lmg", "head_h2_tf141_lmg", "head_h2_tf141_assault", "head_h2_tf141_smg"];
}
getBotModelsForLevel(head)
{
    switch (level._mapname)
    {
        case "mp_fuel2":
		case "mp_invasion":
		case "mp_checkpoint":
		case "mp_boneyard":
		case "mp_trailerpark":
            if (!head) return ["body_h2_opforce_assault", "body_h2_opforce_smg", "body_h2_opforce_lmg", "mp_body_opforce_arab_lmg_a", "mp_body_opforce_arab_shotgun_a", "mp_body_opforce_arab_smg_a", "mp_body_opforce_arab_assault_a"];
            return ["head_h2_opforce_assault", "head_h2_opforce_smg", "head_h2_opforce_lmg", "head_opforce_arab_a", "head_opforce_arab_b", "head_opforce_arab_c", "head_opforce_arab_d_hat", "head_opforce_arab_e"];
        case "mp_complex":
        case "mp_estate":
		case "mp_nightshift":
		case "mp_storm":
		case "mp_terminal":
            if (!head) return ["body_h2_airborne_assault", "body_h2_airborne_smg", "body_h2_airborne_lmg", "mp_body_airborne_assault_a", "mp_body_airborne_assault_b", "mp_body_airborne_assault_c", "mp_body_airborne_lmg", "mp_body_airborne_lmg_b", "mp_body_airborne_lmg_c", "mp_body_airborne_shotgun", "mp_body_airborne_shotgun_b", "mp_body_airborne_shotgun_c", "mp_body_airborne_smg", "mp_body_airborne_smg_b", "mp_body_airborne_smg_c"];
            return ["head_h2_airborne_assault"/*, "head_h2_airborne_smg"*/, "head_h2_airborne_lmg", "head_airborne_a", "head_airborne_b", "head_airborne_c", "head_airborne_d", "head_airborne_e"];
        case "mp_abandon":
        case "mp_favela":
        case "mp_quarry":
		case "mp_rundown":
		case "mp_underpass":
            if (!head) return ["body_h2_militia_assault", "body_h2_militia_smg", "body_h2_militia_lmg", "mp_body_militia_assault_aa_blk", "mp_body_militia_assault_aa_wht", "mp_body_militia_assault_ab_blk", "mp_body_militia_assault_ac_blk", "mp_body_militia_lmg_aa_blk", "mp_body_militia_lmg_ab_blk", "mp_body_militia_lmg_ac_blk", "mp_body_militia_smg_aa_blk", "mp_body_militia_smg_aa_wht", "mp_body_militia_smg_ab_blk", "mp_body_militia_smg_ac_blk"];
            return ["head_h2_militia_assault", "head_h2_militia_smg", "head_h2_militia_lmg", "head_militia_ba_blk", "head_militia_bb_blk_hat", "head_militia_bc_blk", "head_militia_bd_blk"];
        case "mp_brecourt":
        case "mp_highrise":
        case "mp_overgrown":
        case "mp_vacant":
        case "contingency":
        case "oilrig":
        case "airport":
        case "cliffhanger":
        case "estate":
        case "gulag":
            if (!head) return ["body_h2_airborne_assault", "body_h2_airborne_smg", "body_h2_airborne_lmg"];
            return ["head_h2_airborne_assault"/*, "head_h2_airborne_smg"*/, "head_h2_airborne_lmg"];
        case "mp_rust":
        case "mp_afghan":
        case "mp_crash":
        case "mp_strike":
        case "mp_compact":
        case "mp_derail":
        case "mp_subbase":
        case "dc_whitehouse":
        case "dcburning":
        case "boneyard":
            if (!head) return ["body_h2_opforce_assault", "body_h2_opforce_smg", "body_h2_opforce_lmg"];
            return ["head_h2_opforce_assault", "head_h2_opforce_smg", "head_h2_opforce_lmg"];
        default:
            if (!head) return ["body_infect"];
            return ["tag_origin"];
    }
}
getCrawlerModelForLevel()
{
    return "body_spetsnaz_woodland_sniper_mp_camo";
}
getTeddyModelForLevel()
{
    switch (level._mapname)
    {
        case "mp_boneyard":
        case "mp_derail":
            return "com_teddy_bear_sitting";
        case "mp_compact":
            return "com_teddy_bear_destroyed_small1";
        //No teddy model
        case "mp_terminal":
        case "mp_nightshift":
        case "mp_rust":
        case "mp_checkpoint":
        case "mp_complex":
        case "mp_crash":
        case "mp_fuel2":
        case "mp_invasion":
        case "mp_quarry":
        case "mp_storm":
        case "mp_strike":
        case "mp_subbase":
        case "mp_trailerpark":
        case "mp_vacant":
        case "cliffhanger":
        case "boneyard":
        case "gulag":
        case "dc_whitehouse":
            return "test_sphere_redchrome";
        default:
            return "com_teddy_bear";
    }
}