#include user_scripts\mp\aizombies\_aiz;
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
    if (getDvarInt("aiz_enabled") == 0)
        return;

    level.powerBox = false;

    level.roundHud = undefined;
    level.zombieCounterHud = undefined;
    //level.infoHud = undefined;
    level.intermissionHud = undefined;
    level.roundStartHud = undefined;
    level.roundEndHud = undefined;
    level.powerHud = undefined;

    level.mapList = [];
    level.mapList[level.mapList.size] = "mp_afghan";
    level.mapList[level.mapList.size] = "mp_boneyard";
    level.mapList[level.mapList.size] = "mp_brecourt";
    level.mapList[level.mapList.size] = "mp_checkpoint";
    level.mapList[level.mapList.size] = "mp_derail";
    level.mapList[level.mapList.size] = "mp_estate";
    level.mapList[level.mapList.size] = "mp_favela";
    level.mapList[level.mapList.size] = "mp_highrise";
    level.mapList[level.mapList.size] = "mp_invasion";
    level.mapList[level.mapList.size] = "mp_nightshift";
    level.mapList[level.mapList.size] = "mp_quarry";
    level.mapList[level.mapList.size] = "mp_rundown";
    level.mapList[level.mapList.size] = "mp_rust";
    level.mapList[level.mapList.size] = "mp_subbase";
    level.mapList[level.mapList.size] = "mp_terminal";
    level.mapList[level.mapList.size] = "mp_underpass";
    level.mapList[level.mapList.size] = "mp_overgrown";
    level.mapList[level.mapList.size] = "mp_trailerpark";
    level.mapList[level.mapList.size] = "mp_compact";
    level.mapList[level.mapList.size] = "mp_strike";
    level.mapList[level.mapList.size] = "mp_complex";
    level.mapList[level.mapList.size] = "mp_abandon";
    level.mapList[level.mapList.size] = "mp_vacant";
    level.mapList[level.mapList.size] = "mp_storm";
    level.mapList[level.mapList.size] = "mp_fuel2";
    //level.mapList[level.mapList.size] = "mp_crash";//Area is not solid
    //level.mapList[level.mapList.size] = "mp_crossfire";//Area is contained in a barrier
    level.mapList[level.mapList.size] = "estate";
    level.mapList[level.mapList.size] = "oilrig";
    level.mapList[level.mapList.size] = "contingency";
    //level.mapList[level.mapList.size] = "airport";//Causes broken triggers
    level.mapList[level.mapList.size] = "cliffhanger";
    level.mapList[level.mapList.size] = "dc_whitehouse";
    level.mapList[level.mapList.size] = "dcburning";
    level.mapList[level.mapList.size] = "boneyard";
    level.mapList[level.mapList.size] = "gulag";
}

createPlayerHud()
{
    if (isDefined(self.aizHud_created)) return;

    //Ammo counters
    ammoStock = self createFontString("hudsmall", 1);
    ammoStock setPoint("BOTTOM RIGHT", "BOTTOM RIGHT", -24, -16);
    ammoStock.hideWhenInMenu = true;
    ammoStock.hideWhenDead = true;
    ammoStock.archived = true;
    ammoStock setValue(0);
    ammoStock.sort = 0;

    ammoClip = self createFontString("hudbig", 1);
    ammoClip setPoint("BOTTOM RIGHT", "BOTTOM RIGHT", -64, -16);
    ammoClip.hideWhenInMenu = true;
    ammoClip.hideWhenDead = true;
    ammoClip.archived = true;
    ammoClip setValue(0);
    ammoClip.sort = 0;

    weaponName = self createFontString("hudsmall", 1);
    weaponName setPoint("BOTTOM RIGHT", "BOTTOM RIGHT", -24, -36);
    weaponName.hideWhenInMenu = true;
    weaponName.hideWhenDead = true;
    weaponName.archived = true;
    weaponName.alpha = 1;
    weaponName.glowColor = (25.5, 25.5, 3.6);
    weaponName.glowAlpha = 0.1;
    weaponName setText("");
    weaponName.sort = 0;
    

    //Set player fields for ammo hud
    self.hud_ammoStock = ammoStock;
    self.hud_ammoClip = ammoClip;
    self.hud_weaponName = weaponName;

    //grenade icon
    frag = self createIcon("hud_us_grenade", 32, 32);
    frag setPoint("BOTTOM RIGHT", "BOTTOM RIGHT", -24, -48);
    frag.hideWhenInMenu = true;
    frag.hideWhenDead = true;
    frag.alpha = 1;
    frag.archived = true;
    self.hud_frag = frag;
    frag.sort = 1;

    //weapon icon
    weaponIcon = self createIcon("white", 40, 40);
    weaponIcon setPoint("BOTTOM RIGHT", "BOTTOM RIGHT", -64, -48);
    weaponIcon.hideWhenInMenu = true;
    weaponIcon.hideWhenDead = true;
    weaponIcon.alpha = 0;
    weaponIcon.archived = false;
    self.hud_weaponIcon = weaponIcon;
    weaponIcon.sort = 1;

    //Perk hud
    jugg = self createIcon("white", 24, 24);
    jugg setPoint("BOTTOM LEFT", "BOTTOM LEFT", 5, -48);
    jugg.hideWhenInMenu = true;
    jugg.hideWhenDead = true;
    jugg.foreground = true;
    jugg.archived = true;
    jugg.alpha = 0;
    jugg.sort = 3;

    stamina = self createIcon("white", 24, 24);
    stamina setParent(jugg);
    stamina setPoint("CENTER RIGHT", "CENTER RIGHT", 32, 0);
    stamina.hideWhenInMenu = true;
    stamina.hideWhenDead = true;
    stamina.foreground = true;
    stamina.archived = true;
    stamina.alpha = 0;
    stamina.sort = 4;

    speed = self createIcon("white", 24, 24);
    speed setParent(jugg);
    speed setPoint("CENTER RIGHT", "CENTER RIGHT", 64, 0);
    speed.hideWhenInMenu = true;
    speed.hideWhenDead = true;
    speed.foreground = true;
    speed.archived = true;
    speed.alpha = 0;
    speed.sort = 5;

    ammomatic = self createIcon("white", 24, 24);
    ammomatic setParent(jugg);
    ammomatic setPoint("CENTER RIGHT", "CENTER RIGHT", 96, 0);
    ammomatic.hideWhenInMenu = true;
    ammomatic.hideWhenDead = true;
    ammomatic.foreground = true;
    ammomatic.archived = true;
    ammomatic.alpha = 0;
    ammomatic.sort = 6;

    damage = self createIcon("white", 24, 24);
    damage setParent(jugg);
    damage setPoint("CENTER RIGHT", "CENTER RIGHT", 128, 0);
    damage.hideWhenInMenu = true;
    damage.hideWhenDead = true;
    damage.foreground = true;
    damage.archived = true;
    damage.alpha = 0;
    damage.sort = 7;

    steadyaim = self createIcon("white", 24, 24);
    steadyaim setParent(jugg);
    steadyaim setPoint("CENTER RIGHT", "CENTER RIGHT", 160, 0);
    steadyaim.hideWhenInMenu = true;
    steadyaim.hideWhenDead = true;
    steadyaim.foreground = true;
    steadyaim.archived = true;
    steadyaim.alpha = 0;
    steadyaim.sort = 8;

    dpoints = self createIcon("white", 24, 24);
    dpoints setParent(jugg);
    dpoints setPoint("CENTER RIGHT", "CENTER RIGHT", 192, 0);
    dpoints.hideWhenInMenu = true;
    dpoints.hideWhenDead = true;
    dpoints.foreground = true;
    dpoints.archived = true;
    dpoints.alpha = 0;
    dpoints.sort = 8;

    laststand = self createIcon("white", 32, 32);
    laststand setPoint("BOTTOM MIDDLE", "BOTTOM MIDDLE", 0, -6);
    laststand.hideWhenInMenu = true;
    laststand.hideWhenDead = true;
    laststand.foreground = true;
    laststand.archived = true;
    laststand.alpha = 0;
    laststand.sort = 9;

    //Score hud
    scoreHud = self createFontString("objective", 1.25);
    scoreHud setPoint("TOP RIGHT", "TOP RIGHT", -5, 5);
    scoreHud.hideWhenInMenu = true;
    scoreHud.foreground = true;
    scoreHud.archived = true;
    scoreHud.alpha = 1;
    scoreHud.color = (1, 1, 1);
    scoreHud.glowColor = (0.3, 0.9, 0.3);
    scoreHud.glowAlpha = 0.25;
    scoreHud.label = level.gameStrings[180];
    scoreHud setValue(self.cash);
    scoreHud.sort = 10;
    scoreHud.isMoving = false;
    scoreHud maps\mp\gametypes\_hud::fontPulseInit(1.5);

    pointHud = self createFontString("objective", 1.25);
    pointHud setPoint("TOP RIGHT", "TOP RIGHT", -5, 20);
    pointHud.hideWhenInMenu = true;
    pointHud.foreground = true;
    pointHud.archived = false;
    pointHud.alpha = 1;
    pointHud.color = (1, 1, 1);
    pointHud.glowColor = (0, 1, 1);
    pointHud.glowAlpha = 0.25;
    pointHud.label = level.gameStrings[181];
    pointHud setValue(self.points);
    pointHud.sort = 10;
    pointHud maps\mp\gametypes\_hud::fontPulseInit(1.5);

    //Score popups
    scorePop = self createFontString("hudbig", 0.73);
    scorePop setPoint("CENTER", "CENTER", 40, -40);
    scorePop.hideWhenInMenu = true;
    scorePop.archived = false;
    scorePop.alpha = 1;
    scorePop.color = (0.5, 0.5, 0.5);
    scorePop.addScore = 0;
    scorePop.sort = 15;
    scorePop maps\mp\gametypes\_hud::fontPulseInit(0.9);

    //Streak
    killstreakSlot = self createFontString("hudsmall", 1);
    killstreakSlot setPoint("BOTTOM CENTER", "BOTTOM CENTER", 75, -5);
    killstreakSlot.hideWhenInMenu = true;
    killstreakSlot.hideWhenDead = true;
    killstreakSlot.archived = false;
    killstreakSlot.alpha = 0;
    killstreakSlot.label = &"[{+actionslot 4}]  ";
    killstreakSlot setShader("white", 24, 24);
    killstreakSlot.sort = 16;

    self.hasMessageUp = false;

    //Finish out player fields
    self.hud_perks = [];
    self.hud_perks[0] = jugg;
    self.hud_perks[1] = stamina;
    self.hud_perks[2] = speed;
    self.hud_perks[3] = ammomatic;
    self.hud_perks[4] = damage;
    self.hud_perks[5] = steadyaim;
    self.hud_perks[6] = laststand;
    self.hud_perks[7] = dpoints;
    self.hud_scorePop = scorePop;
    self.hud_score = scoreHud;
    self.hud_point = pointHud;
    self.hud_killstreakSlot = killstreakSlot;
    self.aizHud_created = true;
}

createServerHud()
{
    round = newHudElem();
    round.elemType = "font";
	round.font = "objective";
	round.fontscale = 1.5;
	round.baseFontScale = 1.5;
	round.x = 5;
	round.y = -5;
	round.width = 0;
	round.height = 24;
	round.xOffset = 0;
	round.yOffset = 0;
	round.children = [];
	round.parent = level.uiParent;
	round.hidden = false;
    //round setPoint("BOTTOM LEFT", "BOTTOM LEFT", 10, -5);
    round.alignX = "left";
    round.alignY = "bottom";
    round.horzAlign = "left_adjustable";
    round.vertAlign = "bottom_adjustable";
    round.hideWhenInMenu = false;
    round.archived = false;
    round.color = (1, 0.5, 0.2);
    round.label = level.gameStrings[20];
    round setValue(level.wave);
    round.sort = 13;
    round.lowResBackground = false;
    level.roundHud = round;

    zombieCounter = newHudElem();
    zombieCounter.elemType = "font";
	zombieCounter.font = "objective";
	zombieCounter.fontscale = 1.5;
	zombieCounter.baseFontScale = 1.5;
	zombieCounter.x = 5;
	zombieCounter.y = -20;
	zombieCounter.width = 0;
	zombieCounter.height = 16;
	zombieCounter.xOffset = 0;
	zombieCounter.yOffset = 0;
	zombieCounter.children = [];
	zombieCounter.parent = level.uiParent;
	zombieCounter.hidden = false;
    //zombieCounter setPoint("BOTTOM LEFT", "BOTTOM LEFT", 80, -15);
    zombieCounter.alignX = "left";
    zombieCounter.alignY = "bottom";
    zombieCounter.horzAlign = "left_adjustable";
    zombieCounter.vertAlign = "bottom_adjustable";
    zombieCounter.hideWhenInMenu = false;
    zombieCounter.archived = false;
    zombieCounter.color = (1, 0.5, 0.2);
    zombieCounter.alpha = 1;
    zombieCounter.label = level.gameStrings[182];
    zombieCounter setValue(0);
    zombieCounter.sort = 14;
    level.zombieCounterHud = zombieCounter;
    level thread watchZombieCounter();

    while (!isDefined(level.isHellMap))
    {
        wait(0.05);
    }

    if (!level.isHellMap)
    {
        powerHud = newHudElem();
        if (!isDefined(powerHud))
            return;
        powerHud.elemType = "font";
        powerHud.font = "hudsmall";
        powerHud.fontscale = 1;
        powerHud.baseFontScale = 1;
        powerHud.x = -5;
        powerHud.y = 35;
        powerHud.width = 0;
        powerHud.height = 12;
        powerHud.xOffset = 0;
        powerHud.yOffset = 0;
        powerHud.children = [];
        powerHud.parent = level.uiParent;
        powerHud.hidden = false;
        //powerHud setPoint("TOP RIGHT", "TOP RIGHT", 0, 30);
        powerHud.alignX = "right";
        powerHud.alignY = "top";
        powerHud.horzAlign = "right_adjustable";
        powerHud.vertAlign = "top_adjustable";
        powerHud.hideWhenInMenu = true;
        powerHud.foreground = true;
        powerHud.archived = false;
        powerHud.alpha = 1;
        powerHud.color = (1, 1, 1);
        powerHud.glowColor = (1, 0.5, 0.3);
        powerHud.glowAlpha = 0.25;
        powerHud.label = level.gameStrings[183];
        powerHud.sort = 12;
        level.powerHud = powerHud;
    }
}

watchZombieCounter()
{
    level endon("game_ended");

    while (true)
    {
        level waittill_any("bot_spawned", "bot_death");

        updateZombieCounter();
    }
}
updateZombieCounter()
{
    level.zombieCounterHud setValue(level.botsInPlay.size);
}

onRoundChange()
{
    foreach (player in level.players)
    {
        if (!player.isAlive || !isDefined(player.isDown)) continue;
        player.gamblerReady = 1;
        player giveMaxAmmo("h1_fraggrenade_mp");
        player updateAmmoHud(false);
    }

    wait(1);

    level thread roundStartHud();
    level.roundHud.label = level.gameStrings[20];
    level.roundHud setValue(level.wave);
    level.roundHud.color = (1, 0.5, 0.2);
    level.zombieCounterHud.color = (1, 0.5, 0.2);
}

destroyPlayerHud()
{
    if (!isDefined(self.aizHud_created)) return;
    aizHUDs = [];
    aizHUDs[aizHUDs.size] = self.hud_ammoStock;
    aizHUDs[aizHUDs.size] = self.hud_ammoClip;
    aizHUDs[aizHUDs.size] = self.hud_perks[0];
    aizHUDs[aizHUDs.size] = self.hud_perks[1];
    aizHUDs[aizHUDs.size] = self.hud_perks[2];
    aizHUDs[aizHUDs.size] = self.hud_perks[3];
    aizHUDs[aizHUDs.size] = self.hud_perks[4];
    aizHUDs[aizHUDs.size] = self.hud_perks[5];
    aizHUDs[aizHUDs.size] = self.hud_perks[6];
    aizHUDs[aizHUDs.size] = self.hud_perks[7];
    aizHUDs[aizHUDs.size] = self.hud_score;
    aizHUDs[aizHUDs.size] = self.hud_scorePop;
    aizHUDs[aizHUDs.size] = self.hud_point;
    aizHUDs[aizHUDs.size] = self.hud_weaponName;
    aizHUDs[aizHUDs.size] = self.hud_weaponIcon;
    aizHUDs[aizHUDs.size] = self.hud_frag;
    aizHUDs[aizHUDs.size] = self.hud_killstreakSlot;

    foreach (hud in aizHUDs)
    {
        //hud reset();
        if (!isDefined(hud)) continue;
        hud destroy();
    }
    if (isDefined(self.hud_ammoClipAkimbo))
    {
        self.hud_ammoClipAkimbo destroy();
        self.hud_ammoClipAkimbo = undefined;
    }

    self.hud_ammoStock = undefined;
    self.hud_ammoClip = undefined;
    self.hud_perks = [];
    self.hud_perks[0] = undefined;
    self.hud_perks[1] = undefined;
    self.hud_perks[2] = undefined;
    self.hud_perks[3] = undefined;
    self.hud_perks[4] = undefined;
    self.hud_perks[5] = undefined;
    self.hud_perks[6] = undefined;
    self.hud_perks[7] = undefined;
    self.hud_scorePop = undefined;
    self.hud_score = undefined;
    self.hud_point = undefined;
    self.hud_weaponName = undefined;
    self.hud_weaponIcon = undefined;
    self.hud_frag = undefined;
    self.hud_killstreakSlot = undefined;
    self.aizHud_created = undefined;
}
destroyGameHud()
{
	// free up some hud elems so we have enough for other things.
	self notify("perks_hidden"); // stop any threads that are waiting to hide the perk icons
	
	// progress bar
	if (isDefined(self.proxBar))
		self.proxBar destroy();
	if (isDefined(self.proxBarText))
		self.proxBarText destroy();
    //XP popups
    if (isDefined(self.hud_xpPointsPopup))
        self.hud_xpPointsPopup destroy();
    if (isDefined(self.hud_xpEventPopup))
        self.hud_xpEventPopup destroy();
}

updateAmmoHud(updateName, newWeapon)
{
    if (!isDefined(self.aizHud_created) || (isDefined(self.aizHud_created) && !self.aizHud_created))
        return;

    ammoStock = self.hud_ammoStock;
    ammoClip = self.hud_ammoClip;
    weapon = self getCurrentWeapon();
    if (isDefined(newWeapon)) weapon = newWeapon;

    if (self getWeaponAmmoClip("h1_fraggrenade_mp") > 0)
        self.hud_frag.alpha = 1;
    else self.hud_frag.alpha = 0;

    if (isSpecialWeapon(weapon) || isWeaponDeathMachine(weapon))
    {
        ammoStock.alpha = 0;
        ammoClip.alpha = 0;
        if (isDefined(self.hud_ammoClipAkimbo))
        {
            self.hud_ammoClipAkimbo destroy();
            self.hud_ammoClipAkimbo = undefined;
        }
    }
    else
    {
        ammoInClip = self getWeaponAmmoClip(weapon);
        ammoInStock = self getWeaponAmmoStock(weapon);
        if (weapon == "h1_galil_mp")
            ammoInStock = self.galilAmmo;

        ammoStock setValue(ammoInStock);
        ammoClip setValue(ammoInClip);

        ammoStock.alpha = 1;
        ammoClip.alpha = 1;

        if(ammoInClip <= 5)
		{
			ammoClip.color = (1, 0, 0);
			ammoClip.glowColor = (0.9, 0.3, 0.3);
			ammoClip.glowAlpha = 0.3;
		}
		else if(ammoInClip <= 10)
		{
			ammoClip.color = (1, 1, 0);
			ammoClip.glowColor = (0.9, 0.9, 0.3);
			ammoClip.glowAlpha = 0.3;
		}
		else
		{
			ammoClip.color = (0, 1, 0);
			ammoClip.glowColor = (0.3 ,0.9 ,0.3);
			ammoClip.glowAlpha = 0.3;
		}

        if(ammoInStock <= 5)
		{
			ammoStock.color = (1,0,0);
			ammoStock.glowColor = (0.9, 0.3, 0.3);
			ammoStock.glowAlpha = 0.3;
		}
		else if(ammoInStock <= 10)
		{
			ammoStock.color = (1,1,0);
			ammoStock.glowColor = (0.9, 0.9, 0.3);
			ammoStock.glowAlpha = 0.3;
		}
		else
		{
			ammoStock.color = (0,1,0);
			ammoStock.glowColor = (0.3, 0.9, 0.3);
			ammoStock.glowAlpha = 0.3;
		}

        if (weaponIsAkimbo(weapon))
        {
            leftAmmo = self getWeaponAmmoClip(weapon, "left");
            if (!isDefined(self.hud_ammoClipAkimbo))
            {
                ammoClipAkimbo = self createFontString("hudbig", 1);
                ammoClipAkimbo setPoint("BOTTOM RIGHT", "BOTTOM RIGHT", -96, -16);
                ammoClipAkimbo.hideWhenInMenu = true;
                ammoClipAkimbo.hideWhenDead = true;
                ammoClipAkimbo.archived = false;
                ammoClipAkimbo.label = &"&&1|";
                ammoClipAkimbo setValue(leftAmmo);
                ammoClipAkimbo.sort = 0;
                ammoClipAkimbo.alpha = 1;
                self.hud_ammoClipAkimbo = ammoClipAkimbo;
            }

            self.hud_ammoClipAkimbo setValue(leftAmmo);

            if(ammoInClip <= 5)
            {
                self.hud_ammoClipAkimbo.color = (1, 0, 0);
                self.hud_ammoClipAkimbo.glowColor = (0.9, 0.3, 0.3);
                self.hud_ammoClipAkimbo.glowAlpha = 0.5;
            }
            else if(ammoInClip <= 10)
            {
                self.hud_ammoClipAkimbo.color = (1, 1, 0);
                self.hud_ammoClipAkimbo.glowColor = (0.9, 0.9, 0.3);
                self.hud_ammoClipAkimbo.glowAlpha = 0.5;
            }
            else
            {
                self.hud_ammoClipAkimbo.color = (0, 1, 0);
                self.hud_ammoClipAkimbo.glowColor = (0.3 ,0.9 ,0.3);
                self.hud_ammoClipAkimbo.glowAlpha = 0.5;
            }
        }
        else if (isDefined(self.hud_ammoClipAkimbo))
        {
            self.hud_ammoClipAkimbo destroy();
            self.hud_ammoClipAkimbo = undefined;
        }
    }

    if (updateName)
    {
        self thread updateWeaponName(weapon);
        self thread updateWeaponIcon(weapon);
    }
}

updateWeaponName(weapon)
{
    self notify("update_weapon_name_hud");

    self endon("disconnect");
    self endon("update_weapon_name_hud");

    if (!isDefined(self.aizHud_created)) return;

    weaponName = self.hud_weaponName;
    weaponName.alpha = 1;
    weaponName setText(aiz_getWeaponName(weapon));
    if (weapon == "h2_rpg_mp" && self.rpgUpgraded)
        weaponName setText("^1RPG-27");

    wait(1);

    weaponName fadeOverTime(2);
    weaponName.alpha = 0;
    //wait(1);
    //weaponName destroy();
}
updateWeaponIcon(weapon)
{
    self.hud_weaponIcon scaleOverTime(0.05, 0.1, 0.1);
    self.hud_weaponIcon.color = (1,1,1);
    self.hud_weaponIcon.alpha = 1;

    wait(0.05);

    switch(weapon)
    {
        case "h2_usp_mp":
            self.hud_weaponicon setShader("hud_icon_usp_45");
            self.hud_weaponicon scaleOverTime( 0.05, 40, 40 );
        break;
        case "h2_m9_mp":
            self.hud_weaponicon setShader("hud_icon_m9beretta");
            self.hud_weaponicon scaleOverTime( 0.05, 40, 40 );
        break;
        case "h2_coltanaconda_mp":
            self.hud_weaponicon setShader("hud_icon_colt_anaconda");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_deserteagle_mp":
            self.hud_weaponicon setShader("hud_icon_desert_eagle");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_glock_mp":
            self.hud_weaponicon setShader("hud_icon_glock");
            self.hud_weaponicon scaleOverTime( 0.05, 40, 40 );
        break;
        case "h2_beretta393_mp":
            self.hud_weaponicon setShader("hud_icon_beretta393");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_mp5k_mp":
            self.hud_weaponicon setShader("hud_icon_mp5k");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_pp2000_mp":
            self.hud_weaponicon setShader("hud_icon_pp2000");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_pp2000_mp_holo_camo007":
            self.hud_weaponicon.color = (0.3,0.9,0.3);
            self.hud_weaponicon setShader("hud_icon_pp2000");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_uzi_mp":
            self.hud_weaponicon setShader("hud_icon_mini_uzi");
            self.hud_weaponicon scaleOverTime( 0.05, 40, 40 );
        break;
        case "h2_p90_mp":
            self.hud_weaponicon setShader("hud_icon_p90");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_kriss_mp":
            self.hud_weaponicon setShader("hud_icon_kriss");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_ump45_mp":
            self.hud_weaponicon setShader("hud_icon_ump45");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_tmp_mp":
            self.hud_weaponicon setShader("hud_icon_mp9");
            self.hud_weaponicon scaleOverTime( 0.05, 40, 40 );
        break;
        case "h2_ak47_mp":
            self.hud_weaponicon setShader("hud_icon_ak472");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m16_mp_reflex":
            self.hud_weaponicon setShader("hud_icon_m16a4");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m4_mp_reflex":
            self.hud_weaponicon setShader("hud_icon_m4carbine");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_fn2000_mp":
            self.hud_weaponicon setShader("hud_icon_fn2000");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_masada_mp":
            self.hud_weaponicon setShader("hud_icon_masada");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_famas_mp":
            self.hud_weaponicon setShader("hud_icon_famas");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_fal_mp":
            self.hud_weaponicon setShader("hud_icon_fnfal");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_scar_mp":
            self.hud_weaponicon setShader("hud_icon_scar_h");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_tavor_mp":
            self.hud_weaponicon setShader("hud_icon_tavor");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m79_mp":
            self.hud_weaponicon setShader("hud_icon_m79");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_barrett_mp":
            self.hud_weaponicon setShader("hud_icon_barrett50cal");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h1_rpg_mp":
            self.hud_weaponicon setShader("hud_icon_rpg");
            self.hud_weaponicon scaleOverTime( 0.05, 80, 40 );
        break;
        case "h2_rpg_mp":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_rpg");
            self.hud_weaponicon scaleOverTime( 0.05, 80, 40 );
        break;
        case "at4_mp":
            self.hud_weaponicon setShader("hud_icon_at4");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "javelin_mp":
            self.hud_weaponicon setShader("hud_icon_javelin");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_wa2000_mp_acog":
            self.hud_weaponicon setShader("hud_icon_wa2000");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m21_mp_acog":
            self.hud_weaponicon setShader("hud_icon_m14ebr_scope");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_cheytac_mp":
            self.hud_weaponicon setShader("hud_icon_cheytac");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_ranger_mp":
            self.hud_weaponicon setShader("hud_icon_sawed_off");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_model1887_mp":
            self.hud_weaponicon setShader("hud_icon_model1887");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_model1887_mp_fmj":
            self.hud_weaponicon setShader("hud_icon_model1887");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_striker_mp":
            self.hud_weaponicon setShader("hud_icon_striker");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_aa12_mp":
            self.hud_weaponicon setShader("hud_icon_aa12");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m1014_mp":
            self.hud_weaponicon setShader("hud_icon_benelli_m4");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_spas12_mp":
            self.hud_weaponicon setShader("hud_icon_spas12");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_rpd_mp":
            self.hud_weaponicon setShader("hud_icon_rpd");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_sa80_mp":
            self.hud_weaponicon setShader("hud_icon_sa80_lmg");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_mg4_mp":
            self.hud_weaponicon setShader("hud_icon_mg4");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m240_mp_foregrip":
            self.hud_weaponicon setShader("hud_icon_m240");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m240_mp_fmj_xmag_camo008":
            self.hud_weaponicon setShader("hud_icon_m240");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_aug_mp":
            self.hud_weaponicon setShader("hud_icon_steyr");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "onemanarmy_mp":
            self.hud_weaponicon setShader("hud_icon_m9beretta");
            self.hud_weaponicon scaleOverTime( 0.05, 40, 40 );
        break;
        case "defaultweapon_mp":
            self.hud_weaponicon setShader("hud_icon_m240");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m4_mp_silencerar":
            self.hud_weaponicon setShader("hud_icon_m4carbine");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_deserteagle_mp_camo009":
            self.hud_weaponicon.color = (1,1,0.5);
            self.hud_weaponicon setShader("hud_icon_desert_eagle");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_tmp_mp_silencersmg_camo008":
            self.hud_weaponicon.color = (1,1,0.5);
            self.hud_weaponicon setShader("hud_icon_mp9");
            self.hud_weaponicon scaleOverTime( 0.05, 40, 40 );
        break;
        case "h2_usp_mp_akimbo_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_usp_45");
            self.hud_weaponicon scaleOverTime( 0.05, 40, 40 );
        break;
        case "h2_ump45_mp_holo_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_ump45");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m9_mp_akimbo_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_m9beretta");
            self.hud_weaponicon scaleOverTime( 0.05, 40, 40 );
        break;
        case "h2_wa2000_mp_akimbo_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_wa2000");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m16_mp_holo_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_m16a4");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_famas_mp_acog_fmj_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_famas");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_beretta393_mp_akimbo_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_beretta393");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_ak47_mp_fmj_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_ak472");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_aa12_mp_foregrip_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_aa12");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_striker_mp_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_striker");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_cheytac_mp_fmj_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_cheytac");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_glock_mp_akimbo_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_glock");
            self.hud_weaponicon scaleOverTime( 0.05, 40, 40 );
        break;
        case "h2_rpd_mp_foregrip_holo_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_rpd");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "ac130_25mm_mp":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_m240");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_coltanaconda_mp_akimbo_fmj_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_colt_anaconda");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m4_mp_holo_masterkeymwr_camo008":
        case "alt_h2_m4_mp_holo_masterkeymwr_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_m4carbine");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_mp5k_mp_fmj_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_mp5k");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_ak47_mp_glak47_thermal_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_ak472");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "alt_h2_ak47_mp_glak47_thermal_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_40mm_grenade");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_barrett_mp_acog_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_barrett50cal");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_sa80_mp_grip_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_sa80_lmg");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m21_mp_acog_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_m14ebr_scope");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_spas12_mp_grip_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_spas12");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_tmp_mp_akimbo_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_mp9");
            self.hud_weaponicon scaleOverTime( 0.05, 40, 40 );
        break;
        case "h2_mg4_mp_holo_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_mg4");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_pp2000_mp_fmj_reflex_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_pp2000");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_aug_mp_holo_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_steyr");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m240_mp_holo_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_m240");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m240_mp_xmag_camo007":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_m240");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_tavor_mp_fmj_reflex_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_tavor");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_kriss_mp_fastfire_reflex_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_kriss");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_scar_mp_holo_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_scar_h");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_ranger_mp_akimbo_fmj":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_sawed_off");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_p90_mp_akimbo_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_p90");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_masada_mp_reflex_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_masada");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_uzi_mp_acog_silencersmg_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_mini_uzi");
            self.hud_weaponicon scaleOverTime( 0.05, 40, 40 );
        break;
        case "h2_model1887_mp_akimbo_fmj":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_model1887");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_fn2000_mp_f2000scope_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_fn2000");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_fal_mp_reflex_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_fnfal");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m1014_mp_xmag_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_benelli_m4");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_tmp_mp_silencersmg_xmag_camo008":
            self.hud_weaponicon.color = (1,1,0.5);
            self.hud_weaponicon setShader("hud_icon_mp9");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_pp2000_mp_holo_xmag_camo007":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_pp2000");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_m4_mp_acog_silencerar_camo008":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_m4carbine");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h2_ranger_mp_fmj":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_sawed_off");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "stinger_mp":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_stinger");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h1_coltanaconda_mp":
            self.hud_weaponicon.color = (0.3,0.9,0.3);
            self.hud_weaponicon setShader("hud_icon_colt_anaconda");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h1_coltanaconda_mp_akimbo":
            self.hud_weaponicon.color = (0.9,0.3,0.3);
            self.hud_weaponicon setShader("hud_icon_colt_anaconda");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h1_fal_mp":
            self.hud_weaponicon.color = (0.3,0.9,0.3);
            self.hud_weaponicon setShader("hud_icon_fnfal");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h1_galil_mp":
            self.hud_weaponicon.color = (0.3,0.9,0.3);
            self.hud_weaponicon setShader("hud_icon_galil");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h1_m240_mp":
            self.hud_weaponicon.color = (0.3,0.9,0.3);
            self.hud_weaponicon setShader("hud_icon_m240");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h1_mac10_mp":
            self.hud_weaponicon.color = (0.3,0.9,0.3);
            self.hud_weaponicon setShader("hud_icon_mini_uzi");
            self.hud_weaponicon scaleOverTime( 0.05, 40, 40 );
        break;
        case "h1_pp2000_mp":
            self.hud_weaponicon.color = (0.3,0.9,0.3);
            self.hud_weaponicon setShader("hud_icon_pp2000");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h1_striker_mp":
            self.hud_weaponicon.color = (0.3,0.9,0.3);
            self.hud_weaponicon setShader("hud_icon_striker");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        case "h1_vssvintorez_mp":
            self.hud_weaponicon.color = (0.3,0.9,0.3);
            self.hud_weaponicon setShader("hud_icon_dragunov");
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
        default:
            self.hud_weaponicon.alpha = 0;
            self.hud_weaponicon scaleOverTime( 0.05, 60, 40 );
        break;
    }
}

aiz_getWeaponName(weapon)
{
    weapon = trimWeaponScope(weapon);

    switch (weapon)
    {
        case "h2_usp_mp":
            return &"WEAPON_USP";
        case "h2_m9_mp":
            return "M9";
        case "h2_m9_mp_akimbo_xmag_camo008":
            return "^1Mustang & Sally";
        case "h2_aug_mp":
            return "AUG HBAR";
        case "h2_aug_mp_holo_xmag_camo008":
            return "^1ASG LMG Holographic Sight";
        case "h2_pp2000_mp_holo_camo007":
            return "^2Ray Gun";
        case "h2_pp2000_mp_holo_xmag_camo007":
            return "^1Porters X2 Raygun";
        case "defaultweapon_mp":
            return "^2Hand-gun";
        case "h2_tmp_mp_silencersmg_camo008":
            return "^2Flamethrower";
        case "h2_tmp_mp_silencersmg_xmag_camo008":
            return "^3M2A1-7 Flamethrower";
        case "h2_m240_mp_xmag_camo007":
            return "^8Death Machine";
        case "at4_mp":
            return "AT4-HS";
        case "none":
            return &"WEAPON_FREERUNNER";
        case "h2_fn2000_mp":
            return "F2000";
        case "h2_fn2000_mp_f2000scope_camo008":
            return "^1F4000";
        case "h2_pp2000_mp":
            return "PP2000";
        case "h2_pp2000_mp_fmj_reflex_camo008":
            return "^1PP4000";
        case "h2_m240_mp_foregrip":
            return "M240 Grip";
        case "h2_m240_mp_holo_xmag_camo008":
            return "^1Makarov";
        case "h2_kriss_mp":
            return "Vector";
        case "h2_kriss_mp_fastfire_reflex_camo008":
            return "^1Hector";
        case "h2_m1014_mp":
            return "M1014";
        case "h2_m1014_mp_xmag_camo008":
            return "^1M2028";
        case "h2_m16_mp_reflex":
            return "M16A4 Red Dot Sight";
        case "h2_m16_mp_fastfire_holo_xmag_camo008":
            return "^1M16A10 Rapid Fire Holo Sight";
        case "h2_spas12_mp":
            return "SPAS-12";
        case "h2_spas12_mp_foregrip_xmag_camo008":
            return "^1Titanic Shotgun";
        case "h2_ump45_mp":
            return "UMP45";
        case "h2_ump45_mp_holo_xmag_camo008":
            return "^1UMPE-100 Holographic Sight";
        case "h2_p90_mp":
            return "P90";
        case "h2_p90_mp_akimbo_xmag_camo008":
            return "^1Akimbo Madness";
        case "h2_uzi_mp":
            return "Uzi";
        case "h2_uzi_mp_acog_silencersmg_camo008":
            return "^1Super UZI ACOG";
        case "h2_sa80_mp":
            return "L86 LSW";
        case "h2_sa80_mp_foregrip_xmag_camo008":
            return "^1The Grappler";
        case "h2_glock_mp":
            return "G18";
        case "h2_glock_mp_akimbo_xmag_camo008":
            return "^1Noob 18 Akimbo";
        case "h2_rpd_mp":
            return "RPD";
        case "h2_rpd_mp_foregrip_holo_camo008":
            return "^1RPDK Holographic Sight";
        case "h2_usp_mp_akimbo_xmag_camo008":
            return "^1USP.50 Akimbo";
        case "h2_m79_mp":
            return "Thumper";
        case "h2_aa12_mp":
            return "AA-12";
        case "h2_aa12_mp_foregrip_xmag_camo008":
            return "^1AAA121 Grip Xmags";
        case "h2_ak47_mp":
            return "AK-47";
        case "h2_ak47_mp_fmj_xmag_camo008":
            return "^1AK-47 Extended Mags+FMJ";
        case "h2_barrett_mp":
            return "Barrett .50 Cal";
        case "h2_barrett_mp_acog_xmag_camo008":
            return "^1Barrett M92 Extreme";
        case "h2_beretta393_mp":
            return "M93 Raffika";
        case "h2_beretta393_mp_akimbo_xmag_camo008":
            return "^1FM93 Super Raffica Akimbo";
        case "h2_coltanaconda_mp":
            return ".44 Magnum";
        case "h2_coltanaconda_mp_akimbo_fmj_camo008":
            return "^1Python Akimbo";
        case "h2_deserteagle_mp":
            return "Desert Eagle";
        case "h2_deserteagle_mp_camo009":
            return "^3Golden Ownage";
        case "h2_fal_mp":
            return "FN-FAL";
        case "h2_fal_mp_reflex_xmag_camo008":
            return "^1Ep!c Win";
        case "h2_famas_mp":
            return "FAMAS";
        case "h2_famas_mp_acog_fastfire_fmj_camo008":
            return "^1Famas Rapid Fire Acog Sight";
        case "h2_m21_mp_acog":
            return "M14 EBR Acog Scope";
        case "h2_m21_mp_acog_xmag_camo008":
            return "^1M14 Jakmle";
        case "h2_m4_mp_reflex":
            return "M4A1 Red Dot Sight";
        case "h2_m4_mp_holo_masterkeymwr_camo008":
        case "alt_h2_m4_mp_holo_masterkeymwr_camo008":
            return "^1M4A4 Holographic With Shotgun";
        case "h2_m4_mp_silencerar":
            return "M4A1 Silencer";
        case "h2_m4_mp_acog_silencerar_camo008":
            return "^1M4A6 ACOG Silencer";
        case "h2_masada_mp":
            return "Assault Combat Rifle";
        case "h2_masada_mp_reflex_xmag_camo008":
            return "^1GaYCR";
        case "h2_mg4_mp":
            return "MG-4";
        case "h2_mg4_mp_holo_xmag_camo008":
            return "^1MG-8 Holographic Sight";
        case "h2_model1887_mp":
            return "Model 1887";
        case "h2_model1887_mp_akimbo_fmj":
            return "^1Arnold PW?NS";
        case "h2_model1887_mp_fmj":
            return "Model 1887 FMJ";
        case "h2_ranger_mp_fmj":
            return "^1Spaz+Model+Ranger";
        case "h2_mp5k_mp":
            return "MP5K";
        case "h2_mp5k_mp_fmj_xmag_camo008":
            return "^1MP5K Extreme Bullets";
        case "h2_ranger_mp":
            return "Double Barrel Shotgun";
        case "h2_ranger_mp_akimbo_fmj":
            return "^1Double Barrel Shotgun Akimbo";
        case "h2_scar_mp":
            return "SCAR-L";
        case "h2_scar_mp_holo_xmag_camo008":
            return "^1SCAR-BBQ Holographic Sight";
        case "h2_striker_mp":
            return "Striker";
        case "h2_striker_mp_xmag_camo008":
            return "^1Killer Extended Mags";
        case "h2_tavor_mp":
            return "TAR-21";
        case "h2_tavor_mp_fmj_mars_camo008":
            return "^1TAR-21 Mars Sight";
        case "h2_tmp_mp":
            return "TMP";
        case "h2_tmp_mp_akimbo_xmag_camo008":
            return "^1KMP Akimbo Extended Mags";
        case "h2_wa2000_mp_acog":
            return "WA-2000 Acog Scope";
        case "h2_wa2000_mp_acog_xmag_camo008":
            return "^1WAZOO 65";
        case "javelin_mp":
            return "Javelin";
        case "stinger_mp":
            return "^1Javelin Pro";
        case "h2_rpg_mp":
            return "RPG-7";
        case "onemanarmy_mp":
            return "^2OMA";
        case "h2_m240_mp_fmj_xmag_camo008":
            return "^1M240 Grip+FMJ+Damage";
        case "h2_cheytac_mp":
            return "Intervention Explosive Bullets";
        case "h2_cheytac_mp_fmj_camo008":
            return "^1Intervention Super Bullets";
        case "h2_ak47_mp_glak47_thermal_camo008":
            return "^1AK-47 Thermal No Recoil";
        case "alt_h2_ak47_mp_glak47_thermal_camo008":
            return "^1Grenade Launcher AK-84";
        case "defaultweapon_mp":
            return "Hand Gun";
        case "counter_radar_mp":
        case "helicopter_mp":
            return "Mortar Team";
        case "predator_mp":
            return "Predator Missile";
        case "nuke_mp":
            return "Nuke";
        case "emp_mp":
            return "EMP";
        case "h1_coltanaconda_mp":
            return ".44 Magnum ^2Classic";
        case "h1_coltanaconda_mp_akimbo":
            return "Python Akimbo ^2Classic";
        case "h1_fal_mp":
            return "FN FAL ^2Classic";
        case "h1_galil_mp":
            return "^2Galil";
        case "h1_m240_mp":
            return "M240 ^2Classic";
        case "h1_mac10_mp":
            return "Uzi ^2Classic";
        case "h1_pp2000_mp":
            return "PP2000 ^2Classic";
        case "h1_striker_mp":
            return "Striker ^2Classic";
        case "h1_vssvintorez_mp":
            return "Dragunov ^2Classic";
        default:
            return &"NULL_EMPTY";
    }
}

scorePopup(amount)
{
    if (!isDefined(self.aizHud_created)) return;

    if (amount == 0)
        return;

    self notify("scorePopup");
	self endon("scorePopup");

    score = self.hud_scorePop;
    score.addScore = score.addScore + amount;
    scoreAdd = score.addScore;
    oldScore = scoreAdd - amount;

    if (score.isMoving)
    {
        score moveOverTime(0.05);
        score.isMoving = false;
    }

    score.x = 40;
    score.y = -40;
    score thread maps\mp\gametypes\_hud::fontPulse(self);

    if (scoreAdd > 0)
    {
        score.color = (25.5, 25.5, 3.6);
        score.glowColor = (0.3, 0.9, 0.3);
        score.glowAlpha = 0.25;
        score.label = &"MP_PLUS";
    }
    else if (scoreAdd < 0)
    {
        score.color = (25.5, 25.5, 3.6);
        score.glowColor = (0.9, 0.3, 0.3);
        score.glowAlpha = 0.25;
        score.label = &"NULL_EMPTY";
    }

    scoreCountHud = self.hud_score;
    scoreCountHud setValue(self.cash);
    scoreCountHud thread maps\mp\gametypes\_hud::fontPulse(self);
    self.score = int(self.cash);

    score setValue(int(scoreAdd));
    score.alpha = 0.85;

    wait (0.25);

    score moveOverTime(2);
    score.isMoving = true;
    switch(randomInt(6))
	{
	    case 0:
           score.x -= 40;
           score.y = -60;
		break;
		case 1:
            score.x += 40;
            score.y = -60;
		break;
		case 2:
            score.x = 40;
            score.y -= 60;
		break;
		case 3:
            score.x += 20;
            score.y -= 60;
		break;
		case 4:
            score.x -= 60;
            score.y -= 20;
		break;
		case 5:
            score.x -= 20;
            score.y -= 60;
		break;
	}

    wait(1);

    score.isMoving = false;
    score fadeOverTime(1);
    score.alpha = 0;

    score.addScore = 0;
}
updateBonusPoints(addAmount)
{
    if (!isDefined(self.aizHud_created))
        return;

    self.points += addAmount;
    pointNumber = self.hud_point;
    pointNumber setValue(self.points);

    pointNumber thread maps\mp\gametypes\_hud::fontPulse(self);
}
updateMultikillCount()
{
    self notify("multikill_counter");
    self endon("multikill_counter");

    self.multikillCount++;

    wait(1);

    if (self.multikillCount == 2)
    {
        self thread textPopup(level.gameStrings[230]);
        self updateBonusPoints(1);
    }
    else if (self.multikillCount == 3)
    {
        self thread textPopup(level.gameStrings[231]);
        self updateBonusPoints(2);
    }
    else if (self.multikillCount == 4)
    {
        iPrintLn(self.name + " ^2has got a multikill with ^1" + self.multikillCount + " ^2zombies!");
        self thread textPopup(level.gameStrings[232]);
        self updateBonusPoints(2);
    }
    else if (self.multikillCount == 5)
    {
        iPrintLn(self.name + " ^2has got a multikill with ^1" + self.multikillCount + " ^2zombies!");
        self thread textPopup2(level.gameStrings[233]);
        self thread textPopup(level.gameStrings[232]);
        self updateBonusPoints(2);
    }
    else if (self.multikillCount == 6)
    {
        iPrintLn(self.name + " ^2has got a multikill with ^1" + self.multikillCount + " ^2zombies!");
        self thread textPopup2(level.gameStrings[234]);
        self thread textPopup(level.gameStrings[232]);
        self updateBonusPoints(2);
    }
    else if (self.multikillCount >= 7)
    {
        iPrintLn(self.name + " ^2has got a multikill with ^1" + self.multikillCount + " ^2zombies!");
        self thread textPopup2(level.gameStrings[235]);
        self thread textPopup(level.gameStrings[232]);
        self updateBonusPoints(2);
    }

    self.multikillCount = 0;
}

updatePerksHud(reset, instant)
{
    if (!isDefined(self.aizHud_created)) return;

    perk = self.lastBoughtPerk;

    //_hasPerk7 = self.autoRevive;

    if (reset)
    {
        for (i = 0; i < 8; i++)
        {
            self.hud_perks[i].alpha = 0;
            self.perkHudsDone[i] = false;
        }
        return;
    }

    if (self.isAlive)
    {
        if (perk == "em_st_221")//Check for autoRevive first
        {
            if (isDefined(instant) && instant)
                self setPerkHudSlot(6, perk);
            else
                self thread updatePerkHudSlotAfterWait(3, 6, perk);
            self.perkHudsDone[6] = true;
            self.lastBoughtPerk = "";
            return;
        }

        for (i = 0; i < 8; i++)
        {
            if (i == 6)
                continue;

            if (!self.perkHudsDone[i])
            {
                //These are timed to the popup animation when given.
                if (instant)
                    self setPerkHudSlot(i, perk);
                else
                    self thread updatePerkHudSlotAfterWait(3, i, perk);
                self.perkHudsDone[i] = true;
                break;
            }
        }
        self.lastBoughtPerk = "";

    }
}
updatePerkHudSlotAfterWait(waitTime, slot, perk)
{
    self endon("disconnect");

    wait(waitTime);

    self setPerkHudSlot(slot, perk);
}
setPerkHudSlot(slot, perk)
{
    if (!self.isAlive) return;
    perkIcon = self.hud_perks[slot];
    perkIcon setShader(perk, 30, 30);
    perkIcon.alpha = 1;
}

showBoughtPerk(name, imageName, index)
{
    image = newClientHudElem(self);
    image setShader(imageName, 50, 50);
    image.X = 0;
    image.Y = -130;
    image.alignX = "center";
    image.alignY = "middle";
    image.horzAlign = "center";
    image.vertAlign = "middle";
    image.hideWhenInMenu = true;
    image.archived = false;
    image.alpha = 0;

    image fadeOverTime(0.5);
    image.alpha = 1;

    imageX = 0;
    if (index == 6) imageX = self getPerkPath(true);
    else imageX = self getPerkPath(false);
    image scaleOverTime(3, 30, 30);
    image moveOverTime(3);
    image.X = imageX;
    if (index == 6) image.y = 215;
    else image.y = 164;

    wait(3);

    image destroy();

    if (level.perkDescriptions == 0)
        return;

    desc = self createFontString("hudsmall", 1);
    desc.label = level.gameStrings[102 + index];
    if (index == 6) desc setPoint("BOTTOM CENTER", "BOTTOM CENTER", 0, -60);
    else desc setPoint("BOTTOM LEFT", "BOTTOM LEFT", 10, -80);
    desc.color = (1, 1, 1);
    desc.glowColor = (0.3, 0.9, 0.3);
    desc.glowAlpha = 0.25;
    desc.hideWhenInMenu = true;
    desc.archived = false;
    desc.alpha = 0;
    desc maps\mp\gametypes\_hud::fontPulseInit(1.5);
    desc.fontScale = 10;
    desc fadeOverTime(0.25);
    desc changeFontScaleOverTime(0.25);
    desc.fontScale = 1;
    desc.alpha = 1;

    wait(1);

    desc thread maps\mp\gametypes\_hud::fontPulse(self);
    
    wait(4);

    desc fadeOverTime(0.25);
    desc changeFontScaleOverTime(0.25);
    desc.fontScale = 10;
    desc.alpha = 0;

    wait(0.25);
    desc destroy();
}

roundStartHud()
{
    level.roundStartHud = createServerFontString("hudbig", 15);
    level.roundStartHud setPoint("TOPCENTER", "TOPCENTER", 0, 5);
    level.roundStartHud.glowAlpha = 0.25;
    level.roundStartHud.glowColor = (0, 0, 1);
    level.roundStartHud.alpha = 0;
    level.roundStartHud.archived = false;
    level.roundStartHud.label = level.gameStrings[188];
    level.roundStartHud setValue(level.wave);
    level.roundStartHud fadeOverTime(0.5);
    level.roundStartHud changeFontScaleOverTime(0.5);
    level.roundStartHud.fontScale = 1;
    level.roundStartHud.alpha = 1;

    wait(5);

    level.roundStartHud fadeOverTime(0.5);
    level.roundStartHud changeFontScaleOverTime(0.5);
    level.roundStartHud.fontScale = 15;
    level.roundStartHud.alpha = 0;

    wait(1);

    level.roundStartHud destroy();
    level.roundStartHud = undefined;
}

roundEndHud()
{
    level.roundEndHud = createServerFontString("hudbig", 0.150);
    level.roundEndHud.horzAlign = "center";
	level.roundEndHud.vertAlign = "middle";
	level.roundEndHud.alignX = "center";
	level.roundEndHud.alignY = "middle";
    level.roundEndHud.x = 0;
	level.roundEndHud.y = -220;
    level.roundEndHud.glowAlpha = 0.25;
    level.roundEndHud.glowColor = (0.3, 0.9, 0.3);
    level.roundEndHud.archived = false;
    level.roundEndHud.alpha = 0;
    if (level.isBossWave)
    {
        level.roundEndHud.label = level.gameStrings[184];
    }
    else if (level.isCrawlerWave)
    {
        level.roundEndHud.label = level.gameStrings[186];
    }
    else
    {
        level.roundEndHud.label = level.gameStrings[189];
        level.roundEndHud setValue(level.wave);
    }
    level.roundEndHud changeFontScaleOverTime(0.2);
    level.roundEndHud fadeOverTime(0.2);
    level.roundEndHud.fontScale = 1;
    level.roundEndHud.alpha = 1;

    roundEndHudSubtitle = createServerFontString("hudbig", 0.001);
    roundEndHudSubtitle.horzAlign = "center";
	roundEndHudSubtitle.vertAlign = "middle";
	roundEndHudSubtitle.alignX = "center";
	roundEndHudSubtitle.alignY = "middle";
    roundEndHudSubtitle.x = 0;
	roundEndHudSubtitle.y = -195;
    roundEndHudSubtitle.color = (1, 1, 0.5);
    roundEndHudSubtitle.glowAlpha = 0;
    roundEndHudSubtitle.glowColor = (1, 1, 0.5);
    roundEndHudSubtitle.archived = false;
    roundEndHudSubtitle.alpha = 0;
    roundEndHudSubtitle.label = level.gameStrings[14];
    roundEndHudSubtitle changeFontScaleOverTime(0.2);
    roundEndHudSubtitle fadeOverTime(0.2);
    roundEndHudSubtitle.alpha = 1;
    roundEndHudSubtitle.fontScale = 1;

    wait(2.5);

    level.roundEndHud changeFontScaleOverTime(0.2);
    level.roundEndHud fadeOverTime(0.2);
    level.roundEndHud.fontScale = 0.001;
    level.roundEndHud.alpha = 0; 
    roundEndHudSubtitle changeFontScaleOverTime(0.2);
    roundEndHudSubtitle fadeOverTime(0.2);
    roundEndHudSubtitle.fontScale = 0.001;
    roundEndHudSubtitle.alpha = 0;

    wait(0.4);

    level.roundEndHud destroy();
    level.roundEndHud = undefined;
    roundEndHudSubtitle destroy();
}

powerBoughtHud()
{
    if (level.isHellMap) return;
    powerMessage = createServerFontString("objective", 10);
    powerMessage setPoint("CENTER", "CENTER", 0, -130);
    powerMessage.hideWhenInMenu = true;
    powerMessage.foreground = true;
    powerMessage.archived = false;
    powerMessage.color = (1, 1, 1);
    powerMessage.glowColor = (1, 0.5, 0.3);
    powerMessage.glowAlpha = 0.25;
    powerMessage.label = level.gameStrings[190];
    powerMessage.alpha = 0;
    powerName = createServerFontString("objective", 10);
    powerName setPoint("CENTER", "CENTER", 0, -150);
    powerName.hideWhenInMenu = true;
    powerName.foreground = true;
    powerName.archived = false;
    powerName.color = (1, 1, 1);
    powerName.glowColor = (1, 0.5, 0.3);
    powerName.glowAlpha = 0.25;
    powerName setPlayerNameString(self);
    powerName.alpha = 0;

    powerMessage fadeOverTime(1);
    powerMessage.alpha = 1;
    powerName fadeOverTime(1);
    powerName.alpha = 1;
    powerMessage changeFontScaleOverTime(1);
    powerMessage.fontScale = 1.5;
    powerName changeFontScaleOverTime(1);
    powerName.fontScale = 1.5;


    wait(5);

    powerMessage fadeOverTime(1);
    powerMessage.alpha = 0;
    powerName fadeOverTime(1);
    powerName.alpha = 0;
    powerMessage changeFontScaleOverTime(1);
    powerMessage.fontScale = 10;
    powerName changeFontScaleOverTime(1);
    powerName.fontScale = 10;

    wait(1);

    powerMessage destroy();
    powerName destroy();

    upgradesHint = createServerFontString("objective", 10);
    upgradesHint setPoint("CENTER", "CENTER", 0, -130);
    upgradesHint.hideWhenInMenu = true;
    upgradesHint.foreground = true;
    upgradesHint.archived = false;
    upgradesHint.color = (1, 1, 1);
    upgradesHint.glowColor = (0, 0, 1);
    upgradesHint.glowAlpha = 0.25;
    upgradesHint.label = level.gameStrings[216];
    upgradesHint.alpha = 0;
    perksHint = createServerFontString("objective", 10);
    perksHint setPoint("CENTER", "CENTER", 0, -150);
    perksHint.hideWhenInMenu = true;
    perksHint.foreground = true;
    perksHint.archived = false;
    perksHint.color = (1, 1, 1);
    perksHint.glowColor = (1, 0, 0);
    perksHint.glowAlpha = 0.25;
    perksHint.label = level.gameStrings[217];
    perksHint.alpha = 0;

    upgradesHint fadeOverTime(1);
    upgradesHint.alpha = 1;
    perksHint fadeOverTime(1);
    perksHint.alpha = 1;
    upgradesHint changeFontScaleOverTime(1);
    upgradesHint.fontScale = 1.5;
    perksHint changeFontScaleOverTime(1);
    perksHint.fontScale = 1.5;

    wait(5);

    upgradesHint fadeOverTime(1);
    upgradesHint.alpha = 0;
    perksHint fadeOverTime(1);
    perksHint.alpha = 0;
    powerMessage fadeOverTime(1);
    powerMessage.alpha = 0;
    powerName fadeOverTime(1);
    powerName.alpha = 0;

    wait(1);

    powerMessage destroy();
    powerName destroy();
    upgradesHint destroy();
    perksHint destroy();
}

endGame(win)
{
    if (level.gameEnded) return;
    level.gameEndTime = getTime();
    level.gameEnded = true;
    setDvar("scr_gameended", "1");

    wait(1);

    setTeamRadar("allies", false);
    camPos = endGame_getHeliGoal();
    globalCam = spawn("script_model", camPos + (0, 100, 100));
    globalCam setModel("tag_origin");
    angles = (0, 0, 0);
    globalCam.angles = angles;
    globalCam moveTo(globalCam.origin + (0, 0, 2000), 25);

    if (!win)
    {
        level notify("game_ended", "axis");
        //level notify("game_win", "axis");
    }
    else
    {
        level notify("game_ended", "allies");
        //level notify("game_win", "allies");
    }
    //levelFlagSet("game_over");
    //levelFlagSet("block_notifies");
    waitframe();

    if (!level.isHellMap) level.powerHud.alpha = 0;
    level.zombieCounterHud.alpha = 0;
    level.roundHud.alpha = 0;

    foreach (player in level.players)
    {
        if (player.isDown)
            player autoRevive_revivePlayer(undefined);

        player.isDown = true;

        if (isDefined(player.bot)) player thread user_scripts\mp\aizombies\_aiz_killstreaks::killPlayerBot();

        player.sessionTeam = "allies";
        player setclientomnvar( "ui_session_state", "playing");
        player.sessionState = "spectating";

        //if (win) player playLocalSound("victory_music");

        //player notSolid();
        if (!win)
        {
            player takeAllWeapons();
            player destroyPlayerHud();
            camPos = player getEye();
            cam = spawn("script_model", camPos);
            player setPlayerAngles(globalCam.angles);
            player cameraLinkTo(globalCam, "tag_origin", (0, 0, 0), (0, 0, 0));
            player thread doOutro();
        }
    }

    if (win)
    {
        thread endGame_heliWin();
        return;
    }

    level.freezer = true;
    //Add the lose animation to the endgame
    foreach (bot in level.botsInPlay)
    {
        bot user_scripts\mp\aizombies\_aiz_bot_util::playAnimOnBot("z_lose");
        bot moveTo(bot.origin, 0.05);
    }

    wait(5);

    foreach (player in level.players)
    {
        player playLocalSound("nuke_explosion");
        player playLocalSound("nuke_explosion_boom");
        player thread endGameVision();
    }

    thread endGame_hideAllBots();

    wait(2);

    endGameScreen = [];
    setWinningTeam("axis");
    setMatchData("victor", "axis");
    //endGameScreen = createEndGameScreen(win, level.gameStrings[193]);
    foreach (player in level.players)
    {
        player playLocalSound("US_defeat_music");
        player destroyPlayerHud();
    }

    level.gameEnded = false;//Must be false for endGame to work
    thread maps\mp\gametypes\_gamelogic::endGame("axis", 15);

    //wait(9);

    maxMapsCount = level.mapList.size;
    if (!level.crMapsEnabled || cointoss())//CR maps come up too often sometimes so a cointoss has been added to break off CR maps a bit
        maxMapsCount = 25;
    endGame_setNextMap(level.mapList[randomInt(maxMapsCount)]);
}

endGame_setNextMap(mapName)
{
    nextMap = "map " + mapName;
    setDvar("sv_currentmaprotation", nextMap);
	setDvar("sv_maprotationcurrent", nextMap);
	setDvar("sv_maprotation", nextMap);
    setDvar("g_gametype", "war");//Restore gametype for next map
}

endGame_heliWin()
{
	wait(1);

	player = level.players[randomInt(level.players.size)];

    heliSpawn = endGame_getHeliSpawn();
	level.heli = spawnHelicopter(player, heliSpawn, (0, 0, 0), "pavelow_mp", "vehicle_cobra_helicopter_fly");

    if (level.players.size > 0)
    {
        level.players[randomInt(level.players.size)] sayAll("^1Oh Shit What is That");
        level.players[randomInt(level.players.size)] playSound("US_mp_stm_enemyspotted");
    }

	level.heli Vehicle_SetSpeed(40, 50);
    heliMovePoint = endGame_getHeliMove();
    level.heli setVehGoalPos(heliMovePoint, 1);

	level.heli waitTillMatch("goal");

	level.heli playLoopSound("cobra_helicopter_dying_loop");
	level.heli thread endGame_playHeliFX();
    level.heli setyawspeed(180, 180, 180);
	level.heli thread user_scripts\mp\aizombies\_aiz_killstreaks::overwatch_spin();
	level.heli playSound("cobra_helicopter_hit");

    if (level.players.size > 0)
	    level.players[randomInt(level.players.size)] sayAll("^1Shit Get Down");
        
	playFxOnTag(level.fx_endGameHeliFlames, level.heli, "tag_engine_left");
	level.heli Vehicle_SetSpeed(40,50);
    
    heliGoal = endGame_getHeliGoal();
    level.heli setvehGoalPos(heliGoal, 1);

	level.heli waitTillMatch("goal");

	level.heli thread endGame_finishHeliSequence();
}
endGame_finishHeliSequence()
{
	self playSound("cobra_helicopter_crash");
    deathTag = self getTagAngles("tag_deathfx");
	playFx(level.fx_endGameHeliExplosion, deathTag, anglesToForward(deathTag), anglesToUp(deathTag));
	self delete();
	foreach(player in level.players)
	{
		earthquake(1.3, 1.1, player.origin, 3000);
		player setStance("prone");
		player.moveSpeedScaler = 0.35;
		player maps\mp\gametypes\_weapons::updateMoveSpeedScale("primary");
		player VisionSetNakedForPlayer("mpnuke_aftermath", 2);	
        player playLocalSound("nuke_explosion");
        player playLocalSound("nuke_explosion_boom");
	}

	wait(5);

	foreach(player in level.players)
	{
		player thread scorePopup(20000);
		player thread textPopup(level.gameStrings[15]);
		player thread maps\mp\gametypes\_rank::giveRankXP("kill", 20000);
	}

    wait(3);

    level.gameEnded = false;//Must be false for endGame to work
	thread maps\mp\gametypes\_gamelogic::endGame("allies", 14);

    //wait(9);

    maxMapsCount = level.mapList.size;
    if (!level.crMapsEnabled)
        maxMapsCount = 25;
    endGame_setNextMap(level.mapList[randomInt(maxMapsCount)]);
}
endGame_playHeliFX()
{
	while(isDefined(self))
	{
		playFXOnTag(level.fx_flamethrowerImpact, self, "tag_engine_left");
		playFXOnTag(level.fx_flamethrowerImpactUpgrade, self, "tag_engine_left");
		wait 4;
	}
}
endGame_getHeliSpawn()
{
	rSpawn = (0, 500, 500);
	switch(level._mapname)
	{
		case "mp_abandon":
		rSpawn = (-5684,8503,939);
		break;
		case "mp_estate":
		rSpawn = (-7669,-2787,-156);
		break;
		case "mp_derail":
		rSpawn = (-420,2083,773);
		break;
		case "mp_favela":
		rSpawn = (-3605,1028,1949);
		break;
		case "mp_underpass":
		rSpawn = (6952,4630,1375);
		break;
		case "mp_brecourt":
		rSpawn = (4147,3381,1862);
		break;
		case "mp_afghan":
		rSpawn = (-2259,-4580,2);
		break;
		case "mp_highrise":
		if(level.mapVariation == 0)
			rSpawn = (5799,7047,3859);
		if(level.mapVariation == 1)
			rSpawn = (-5350,10560,5990);
        if(level.mapVariation == 2)
			rSpawn = (-3874,6463,4113);
		if(level.mapVariation == 3)
			rSpawn = (-11171,243,6486);
		break;
		case "mp_nightshift":
		if(level.mapVariation == 0)
			rSpawn = (-1814,-3775,748);
		if(level.mapVariation == 1)
			rSpawn = (4628,-1204,1234);
		if(level.mapVariation == 2)
			rSpawn = (1902,-5880,840);
		break;
		case "mp_terminal":
		rSpawn = (-5862,2653,830);
		break;
		case "mp_strike":
		rSpawn = (-9493,1494,594);
		break;
		case "mp_subbase":
		rSpawn = (-86,-861,854);
		break;
		case "mp_boneyard":
		rSpawn = (1909,-5738,610);
		break;
		case "mp_invasion":
		rSpawn = (3064,1670,955);
		break;
		case "mp_checkpoint":
		rSpawn = (2104,324,508);
		break;
		case "mp_rust":
		rSpawn = (67,-141,513);
		break;
		case "mp_quarry":
		rSpawn = (-3023,5275,633);
		break;
		case "mp_compact":
		rSpawn = (2648,602,523);
		break;
		case "mp_complex":
		rSpawn = (895,4161,1180);
		break;
		case "mp_trailerpark":
		rSpawn = (1194,721,632);
		break;
		case "mp_rundown":
		rSpawn = (340,-846,1349);
		break;
		case "mp_vacant":
		rSpawn = (-9843,1186,632);
		break;
		case "mp_storm":
		rSpawn = (-6699,-2555,741);
		break;
		case "mp_fuel2":
		rSpawn = (23101,27505,9481);
		break;
		case "mp_overgrown":
		rSpawn = (-181,-9814,483);
		break;
		case "mp_crash":
		rSpawn = (-1085,-6916,1210);
		break;
        case "cliffhanger":
        rSpawn = (1186, -27154, 2260);
        break;
        case "contingency":
        rSpawn = (-13710, 5950, 1071);
        break;
		case "dcburning":
		rSpawn = (-24220, -6016, 504);
		break;
        case "boneyard":
		rSpawn = (-4656, 0, 580);
		break;
        case "estate":
		rSpawn = (-5819, 263, 633);
		break;
        case "dc_whitehouse":
		if(level.mapVariation == 0)
			rSpawn = (3078, 8708, 674);
		if(level.mapVariation == 1)
			rSpawn = (9021, 10880, 1189);
		break;
	}
	return rSpawn;
}
endGame_getHeliMove()
{
	rMove = (0, 0, 500);
	switch(level._mapname)
	{
		case "mp_abandon":
		rMove = (-3576,5414,791);
		break;
		case "mp_estate":
		rMove = (-4679,-1266,-196);
		break;
		case "mp_derail":
		rMove = (1395,1638,700);
		break;
		case "mp_favela":
		rMove = (236,1929,1082);
		break;
		case "mp_underpass":
		rMove = (4090,3206,935);
		break;
		case "mp_brecourt":
		rMove = (8288,5790,1332);
		break;
		case "mp_afghan":
		rMove = (-3650,-1148,-696);
		break;
		case "mp_highrise":
		if(level.mapVariation == 0)
			rMove = (1006,9004,2853);
		if(level.mapVariation == 1)
			rMove = (-95,10777,3907);
        if(level.mapVariation == 2)
			rMove = (-8484,5812,3144);
		if(level.mapVariation == 3)
			rMove = (-13348,4425,6139);
		break;
		case "mp_nightshift":
		if(level.mapVariation == 0)
			rMove = (-1751,-1309,533);
		if(level.mapVariation == 1)
			rMove = (2033,-1011,708);
		if(level.mapVariation == 2)
			rMove = (1925,-1992,375);
		break;
		case "mp_terminal":
		rMove = (859,3444,693);
		break;
		case "mp_strike":
		rMove = (-3947,1422,414);
		break;
		case "mp_subbase":
		rMove = (-345,-3844,368);
		break;
		case "mp_boneyard":
		rMove = (820,-3232,450);
		break;
		case "mp_invasion":
		rMove = (3007,8854,543);
		break;
		case "mp_checkpoint":
		rMove = (2355,2210,318);
		break;
		case "mp_rust":
		rMove = (760,-3910,523);
		break;
		case "mp_quarry":
		rMove = (-3396,3564,566);
		break;
		case "mp_compact":
		rMove = (2257,2353,414);
		break;
		case "mp_complex":
		rMove = (629,1211,907);
		break;
		case "mp_trailerpark":
		rMove = (1095,-1611,501);
		break;
		case "mp_rundown":
		rMove = (607,2084,541);
		break;
		case "mp_vacant":
		rMove = (-2936,762,528);
		break;
		case "mp_storm":
		rMove = (4977,-1931,644);
		break;
		case "mp_fuel2":
		rMove = (22855,23347,8940);
		break;
		case "mp_overgrown":
		rMove = (-1379,-6723,291);
		break;
		case "mp_crash":
		rMove = (-1119,-4474,979);
		break;
        case "cliffhanger":
        rMove = (-2947, -25613, 1533);
        break;
        case "contingency":
        rMove = (-13251, 3472, 1291);
        break;
        case "dcburning":
		if(level.mapVariation == 0)
			rMove = (-21094, 5196, 333);
		if(level.mapVariation == 1)
			rMove = (-22200, 289, 402);
		break;
        case "boneyard":
        rMove = (-4656, -6375, 580);
        break;
        case "estate":
        rMove = (-993, 412, 396);
        break;
        case "dc_whitehouse":
		if(level.mapVariation == 0)
			rMove = (-876, 8582, 164);
		if(level.mapVariation == 1)
			rMove = (-3723, 8453, 640);
		break;
	}
	return rMove;
}
endGame_getHeliGoal()
{
	rMove = (0, 0, 0);
	switch(level._mapname)
	{
		case "mp_abandon":
			if (coinToss())
				rMove = (-2017,1769,150);
			else
				rMove = (-440,4724,150);
		break;
		case "mp_estate":
			if (coinToss())
				rMove = (-2546,-1719,-470);
			else
				rMove = (-2487,-433,-139);
		break;
		case "mp_derail":
			if (coinToss())
				rMove = (2538,1697,311);
			else
				rMove = (2634,1310,366);
		break;
		case "mp_favela":

			if (coinToss())
				rMove = (1319,2378,616);
			else
				rMove = (1984,2641,489);
		break;
		case "mp_underpass":

			if (coinToss())
				rMove = (3305,3091,594);
			else
				rMove = (3851,2178,559);
		break;
		case "mp_brecourt":

			if (coinToss())
				rMove = (10712,6558,610);
			else
				rMove = (9774,8120,553);

		break;
		case "mp_afghan":
			if (coinToss())
				rMove = (-3985,443,-1200);
			else
				rMove = (-2399,-689,-1174);
		break;
		case "mp_highrise":
		if(level.edit == 0)
		{
            if (coinToss())
                rMove = (-829,9656,2374);
            else
                rMove = (-895,11245,2306);
		}
		if(level.edit == 1)
		{
            if (coinToss())
                rMove = (1563,11359,3479);
            else
                rMove = (1690,10481,3497);
		}
        if(level.edit == 2)
		{
            if (coinToss())
                rMove = (-10052,6446,2508);
            else
                rMove = (-9711,4265,2485);
		}
		if(level.edit == 3)
		{
            if (coinToss())
                rMove = (-13113,6384,5925);
            else
                rMove = (-14940,5617,5619);
		}
		break;
		case "mp_nightshift":
		if(level.edit == 0)
		{
            if (coinToss())
                rMove = (-1255,-584,150);
            else
                rMove = (-1732,-506,139);
		}
		if(level.edit == 1)
		{
            if (coinToss())
                rMove = (824,-1328,149);
            else
                rMove = (871,-1038,126);
		}
		if(level.edit == 2)
		{
            if (coinToss())
                rMove = (1935,-1020,141);
            else
                rMove = (1740,-1411,115);
		}
		break;
		case "mp_terminal":
			if (coinToss())
				rMove = (1889,2971,287);
			else
				rMove = (1535,4026,586);
		break;
		case "mp_strike":
			if (coinToss())
				rMove = (-2425,1349,113);
			else
				rMove = (-2907,1486,112);
		break;
		case "mp_subbase":
			if (coinToss())
				rMove = (-428,-4978,93);
			else
				rMove = (-275,-5067,81);
		break;
		case "mp_boneyard":
			if (coinToss())
				rMove = (731,-1752,27);
			else
				rMove = (-443,-1863,46);
		break;
		case "mp_invasion":
			if (coinToss())
				rMove = (4507,11332,103);
			else
				rMove = (2926,12053,62);
		break;
		case "mp_checkpoint":
			if (coinToss())
				rMove = (2418,3331,87);
			else
				rMove = (1507,3083,48);
		break;
		case "mp_rust":
			if (coinToss())
				rMove = (168,-9587,-20);
			else
				rMove = (2028,-9862,-47);
		break;
		case "mp_quarry":
			if (coinToss())
				rMove = (-3269,2260,140);
			else
				rMove = (-3138,2910,115);
		break;
		case "mp_compact":
			if (coinToss())
				rMove = (2320,3011,138);
			else
				rMove = (1789,2975,161);
		break;
		case "mp_complex":
			if (coinToss())
				rMove = (1487,-137,521);
			else
				rMove = (-701,-260,450);
		break;
		case "mp_trailerpark":
			if (coinToss())
				rMove = (1823,-2807,278);
			else
				rMove = (533,-2391,73);
		break;
		case "mp_rundown":
			if (coinToss())
				rMove = (411,2902,164);
			else
				rMove = (962,2588,168);
		break;
		case "mp_vacant":
			if (coinToss())
				rMove = (-260,1045,133);
			else
				rMove = (-993,-105,76);
		break;
		case "mp_storm":
			if (coinToss())
				rMove = (2947,-1911,255);
			else
				rMove = (4930,-622,158);
		break;
		case "mp_fuel2":
			if (coinToss())
				rMove = (-1403,-5867,-89);
			else
				rMove = (-2219,-6130,-107);
		break;
		case "mp_overgrown":
			if (coinToss())
				rMove = (0,21352,6931);
			else
				rMove = (4930,-622,158);
		break;
		case "mp_crash":
			if (coinToss())
				rMove = (-1035,-2408,124);
			else
				rMove = (-1002,-2852,202);
		break;
        case "cliffhanger":
			if (coinToss())
				rMove = (-3878,-25641,1125);
			else
				rMove = (-3423, -24561, 1327);
		break;
        case "contingency":
			if (coinToss())
				rMove = (-14132, 2291, 993);
			else
				rMove = (-13989, 2644, 632);
		break;
        case "dcburning":
		if(level.edit == 0)
		{
            if (coinToss())
                rMove = (-20799, 6616, -123);
            else
                rMove = (-21448, 6551, -123);
		}
		if(level.edit == 1)
		{
            if (coinToss())
                rMove = (-21774, 425, -272);
            else
                rMove = (-22631, 2164, -236);
		}
		break;
        case "boneyard":
			if (coinToss())
				rMove = (-4064, -7217, 8);
			else
				rMove = (-4665, -7277, 112);
		break;
        case "estate":
			if (coinToss())
				rMove = (-308, 459, 230);
			else
				rMove = (-360, 266, 234);
		break;
        case "dc_whitehouse":
		if(level.edit == 0)
		{
            if (coinToss())
                rMove = (-1756, 8664, -31);
            else
                rMove = (-1755, 8362, -31);
		}
		if(level.edit == 1)
		{
            if (coinToss())
                rMove = (2119, 6651, -218);
            else
                rMove = (2072, 8116, -218);
		}
		break;
	}
	return rMove;
}

endGame_hideAllBots()
{
    wait(2);

    foreach (bot in level.botsInPlay)
    {
        bot hideAllParts();
        if (isDefined(bot.head)) bot.head hide();
    }
}

endGame_createTopPlayerClone()
{
    self endon("disconnect");

    wait(0.05);

    clone = self clonePlayer(6);
    head = spawn("script_model", clone.origin);
    //headModel = self getAttachModelName(0);
    head setModel(self.headModel);
    head linkTo(clone, "j_spine4", (0, 0, 0), (0, 0, 0));
    self playerHide();
}

endGame_moveCameraUpwards()
{
    wait(5);

    self moveTo(self.origin + (0, 0, 1900), 25, 1, 1);
}

endGameVision()
{
    self endon("disconnect");

    self visionSetNakedForPlayer("end_game2", 2.5);
    wait(3);
    self visionSetNakedForPlayer("mpnuke_aftermath");
}

doOutro()
{
    endGameText = self createEndGameSequenceForPlayer();
    endGameText[0].alpha = 0;
    endGameText[0].fontScale = 25;
    endGameText[0] fadeOverTime(0.25);
    endGameText[0].alpha = 1;
    endGameText[0] changeFontScaleOverTime(0.25);
    endGameText[0].fontScale = 0.85;
    self playLocalSound("weap_m2_50cal_fire_plr");
    earthquake(.25, .3, self.origin, 5000);
    wait(.9);
    endGameText[1].alpha = 0;
    endGameText[1].fontScale = 25;
    endGameText[1] fadeOverTime(0.25);
    endGameText[1].alpha = 1;
    endGameText[1] changeFontScaleOverTime(0.25);
    endGameText[1].fontScale = 0.85;
    self playLocalSound("weap_m2_50cal_fire_plr");
    earthquake(.25, .3, self.origin, 5000);
    wait(.9);
    endGameText[2].alpha = 0;
    endGameText[2].fontScale = 25;
    endGameText[2] fadeOverTime(0.25);
    endGameText[2].alpha = 1;
    endGameText[2] changeFontScaleOverTime(0.25);
    endGameText[2].fontScale = 0.85;
    self playLocalSound("weap_m2_50cal_fire_plr");
    earthquake(.25, .3, self.origin, 5000);
    wait(.9);
    endGameText[3].alpha = 0;
    endGameText[3].fontScale = 25;
    endGameText[3] fadeOverTime(0.25);
    endGameText[3].alpha = 1;
    endGameText[3] changeFontScaleOverTime(0.25);
    endGameText[3].fontScale = 0.85;
    self playLocalSound("weap_m2_50cal_fire_plr");
    earthquake(.25, .3, self.origin, 5000);
    wait(.9);
    endGameText[4].alpha = 0;
    endGameText[4].fontScale = 25;
    endGameText[4] fadeOverTime(0.25);
    endGameText[4].alpha = 1;
    endGameText[4] changeFontScaleOverTime(0.25);
    endGameText[4].fontScale = 0.85;
    self playLocalSound("weap_m2_50cal_fire_plr");
    earthquake(.25, .3, self.origin, 5000);

    wait(3);

    foreach (h in endGameText)
    {
        h fadeOverTime(0.5);
        h.alpha = 0;

        h thread endGame_destroyTextAfterTime(0.5);
    }
}
endGame_destroyTextAfterTime(time)
{
    wait(time);

    self destroy();
}

createEndGameScreen(win, endText)
{
    outcomeTitle = newHudElem();
    outcomeTitle.elemType = "font";
    outcomeTitle.font = "hudbig";
    outcomeTitle.fontScale = 1.5;
    outcomeTitle.children = [];
    outcomeTitle.parent = level.uiParent;
    outcomeTitle setPoint("center", "center", 0, -134);
    outcomeTitle.foreground = true;
    outcomeTitle.glowAlpha = 0.25;
    outcomeTitle.hideWhenInMenu = false;
    outcomeTitle.archived = false;

    outcomeText = newHudElem();
    outcomeText.elemType = "font";
    outcomeText.font = "hudbig";
    outcomeText.fontScale = 1;
    outcomeText.parent = outcomeTitle;
    outcomeText.children = [];
    outcomeText.foreground = true;
    outcomeText setPoint("center", "center", 0, 28);
    outcomeText.glowAlpha = 0.25;
    outcomeText.hideWhenInMenu = false;
    outcomeText.archived = false;

    outcomeTitle.glowColor = (0, 0, 0);
    if (win)
    {
        outcomeTitle.label = level.gameStrings[194];
        outcomeTitle.color = (.3, .7, .2);
    }
    else
    {
        outcomeTitle.label = level.gameStrings[195];
        outcomeTitle.color = (.7, .3, .2);
    }
    outcomeText.glowColor = (.2, .3, .7);
    outcomeText.label = endText;
    outcomeTitle setPulseFX(100, 60000, 1000);
    outcomeText setPulseFX(100, 60000, 1000);

    leftIcon = newHudElem();
    leftIcon.children = [];
    leftIcon setShader("h2m_faction_rangers", 70, 70);
    leftIcon.parent = outcomeText;
    leftIcon setPoint("top", "bottom", -60, 60);
    //leftIcon setShader("cardicon_soap", 70, 70);
    leftIcon.foreground = true;
    leftIcon.hideWhenInMenu = false;
    leftIcon.archived = false;
    leftIcon.alpha = 0;
    leftIcon fadeOverTime(0.5);
    leftIcon.alpha = 1;

    rightIcon = newHudElem();
    rightIcon.children = [];
    rightIcon setShader("h1_playlist_infect", 70, 70);
    rightIcon.parent = outcomeText;
    rightIcon setPoint("top", "bottom", 60, 60);
    //rightIcon setShader("cardicon_nuke", 70, 70);
    rightIcon.foreground = true;
    rightIcon.hideWhenInMenu = false;
    rightIcon.archived = false;
    rightIcon.alpha = 0;
    rightIcon fadeOverTime(0.5);
    rightIcon.alpha = 1;

    leftScore = newHudElem();
    leftScore.elemType = "font";
    leftScore.font = "hudbig";
    leftScore.fontScale = 1.25;
    leftScore.children = [];
    leftScore.parent = leftIcon;
    leftScore setPoint("top", "bottom", 0, 50);
    if (win)
    {
        leftScore.glowColor = (.2, .8, .2);
        leftScore.label = level.gameStrings[196];
    }
    else
    {
        leftScore.glowColor = (.8, .2, .2);
        leftScore.label = level.gameStrings[197];
    }
    leftScore.glowAlpha = 0.25;
    leftScore.foreground = true;
    leftScore.hideWhenInMenu = false;
    leftScore.archived = false;
    leftScore setPulseFX(100, 60000, 1000);

    rightScore = newHudElem();
    rightScore.elemType = "font";
    rightScore.font = "hudbig";
    rightScore.fontScale = 1.5;
    rightScore.children = [];
    rightScore.parent = rightIcon;
    rightScore setPoint("top", "bottom", 0, 50);
    if (!win)
    {
        rightScore.glowColor = (0.2, 0.8, 0.2);
        rightScore.label = level.gameStrings[196];
    }
    else
    {
        rightScore.glowColor = (0.8, 0.2, 0.2);
        rightScore.label = level.gameStrings[197];
    }
    rightScore.glowAlpha = 0.25;
    rightScore.foreground = true;
    rightScore.hideWhenInMenu = false;
    rightScore.archived = false;
    rightScore setPulseFX(100, 60000, 1000);

    ret = [];
    ret[0] = outcomeTitle;
    ret[1] = outcomeText;
    ret[2] = rightScore;
    ret[3] = leftScore;
    ret[4] = rightIcon;
    ret[5] = leftIcon;

    return ret;
}

createEndGameSequenceForPlayer()
{
    endGameText = [];

    endGameText[0] = self createFontString("hudbig", 25);
    endGameText[0].children = [];
    endGameText[0] setPoint("TOPMIDDLE", "TOPMIDDLE", 0, 60);
    endGameText[0].color = (1, 1, 1);
    endGameText[0].glowColor = (0.3, 0.9, 0.9);
    endGameText[0].glowAlpha = 0.25;
    endGameText[0].label = level.gameStrings[198];
    endGameText[0].alpha = 0;

    endGameText[1] = self createFontString("hudbig", 25);
    endGameText[1].children = [];
    endGameText[1] setPoint("TOPMIDDLE", "TOPMIDDLE", 0, 75);
    endGameText[1].color = (1, 1, 1);
    endGameText[1].glowColor = (0.3, 0.9, 0.9);
    endGameText[1].glowAlpha = 0.25;
    endGameText[1].label = level.gameStrings[199];
    endGametext[1] setValue(level.timePlayedMinutes);
    endGameText[1].alpha = 0;

    endGameText[2] = self createFontString("hudbig", 25);
    endGameText[2].children = [];
    endGameText[2] setPoint("TOPMIDDLE", "TOPMIDDLE", 0, 90);
    endGameText[2].color = (1, 1, 1);
    endGameText[2].glowColor = (0.3, 0.9, 0.9);
    endGameText[2].glowAlpha = 0.25;
    endGameText[2].label = level.gameStrings[200];
    endGametext[2] setValue(level.timePlayed);
    endGameText[2].alpha = 0;

    endGameText[3] = self createFontString("hudbig", 25);
    endGameText[3].children = [];
    endGameText[3] setPoint("TOPMIDDLE", "TOPMIDDLE", 0, 105);
    endGameText[3].color = (1, 1, 1);
    endGameText[3].glowColor = (0.3, 0.9, 0.9);
    endGameText[3].glowAlpha = 0.25;
    endGameText[3].label = level.gameStrings[201];
    endGameText[3] setValue(level.wave);
    endGameText[3].alpha = 0;

    endGameText[4] = self createFontString("hudbig", 25);
    endGameText[4].children = [];
    endGameText[4] setPoint("TOPMIDDLE", "TOPMIDDLE", 0, 120);
    endGameText[4].color = (1, 1, 1);
    endGameText[4].glowAlpha = 0.25;
    endGameText[4].glowColor = (0.9, 0.3, 0.3);
    endGameText[4].label = level.gameStrings[203];
    endGameText[4].alpha = 0;

    return endGameText;
}

destroyHudAfterWait(waitTime)
{
    wait(waitTime);

    self destroy();
}
powerupText(text, intensity, color, glow, glowIntensity)
{
	bonusDropText = newHudElem();
	bonusDropText.horzAlign = "center";
	bonusDropText.vertAlign = "middle";
	bonusDropText.alignX = "center";
	bonusDropText.alignY = "middle";
	bonusDropText.font = "objective";
	bonusDropText.fontscale = 2;
    bonusDropText.archived = false;
	bonusDropText.color = color;
	bonusDropText.label = text;
	bonusDropText.alpha = intensity;
	bonusDropText.glowColor = glow;
	bonusDropText.glowAlpha = glowIntensity;
	bonusDropText.x = 0;
	bonusDropText.y = 140;
	bonusDropText moveOverTime(2);
	bonusDropText fadeOverTime(2);
	bonusDropText.x = 0;
	bonusDropText.y = 80;
	bonusDropText.alpha = 0;

	wait(2);

	bonusDropText destroy();
}
powerupIcon(shader, color)
{
	bonusDropIcon = newHudElem();
	bonusDropIcon.alignX = "center";
	bonusDropIcon.alignY = "middle";
	bonusDropIcon.horzAlign = "center";
	bonusDropIcon.vertAlign = "middle";
	bonusDropIcon.x = 0;
	bonusDropIcon.y = 125;
	bonusDropIcon.color = color;
	bonusDropIcon.foreground = true;
    bonusDropIcon.archived = false;
	bonusDropIcon setShader(shader, 30, 30);
	bonusDropIcon.alpha = 1;
	bonusDropIcon moveOverTime(2);
	bonusDropIcon fadeOverTime(2);
	bonusDropIcon.x = 0;
	bonusDropIcon.y = 65;
	bonusDropIcon.alpha = 0;
    
	wait(2);

	bonusDropIcon destroy();
}

getPerkPath(revive)
{
    if (revive)
        return 0;

    perkSlots = self getPerkHudSlotsOpen();

    if (!perkSlots[0])
        return -410;
    else if (!perkSlots[1])
        return -378;
    else if (!perkSlots[2])
        return -346;
    else if (!perkSlots[3])
        return -314;
    else if (!perkSlots[4])
        return -282;
    else if (!perkSlots[5])
        return -250;
    else if (!perkSlots[6])
        return -186;
    else return -122;//Error
}

getPerkHudSlotsOpen()
{
    ret = [];
    for (i = 0; i < 7; i++)
        ret[i] = self.perkHudsDone[i];
    return ret;
}

fadeOutIcon(fadeTime, delay)
{
    if (!isDefined(delay))
        delay = 1;

    wait(delay);

    self fadeOverTime(fadeTime);
    self.alpha = 0;
}
destroyHud(time)
{
    if (!isDefined(time))
    {
        self destroy();
        return;
    }

    wait(time);

    self destroy();
}

textPopup(text, param)
{
	self endon("disconnect");

	wait (0.05);

    if (isDefined(self.textPopup))
        self.textPopup destroy();

	self notify("textPopup");
	self endon("textPopup");
	self.textPopup = newClientHudElem(self);
	self.textPopup.horzAlign = "center";
	self.textPopup.vertAlign = "middle";
	self.textPopup.alignX = "center";
	self.textPopup.alignY = "middle";
	self.textPopup.x = 40;
	self.textPopup.y = -30;
	self.textPopup.font = "hudbig";
	self.textPopup.fontscale = 0.69;
	self.textPopup.color = (25.5, 25.5, 3.6);
	self.textPopup.label = text;
    if (isDefined(param))
    {
        if (isPlayer(param))
            self.textPopup setPlayerNameString(param);
        else
            self.textPopup setText(param);
    }
	self.textPopup.alpha = 0.85;
	self.textPopup.glowColor = (0.3, 0.3, 0.9);
	self.textPopup.glowAlpha = 0.25;
	self.textPopup changeFontScaleOverTime(0.1);
	self.textPopup.fontScale = 0.75;

    wait(0.1);

	self.textPopup changeFontScaleOverTime( 0.1 );
	self.textPopup.fontScale = 0.69;	
	switch(randomInt(2))
	{
	    case 0:
            self.textPopup moveOverTime(2);
            self.textPopup.x = 100;
            self.textPopup.y = -30;
		break;
		case 1:
            self.textPopup moveOverTime(2);
            self.textPopup.x = -100;
            self.textPopup.y = -30;
		break;
	}

	wait(1);

	self.textPopup fadeOverTime(1);
	self.textPopup.alpha = 0;

    wait(1);

    self.textPopup destroy();
    self.textPopup = undefined;
}
textPopup2(text, param)
{
	self endon("disconnect");

	wait (0.05);

    if (isDefined(self.textPopup2))
        self.textPopup2 destroy();

	self notify("textPopup2");
	self endon("textPopup2");

	self.textPopup2 = newClientHudElem(self);
	self.textPopup2.horzAlign = "center";
	self.textPopup2.vertAlign = "middle";
	self.textPopup2.alignX = "center";
	self.textPopup2.alignY = "middle";
	self.textPopup2.x = 0;
	self.textPopup2.y = 0;
	self.textPopup2.font = "hudbig";
	self.textPopup2.fontscale = 0.69;
	self.textPopup2.color = (25.5, 25.5, 3.6);
	self.textPopup2.label = text;
    if (isDefined(param))
    {
        if (isPlayer(param))
            self.textPopup setPlayerNameString(param);
        else
            self.textPopup setText(param);
    }
	self.textPopup2.alpha = 0.85;
	self.textPopup2.glowColor = (0.3, 0.9, 0.3);
	self.textPopup2.glowAlpha = 0.25;
	self.textPopup2 changeFontScaleOverTime(0.1);
	self.textPopup2.fontScale = 0.75;

    wait(0.1);

	self.textPopup2 changeFontScaleOverTime(0.1);
	self.textPopup2.fontScale = 0.69;
    if (cointoss())
    {
        self.textPopup2 moveOverTime(2);
        self.textPopup2.x = 60;
        self.textPopup2.y = 0;
    }
    else
    {
        self.textPopup2 moveOverTime(2);
        self.textPopup2.x = -60;
        self.textPopup2.y = 0;
    }

	wait(1);

	self.textPopup2 fadeOverTime(1);
	self.textPopup2.alpha = 0;

    wait(1);

    self.textPopup2 destroy();
    self.textPopup2 = undefined;
}
textWithIcon2(text, text2, icon)
{
	notifyData = spawnStruct();
	notifyData.iconName = icon;
	notifyData.titleText = text;
	notifyData.notifyText = text2;
	notifyData.glowColor = (0.3, 0.6, 0.3);
	notifyData.sound = "null";
	self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}

createIntermissionTimer()
{
    if (isDefined(level.intermissionHud))
    {
        level.intermissionHud.timerNum destroy();
        level.intermissionHud destroy();
        level.intermissionHud = undefined;
    }
    intermission = newTeamHudElem("allies");
    intermission.x = 0;
    intermission.y = 5;
    intermission.alignX = "center";
    intermission.alignY = "top";
    intermission.horzAlign = "center";
    intermission.vertAlign = "top_adjustable";
    intermission.foreground = true;
    intermission.alpha = 1;
    intermission.archived = false;
    intermission.hideWhenInMenu = true;
    intermission.color = (1, 0, 0);
    intermission.font = "objective";
    intermission.fontScale = 1.3;
    intermission.label = level.gameStrings[21];

    intermissionNum = newTeamHudElem("allies");
    intermissionNum.x = 0;
    intermissionNum.y = 20;
    intermissionNum.alignX = "center";
    intermissionNum.alignY = "top";
    intermissionNum.horzAlign = "center";
    intermissionNum.vertAlign = "top_adjustable";
    intermissionNum.foreground = true;
    intermissionNum.alpha = 1;
    intermissionNum.archived = false;
    intermissionNum.hideWhenInMenu = true;
    intermissionNum.color = (1, 1, 0);
    intermissionNum.font = "hudbig";
    intermissionNum.fontScale = 0.9;
    intermissionNum setValue(0);
    intermission.timerNum = intermissionNum;
    return intermission;
}

createPowerupHeadIcon(shader)
{
    icon = newTeamHudElem("allies");
    icon setShader(shader, 8, 8);
    icon.alpha = 0.85;
    icon.archived = false;
    icon setWaypoint(true, true, false);
    icon setTargetEnt(self);
    return icon;
}

createReviveHeadIcon()
{
    icon = newTeamHudElem("allies");
    icon setShader("waypoint_revive", 8, 8);
    icon.alpha = 0.85;
    icon.archived = false;
    icon setWaypoint(true, true);
    icon setTargetEnt(self);
    return icon;
}


createReviveOverlayIcon()
{
    icon = newClientHudElem(self);
    if (isDefined(self.hud_perks[6])) perk = self.hud_perks[6];
    else perk = level.roundHud;//Fallback just in-case. Should never happen
    icon.x = perk.x;
    icon.y = perk.y;
    icon.alignX = perk.alignX;
    icon.alignY = perk.alignY;
    icon.vertAlign = perk.vertAlign;
    icon.horzAlign = perk.horzAlign;
    icon setShader("em_st_221", perk.width, perk.height);
    icon.hideWhenInMenu = true;
    icon.foreground = true;
    icon.archived = false;
    icon.alpha = 0;
    return icon;
}

createReviveOverlay()
{
    icon = newClientHudElem(self);
    //icon setPoint("center", "middle");
    icon.x = 0;
    icon.y = 0;
    icon.alignX = "left";
    icon.alignY = "top";
    icon.horzAlign = "fullscreen";
    icon.vertAlign = "fullscreen";
    icon setShader("combathigh_overlay", 640, 480);
    icon.sort = -10;
    icon.archived = false;
    icon.hideWhenInMenu = false;
    icon.hideIn3rdPerson = true;
    icon.foreground = true;
    icon.alpha = 1;
    return icon;
}
createPrimaryProgressBar(xOffset, yOffset)
{
    progressBar = self createIcon("progress_bar_fill", 0, 9);//NewClientHudElem(self);
    progressBar.frac = 0;
    progressBar.isScaling = false;
    progressBar.color = (1, 1, 1);
    progressBar.sort = -2;
    progressBar setShader("progress_bar_fill", 1, 9);
    progressBar.alpha = 1;
    progressBar setPoint("center", "", 0, -61);
    progressBar.alignX = "left";
    progressBar.X = -60;
    progressBar.archived = false;

    progressBarBG = self createIcon("progress_bar_bg", 124, 13);//NewClientHudElem(self);
    progressBarBG setPoint("center", "", 0, -61);
    progressBarBG.bar = progressBar;
    progressBarBG.sort = -3;
    progressBarBG.color = (0, 0, 0);
    progressBarBG.alpha = .5;
    //progressBarBG.parent = progressBar;
    //progressBarBG setShader("progress_bar_bg", 124, 13);
    //progressBarBG.hidden = false;
    progressBarBG.archived = false;
    progressBar.bg = progressBarBG;

    self.progressBar = progressBar;

    return progressBarBG;
}

updateBar(barFrac, rateOfChange)
{
    //int barWidth = (barBG.width * barFrac + .5f);

    //if (barWidth == null)
    //barWidth = 1;

    self.frac = barFrac;
    //self setShader("progress_bar_fill", barWidth, barBG.height);

    if (rateOfChange > 0)
        self scaleOverTime(rateOfChange, barFrac, self.height);
    else if (rateOfChange < 0)
        self scaleOverTime(-1 * rateOfChange, barFrac, self.height);

    //self.rateOfChange = rateOfChange;
    //time = getTime();
    //self.lastUpdateTime = time;
}