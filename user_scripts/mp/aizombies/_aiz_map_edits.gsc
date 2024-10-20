#include user_scripts\mp\aizombies\_aiz;
#include common_scripts\utility;
#include maps\mp\_utility;
#include user_scripts\mp\aizombies\_aiz_hud;

init()
{
    if (getDvarInt("aiz_enabled") == 0)
        return;
        
    level.playerSpawnLocs = [];
    level.playerSpawnAngles = [];
    level.boxLocations = [];
    level.boxMaxUses = 15;
    level.randomMap = 0;

    level.boxCounter = 0;
    level.boxIndex = 0;

    level.objID_box = 32;
    level.objID_gambler = 31;
    level.objID_ammo = 30;
    level.objID_power = 29;
    level.objID_perks = [];
    level.objID_perks[0] = 28;
    level.objID_perks[1] = 27;
    level.objID_perks[2] = 26;
    level.objID_perks[3] = 25;
    level.objID_perks[4] = 24;
    level.objID_perks[5] = 23;
    level.objID_perks[6] = 22;
    level.objID_perks[7] = 21;
    level.objID_upgrade = 20;
    level.objID_killstreak = 19;

    level.usables = [];

    level.teddyModel = getTeddyModelForLevel();

    initializeBoxWeapons();

    level.airDropCrates = getEntArray( "care_package", "targetname" );
	level.oldAirDropCrates = getEntArray( "airdrop_crate", "targetname" );
	
	if ( !level.airDropCrates.size )
	{	
		level.airDropCrates = level.oldAirDropCrates;
		
        if (isMWRMap() || isMW2CRMap())
            level.airDropCrateCollision = getEnt("patchclip_player_32_32_32", "targetname");
        else
        {
            if(level.airDropCrates.size)
                level.airDropCrateCollision = getEnt(level.airDropCrates[0].target, "targetname");
        }
	}
	else
	{
		foreach (crate in level.oldAirDropCrates) 
			crate delete();

		if(level.airDropCrates.size)
			level.airDropCrateCollision = getEnt(level.airDropCrates[0].target, "targetname");

		level.oldAirDropCrates = getEntArray("airdrop_crate", "targetname");
	}
}

initializeBoxWeapons()
{
    level.weaponModels = [];
    level.weaponNames = [];
    level.localizedWeaponNames = [];

    currentIndex = 0;

	level.weaponModels[currentIndex] = "wpn_h2_m9_npc";
    currentIndex++;
	level.weaponModels[currentIndex] = "wpn_h2_aug_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_f2000_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_pp2000_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "h2_weapon_m240";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_m1014_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_vector_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_m16_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_spas12_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_ump45_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_p90_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_miniuzi_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_lsw_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_glock_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_rpd_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "h2_weapon_m79";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_usp_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_aa12_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_ak47_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "h2_weapon_m82";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_raffica_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_iw4_magnum_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_deagle_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_famas_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_fal_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_m14_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_m4a1_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_m4a1_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_acr_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_mg4_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_model1887_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_model1887_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_mp5k_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_ranger_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_scar_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_striker_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_tavor_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_tmp_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_wa2000_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "h2_weapon_rpg7";
    currentIndex++;
    level.weaponModels[currentIndex] = "h2_viewmodel_javelin_base";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_tmp_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_pp2000_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "weapon_oma_pack_viewmodel";
    currentIndex++;
    level.weaponModels[currentIndex] = "wpn_h2_cheytac_npc";
    currentIndex++;
    level.weaponModels[currentIndex] = "h2_weapon_at4";
    if (level.newWeapons)
    {
        currentIndex++;
        level.weaponModels[currentIndex] = "weapon_colt_anaconda";
        currentIndex++;
        level.weaponModels[currentIndex] = "weapon_fn_fal";
        currentIndex++;
        level.weaponModels[currentIndex] = "t6_wpn_ar_galil_world";
        currentIndex++;
        level.weaponModels[currentIndex] = "weapon_m240";
        currentIndex++;
        level.weaponModels[currentIndex] = "weapon_mini_uzi";
        currentIndex++;
        level.weaponModels[currentIndex] = "weapon_pp2000";
        currentIndex++;
        level.weaponModels[currentIndex] = "weapon_striker";
        currentIndex++;
        level.weaponModels[currentIndex] = "weapon_dragunov_cod3";
    }

    currentIndex = 0;

    level.weaponNames[currentIndex] = "h2_m9_mp"; 
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_aug_mp"; 
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_fn2000_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_pp2000_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_m240_mp_foregrip";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_m1014_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_kriss_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_m16_mp_reflex";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_spas12_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_ump45_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_p90_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_uzi_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_sa80_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_glock_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_rpd_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_m79_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_usp_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_aa12_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_ak47_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_barrett_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_beretta393_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_coltanaconda_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_deserteagle_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_famas_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_fal_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_m21_mp_acog";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_m4_mp_reflex";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_m4_mp_silencerar";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_masada_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_mg4_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_model1887_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_model1887_mp_fmj";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_mp5k_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_ranger_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_scar_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_striker_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_tavor_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_tmp_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_wa2000_mp_acog";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_rpg_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "javelin_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_tmp_mp_silencersmg_camo008";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_pp2000_mp_holo_camo007";
    currentIndex++;
    level.weaponNames[currentIndex] = "onemanarmy_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "h2_cheytac_mp";
    currentIndex++;
    level.weaponNames[currentIndex] = "at4_mp";
    if (level.newWeapons)
    {
        currentIndex++;
        level.weaponNames[currentIndex] = "h1_coltanaconda_mp";
        currentIndex++;
        level.weaponNames[currentIndex] = "h1_fal_mp";
        currentIndex++;
        level.weaponNames[currentIndex] = "h1_galil_mp";
        currentIndex++;
        level.weaponNames[currentIndex] = "h1_m240_mp";
        currentIndex++;
        level.weaponNames[currentIndex] = "h1_mac10_mp";
        currentIndex++;
        level.weaponNames[currentIndex] = "h1_pp2000_mp";
        currentIndex++;
        level.weaponNames[currentIndex] = "h1_striker_mp";
        currentIndex++;
        level.weaponNames[currentIndex] = "h1_vssvintorez_mp";
    }

    currentIndex = 0;

    level.localizedWeaponNames[currentIndex] = "M9";
	currentIndex++;
    level.localizedWeaponNames[currentIndex] = "AUG HBAR";
	currentIndex++;
    level.localizedWeaponNames[currentIndex] = "F2000";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "PP2000";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "M240";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "M1014";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "Vector";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "M16A4 Red Dot Sight";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "SPAS-12";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "UMP45";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "P90";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "Uzi";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "L86 LSW";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "G18";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "RPD";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "Thumper";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = &"WEAPON_USP";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = &"WEAPON_AA12";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = &"WEAPON_AK47";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = &"WEAPON_BARRETT";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "M93 Raffika";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = &"WEAPON_ANACONDA";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = &"WEAPON_DESERTEAGLE";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "FAMAS";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "FN FAL";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "M14 EBR Acog Scope";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "M4A1 Red Dot Sight";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "M4A1 Silencer";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "Assault Combat Rifle";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "MG-4";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = &"WEAPON_MODEL1887";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "Model 1887 FMJ";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "MP5K";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "Double Barrel Shotgun";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "SCAR-L";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = &"WEAPON_STRIKER";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "TAR-21";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "TMP";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "WA2000 ACOG Scope";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = &"WEAPON_RPG";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = &"WEAPON_JAVELIN";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "Flamethrower";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "Ray Gun";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "OMA";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "Intervention Explosive Bullets";
    currentIndex++;
    level.localizedWeaponNames[currentIndex] = "AT4-HS";
    if (level.newWeapons)
    {
        currentIndex++;
        level.localizedWeaponNames[currentIndex] = ".44 Magnum Classic";
        currentIndex++;
        level.localizedWeaponNames[currentIndex] = "FN FAL Classic";
        currentIndex++;
        level.localizedWeaponNames[currentIndex] = "Galil";
        currentIndex++;
        level.localizedWeaponNames[currentIndex] = "M240 Classic";
        currentIndex++;
        level.localizedWeaponNames[currentIndex] = "Uzi Classic";
        currentIndex++;
        level.localizedWeaponNames[currentIndex] = "PP2000 Classic";
        currentIndex++;
        level.localizedWeaponNames[currentIndex] = "Striker Classic";
        currentIndex++;
        level.localizedWeaponNames[currentIndex] = "Dragunov Classic";
    }
}

executeUsable(type, player, ent)
{
    switch (type)
    {
        case "sentryPickup":
            player user_scripts\mp\aizombies\_aiz_killstreaks::pickupSentry(ent.turret, false);
            break;
        case "revive":
            revivePlayer(ent, player);
            break;
        case "door":
            player useDoor(ent);
            break;
        case "randombox":
            player thread useBox(ent);
            break;
        case "pap":
            player thread usePapBox(ent, player getCurrentWeapon());
            break;
        case "gambler":
            player useGambler(ent);
            break;
        case "perk1":
            player usePerk(ent, 1);
            break;
        case "perk2":
            player usePerk(ent, 2);
            break;
        case "perk3":
            player usePerk(ent, 3);
            break;
        case "perk4":
            player usePerk(ent, 4);
            break;
        case "perk5":
            player usePerk(ent, 5);
            break;
        case "perk6":
            player usePerk(ent, 6);
            break;
        case "perk7":
            player usePerk(ent, 7);
            break;
        case "perk8":
            player usePerk(ent, 8);
            break;
        case "ammo":
            player useAmmo(ent);
            break;
        case "power":
            player usePower(ent);
            break;
        case "killstreak":
            player useKillstreak(ent);
            break;
        case "elevator":
            player useElevator(ent);
            break;
        case "wallweapon":
            player useWallWeapon(ent);
            break;
        case "zipline":
            player useZipline(ent);
            break;
        default:
            break;
    }
}

removeUsable()
{
    if (isDefined(self.objID))
    {
        _objective_delete(self.objID);
    }
    if (isDefined(self.icon))
    {
        self.icon destroy();
    }

    //trigger = self.trigger;
    level.usables = array_remove(level.usables, self);
    if (!array_contains(level.usables, self))
    {
        if (isDefined(self.pieces))
        {
            pieces = self.pieces;
            foreach (p in pieces) p delete();
        }
        self delete();
        if (isDefined(self.collision))
            self.collision delete();
        //trigger delete();
    }
}

trackUsablesForPlayer()
{
    self notify("track_usables");

    level endon ("game_ended");
    self endon ("death");
    self endon ("disconnect");
    self endon("track_usables");

    self thread handleUsableMessage();
    
    triggerHelper = spawn("script_origin", self.origin);
    triggerHelper setCursorHint("HINT_NOICON");
    triggerHelper setHintString(&"NULL_EMPTY");
    triggerHelper setSelfUsable(self);
    triggerHelper thread notUsableForJoiningPlayers(self);
    triggerHelper linkTo(self, "tag_origin", (0, 0, 10), (0,0,0));
    triggerHelper thread deleteTriggerHelperOnDeath(self);

    while(isDefined(triggerHelper))
    {
        triggerHelper waittill("trigger");

        self checkPlayerUsables();
    }
}
deleteTriggerHelperOnDeath(player)
{
    player waittill_any("death", "disconnect", "track_usables");

    self unlink();
    self delete();
}

handleUsableMessage()
{
    self notify("track_usable_messages");

    level endon ("game_ended");
    self endon ("death");
    self endon ("disconnect");
    self endon ("track_usable_messages");

    while (true)
    {
        wait(0.25);

        if (self.hasMessageUp)
            continue;

        foreach (usable in level.usables)
        {
            if (!isDefined(usable.range)) continue;

            if (usable.usabletype == "giftTrigger")
                if (usable.owner == self) continue;

            if (distanceSquared(self.origin, usable.origin) < usable.range)
            {
                self displayUsableHintMessage(usable);
            }
        }
    }
}

setLowerMessageParams(messageParams)
{
    if (!isDefined(messageParams) || messageParams.size == 0)
        return;

    self.lowerMessage setText("");
    self.lowerMessage.label = messageParams[0];
    if (messageParams.size > 1)
        self.lowerMessage setText(messageParams[1]);
    if (messageParams.size > 2)
        self.lowerMessage setValue(messageParams[2]);
}

displayUsableHintMessage(usable)
{
    //if (!isDefined(self.hud_message)) return;

    self.hasMessageUp = true;
    //message = self.hud_message;
    //message.alpha = 0.85;
    //message setText(usable getUsableText(self));
    usableText = usable getUsableText(self);

    if (usableText.size > 0)
    {
        self setLowerMessage("usable_message", usableText[0]);
        self setLowerMessageParams(usableText);
    }

    self thread watchPlayerLeaveUsable(usable);
}
watchPlayerLeaveUsable(usable)
{
    level endon ("game_ended");
    self endon ("death");
    self endon ("disconnect");
    self endon ("left_usable");

    while (true)
    {
        if (!isDefined(usable))
        {
            self clearLowerMessage("usable_message");
            self.hasMessageUp = false;
            self notify("left_usable");
        }

        //message setText(getUsableText(usable, self));
        usableText = usable getUsableText(self);
        if (usableText.size > 0)
            self setLowerMessageParams(usableText);

        if (distanceSquared(self.origin, usable.origin) > usable.range)
        {
            //message.alpha = 0;
            //message setText("");
            self clearLowerMessage("usable_message");
            self.hasMessageUp = false;
            self notify("left_usable");
        }

        wait(0.25);
    }
}

checkPlayerUsables()
{
    foreach (usable in level.usables)
    {
        if (isDefined(usable.range) && distanceSquared(self.origin, usable.origin) < usable.range)
        {
            if (usable.usabletype == "giftTrigger" && usable.owner == self) continue;

            executeUsable(usable.usabletype, self, usable);
            return;//We found a usable close enough, get out of this loop
        }
    }
}

//-SPECIAL USABLE LOGIC-//
revivePlayer(reviveTrigger, reviver)
{
    //self = player being revived
    if (isDefined(reviver.isCarryingSentry) && reviver.isCarryingSentry) return;
    if (reviver.isDown) return;
    if (reviver.sessionTeam != "allies") return;
    if (reviveTrigger.player == reviver) return;
    if (isDefined(reviveTrigger.user)) return;//To avoid multiple revivers at a time

    reviveTrigger.player iPrintLnBold("Being revived by " + reviver.name + "...");
    reviver createPrimaryProgressBar(0, 0);
    //progressBar setPoint("center", "center", 0, -61);
    reviver.progressBar.isScaling = false;
    reviveTrigger.user = reviver;
    reviveTrigger.reviveCounter = 1;
    reviver thread revivePlayer_logicLoop(reviveTrigger);
}
revivePlayer_logicLoop(reviveTrigger)
{
    //level endon("game_ended");
    //self endon("disconnect");

    while(true)
    {
        if (level.gameEnded || !isDefined(self))
        {
            reviveTrigger.user = undefined;
            self.progressBar.bar destroy();
            self.progressBar destroy();
            break;
        }
        if (self useButtonPressed() && isDefined(reviveTrigger.player) && reviveTrigger.player.isAlive && distanceSquared(self.origin, reviveTrigger.origin) < 5625 && !self.isDown)
        {
            reviveCounter = reviveTrigger.reviveCounter;
            self disableWeapons();
            reviveCounter++;
            if (self.autoRevive) reviveCounter++;//Double time
            reviveTrigger.reviveCounter = reviveCounter;

            if (!self.progressBar.isScaling)
            {
                self.progressBar.isScaling = true;
                if (self.autoRevive) self.progressBar updateBar(120, 1.875);
                else self.progressBar updateBar(120, 3.75);
            }
            if (reviveCounter >= 75)
            {
                downedPlayer = reviveTrigger.player;
                downedPlayer lastStandRevive();
                self enableWeapons();
                downedPlayer.isDown = false;
                if (!level.isHellMap || (level.isHellMap && level.visionRestored)) downedPlayer visionSetNakedForPlayer(level.vision);
                else downedPlayer visionSetNakedForPlayer(level.hellVision);
                downedPlayer thread maps\mp\gametypes\_hud_message::playerCardSplashNotify("revived", self);
                downedPlayer enableWeaponSwitch();
                downedPlayer enableOffhandWeapons();
                //weaponList = downedPlayer.weaponsList;
                if (!array_contains(downedPlayer.weaponsList, "h2_usp_mp"))
                {
                    downedPlayer takeWeapon("h2_usp_mp");
                    downedPlayer switchToWeapon(downedPlayer.lastDroppableWeapon);
                }
                downedPlayer thread restoreWeaponIfEmptyHanded();

                downedPlayer.Health = downedPlayer.maxHealth;
                reviveTrigger.icon destroy();
                //downedPlayer.headIcon = "";
                //downedPlayer.headIconTeam = "axis";
                self.progressBar.bg destroy();
                self.progressBar destroy();
                amount = int(downedPlayer.cash / 30);
                amount -= int(amount % 10);//Remove the difference
                self thread textPopup(&"Revived &&1!", downedPlayer);
                self.cash += amount;
                self thread scorePopup(amount);
                self.assists++;
                reviveTrigger.reviveCounter = undefined;
                reviveTrigger removeUsable();
                self clearLowerMessage("usable_message");
                self.hasMessageUp = false;
                self notify("left_usable");
                break;
            }
        }
        else
        {
            downedPlayer = reviveTrigger.player;
            reviveTrigger.user = undefined;
            self.progressBar.bg destroy();
            self.progressBar destroy();
            reviveTrigger.reviveCounter = 1;
            self enableWeapons();
            if (!isDefined(downedPlayer) || !downedPlayer.IsAlive)
            {
                reviveTrigger removeUsable();
            }
            break;
        }
        wait(0.05);
    }
}
//-END SPECIAL USABLE LOGIC-//

//-START STRUCTURE CREATORS-//
randomWeaponCrate(origin, angles, objID, currentLoc)
{
    if (!isDefined(currentLoc))
        currentLoc = 0;

    crate = spawnCrate(origin, angles, false, false);
    curObjID = level.objID_box;
    objective_add(curObjID, "invisible", (0, 0, 0));
    objective_position(curObjId, crate.origin);
    objective_team(curObjID, "allies");
    objective_state(curObjId, "active");
    objective_icon(curObjId, "hud_icon_m16a4");
    crate.objID = curObjID;

    HeadIcon = newHudElem();
    HeadIcon.x = origin[0];
    HeadIcon.y = origin[1];
    HeadIcon.z = origin[2] + 40;
    HeadIcon.alpha = 0.85;
    HeadIcon.archived = false;
    HeadIcon setShader("hud_icon_m16a4", 10, 10);
    HeadIcon setWaypoint(true, true, false);
    crate.icon = HeadIcon;

    crate.state = "idle";
    crate.weapon = 0;
    crate.player = undefined;
    crate.destroyed = true;
    crate.lastLocation = currentLoc;

    weapon = spawn("script_model", crate.origin + (0, 0, 20));
    weapon setModel("wpn_h2_usp_vm");
    weapon hidePart("tag_knife");
    crate.weaponEnt = weapon;

    crate thread rotateWeaponCrateWeapon();

    crate addUsable("randombox", 75);

    crate thread watchCratePlayerCollision();

    return crate;
}
watchCratePlayerCollision()
{
    self endon("death");

    self notSolid();
    self setContents(0);

    isClear = false;
    while (!isClear)
    {
        waitframe();
        isClear = true;
        foreach (player in level.players)
        {
            if (!isDefined(player.isAlive) || !player.isAlive)
                continue;

            if (player isTouching(self))
            {
                isClear = false;
                break;
            }
        }
    }

    self solid();
    self setContents(1);
}
rotateWeaponCrateWeapon()
{
    level endon("game_ended");
    self endon("death");

    while(true)
    {
        if (self.state == "idle")
        {
            if (isDefined(self.weaponEnt))
                self.weaponEnt rotateYaw(360, 3);

            wait(3);
        }
        else wait(1);
    }
}

papCrate(origin, angles)
{
    if (!level.isHellMap)
    {
        level waittill("power_activated");
        wait(6);
    }

    crate = spawn("script_model", origin - (0, 0, 15));
    if (level._mapname == "oilrig" || level._mapname == "contingency")
        crate setModel("com_plasticcase_beige_big_snow");
    else if (level._mapname == "cliffhanger")
        crate setModel("com_plasticcase_green_big_snow");
    else if (level._mapname == "boneyard")
        crate setModel("com_plasticcase_enemy");
    else if (level._mapname == "dc_whitehouse" && level.mapVariation == 0)
        crate setModel("tag_origin");
    else if (level._mapname == "airport")
        crate setModel("me_plastic_crate1");
    else
        crate setModel("com_plasticcase_beige_big");

    crate.angles = angles;
    crateCol = spawnCrate(origin, angles, true, false);
    crate.collision = crateCol;
    curObjID = level.objID_upgrade;
    objective_add(curObjID, "invisible", (0, 0, 0));
    objective_position(curObjId, crate.origin);
    objective_team(curObjID, "allies");
    objective_state(curObjId, "active");
    objective_icon(curObjId, "em_st_043");

    HeadIcon = newHudElem();
    HeadIcon.x = origin[0];
    HeadIcon.y = origin[1];
    HeadIcon.z = origin[2] + 40;
    HeadIcon.alpha = 0.85;
    HeadIcon.archived = false;
    HeadIcon setShader("em_st_043", 10, 10);
    HeadIcon setWaypoint(true, true, false);
    crate.icon = HeadIcon;

    crate.state = "idle";
    crate.weapon = "";
    crate.player = undefined;

    weapon = spawn("script_model", crate.origin + (0, 0, 10));
    weapon setModel("tag_origin");
    weapon hide();
    //weapon enableLinkTo();
    crate.weaponEnt = weapon;

    attachments = [];
    attachments[0] = spawn("script_model", weapon.origin);
    attachments[0] setModel("tag_origin");
    attachments[0] linkTo(weapon);
    attachments[0] hide();
    attachments[1] = spawn("script_model", weapon.origin);
    attachments[1] setModel("tag_origin");
    attachments[1] linkTo(weapon);
    attachments[1] hide();
    crate.attachments = attachments;

    crate addUsable("pap", 75);
    //return crate;
}

gamblerCrate(origin, angles)
{
    crate = spawnCrate(origin, angles, false, false);
    laptop = spawn("script_model", (origin[0], origin[1], origin[2] + 22));
    laptop.angles = (0, 90, 0);
    laptop setModel("com_laptop_2_open");
    if (isMWRMap() || isMW2CRMap())
    {
        laptop setModel("wpn_h1_remote_tablet_npc");
        laptop.angles = (-90, 90, 0);
    }
    crate.laptop = laptop;
    crate.gamblerInUse = false;
    laptop thread rotateEntity();
    curObjID = level.objID_gambler;
    objective_add(curObjID, "invisible", (0, 0, 0));
    objective_position(curObjId, crate.origin);
    objective_team(curObjID, "allies");
    objective_state(curObjId, "active");
    objective_icon(curObjId, "em_st_128");

    HeadIcon = newHudElem();
    HeadIcon.x = origin[0];
    HeadIcon.y = origin[1];
    HeadIcon.z = origin[2] + 40;
    HeadIcon.alpha = 0.85;
    HeadIcon.archived = false;
    HeadIcon setShader("em_st_128", 10, 10);
    HeadIcon setWaypoint(true, true, false);
    crate.icon = HeadIcon;

    crate addUsable("gambler", 75);
    //return crate;
}

perkCrate(origin, angles, perk)
{
    if (perk != 8)
    {
        if (!level.isHellMap)
        {
            level waittill("power_activated");

            wait(6);
        }
    }

    crate = spawnCrate(origin + (0, 0, 50), angles, false, false);
    model = "com_plasticcase_friendly";
    if (perk == 1 || perk == 2 || perk == 5) model = "com_plasticcase_enemy";
    crate setModel(model);
    curObjID = level.objID_perks[perk-1];
    icon = "white";
    cost = 5000;
    switch (perk)
    {
        case 1:
            cost = 2500;
            icon = "em_st_087";
            break;
        case 2:
            cost = 2000;
            icon = "em_st_207";
            break;
        case 3:
            cost = 3000;
            icon = "em_st_208";
            break;
        case 4:
            cost = 6500;
            icon = "em_st_039";
            break;
        case 5:
            cost = 2500;
            icon = "em_st_212";
            break;
        case 6:
            cost = 2000;
            icon = "em_st_218";
            break;
        case 7:
            cost = 2500;
            icon = "em_st_221";
            break;
        case 8:
            cost = 200;
            icon = "em_st_214";
            break;
        default:
            icon = "white";
            break;
    }

    objective_add(curObjID, "invisible", (0, 0, 0));
    objective_position(curObjId, origin);
    objective_team(curObjID, "allies");
    objective_state(curObjId, "active");
    objective_icon(curObjId, icon);
    crate.cost = cost;
    crate addUsable("perk" + perk, 75);

    crate moveTo(origin, 3);

    //return crate;
}

ammoCrate(origin, angles)
{
    crate = spawnCrate(origin, angles, false, false);
    curObjID = level.objID_ammo;
    objective_add(curObjID, "invisible", (0, 0, 0));//waypoint_ammo_friendly or airdrop_icon
    objective_position(curObjId, crate.origin);
    objective_team(curObjID, "allies");
    objective_state(curObjId, "active");
    objective_icon(curObjId, "waypoint_ammo_friendly");

    HeadIcon = newHudElem();
    HeadIcon.x = origin[0];
    HeadIcon.y = origin[1];
    HeadIcon.z = origin[2] + 40;
    HeadIcon.alpha = 0.85;
    HeadIcon.archived = false;
    HeadIcon setShader("waypoint_ammo_friendly", 10, 10);
    HeadIcon setWaypoint(true, true, false);
    crate.icon = HeadIcon;

    crate.used = false;
    crate addUsable("ammo", 75);
    //return crate;
}

killstreakCrate(origin, angles)
{
    if (!level.isHellMap)
    {
        level waittill("power_activated");
        wait(6);
    }

    crate = spawnCrate(origin + (0, 0, 50), angles, false, false);
    crate setModel("com_plasticcase_enemy");
    curObjID = level.objID_killstreak;
    objective_add(curObjID, "invisible", (0, 0, 0));
    objective_position(curObjId, crate.origin);
    objective_team(curObjID, "allies");
    objective_state(curObjId, "active");
    objective_icon(curObjId, "em_st_025");

    HeadIcon = newHudElem();
    HeadIcon.x = origin[0];
    HeadIcon.y = origin[1];
    HeadIcon.z = origin[2] + 40;
    HeadIcon.alpha = 0.85;
    HeadIcon.archived = false;
    HeadIcon setShader("em_st_025", 10, 10);
    HeadIcon setWaypoint(true, true, false);

    remote = spawn("script_model", origin + (0, 0, 20));
    remote.angles = (0, 0, 0);
    remote setModel("wpn_h1_airsupport_vm");
    remote thread rotateEntity();

    crate addUsable("killstreak", 75);

    crate moveTo(origin, 3);
    //return crate;
}

rotateEntity()
{
    level endon ("game_ended");

    while (true)
    {
        self rotateYaw(360, 4);
        wait(4);
    }
}

powerCrate(origin, angles)
{
    crate = spawnCrate(origin, angles, false, false);
    curObjID = level.objID_power;
    objective_add(curObjID, "invisible", (0, 0, 0));
    objective_position(curObjId, crate.origin);
    objective_team(curObjID, "allies");
    objective_state(curObjId, "active");
    objective_icon(curObjId, "em_st_160");
    crate.objID = curObjID;

    HeadIcon = newHudElem();
    HeadIcon.x = origin[0];
    HeadIcon.y = origin[1];
    HeadIcon.z = origin[2] + 40;
    HeadIcon.alpha = 0.85;
    HeadIcon.archived = false;
    HeadIcon setShader("em_st_160", 10, 10);
    HeadIcon setWaypoint(true, true, false);
    crate.icon = HeadIcon;

    crate.bought = false;
    crate addUsable("power", 75);
    //return crate;
}

wallWeapon(origin, angles, weapon, price)
{
    wep = spawn("script_model", origin);
    model = getWeaponModel(weapon);
    wep setModel(model);
    wep.angles = angles;
    wep.price = price;
    wep.weapon = weapon;
    wep.bought = false;
    wep addUsable("wallweapon", 70);
    return wep;
}

createRamp(top, bottom, invisible)
{
    rampDist = distance(top, bottom);
    blocks = ceil(rampDist / 30);
    a = ((top[0] - bottom[0]) / blocks, (top[1] - bottom[1]) / blocks, (top[2] - bottom[2]) / blocks);
    temp = VectorToAngles(top - bottom);
    ba = (temp[2], temp[1] + 90, temp[0]);
    for (b = 0; b <= blocks; b++)
    {
        spawnCrate(bottom + (a * b), ba, invisible, false);
    }
}

createPowerRamp(top, bottom)
{
    if (!level.isHellMap)
    {
        level waittill("power_activated");

        wait(6);
    }

    rampDist = distance(top, bottom);
    blocks = ceil(rampDist / 30);
    a = ((top[0] - bottom[0]) / blocks, (top[1] - bottom[1]) / blocks, (top[2] - bottom[2]) / blocks);
    temp = VectorToAngles(top - bottom);
    ba = (temp[2], temp[1] + 90, temp[0]);
    for (b = 0; b <= blocks; b++)
    {
        spawnCrate(bottom + (a * b), ba, false, false);
        wait(0.1);
    }
}

createDoor(open, close, angle, size, height, range, cost, newSpawn, newSpawnAngles)
{

    offset = (((size / 2) - 0.5) * -1);
    center = spawn("script_model", close);
    pieces = [];
    if (size > 0)
    {
        for (j = 0; j < size; j++)
        {
            door = spawnCrate(close + vecscale((0, 30, 0), offset), (0, 0, 0), false, false);
            door setModel("com_plasticcase_enemy");
            //door enableLinkTo();
            door linkTo(center);
            pieces[pieces.size] = door;
            for (h = 1; h < height; h++)
            {
                door2 = spawnCrate(close + vecscale((0, 30, 0), offset) - vecscale((70, 0, 0), h), (0, 0, 0), false, false);
                door2 setModel("com_plasticcase_enemy");
                //door2 enableLinkTo();
                door2 linkTo(center);
                pieces[pieces.size] = door2;
            }
            offset += 1;
        }
    }
    center.angles = angle;
    center.open = open;
    center.close = close;
    center.cost = cost;
    center.pieces = pieces;

    center addUsable("door", range);
    center.state = "close";

    if (isDefined(newSpawn) && isDefined(newSpawnAngles))
    {
        center.spawn = newSpawn;
        center.spawnAngles = newSpawnAngles;
    }

    return center;
}

createWall(start, end, invisible, death)
{
    D = distance((start[0], start[1], 0), (end[0], end[1], 0));
    H = distance((0, 0, start[2]), (0, 0, end[2]));
    horizSpacing = 60;
    vertSpacing = 30;
    if (isMW2CRMap())
    {
        horizSpacing = 20;
        vertSpacing = 20;
    }
    blocks = roundDecimalPlaces(D / horizSpacing, 0);
    height = roundDecimalPlaces(H / vertSpacing, 0);

    C = end - start;
    A = (C[0] / blocks, C[1] / blocks, C[2] / height);
    TXA = A[0] / 4;
    TYA = A[1] / 4;
    angle = VectorToAngles(C);
    angle = (0, angle[1], 90);
    //center = Spawn("script_origin", (
    //(start[0] + end[0]) / 2, (start[1] + end[1]) / 2, (start[2] + end[2]) / 2));
    for (h = 0; h < height; h++)
    {
        crate = spawnCrate((start + (TXA, TYA, 15) + vecscale((0, 0, A[2]), h)), angle, invisible, death);
        //crate enableLinkTo();
        //crate linkTo(center);
        crate willNeverChange();
        if (death) crate thread setDeathWall();
        for (i = 0; i < blocks; i++)
        {
            crate = spawnCrate(start + vecscale((A[0], A[1], 0), i) + (0, 0, 15) + vecscale((0, 0, A[2]), h), angle, invisible, death);
            //crate enableLinkTo();
            //crate linkTo(center);
            crate willNeverChange();
            if (death) crate thread setDeathWall();
        }
        crate = spawnCrate((end[0], end[1], start[2]) + (TXA * -1, TYA * -1, 15) + vecscale((0, 0, A[2]), h), angle, invisible, death);
        //crate enableLinkTo();
        //crate linkTo(center);
        crate willNeverChange();
        if (death) crate thread setDeathWall();
    }
    //return center;
}

vecscale(vec, scalar)
{
	return (vec[0]*scalar, vec[1]*scalar, vec[2]*scalar);
}

setDeathWall()
{
    level endon("game_ended");
    self endon("death");

    while(true)
    {
        foreach (player in level.players)
        {
            if (player.isAlive && distance(player.origin, self.origin) < 60)
                player _suicide();
        }

        wait(0.2);
    }
}

createFloor(corner1, corner2, invisible, death)
{
    width = corner1[0] - corner2[0];
    if (width < 0) width = width * -1;
    length = corner1[1] - corner2[1];
    if (length < 0) length = length * -1;

    bwide = roundDecimalPlaces(width / 50, 0);
    length = roundDecimalPlaces(length / 30, 0);
    C = corner2 - corner1;
    A = (C[0] / bwide, C[1] / length, 0);
    //center = spawn("script_origin", (
    //(corner1[0] + corner2[0]) / 2, (corner1[1] + corner2[1]) / 2, corner1[2]));
    for (i = 0; i < bwide; i++)
    {
        for (j = 0; j < length; j++)
        {
            crate = spawnCrate(corner1 + vecscale((A[0], 0, 0), i) + vecscale((0, A[1], 0), j), (0, 0, 0), invisible, death);
            //crate enableLinkTo();
            //crate linkTo(center);
            crate willNeverChange();
        }
    }
    //return center;
}

createElevator(enter, exit)
{
    flag = Spawn("script_model", enter);
    flag setModel(getAlliesFlagModel(level._mapname));
    flag2 = Spawn("script_model", exit);
    flag2 setModel(getAxisFlagModel(level._mapname));
    //trigger = spawn("trigger_radius", flag.origin + (0, 0, 50), 0, 50, 50);
    //trigger.code_classname = "trigger_teleport";
    //trigger.endPos = exit;

    level thread watchElevator(enter, exit);
}

watchElevator(enter, exit)
{
    level endon("game_ended");

    while(true)
    {
        foreach (player in level.players)
        {
            if (player.isAlive && distanceSquared(player.origin, enter) <= 2500)
            {
                player setOrigin(exit);
            }
        }
        wait(.2);
    }
}

realElevator(start, angle, end, drop)
{
    elevator = spawnCrate(start, angle, false, false);
    elevator.startPos = start;
    elevator.endPos = end;
    elevator.dropPos = drop;
    elevator.isMoving = false;
    elevator addUsable("elevator", 50);
}
createZipline(start, angle, cost, pos1, pos2, pos3, pos4, pos5)
{
    if (!level.isHellMap)
    {
        level waittill("power_activated");
        wait(6);
    }

    zipline = spawnCrate(start, angle, false, false);
    zipline.startPos = start;
    zipline.path = [];
    zipline.path[zipline.path.size] = pos1;
    if (isDefined(pos2))
        zipline.path[zipline.path.size] = pos2;
    if (isDefined(pos3))
        zipline.path[zipline.path.size] = pos3;
    if (isDefined(pos4))
        zipline.path[zipline.path.size] = pos4;
    if (isDefined(pos5))
        zipline.path[zipline.path.size] = pos5;

    zipline.isMoving = false;
    zipline.cost = cost;
    zipline addUsable("zipline", 50);
}

spawnModel(origin, angles, model)
{
    ent = Spawn("script_model", origin);
    ent setModel(model);
    ent.angles = angles;

    ent checkModelForAnim();
    //return ent;
}
checkModelForAnim()
{
    modelName = self.Model;

    if (isSubStr(modelName, "plastic_fence"))
    {
        PreCacheMpAnim(modelName + "_med_01");
        self scriptModelPlayAnim(modelName + "_med_01");
    }
    else if (isSubStr(modelName, "fence_tarp"))
    {
        if (modelName != "fence_tarp_134x76")
        {
            PreCacheMpAnim(modelName + "_med_01");
            self scriptModelPlayAnim(modelName + "_med_01");
        }
        else if (modelName == "fence_tarp_134x76")
        {
            PreCacheMpAnim(modelName + "_med_02");
            self scriptModelPlayAnim(modelName + "_med_02");
        }
    }
    else if (isSubStr(modelName, "oil_pump_jack"))
    {
        PreCacheMpAnim("oilpump_pump01");
        self scriptModelPlayAnim("oilpump_pump01");
    }
    else if (isSubStr(modelName, "machinery_windmill"))
    {
        PreCacheMpAnim("windmill_spin_med");
        self scriptModelPlayAnim("windmill_spin_med");
    }
    else if (modelName == "foliage_tree_palm_bushy_1")
    {
        preCacheMpAnim("palmtree_mp_bushy1_sway");
        self scriptModelPlayAnim("palmtree_mp_bushy1_sway");
        self setContents(1);
    }
    else if (modelName == "foliage_pacific_fern01_animated")
    {
        preCacheMpAnim("foliage_pacific_fern01_sway");
        self scriptModelPlayAnim("foliage_pacific_fern01_sway");
        self setContents(1);
    }
}

spawnCrate(origin, angles, invisible, death)
{
    ent = spawn("script_model", origin);
    if (!invisible && !death) ent setModel("com_plasticcase_friendly");
    ent.angles = angles;
    if (!death)
    {
        if (level._mapname == "dc_whitehouse" && level.mapVariation == 1)
            return ent;

        ent cloneBrushModelToScriptModel(level.airDropCrateCollision);
        ent setContents(1);
        //ent solid();
    }
    return ent;
}

monitorFallDeath(height)
{
    level endon ("game_ended");

    level waittill("connected");

    while(true)
    {
        foreach (player in level.players)
        {
            if (isDefined(player.isAlive) && player.isAlive && !player.notTargetable)
            {
                if (player.origin[2] < height)
                    player suicide();
            }
        }
        wait(0.2);
    }
}
//-END STRUCTURE CREATORS-//

//-START USE LOGIC-//
useBox(box)
{
    currentWeapon = self getCurrentWeapon();
    if (self.SessionTeam == "axis" || self.isDown || isKillstreakWeapon(currentWeapon) || isWeaponDeathMachine(currentWeapon) || isSubStr(currentWeapon, "marker") || currentWeapon == "none") return;
    if (self isSwitchingWeapon()) return;
    //boxPlayer = box.player;
    if (box.state == "waiting" && box.player == self)
    {
        boxWeapon = box.weapon;
        name = level.weaponNames[boxWeapon];

        if (isRayGun(name))
        {
            box playSound("copycat_steal_class");
            level.currentRayguns++;
        }

        if (isRayGun(currentWeapon))
            level.currentRayguns--;

        if (!self hasWeapon(name) && !self.newGunReady)
        {
            self updatePlayerWeaponsList(currentWeapon, true);
            self takeWeapon(currentWeapon);
            if (currentWeapon == "h2_rpg_mp" && self.rpgUpgraded)
                self.rpgUpgraded = false;
        }

        self loadweapons(name);
        self giveWeapon(name);
        self giveMaxAmmo(name);
        if (name == "h1_galil_mp")
        {
            self setWeaponAmmoClip("h1_galil_mp", 35);
            self setWeaponAmmoStock("h1_galil_mp", 180);
            self.galilAmmo = 210;
            self.galilClip = 35;
        }

        self switchToWeapon(name);
        self updatePlayerWeaponsList(name);
        self.newGunReady = false;

        self playLocalSound("ammo_crate_use");
        weaponEnt = box.weaponEnt;
        //weaponEnt hide();
        weaponEnt setModel("wpn_h2_usp_vm");
        weaponEnt hidePart("tag_knife");
        weaponEnt moveTo(box.origin + (0, 0, 20), 1, 0.3, 0.6);
        box.destroyed = true;
        box.state = "post_pickup";

        box notify("weapon_taken");

        wait(2);
        box.state = "idle";
        return;
    }

    if (box.state != "idle") return;

    if (self.cash < 950)
    {
        self iPrintLn(level.gameStrings[241]);
        return;
    }

    if (box.state == "idle")
    {
        self.cash -= 950;
        self thread scorePopup(-950);
        self thread textPopup(level.gameStrings[242]);
    }
    box.state = "inuse";
    self playLocalSound("achieve_bomb");
    weapon = box.weaponEnt;
    //weapon.origin = box.origin;
    //weapon show();
    weapon setModel(level.weaponModels[0]);
    //weapon.angles = angles;
    weapon rotateTo(box.angles, 1, 0, .5);
    box.destroyed = false;
    weapon.boxCounter = 0;
    weapon.boxIndex = 0;

    weapon moveTo(box.origin + (0, 0, 40), 3, 0, 0.5);

    weapon thread box_rollWeapon();

    wait(5.5);

    if (level.boxLocations.size > 1)//Fix box getting bear with 1 location available
    {
        isBear = randomInt(level.boxMaxUses) == level.boxMaxUses - 1;//Random number is max
        if (isBear && level.boxMaxUses < 13)
        {
            weapon.angles -= (0, 90, 0);
            box thread moveWeaponBox(weapon);
            //give player back their 'hard earned' moo-lah
            self.cash += 950;
            self thread scorePopup(950);
            return;
        }
        else level.boxMaxUses--;
    }

    if (isRayGun(level.weaponNames[weapon.boxIndex]) && (level.currentRayguns >= level.maxRayguns || self hasRayGun()))
    {
        weapon.boxIndex = randomInt(level.weaponModels.size);
        weapon setModel(level.weaponModels[weapon.boxIndex]);
    }

    if (self hasWeapon(level.weaponNames[weapon.boxIndex]) || self hasUpgradedWeapon(getWeaponUpgrade(level.weaponNames[weapon.boxIndex])))//Just reroll
    {
        weapon.boxIndex = randomInt(level.weaponModels.size);
        weapon setModel(level.weaponModels[weapon.boxIndex]);
        if (self hasWeapon(level.weaponNames[weapon.boxIndex]) || self hasUpgradedWeapon(getWeaponUpgrade(level.weaponNames[weapon.boxIndex])))//If again, reroll
        {
            weapon.boxIndex = randomInt(level.weaponModels.size);
            weapon setModel(level.weaponModels[weapon.boxIndex]);
        }
    }

    box.state = "waiting";
    box.weapon = weapon.boxIndex;
    weapon setModel(level.weaponModels[weapon.boxIndex]);
    weapon moveTo(box.origin + (0, 0, 20), 10, 0, 1);
    box.player = self;

    if (weaponIsClassic(level.weaponNames[weapon.boxIndex]))
    {
        foreach (player in level.players)
        {
            while (!player loadWeapons(level.weaponNames[weapon.boxIndex]))
                waitframe();
        }

        weapon showAllParts();
        hideTags = getClassicWeaponHideTags(level.weaponNames[weapon.boxIndex]);
        if (isDefined(hideTags))
        {
            foreach (tag in hideTags)
                weapon hidePart(tag);
        }
    }

    box thread box_waitForWeapon(weapon);
}
box_waitForWeapon(weapon)
{
    self endon("weapon_taken");

    wait(11);

    if (self.state != "idle" && distance(weapon.origin, (self.origin + (0, 0, 20))) < 0.1)
    {
        if (!self.destroyed)
        {
            self.weapon = 0;
            self.destroyed = true;
            //weapon hide();
            weapon setModel("wpn_h2_usp_vm");
            weapon hidePart("tag_knife");

            self.state = "idle";
        }
    }
}
box_rollWeapon()
{
    level endon("game_ended");
    self endon("death");

    waitTime = 0.12;

    while (self.boxCounter < 30)
    {
        self.boxIndex = randomInt(level.weaponModels.size);
        self setModel(level.weaponModels[self.boxIndex]);
        if (weaponIsClassic(level.weaponNames[self.boxIndex]))
        {
            hideTags = getClassicWeaponHideTags(level.weaponNames[self.boxIndex]);
            if (isDefined(hideTags))
            {
                foreach (tag in hideTags)
                    self hidePart(tag);
            }
        }
        self.boxCounter++;
        if (self.boxCounter >= 28)
            waitTime = 0.5;
        else if (self.boxCounter >= 24)
            waitTime = 0.3;
        else if (self.boxCounter >= 18)
            waitTime = 0.2;
            
        wait(waitTime);
    }
}

moveWeaponBox(bear)
{
    self notSolid();
    self setContents(0);
    self playSound("mp_last_stand");
    level.usables = array_remove(level.usables, self);
    if (isDefined(self.icon)) self.icon destroy();
    bear moveTo(bear.origin + (0, 0, 60), 3, 1);
    bear setModel(level.teddyModel);
    self.isRotating = true;

    wait(3);

    playFX(level.fx_disappear, bear.origin);
    bear delete();
    self moveTo(self.origin + (0, 0, 80), 5, 3);

    wait(5);

    self.isRotating = undefined;
    PlayFX(level.fx_disappear, self.origin);
    objID = self.objID;
    _objective_delete(objID);
    //_objIDs.Remove(box);//Removing from internal list only to avoid overwrite
    newLoc = randomInt(level.boxLocations.size);
    if (newLoc == self.lastLocation)//Reroll
        newLoc = randomInt(level.boxLocations.size);
        
    self delete();

    level.boxMaxUses = 15;//Reset uses
    wait(1.5);
    randomWeaponCrate(level.boxLocations[newLoc][0], level.boxLocations[newLoc][1], objID, newLoc);
}
usePapBox(box, currentGun)
{
    if (self.sessionTeam != "allies") return;
    currentWeapon = self getCurrentWeapon();
    if (isSubStr(currentWeapon, "killstreak")) return;
    //if (self isSwitchingWeapon()) return;
    //if (currentWeapon == "" || currentWeapon == "none") return;//If we have no gun, no PAP

    if (box.state == "waiting" && isDefined(box.player) && box.player == self)
    {
        gun = box.weaponName;

        self loadweapons(gun);
        self giveWeapon(gun);
        self giveMaxAmmo(gun);
        self switchToWeapon(gun);
        //self.newGunReady = false;

        self updatePlayerWeaponsList(gun);

        if (gun == "h2_rpg_mp")
            self.rpgUpgraded = true;

        if (self.perk4weapon == box.oldWeapon) self.perk4weapon = gun;

        self playLocalSound("oldschool_pickup");
        weaponEnt = box.weaponEnt;
        attachments = box.attachments;
        foreach (a in attachments) 
        {
            a setModel("tag_origin");
            a hide(); 
        }
        weaponEnt setModel("tag_origin");
        weaponEnt hide();
        box notify("weapon_taken");

        wait(1);//Wait a second until being ready again to fix the rapid upgrade bug

        box.destroyed = true;
        box.state = "idle";
        box.player = undefined;
        return;
    }

    if (!level.powerActivated || self.isDown) return;

    if (box.state != "idle") return;
    if (self.cash < 5000) return;
    if (getWeaponUpgrade(currentGun) == "") 
    {
        self iPrintLnBold(level.gameStrings[287]);
        return;//Don't PAP already PAPed guns
    }
    if (currentGun == "h2_rpg_mp" && self.rpgUpgraded)
    {
        self iPrintLnBold(level.gameStrings[287]);
        return;//Don't PAP the RPG again
    }
    if (box.state == "idle")
    {
        self.cash -= 5000;
        self thread scorePopup(-5000);
        self thread textPopup(level.gameStrings[243]);
    }
    box.state = "inuse";
    box.player = self;
    weapon = box.weaponEnt;
    weapon.angles = box.angles;
    weaponModel = getWeaponModel(currentGun);
    weapon show();
    weapon setModel(weaponModel);
    weapon.origin = box.origin + (0, 0, 40);
    upgradeWeapon = getWeaponUpgrade(currentGun);
    box.weaponName = upgradeWeapon;
    box.oldWeapon = currentWeapon;
    self updatePlayerWeaponsList(currentWeapon, true);
    self takeWeapon(currentWeapon);
    //self.newGunReady = true;
    if (self.weaponsList.size != 0)
    {
        nextWeapon = self getNextOwnedWeapon();
        self switchToWeapon(nextWeapon);
    }
    box.destroyed = false;
    self playLocalSound("US_victory_music");

    if (currentGun == "at4_mp")
        self.newGunReady = false;

    wait(1);

    weapon moveTo(box.origin + (0, 0, 10), 2);

    wait(2);

    wep = box.weaponName;
    weapon setModel(getWeaponUpgradeModel(currentGun));

    tag = "tag_origin";
    tagOffset = (0, 0, 0);
    model = "tag_origin";
    tokenizedWeapon = strTok(wep, "_");

    foreach (a in getWeaponAttachments(wep))
    {
        switch (a)
        {
            case "reflex":
                tag = "tag_reflex";
                model = "attach_h2_reflex_vm";
                break;
            case "acog":
                tag = "tag_acog";
                model = "attach_h2_acog_vm";
                break;
            case "akimbo":
                tag = "tag_weapon";
                tagOffset = (6, 5, 2);
                model = weapon.model;
                break;
            case "thermal":
                tag = "tag_thermal_scope";
                model = "attach_h2_thermal_vm";
                break;
            case "sho":
            case "masterkeymwr":
                tag = "tag_shotgun";
                model = "attach_h2_shotgun_vm";
                break;
            case "holo":
                tag = "tag_holo";
                model = "attach_h2_holo_vm";
                break;
            case "glak47":
                tag = "tag_gp25";
                model = "attach_h2_gp25_npc";
                break;
            case "silencerar":
                tag = "tag_silencer1";
                model = "tag_silencer";
                break;
            case "silencersmg":
                tag = "tag_silencer1";
                model = "tag_silencer";
                break;
            case "silencerlmg":
                tag = "tag_silencer1";
                model = "tag_silencer";
                break;
            case "silencersniper":
                tag = "tag_silencer1";
                model = "tag_silencer";
                break;
            case "silencerpistol":
                tag = "tag_silencer1";
                model = "tag_silencer";
                break;
            case "silencershotgun":
                tag = "tag_silencer1";
                model = "tag_silencer";
                break;
            case "mars":
                tag = "tag_tavor_scope";
                model = "attach_h2_mars_npc";
                break;
            case "f2000scope":
                tag = "tag_fn2000_scope";
                model = "attach_h2_f2000_scope_vm";
                break;
        }

        tagOrigin = weapon getTagOrigin(tag);
        tagAngles = weapon getTagAngles(tag);
        attachEnts = box.attachments;

        if (attachEnts[0].model == "tag_origin")
        {
            attachEnts[0] show();
            attachEnts[0] unlink();
            attachEnts[0].angles = tagAngles;
            attachEnts[0] setModel(model);
            attachEnts[0].origin = tagOrigin + tagOffset;
            attachEnts[0] linkTo(weapon, tag, tagOffset, (0, 0, 0));
        }
        else
        {
            attachEnts[1] show();
            attachEnts[1] unlink();
            attachEnts[1].angles = tagAngles;
            attachEnts[1] setModel(model);
            attachEnts[1].origin = tagOrigin + tagOffset;
            attachEnts[1] linkTo(weapon, tag, tagOffset, (0, 0, 0));
        }
    }

    weapon moveTo(box.origin + (0, 0, 60), 2);
    wait(2);

    box.state = "waiting";
    weapon moveTo(box.origin + (0, 0, 25), 10);

    box thread pap_waitForWeapon(self);
}
pap_waitForWeapon(player)
{
    self endon("weapon_taken");

    wait(10.5);

    if (!self.destroyed)
    {
        foreach (a in self.attachments)
        {
            a setModel("tag_origin");
            a hide();
        }
        self.weaponEnt setModel("tag_origin");
        self.weaponEnt hide();
        self.state = "idle";
        self.destroyed = true;
        self.player = undefined;
        player.newGunReady = true;
    }
}

useGambler(box)
{
    if (self.sessionTeam != "allies") return;
    if (box.gamblerInUse)
    {
        self iPrintLn(level.gameStrings[244]);
        return;
    }
    if (!self.gamblerReady && !box.gamblerInUse)
    {
        self iPrintLnBold(level.gameStrings[245]);
        return;
    }
    if (self.cash >= 1000)
    {
        self.cash -= 1000;
        self thread scorePopup(-1000);
        self thread textPopup(level.gameStrings[246]);
        box.gamblerInUse = true;
        self.gamblerReady = false;
        //level notify("use_gambler");
        self iPrintLnBold(level.gameStrings[248]);
        self thread gamblerCountdown();
        box.laptop thread moveGamblerLaptop(box);
        self thread gamblerRoll(box);
    }
}

moveGamblerLaptop(box)
{
    self moveTo(box.origin + (0, 0, 38), 4);

    wait(8.5);

    self moveTo(box.origin + (0, 0, 22), 4);
}

gamblerRoll(box)
{
    wait(12.5);

    box.gamblerInUse = false;
    if (!self.isAlive) return;
    switch (randomInt(22))
    {
        case 0:
            //Extra weapon
            self giveWeapon("defaultweapon_mp");
            self updatePlayerWeaponsList("defaultweapon_mp");
            self thread switchToWeapon_delay("defaultweapon_mp", 0.1);
            self iPrintLnBold(level.gameStrings[249], "an extra weapon slot");
            
            break;
        case 1:
            //500 points
            self.cash += 500;
            self thread scorePopup(500);
            self iPrintLnBold(level.gameStrings[249], "500 points");
            
            //self playFX(level.fx_money, self.origin);
            break;
        case 2:
            //1000 points
            self.cash += 1000;
            self thread scorePopup(1000);
            self iPrintLnBold(level.gameStrings[249], "1000 points");
            
            //self playFX(level.fx_money, self.origin);
            break;
        case 3:
            //1500 points
            self.cash += 1500;
            self thread scorePopup(1500);
            self iPrintLnBold(level.gameStrings[249], "1500 points");
            
            //self playFX(level.fx_money, self.origin);
            break;
        case 4:
            //2000 points
            self.cash += 2000;
            self thread scorePopup(2000);
            self iPrintLnBold(level.gameStrings[249], "2000 points");
            
            //self playFX(level.fx_money, self.origin);
            break;
        case 5:
            //5000 points
            self.cash += 5000;
            self thread scorePopup(5000);
            self iPrintLnBold(level.gameStrings[249], "5000 points");
            
            //self playFX(level.fx_money, self.origin);
            break;
        case 6:
            //7500 points
            self.cash += 7500;
            self thread scorePopup(7500);
            self iPrintLnBold(level.gameStrings[249], "7500 points");
            
            //self playFX(level.fx_money, self.origin);
            break;
        case 7:
            //10000 points
            self.cash += 10000;
            self thread scorePopup(10000);
            self iPrintLnBold(level.gameStrings[249], "10000 points");
            
            //self playFX(level.fx_money, self.origin);
            break;
        case 8:
            //lose 500
            self.cash -= 500;
            if (self.cash < 0)
                self.cash = 0;
            self thread scorePopup(-500);
            self iPrintLnBold(level.gameStrings[250], "500 points");
            
            break;
        case 9:
            //lose all perks
            if (!isDefined(self.allPerks))
            {
                if (self.perksBought[0])
                {
                    self.maxHealth = level.maxPlayerHealth;
                    self.health = level.maxPlayerHealth;
                    self.perksBought[0] = false;
                }
                if (self.perksBought[1])
                {
                    self _unSetPerk("specialty_lightweight");
                    //self _unSetPerk("specialty_marathon");
                    self _unSetPerk("specialty_longersprint");
                    self.perksBought[1] = false;
                }
                if (self.perksBought[2])
                {
                    self _unSetPerk("specialty_fastreload");
                    //self _unSetPerk("specialty_quickswap");
                    self _unSetPerk("specialty_quickdraw");
                    self.perksBought[2] = false;
                }
                if (self.perksBought[3])
                {
                    self.ammoMatic = false;
                    self.perksBought[3] = false;
                }
                if (self.perksBought[4])
                {
                    self _unSetPerk("specialty_bulletdamage");
                    self.perksBought[4] = false;
                }
                if (self.perksBought[5])
                {
                    self _unSetPerk("specialty_bulletaccuracy");
                    self.perksBought[5] = false;
                }
                if (self.perksBought[6] > 0)
                    self.autoRevive = false;
                if (self.perksBought[7])
                {
                    self.hasDoublePoints = false;
                    self.perksBought[7] = false;
                }

                self updatePerksHud(true, true);
                self.totalPerkCount = 0;
            }
            self iPrintLnBold(level.gameStrings[250], "all of your perks");
            break;
        case 10:
            //lose all perks and 200 points
            self.cash -= 200;
            if (self.cash < 0)
                self.cash = 0;
            self thread scorePopup(-200);

            if (!isDefined(self.allPerks))
            {
                if (self.perksBought[0])
                {
                    self.maxHealth = level.maxPlayerHealth;
                    self.health = level.maxPlayerHealth;
                    self.perksBought[0] = false;
                }
                if (self.perksBought[1])
                {
                    self _unSetPerk("specialty_lightweight");
                    //self _unSetPerk("specialty_marathon");
                    self _unSetPerk("specialty_longersprint");
                    self.perksBought[1] = false;
                }
                if (self.perksBought[2])
                {
                    self _unSetPerk("specialty_fastreload");
                    //self _unSetPerk("specialty_quickswap");
                    self _unSetPerk("specialty_quickdraw");
                    self.perksBought[2] = false;
                }
                if (self.perksBought[3])
                {
                    self.ammoMatic = false;
                    self.perksBought[3] = false;
                }
                if (self.perksBought[4])
                {
                    self _unSetPerk("specialty_bulletdamage");
                    self.perksBought[4] = false;
                }
                if (self.perksBought[5])
                {
                    self _unSetPerk("specialty_bulletaccuracy");
                    self.perksBought[5] = false;
                }
                if (self.perksBought[6] > 0)
                    self.autoRevive = false;
                if (self.perksBought[7])
                {
                    self.hasDoublePoints = false;
                    self.perksBought[7] = false;
                }

                self updatePerksHud(true, true);
                self.totalPerkCount = 0;
            }
            self iPrintLnBold(level.gameStrings[250], "all of your perks and 200 points");
            break;
        case 11:
            //double health
            self iPrintLnBold(level.gameStrings[251]);
            self thread setTempHealth(self.health * 2, 30, level.gameStrings[252]);
            
            break;
        case 12:
            //inf health
            self iPrintLnBold(level.gameStrings[253]);
            self thread setTempHealth(999999999, 30, level.gameStrings[254]);
            
            break;
        case 13:
            //model1887
            self iPrintLnBold(level.gameStrings[249], "a Model 1887");

            currentWeapon = self getCurrentWeapon();
            if (isRayGun(currentWeapon))
                level.currentRayguns--;

            self takeWeapon(currentWeapon);
            self updatePlayerWeaponsList(currentWeapon, true);
            self giveWeapon("h2_model1887_mp");
            self updatePlayerWeaponsList("h2_model1887_mp");
            self thread switchToWeapon_delay("h2_model1887_mp", 0.1);
            
            break;
        case 14:
            //max ammo
            self iPrintLnBold(level.gameStrings[255]);

            if (cointoss())
                self thread gambler_maxAmmo(true);
            else
                self thread gambler_maxAmmo(false);
            
            break;
        case 15:
            //lose 1000
            self.cash -= 1000;
            if (self.cash < 0)
                self.cash = 0;
            self thread scorePopup(-1000);
            self iPrintLnBold(level.gameStrings[250], "1000 points");
            
            break;
        case 16:
            //lose all $
            cash = -self.cash;
            self.cash = 0;
            self thread scorePopup(cash);
            self iPrintLnBold(level.gameStrings[250], "all of your points");
            
            break;
        case 17:
            //live or die
            self iPrintLnBold(level.gameStrings[258]);
            self thread gambler_determineDeath();
            
            break;
        case 18:
            self iPrintLnBold(level.gameStrings[247], "nothing");
            
            break;
        case 19:
            self iPrintLnBold(level.gameStrings[249], "an extra free perk");
            self thread user_scripts\mp\aizombies\_aiz_bonus_drops::giveRandomPerk();
            
            break;
        case 20:
            self iPrintLnBold(level.gameStrings[250], "your current weapon");
            if (aiz_mayDropWeapon(self getCurrentWeapon()) && self.weaponsList.size > 1)
            {
                self updatePlayerWeaponsList(self getCurrentWeapon(), true);
                if (isRayGun(self getCurrentWeapon())) level.currentRayguns--;
                self takeWeapon(self getCurrentWeapon());
                self thread switchToWeapon_delay(self.weaponsList[0], 0.4);
                self.newGunReady = true;
            }
            
            break;
        case 21:
            self iPrintLnBold(level.gameStrings[249], "a random killstreak");
            randomStreak = randomInt(12);
            if (randomStreak == 0)
                randomStreak = 1;
            self user_scripts\mp\aizombies\_aiz_killstreaks::giveRandomKillstreak(1, false);
            break;
        default:
            self iPrintLnBold(level.gameStrings[247], "nothing");
            
            break;
    }
}

gambler_maxAmmo(success)
{
    self endon("death");
    level endon("game_ended");

    wait(2);

    if (success)
    {
        self z_giveMaxAmmo();
        self iPrintLnBold(level.gameStrings[256]);
    }
    else
        self iPrintLnBold(level.gameStrings[257]);
}

gambler_determineDeath()
{
    level endon("game_ended");
    self endon("death");

    wait(1.5);
    self iPrintLnBold("^24");
    wait(1);
    self iPrintLnBold("^23");
    wait(1);
    self iPrintLnBold("^22");
    wait(1);
    self iPrintLnBold("^21");
    wait(1);
    roll = randomInt(4);
    switch (roll)
    {
        case 2:
            self _suicide();
            break;
        default:
            self iPrintLnBold(level.gameStrings[259]);
            break;
    }
}

gamblerCountdown()
{
    level endon("game_ended");
    self endon("death");

    wait(1.5);
    self iPrintLnBold("^210");
    wait(1);
    self iPrintLnBold("^29");
    wait(1);
    self iPrintLnBold("^28");
    wait(1);
    self iPrintLnBold("^27");
    wait(1);
    self iPrintLnBold("^26");
    wait(1);
    self iPrintLnBold("^25");
    wait(1);
    self iPrintLnBold("^24");
    wait(1);
    self iPrintLnBold("^23");
    wait(1);
    self iPrintLnBold("^22");
    wait(1);
    self iPrintLnBold("^21");
}

useAmmo(box)
{
    if (self.sessionTeam != "allies") return;
    cost = 4500 + self.ammoCostAddition;
    if (self.cash < cost)
    {
        self iPrintLn(level.gameStrings[260], cost);
        return;
    }
    else
    {
        self.cash -= cost;
        self thread scorePopup(-cost);
        self thread textPopup(level.gameStrings[261]);
        if (level.ammoIncrease != 0)
        {
            if (self.ammoCostAddition == 0) self.ammoCostAddition = 500;
            else self.ammoCostAddition *= 2;
        }
        self z_giveMaxAmmo();
        self playLocalSound("ammo_crate_use");
    }

    wait(1);//Wait a second to allow using after a delay
}

useKillstreak(box)
{
    if (!level.powerActivated) return;
    if (self.SessionTeam != "allies") return;
    if (!isDefined(self.aizHud_created)) return;
    if (self.points < 200) return;
    else
    {
        self updateBonusPoints(-200);
        self thread scorePopup(-200);
        self thread textPopup(level.gameStrings[262]);
        self user_scripts\mp\aizombies\_aiz_killstreaks::giveRandomKillstreak(1, true);
    }
}

useElevator(elevator)
{
    if (self.isDown || !self.isAlive || self.cash < 500 || elevator.isMoving) return;
    self.cash -= 500;
    self thread scorePopup(-500);
    self thread textPopup(level.gameStrings[265]);
    elevator.isMoving = true;
    self.notTargetable = true;//Setting this flag to make the user not targeted by bots

    start = elevator.startPos;
    end = elevator.endPos;
    drop = elevator.dropPos;
    self playerLinkTo(elevator, "tag_origin", 0, 180, 180, 180, 180, true);
    elevator moveTo(end, 5);

    wait(5);

    elevator thread elevator_dropOffPlayer(self, start, drop);
}
elevator_dropOffPlayer(player, start, drop)
{
    self moveTo(start, 5);

    if (player.isAlive)
    {
        player unlink();
        player setOrigin(drop);
        player.notTargetable = false;
    }

    wait(5);

    self.isMoving = false;
}
useZipline(zipline)
{
    if (self.isDown || !level.powerActivated || !self.isAlive || self.cash < zipline.cost || zipline.isMoving) return;
    self.cash -= zipline.cost;
    self thread scorePopup(-zipline.cost);
    self thread textPopup(level.gameStrings[297]);
    self.notTargetable = true;//Setting this flag to make the user not targeted by bots
    zipline.isMoving = true;

    start = zipline.startPos;
    path = zipline.path;
    self playerLinkTo(zipline);
    zipline thread zipline_ridePath(self, start, path);
}
zipline_ridePath(player, start, path)
{
    travelTime = 5;
    for (i = 0; i < path.size; i++)
    {
        self moveTo(path[i], travelTime);
        wait(travelTime);
        travelTime = 10;
    }

    if (level._mapname == "estate" || level._mapname == "contingency")
    {
        if (player.isAlive)
        {
            player unlink();
            player setOrigin(path[path.size - 1] + (0, 0, 100));
            player thread zipline_teleportPlayerBack(start + (0, 0, 50));
        }
    }

    self moveTo(start, 5);

    wait(5);

    if (player.isAlive && level._mapname != "estate" && level._mapname != "contingency")
    {
        player unlink();
        player setOrigin(start + (0, 0, 50));
        player.notTargetable = false;
    }

    self.isMoving = false;
}
zipline_teleportPlayerBack(backPos)
{
    timer = newClientHudElem(self);
    timer.parent = level.uiParent;
    timer.children = [];
    timer.elemType = "font";
    timer.font = "hudsmall";
    timer.fontScale = 10;
    timer.hideWhenInMenu = true;
    timer.archived = false;
    timer.alpha = 1;
    timer maps\mp\gametypes\_hud_util::setPoint("BOTTOM CENTER", "BOTTOM CENTER", 0, -150);
    timer setTimer(30);
    timer changeFontScaleOverTime(0.5);
    timer.fontScale = 1.5;

	wait(30);

	if (self.isAlive) self shellShock("frag_grenade_mp", 3);

	wait(2);

	if (self.isAlive)
    {
        self shellShock( "concussion_grenade_mp", 3);

        self setOrigin(backPos);
    }

    timer destroy();

    wait(1);

    self.notTargetable = false;
}

usePerk(box, perk)
{
    if ((!level.powerActivated && perk != 8) || self.isDown) return;
    if (self.sessionTeam != "allies") return;
    if (self.totalPerkCount >= level.perkLimit && level.perkLimit > 0) return;
    if (perk != 7 && self.perksBought[perk-1]) return;
    else if (perk == 7 && (self.perksBought[6] > 2 || self.autoRevive)) return;
    if ((perk != 8 && self.cash < box.cost) || (perk == 8 && self.points < box.cost)) return;

    cost = box.cost;
    name = "";
    icon = "white";
    perks = [];
    switch (perk)
    {
        case 1:
            name = level.gameStrings[169];
            //perks[perks.size] = "specialty_armorvest";
            icon = "em_st_087";
            break;
        case 2:
            name = level.gameStrings[170];
            perks[perks.size] = "specialty_lightweight";
            perks[perks.size] = "specialty_longersprint";
            //perks[perks.size] = "specialty_marathon";
            icon = "em_st_207";
            break;
        case 3:
            name = level.gameStrings[171];
            perks[perks.size] = "specialty_fastreload";
            perks[perks.size] = "specialty_quickdraw";
            //perks[perks.size] = "specialty_quickswap";
            icon = "em_st_208";
            break;
        case 4:
            name = level.gameStrings[172];
            icon = "em_st_039";
            break;
        case 5:
            name = level.gameStrings[173];
            perks[perks.size] = "specialty_bulletdamage";
            icon = "em_st_212";
            break;
        case 6:
            name = level.gameStrings[174];
            perks[perks.size] = "specialty_bulletaccuracy";
            icon = "em_st_218";
            break;
        case 7:
            name = level.gameStrings[175];
            icon = "em_st_221";
            break;
        case 8:
            name = level.gameStrings[176];
            icon = "em_st_214";
            break;
    }
    if (perk == 8)
    {
        self updateBonusPoints(-cost);
    }
    else
    {
        self.cash -= cost;
    }
    self thread scorePopup(-cost);
    self thread textPopup(name);

    foreach (perkName in perks) self givePerk(perkName, false);
    self thread setPerkBlur();

    if (perk == 1)
    {
        self.maxHealth = level.maxPlayerHealth_Jugg;
        self.health = level.maxPlayerHealth_Jugg;
    }
    else if (perk == 4)
        self.ammoMatic = true;
    else if (perk == 7)
        self.autoRevive = true;
    else if (perk == 8)
        self.hasDoublePoints = true;
    if (perk != 7) self.perksBought[perk-1] = true;
    else if (perk == 7) self.perksBought[6]++;

    self.totalPerkCount++;
    self.lastBoughtPerk = icon;
    self playLocalSound("ui_cac_equip_perk");
    self thread showBoughtPerk(name, icon, perk-1);

    self updatePerksHud(false, false);
}
setPerkBlur()
{
    self setBlurForPlayer(10, 0.3);

    wait (0.7);

    self setBlurForPlayer(0, 0.3);
}

usePower(box)
{
    if (self.sessionTeam != "allies") return;
    if (self.cash < 10000) return;
    if (box.bought) return;
    self.cash -= 10000;
    self thread scorePopup(-10000);
    self thread textPopup(level.gameStrings[274]);
    box.bought = true;

    //box cloneBrushModelToScriptModel(undefined);
    box notSolid();
    box setContents(0);
    box moveTo(box.origin + (0, 0, 2000), 5);

    level.EMPTime = 0;
    objID = box.objID;
    _objective_delete(objID);
    box.icon destroy();
    box.icon = undefined;
    level.powerBox = true;
    
    box thread powerBoxActivate(self);
}
powerBoxActivate(player)
{
    level endon("game_ended");

    wait (5);

    level notify("power_activated");

    playFX(level.fx_empBlast, self.origin);

    self removeUsable();

    foreach (p in level.players)
    {
        p playLocalSound("nuke_explosion");
    }
    level.powerActivated = true;
    if (isDefined(level.powerHud))
    {
        thread powerActivateHud();
    }
    player thread powerBoughtHud();
}
powerActivateHud()
{
    level.powerHud fadeOverTime(3);
    level.powerHud.alpha = 0;

    wait(3);

    level.powerHud.glowColor = (0.3, 0.9, 0.3);
    level.powerHud.label = level.gameStrings[275];
    level.powerHud fadeOverTime(2);
    level.powerHud.alpha = 1;

    wait(2);

    level.powerHud changeFontScaleOverTime(0.1);
    level.powerHud.fontScale = 1.25;

    wait(0.1);

    level.powerHud changeFontScaleOverTime(0.1);
    level.powerHud.fontScale = 1;
}

useDoor(door)
{
    if (!self.isAlive) return;
    if (self.SessionTeam == "allies")
    {
        if (door.state != "close") return;
        cost = door.cost;
        if (self.cash < cost) return;
        door.state = "open";
        self.cash -= cost;
        self thread scorePopup(-cost);
        self thread textPopup(level.gameStrings[276]);
        door moveTo(door.open, 1);
        if (isDefined(door.spawn) && isDefined(door.spawnAngles))
        {
            level.botSpawns[level.botSpawns.size] = door.spawn;
            level.botSpawnAngles[level.botSpawnAngles.size] = door.spawnAngles;
        }

        wait (1.1);

        door removeUsable();
    }
}

useWallWeapon(box)
{
    if (self.sessionTeam != "allies") return;

    price = box.price;
    if (self hasWeapon(box.weapon) && box.weapon != "frag_grenade_mp") price /= 2;
    if (self.cash < price) return;
    if (self.isAlive)
    {
        if (!box.bought) box.bought = true;
        self.cash -= price;
        self thread scorePopup(-price);
        weapon = box.weapon;
        if (!self.newGunReady && !self hasWeapon(weapon) && weapon != "frag_grenade_mp")
        {
            if (isRayGun(self getCurrentWeapon()))
                level.currentRayguns--;

            self updatePlayerWeaponsList(self getCurrentWeapon(), true);
            self takeWeapon(self getCurrentWeapon());
        }
        self giveWeapon(weapon);
        self giveMaxAmmo(weapon);
        if (weapon != "frag_grenade_mp") 
        {
            self updatePlayerWeaponsList(weapon);
            self switchToWeapon(weapon);
            self.newGunReady = false;
        }
        self playLocalSound("oldschool_pickup");
        self updateAmmoHud(false);
    }
}
//-END USE LOGIC-//

//-GET TEXTS-//
getUsableText(player)
{
    if (player.sessionTeam != "allies") return [&"NULL_EMPTY"];
    if (level.gameEnded) return [&"NULL_EMPTY"];
    
    switch (self.usableType)
    {
        case "sentryPickup":
            if (self.turret.isBeingCarried || self.turret.owner != player) return [&"NULL_EMPTY"];
            return [level.gameStrings[312]];
        case "revive":
            downed = self.player;
            if (player == downed || (isDefined(self.user) && self.user == player)) return [&"NULL_EMPTY"];
            else if (player.isDown) return [&"NULL_EMPTY"];
            else if (isDefined(self.user)) return [level.gameStrings[299], downed.name];
            else return [level.gameStrings[300], downed.name];
        case "door":
            if (self.state == "close")
                return [level.gameStrings[278], &"NULL_EMPTY", self.cost];
            else return [&"NULL_EMPTY"];
        case "randombox":
            if (self.state == "inuse" || self.state == "post_pickup") return [&"NULL_EMPTY"];
            if (self.state == "waiting")
            {
                if (self.player == player)
                    return [level.gameStrings[279], level.localizedWeaponNames[self.weapon]];
                return [&"NULL_EMPTY"];
            }
            return [level.gameStrings[281]];
        case "pap":
            if (!level.powerActivated) return [level.gameStrings[282]];
            if (self.state == "inuse") return [&"NULL_EMPTY"];
            if (self.state == "waiting")
            {
                if (self.player == player)
                    return [level.gameStrings[283], aiz_getWeaponName(self.weaponName)];
                return [&"NULL_EMPTY"];
            }
            weaponName = aiz_getWeaponName(player getCurrentWeapon());
            if (!isDefined(weaponName))
                weaponName = "^1weapon";
            return [level.gameStrings[284], weaponName];
        case "gambler":
            if (!player.gamblerInUse) return [level.gameStrings[285]];
            else return [&"NULL_EMPTY"];
        case "killstreak":
            if (!level.powerActivated) return [level.gameStrings[282]];
            else return [level.gameStrings[286]];
        case "elevator":
            if (self.isMoving) return [&"NULL_EMPTY"];
            else return [level.gameStrings[291]];
        case "perk1":
            if (!level.powerActivated) return [level.gameStrings[282]];
            if (player.perksBought[0]) return [level.gameStrings[293], level.gameStrings[266]];
            if (player.totalPerkCount >= level.perkLimit && level.perkLimit > 0) return [level.gameStrings[295], &"NULL_EMPTY", level.perkLimit];
            else return [level.gameStrings[27], &"NULL_EMPTY", 2500];
        case "perk2":
            if (!level.powerActivated) return [level.gameStrings[282]];
            if (player.perksBought[1]) return [level.gameStrings[293], level.gameStrings[267]];
            if (player.totalPerkCount >= level.perkLimit && level.perkLimit > 0) return [level.gameStrings[295], &"NULL_EMPTY", level.perkLimit];
            else return [level.gameStrings[28], &"NULL_EMPTY", 2000];
        case "perk3":
            if (!level.powerActivated) return [level.gameStrings[282]];
            if (player.perksBought[2]) return [level.gameStrings[293], level.gameStrings[268]];
            if (player.totalPerkCount >= level.perkLimit && level.perkLimit > 0) return [level.gameStrings[295], &"NULL_EMPTY", level.perkLimit];
            else return [level.gameStrings[29], &"NULL_EMPTY", 3000];
        case "perk4":
            if (!level.powerActivated) return [level.gameStrings[282]];
            if (player.perksBought[3]) return [level.gameStrings[293], level.gameStrings[269]];
            if (player.totalPerkCount >= level.perkLimit && level.perkLimit > 0) return [level.gameStrings[295], &"NULL_EMPTY", level.perkLimit];
            else return [level.gameStrings[30], &"NULL_EMPTY", 6500];
        case "perk5":
            if (!level.powerActivated) return [level.gameStrings[282]];
            if (player.perksBought[4]) return [level.gameStrings[293], level.gameStrings[270]];
            if (player.totalPerkCount >= level.perkLimit && level.perkLimit > 0) return [level.gameStrings[295], &"NULL_EMPTY", level.perkLimit];
            else return [level.gameStrings[31], &"NULL_EMPTY", 2500];
        case "perk6":
            if (!level.powerActivated) return [level.gameStrings[282]];
            if (player.perksBought[5]) return [level.gameStrings[293], level.gameStrings[271]];
            if (player.totalPerkCount >= level.perkLimit && level.perkLimit > 0) return [level.gameStrings[295], &"NULL_EMPTY", level.perkLimit];
            else return [level.gameStrings[32], &"NULL_EMPTY", 2500];
        case "perk7":
            if (!level.powerActivated) return [level.gameStrings[282]];
            if (player.autoRevive) return [level.gameStrings[293], level.gameStrings[272]];
            else if (player.perksBought[6] >= 3) return [level.gameStrings[35]];
            if (player.totalPerkCount >= level.perkLimit && level.perkLimit > 0) return [level.gameStrings[295], &"NULL_EMPTY", level.perkLimit];
            else return [level.gameStrings[33], &"NULL_EMPTY", 2500];
        case "perk8":
            if (player.perksBought[7]) return [level.gameStrings[293], level.gameStrings[273]];
            if (player.totalPerkCount >= level.perkLimit && level.perkLimit > 0) return [level.gameStrings[295], &"NULL_EMPTY", level.perkLimit];
            else return [level.gameStrings[34], &"NULL_EMPTY", 200];
        case "ammo":
            if (self.used) return [&"NULL_EMPTY"];
            else return [level.gameStrings[321], &"NULL_EMPTY", (4500 + player.ammoCostAddition)];
        case "power":
            return [level.gameStrings[296]];
        case "wallweapon":
            if (isDefined(self.script_noteworthy)) return [level.gameStrings[318]];

            weapon = self.weapon;
            //weaponName = getWeaponName(weapon);
            //if (weaponName == &"NULL_EMPTY") weaponName = level.gameStrings[317];
            cost = self.price;

            //if (!player hasWeapon(weapon) && cost != 0) return [&"NULL_EMPTY", "Press ^3[{+activate}] ^7for " + weaponName + " ^7[Cost: " + cost + "]"];
            /*else */if (!player hasWeapon(weapon) || weapon == "frag_grenade_mp"/* && cost == 0*/) return [level.gameStrings[322], &"NULL_EMPTY", cost];
            else return [level.gameStrings[321], &"NULL_EMPTY", (cost/2)];
        case "zipline":
            if (!level.powerActivated) return [level.gameStrings[282]];
            else if (self.isMoving) return [&"NULL_EMPTY"];
            else return [level.gameStrings[318], &"NULL_EMPTY", self.cost];
        default:
            return [&"NULL_EMPTY"];
    }
}
//-END GET TEXTS-//

addUsable(type, range)
{
    self.usabletype = type;
    self.range = (range * range);
    /*
    trigger = spawn("trigger_radius", self.origin, 0, range, range);
    //trigger.code_classname = "trigger_" + type;
    trigger.type = type);
    trigger linkTo(self);
    trigger.parent = self;
    self.trigger = trigger;
    */
    level.usables[level.usables.size] = self;
}

spawnMapEditObject(type, origin, angles, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
{
    if (!isDefined(type) || !isDefined(origin))
        return;

    switch (type)
    {
        case "crate":
            spawnCrate(origin, angles, false, false);
            break;
        case "invisiblecrate":
            spawnCrate(origin, angles, true, false);
            break;
        case "ramp":
            createRamp(origin, angles, false);
            break;
        case "invisibleramp":
            createRamp(origin, angles, true);
            break;
        case "powerramp":
            thread createPowerRamp(origin, angles);
            break;
        case "teleport":
            createElevator(origin, angles);
            break;
        case "door":
            createDoor(origin, angles, arg2, arg3, arg4, arg5, arg6);
            break;
        case "doorandspawn":
            if (!isDefined(arg8))
            {
                createDoor(origin, angles, arg2, arg3, arg4, arg5, arg6);
                break;
            }
            createDoor(origin, angles, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
            break;
        case "wall":
            createWall(origin, angles, false, false);
            break;
        case "invisiblewall":
            createWall(origin, angles, true, false);
            break;
        case "deathwall":
            createWall(origin, angles, true, true);
            break;
        case "randombox":
            level.boxLocations[level.boxLocations.size] = [origin, angles];
            if (isDefined(arg2) && isDefined(arg3))
            {
                level.boxLocations[level.boxLocations.size] = [arg2, arg3];
            }
            if (isDefined(arg4) && isDefined(arg5))
            {
                level.boxLocations[level.boxLocations.size] = [arg4, arg5];
            }
            if (isDefined(arg6) && isDefined(arg7))
            {
                level.boxLocations[level.boxLocations.size] = [arg6, arg7];
            }
            if (isDefined(arg8) && isDefined(arg9))
            {
                level.boxLocations[level.boxLocations.size] = [arg8, arg9];
            }
            randomWeaponCrate(origin, angles);
            break;
        case "pap":
            thread papCrate(origin, angles);
            break;
        case "gambler":
            gamblerCrate(origin, angles);
            break;
        case "floor":
            createFloor(origin, angles, false, false);
            break;
        case "invisiblefloor":
            createFloor(origin, angles, true, false);
            break;
        case "deathfloor":
            createFloor(origin, angles, true, true);
            break;
        case "elevator":
            realElevator(origin, angles, arg2, arg3);
            break;
        case "model":
            spawnModel(angles, arg2, origin);
            break;
        case "perk1":
            thread perkCrate(origin, angles, 1);
            break;
        case "perk2":
            thread perkCrate(origin, angles, 2);
            break;
        case "perk3":
            thread perkCrate(origin, angles, 3);
            break;
        case "perk4":
            thread perkCrate(origin, angles, 4);
            break;
        case "perk5":
            thread perkCrate(origin, angles, 5);
            break;
        case "perk6":
            thread perkCrate(origin, angles, 6);
            break;
        case "perk7":
            thread perkCrate(origin, angles, 7);
            break;
        case "perk8":
            thread perkCrate(origin, angles, 8);
            break;
        case "ammo":
            ammoCrate(origin, angles);
            break;
        case "killstreak":
            thread killstreakCrate(origin, angles);
            break;
        case "power":
            powerCrate(origin, angles);
            break;
        case "spawn":
            level.playerSpawnLocs[level.playerSpawnLocs.size] = origin;
            level.playerSpawnAngles[level.playerSpawnAngles.size] = angles;
            break;
        case "zombiespawn":
            level.botSpawns[level.botSpawns.size] = origin;
            level.botSpawnAngles[level.botSpawnAngles.size] = angles;
            break;
        case "mapname":
            level.zombieMapname = origin;
            break;
        case "hellMap":
            if (origin)
            {
                level.isHellMap = true;
                level.powerActivated = true;
            }
            else 
            {
                level.isHellMap = false;
            }
            break;
        case "maxWave":
            level.totalWaves = origin;
            break;
        case "minefield":
            mine = spawn("trigger_radius", origin, 0, angles, arg2);
            mine.targetname = "minefield";
            break;
        case "radiation":
            rad = spawn("trigger_radius", origin, 0, angles, arg2);
            rad.targetname = "radiation";
            break;
        case "fallLimit":
            level thread monitorFallDeath(origin);
            //Also set zombie death limit here
            level.mapHeight = origin;
            break;
        case "wallweapon":
            wallWeapon(origin, angles, arg2, arg3);
            break;
        case "zipline":
            thread createZipline(origin, angles, arg2, arg3, arg4, arg5, arg6, arg7);
            break;
        default:
            printLn(level.gameStrings[326], type);
            break;
    }
}

cleanLevelEnts()
{
    for (i = 18; i < 2000; i++)
    {
        ent = getEntByNum(i);
        if (!isDefined(ent)) continue;
        entTargetName = ent.targetname;
        if (!isDefined(entTargetName))
            continue;

        entClassName = ent.classname;
        if (!isDefined(entClassName))
            continue;

        if (isSubStr(entTargetName, "killCamEnt_") || 
        (isSubStr(entClassName, "mp_") && isSubStr(entClassName, "_spawn") && !isSubStr(entClassName, "mp_tdm")) ||
        /*isSubStr(entTargetName, "auto") || */isSubStr(entTargetName, "heli_") ||
        entTargetName == "flag_descriptor" ||
        entTargetName == "radiotrigger")
            ent delete();
    }

    wait(0.1);

    for (i = 18; i < 2000; i++)//Second pass to grab additional spawned stuff
    {
        ent = getEntByNum(i);
        if (!isDefined(ent)) continue;
        entTargetName = ent.targetname;
        if (!isDefined(entTargetName))
            continue;

        entClassName = ent.classname;
        if (!isDefined(entClassName))
            continue;

        if (isSubStr(entTargetName, "killCamEnt_") || 
        (isSubStr(entClassName, "mp_") && isSubStr(entClassName, "_spawn") && !isSubStr(entClassName, "mp_tdm")) ||
        /*isSubStr(entTargetName, "auto") || */isSubStr(entTargetName, "heli_") ||
        entTargetName == "flag_descriptor" ||
        entTargetName == "radiotrigger")
            ent delete();
    }
}
getAlliesFlagModel(mapname)
{
    return "h1_flag_mp_domination_usmc_blue";
}
getAxisFlagModel(mapname)
{
    return "h1_flag_mp_domination_usmc_red";
}