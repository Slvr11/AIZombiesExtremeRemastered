#include common_scripts\utility;
#include user_scripts\mp\aizombies\_aiz;
#include user_scripts\mp\aizombies\_aiz_bot_util;

spawnBot(spawnLoc, isCrawler)
{
    if ((!isCrawler && level.botPool.size == 0) || (isCrawler && level.crawlerPool.size == 0)) return true;//True so in case all 30 have spawned, don't error out
    bot = getNextAvailableBotFromPool(isCrawler, false);

    if (!isDefined(bot))
    {
        //printLn("Error spawning bot: undefined bot was found.");
        return true;
    }

    if (level.botSpawns.size == 0)
    {
        printLn("No bot spawns available! Please have at least one \"zombiespawn\" in your map definition.");
        Announcement("^1No bot spawns available! Check console for details");
        return false;
    }
    
    bot.isSpawned = true;
    bot.currentWaypoint = undefined;
    bot.origin = level.botSpawns[spawnLoc] + (randomInt(20), randomInt(20), 0);
    bot.angles = level.botSpawnAngles[spawnLoc];
    bot show();
    bot showAllParts();

    if (isCrawler)
    {
        if (array_contains(level.wawMaps, level._mapname)) bot playAnimOnBot("dog_idle");
        else bot playAnimOnBot("crawlerAnim_idle");
    }
    else bot playAnimOnBot("z_idle");

    bot.state = "idle";
    if (!isCrawler && isDefined(bot.head))
    {
        botHead = bot.head;
        botHead show();
        //Remove helmet
        //botHead hidePart("j_head_end");
        //botHead hidePart("j_helmet");
        //botHead hidePart("j_collar_rear");
        //bot.headHitbox setCanDamage(true);
    }
    bot.isAlive = true;
    bot.isAttacking = false;
    bot.moveSpeed = randomFloatRange(50, level.botMaxMoveSpeed);
    bot updateBotLastActiveTime();
    level.spawnedBots++;
    botHitbox = bot.hitbox;
    if (isCrawler) botHitbox.currentHealth = level.crawlerHealth;
    else botHitbox.currentHealth = level.botHealth;
    if (!isDefined(botHitbox.currentHealth))
    {
        printLn("currentHealth was undefined for a bot, using default");
        botHitbox.currentHealth = 100;
    }
    botHitbox.damageTaken = 0;
    botHitbox.canBeDamaged = true;
    botHitbox setCanDamage(true);
    botHitbox setCanRadiusDamage(true);
    //botHitbox show();
    botHitbox setModel("com_plasticcase_enemy");
    level.botsInPlay[level.botsInPlay.size] = bot;
    /*
    if (isCrawler) level.crawlerPool = array_remove(level.crawlerPool, bot);
    else level.botPool = array_remove(level.botPool, bot);
    */

    level notify("bot_spawned");

    //Check for waypoints on spawn once
    foreach (v in level.waypoints)
    {
        if (!isDefined(v))
            continue;

        waypointTrace = sightTracePassed(bot getTagOrigin("j_head"), v.origin, false, bot);//Check for waypoints
        if (waypointTrace)
        {
            bot.currentWaypoint = v;//Set the first seen one as current
            bot.visibleWaypoints = v.visiblePoints;
            break;
        }
    }
    if (!isDefined(bot.currentWaypoint))
    {
        //If we haven't found a waypoint with the sightTrace, then find the closest waypoint and use that instead
        closestDist = 999999999;
        closestWaypoint = undefined;
        foreach (v in level.waypoints)
        {
            if (!isDefined(v))
                continue;
            
            heightDiff = bot.origin[2] - v.origin[2];
            if (heightDiff < 0) heightDiff *= -1;
            if (distanceSquared(bot.origin, v.origin) < closestDist && heightDiff < 100)
            {
                closestDist = distanceSquared(bot.origin, v.origin);
                closestWaypoint = v;
            }
        }

        if (isDefined(closestWaypoint))
        {
            bot.currentWaypoint = closestWaypoint;
            bot.visibleWaypoints = closestWaypoint.visiblePoints;
        }
    }

    if (!isDefined(bot.currentWaypoint))
        printLn("bot could not find a waypoint at spawn");

    bot thread botAI(botHitbox, isCrawler, false);

    return true;
}
spawnBossBot(spawnLoc)
{
    if (level.bossPool.size == 0) return true;//True so in case max have spawned, don't error out
    bot = getNextAvailableBotFromPool(false, true);

    if (level.botSpawns.size == 0)
    {
        printLn("No bot spawns available! Please have at least one \"zombiespawn\" in your map definition.");
        Announcement("^1No bot spawns available! Check console for details");
        return false;
    }

    random = randomInt(20);
    bot.isSpawned = true;
    bot.currentWaypoint = undefined;
    bot.origin = level.botSpawns[spawnLoc] + (random, random, 0);
    bot.angles = level.botSpawnAngles[spawnLoc];
    bot show();
    bot showAllParts();

    bot playAnimOnBot("z_idle");

    bot.state = "idle";
    bot.isAlive = true;
    bot.isAttacking = false;
    bot.moveSpeed = 170;
    bot updateBotLastActiveTime();
    level.spawnedBots++;
    botHitbox = bot.hitbox;
    botHitbox.currentHealth = level.bossHealth;
    botHitbox.damageTaken = 0;
    botHitbox setCanDamage(true);
    botHitbox setCanRadiusDamage(true);
    //botHitbox show();
    botHitbox setModel("com_plasticcase_enemy");

    level.botsInPlay[level.botsInPlay.size] = bot;
    //level.bossPool = array_remove(level.bossPool, bot);

    level notify("bot_spawned");

    bot thread botAI(botHitbox, false, true);

    user_scripts\mp\aizombies\_aiz_round_system::checkForCompass();

    //Check for waypoints on spawn once
    foreach (v in level.waypoints)
    {
        waypointTrace = sightTracePassed(bot getTagOrigin("j_head"), v.origin, false, botHitbox);//Check for waypoints
        if (waypointTrace)
        {
            bot.currentWaypoint = v;//Set the first seen one as current
            bot.visibleWaypoints = v.visiblePoints;
            break;
        }
    }
    if (!isDefined(bot.currentWaypoint))
    {
        //If we haven't found a waypoint with the sightTrace, then find the closest waypoint and use that instead
        closestDist = 999999999;
        closestWaypoint = undefined;
        foreach (v in level.waypoints)
        {
            if (!isDefined(v))
                continue;
            
            heightDiff = bot.origin[2] - v.origin[2];
            if (heightDiff < 0) heightDiff *= -1;
            if (distanceSquared(bot.origin, v.origin) < closestDist && heightDiff < 100)
            {
                closestDist = distanceSquared(bot.origin, v.origin);
                closestWaypoint = v;
            }
        }

        if (isDefined(closestWaypoint))
        {
            bot.currentWaypoint = closestWaypoint;
            bot.visibleWaypoints = closestWaypoint.visiblePoints;
        }
    }

    return true;
}

botAI(botHitbox, isCrawler, isBoss)
{
    self endon("death");
    self endon("zombie_death");
    level endon("game_ended");

    ai = self;

    while(self.isAlive)
    {
        wait(0.1);

        if (!ai.isAlive || !array_contains(level.botsInPlay, ai) || botHitbox.currentHealth <= botHitbox.damageTaken) return;
        ai killBotIfUnderMap();
        if (!ai.isAlive)
            return;//Do another check after height check

        //check time inactivity
        if (getTime() > ai.lastActiveTime + 120000 && !isBoss && !level.freezerActivated)
        {
            ai thread killBotAndRespawn();
            return;
        }

        target = undefined;
        botOrigin = ai.origin;
        botHeadTag = self getTagOrigin("j_head");// + (0, 0, 5);

        //-START TARGETING-//
        if (!level.freezerActivated)//Find a real target
        {
            closestDist = 999999999;
            secondClosestDist = 999999999;
            closestPlayer = undefined;
            secondClosestPlayer = undefined;
            foreach (p in level.players)//Find a player
            {
                if (!isDefined(p) || p.sessionTeam != "allies" || !p.isAlive || p.isDown) continue;
                if (p.notTargetable) continue;

                playerOrigin = p.origin;

                targetDistance = 25000000;
                currentDist = distanceSquared(playerOrigin, botOrigin);
                if (currentDist > targetDistance) continue;

                //Attacking players
                if (distanceSquared(botHitbox.origin, playerOrigin) <= 2500 && !ai.isAttacking)
                    ai thread ai_attackPlayer(p, isCrawler, isBoss);
                //End attacking
                
                isClosest = currentDist < closestDist;
                isSecondClosest = currentDist < secondClosestDist;
                if (isClosest)
                {
                    secondClosestPlayer = closestPlayer;
                    secondClosestDist = closestDist;
                    closestDist = currentDist;
                    closestPlayer = p;
                }
                else if (isSecondClosest && currentDist > closestDist)
                {
                    secondClosestDist = currentDist;
                    secondClosestPlayer = p;
                }
            }

            if (isDefined(closestPlayer))
            {
                playerHeadTag = closestPlayer getTagOrigin("j_head");
                trace = undefined;
                if (array_contains(level.wawMaps, level._mapname))
                {
                    trace = bulletTracePassed(botHeadTag + (0, 0, 10), playerHeadTag, false, botHitbox);
                }
                else
                {
                    if (!isCrawler && !isBoss)
                        trace = sightTracePassed(botHeadTag, playerHeadTag, false, ai, ai.head);
                    else trace = sightTracePassed(botHeadTag, playerHeadTag, false, ai);
                }

                if (trace)
                {
                    target = closestPlayer;
                }
                else if (isDefined(secondClosestPlayer))
                {
                    playerHeadTag = secondClosestPlayer.origin + (0, 0, 65);//Previously got the head tag origin, changing for performance
                    if (!isCrawler && !isBoss)
                        trace = sightTracePassed(botHeadTag, playerHeadTag, false, ai, ai.head);
                    else trace = sightTracePassed(botHeadTag, playerHeadTag, false, ai);

                    if (trace)
                    {
                        target = secondClosestPlayer;
                    }
                }
            }

            if (!isDefined(target))//No players, find a waypoint
            {
                if (isDefined(ai.visibleWaypoints))
                {
                    //currentWaypoint = ai.currentWaypoint;
                    if (!isDefined(ai.currentWaypoint) && isDefined(ai.visibleWaypoints))
                    {
                        visibleWaypoints = ai.visibleWaypoints;
                        ai.currentWaypoint = visibleWaypoints[randomInt(visibleWaypoints.size)];
                    }
                    else if (isDefined(ai.currentWaypoint) && distanceSquared(botOrigin, ai.currentWaypoint.origin) < 2500)
                    {
                        ai.visibleWaypoints = ai.currentWaypoint.visiblePoints;
                        ai.currentWaypoint = undefined;
                        continue;
                    }
                }
                else//Recalculate point
                {
                    foreach (v in level.waypoints)
                    {
                        if (!isDefined(v))
                            continue;
                        //Check for waypoints
                        if (sightTracePassed(botHeadTag, v.origin, false, ai))
                        {
                            ai.currentWaypoint = v;//Set the first seen one as current
                            ai.visibleWaypoints = v.visiblePoints;
                            break;
                        }
                    }
                }
                if (isDefined(ai.currentWaypoint)) target = ai.currentWaypoint;
            }
        }
        //-END TARGETING-//
        //Now we are done targeting, do the action for the target

        //-START MOTION-//
        if (ai.isAttacking) continue;//Stop moving to attack.
        
        if (!level.freezerActivated && isDefined(target) && isPlayer(target))
        {
            hasCollidedWithOtherBot = false;
            foreach (bot in level.botsInPlay)//Prevent bots from combining into each other
            {
                if (ai == bot) continue;
                closeOrigin = bot.origin;
                if (distanceSquared(botOrigin, closeOrigin) < 256)//Move away from the bot and recalc
                {
                    dir = vectorToAngles(botOrigin - closeOrigin);
                    if (botOrigin == closeOrigin)
                        dir = (randomFloat(1), randomFloat(1), 0);
                    forward = anglesToForward((0, dir[1], 0));
                    awayPos = botOrigin + (forward * 50);
                    ai moveTo(awayPos, distance(botOrigin, awayPos) / 120);
                    ai rotateTo((0, dir[1], 0), 0.3, 0.1, 0.1);
                    hasCollidedWithOtherBot = true;
                    break;
                }
            }
            if (hasCollidedWithOtherBot)
                continue;
        }

        ground = getGroundPosition(botOrigin, 12)[2];

        if (isDefined(target))//Move to our target
        {
            targetOrigin = target.origin;;
            angleY = vectorToAngles(targetOrigin - botOrigin)[1];
            ai rotateTo((0, angleY, 0), 0.3, 0.1, 0.1);

            if (distance2D(botOrigin, targetOrigin) < 100 || ground == botOrigin[2]) ground = targetOrigin[2];
            if ((level._mapname == "mp_checkpoint" && level.mapVariation == 0) || (level._mapname == "mp_fuel2" && level.mapVariation == 0) || level._mapname == "mp_rust" || level._mapname == "mp_invasion" || level._mapname == "oilrig" || (level._mapname == "dc_whitehouse" && level.mapVariation == 1))//Quick fix for maps that have no floor
            {
                if (level._mapname != "mp_rust" && level._mapname != "mp_checkpoint" && level._mapname != "mp_invasion")
                    ground = targetOrigin[2];
                else if (level._mapname == "mp_rust" && ground < -300)
                    ground = -300;
                else if (level._mapname == "mp_checkpoint" && ground < -25)
                    ground = -25;
                else if (level._mapname == "mp_invasion" && ground < -50)
                    ground = -50;
                else if (level._mapname == "oilrig" && ground < -1400)
                    ground = -1400;
                else if (level._mapname == "dc_whitehouse" && ground < -230)
                    ground = -230;
            }

            speed = ai.moveSpeed;
            distance = distance(botOrigin, targetOrigin);

            groundDist = ground - botOrigin[2];
            groundDist *= 8;//Overcompensate to move faster and track along ground in a better way
            if (ground == targetOrigin[2]) groundDist = 0;//Fix 'jumping bots'

            ai moveTo((targetOrigin[0], targetOrigin[1], ground + groundDist), distance / speed);

            state = ai.state;
            if (state == "idle")
            {
                if (isCrawler) ai playAnimOnBot("crawlerAnim_walk");
                else if (isBoss) ai playAnimOnBot("z_run");
                else
                {
                    if (speed > 120) ai playAnimOnBot("z_run");
                    else ai playAnimOnBot("z_walk");
                }
                ai.state = "moving";
            }
        }
        else//failsafe, just stand still if there is no other options
        {
            ai moveTo((botOrigin[0], botOrigin[1], ground), 1);
            state = ai.state;
            if (state != "idle" && state != "hurt" && state != "attacking")
            {
                if (isCrawler) ai playAnimOnBot("crawlerAnim_idle");
                else ai playAnimOnBot("z_idle");
                ai.state = "idle";
            }
        }
        //-END MOTION-//

        //resetTimeout();
    }
}

ai_attackPlayer(target, isCrawler, isBoss)
{
    level endon("game_ended");
    self endon("death");
    self endon("zombie_death");

    self.isAttacking = true;

    if (!isBoss) self updateBotLastActiveTime();

    if (self.primedForNuke)
    {
        self playAnimOnBot("z_lose");
        return;
    }
    else if (isCrawler) self playAnimOnBot("crawlerAnim_attack");
    else self playAnimOnBot("z_attack");

    if (level.botDamageDelay)
        wait(0.2);

    if (distanceSquared(self.origin, target.origin) <= 2500)
    {
        playFX(level.fx_blood, target.origin + (0, 0, 30));
        if (self.model == "body_infect")
            self playSound("zombie_attack" + randomInt(16) + "_npc");

        dir = vectorToAngles(target.origin - self.origin);
        dir = vectorNormalize(dir);

        targetCurrentWeapon = target getCurrentWeapon();
        target playSound("melee_punch_other");
        target finishPlayerDamage(level, level, level.botDmg, 0, "MOD_FALLING", "none", target.origin, dir, "none", 0, 0);
    }

    wait(0.5);

    if ((isCrawler) && self.isAlive)
        self playAnimOnBot("crawlerAnim_walk");
    else if (isBoss && self.isAlive)
        self playAnimOnBot("z_run");
    else
    {
        if (self.isAlive)
        {
            if (self.moveSpeed > 120) self playAnimOnBot("z_run");
            else self playAnimOnBot("z_walk");
        }
    }
    if (self.isAlive) self.isAttacking = false;
}