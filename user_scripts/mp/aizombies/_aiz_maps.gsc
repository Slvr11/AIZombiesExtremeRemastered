#include user_scripts\mp\aizombies\_aiz_map_edits;

setRandomMapVariation()
{
    if (isDefined(level.mapVariation))
        return;

    setDvarIfUninitialized("aiz_forceMapVariation", -1);

    if (getDvarInt("aiz_forceMapVariation") != -1)
    {
        level.mapVariation = getDvarInt("aiz_forceMapVariation");
        setDvar("aiz_forceMapVariation", -1);
        return;
    }

    variations = 0;

    currentMap = user_scripts\mp\aizombies\_aiz::getMapname();
    switch (currentMap)
    {
        case "mp_terminal":
            variations = 1;
        break;
        case "mp_afghan":
            variations = 1;
        break;
        case "mp_boneyard":
            variations = 1;
        break;
        case "mp_brecourt":
            variations = 1;
        break;
        case "mp_checkpoint":
            variations = 1;
        break;
        case "mp_derail":
            variations = 1;
        break;
        case "mp_estate":
            variations = 1;
        break;
        case "mp_favela":
            variations = 1;
        break;
        case "mp_highrise":
            variations = 4;
        break;
        case "mp_invasion":
            variations = 1;
        break;
        case "mp_nightshift":
            variations = 3;
        break;
        case "mp_quarry":
            variations = 1;
        break;
        case "mp_rundown":
            variations = 1;
        break;
        case "mp_rust":
            variations = 2;
        break;
        case "mp_subbase":
            variations = 1;
        break;
        case "mp_terminal":
            variations = 1;
        break;
        case "mp_underpass":
            variations = 1;
        break;
        case "mp_overgrown":
            variations = 1;
        break;
        case "mp_trailerpark":
            variations = 1;
        break;
        case "mp_compact":
            variations = 1;
        break;
        case "mp_strike":
            variations = 1;
        break;
        case "mp_complex":
            variations = 2;
        break;
        case "mp_abandon":
            variations = 1;
        break;
        case "mp_vacant":
            variations = 1;
        break;
        case "mp_storm":
            variations = 1;
        break;
        case "mp_fuel2":
            variations = 2;
        break;
        case "mp_crash":
            variations = 1;
        break;
        case "mp_crossfire":
            variations = 1;
        break;
        case "estate":
            variations = 1;
        break;
        case "oilrig":
            variations = 1;
        break;
        case "contingency":
            variations = 1;
        break;
        case "airport":
            variations = 1;
        break;
        case "cliffhanger":
            variations = 1;
        break;
        case "dc_whitehouse":
            variations = 2;
        break;
        case "boneyard":
            variations = 1;
        break;
        case "gulag":
            variations = 1;
        break;
        case "dcburning":
            variations = 2;
        break;
    }

    if (!isDefined(variations) || variations == 0)
    {
        level.mapVariation = 0;
        return;
    }

    level.mapVariation = randomInt(variations);
}
loadMapEdits()
{
    currentMap = user_scripts\mp\aizombies\_aiz::getMapname();

    switch (currentMap)
    {
        case "mp_afghan":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (-2135,-62,-1440), (-2209,43,-1297));
                spawnMapEditObject("invisiblewall", (-3501,567,-1443), (-3410,1545,-1233));
                spawnMapEditObject("radiation", (-2110,-1344,-1444), 170, 150);//Hurt area
                spawnMapEditObject("randombox", (-1672,-1081,-1444), (0,44,0), (-3434,1581,-1443), (0,115,0), (-2629,-267,-1439), (0,79,0), (-2755,-1177,-1440), (0,73,0));
                spawnMapEditObject("power", (-3136,41,-1446), (0,333,0));
                spawnMapEditObject("perk8", (-2928,-417,-1444), (0,123,0));
                spawnMapEditObject("ammo", (-2710,-424,-1444), (0,34,0));
                spawnMapEditObject("gambler", (-2199,-28,-1444), (0,313,0));
                spawnMapEditObject("killstreak", (-2692,-1314,-1301), (0,168,0));
                spawnMapEditObject("pap", (-2841,-394,-1332), (0,120,0));
                spawnMapEditObject("perk1", (-3822,1390,-1448), (0,185,0));
                spawnMapEditObject("perk2", (-3499,920,-1448), (0,282,0));
                spawnMapEditObject("perk3", (-2502,-13,-1444), (0,7,0));
                spawnMapEditObject("perk4", (-3481,-342,-1448), (0,8,0));
                spawnMapEditObject("perk5", (-3420,379,-1448), (0,280,0));
                spawnMapEditObject("perk6", (-2863,-195,-1445), (0,246,0));
                spawnMapEditObject("perk7", (-3541,-511,-1448), (0,343,0));
                spawnMapEditObject("spawn", (-2084,-708,-1439), (0, randomIntRange(136,212), 0));
                spawnMapEditObject("spawn", (-1941,-886,-1440), (0, randomIntRange(136,212), 0));
                spawnMapEditObject("spawn", (-2157,-371,-1440), (0, randomIntRange(136,212), 0));
                spawnMapEditObject("spawn", (-2347,-748,-1440), (0, randomIntRange(136,212), 0));
                spawnMapEditObject("zombiespawn", (-3883,-553,-1448), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-3975,3,-1448), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-3828,-1164,-1448), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-4523,1006,-1449), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-4422,1209,-1449), (0, 0, 0));
                spawnMapEditObject("mapname", "Desert Wasteland");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -1585);

                deleteDeathTriggers();
            }
        break;
        case "mp_boneyard":
        if (level.mapVariation == 0)
            {
                spawnMapEditObject("randombox", (167,-1775,-124),(0,105,0));
                spawnMapEditObject("power", (88,-2355,-119),(0,120,0));
                spawnMapEditObject("perk8", (314,-2309,-124),(0,131,0));
                spawnMapEditObject("ammo", (-56,-1799,-120),(0,100,0));
                spawnMapEditObject("gambler", (960,-1661,-51),(0,90,0));
                spawnMapEditObject("killstreak", (248,-3140,-77),(0,293,0));
                spawnMapEditObject("pap", (-537,-2008,-88),(0,90,0));
                spawnMapEditObject("perk1", (1301,-2258,-51),(0,0,0));
                spawnMapEditObject("perk2", (-122,-875,-108),(0,90,0));
                spawnMapEditObject("perk3", (-370,-756,-65),(0,0,0));
                spawnMapEditObject("perk4", (-261,-3077,-68),(0,31,0));
                spawnMapEditObject("perk5", (-875,-1093,-84),(0,163,0));
                spawnMapEditObject("perk6", (-553,-756,-76),(0,0,0));
                spawnMapEditObject("perk7", (-565,-2420,0),(0,70,0));
                spawnMapEditObject("spawn", (124,-810,-124), (0, 270, 0));
                spawnMapEditObject("spawn", (71,-810,-124), (0, 270, 0));
                spawnMapEditObject("spawn", (7,-813,-124), (0, 270, 0));
                spawnMapEditObject("spawn", (-42,-811,-123), (0, 270, 0));
                spawnMapEditObject("zombiespawn", (-674,-3297,-12), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1287,-2771,-52), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1268,-2908,-52), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1205,-2046,-52), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1440,-4082,-52), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1036,-3259,-12), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1212,-2318,-7), (0, 0, 0));
                spawnMapEditObject("mapname", "Deserted Entrance");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -200);
            }
        break;
        case "mp_brecourt":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (10694,6956,1545),(10693,7477,1600));
                spawnMapEditObject("teleport", (10703,6942,343),(11371,7212,1471));//Teleporter
                spawnMapEditObject("teleport", (10713,7023,1471),(9845,7341,343));//Teleporter2
                
                spawnMapEditObject("randombox", (10113,7044,358),(0,90,0));
                spawnMapEditObject("power", (10113,7198,358),(0,90,0));
                spawnMapEditObject("perk8", (10113,7327,358),(0,90,0));
                spawnMapEditObject("ammo", (9480,6527,358),(0,90,0));
                spawnMapEditObject("ammo", (10901,7439,1481),(0,0,0));
                spawnMapEditObject("gambler", (10113,8312,358),(0,90,0));
                spawnMapEditObject("killstreak", (10360,6935,353),(0,0,0));
                spawnMapEditObject("pap", (10727,7210,1486),(0,90,0));
                spawnMapEditObject("perk1", (10528,6222,358),(0,0,0));
                spawnMapEditObject("perk2", (10374,6224,358),(0,0,0));
                spawnMapEditObject("perk3", (9983,6227,358),(0,0,0));
                spawnMapEditObject("perk4", (11909,7442,1486),(0,0,0));
                spawnMapEditObject("perk5", (10241,6224,358),(0,0,0));
                spawnMapEditObject("perk6", (10116,6224,358),(0,0,0));
                spawnMapEditObject("perk7", (11911,6989,1486),(0,0,0));
                spawnMapEditObject("spawn", (10943,7200,1486), (0, 0, 0));
                spawnMapEditObject("spawn", (9958,7285,358), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (10961,6828,358), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (10955,6688,358), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (9850,8886,358), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (9693,8883,358), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (12867,7423,1486), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (12856,7070,1486), (0, 0, 0));
                spawnMapEditObject("mapname", "Apartment Rooftops");
                spawnMapEditObject("fallLimit", 0);
                spawnMapEditObject("maxWave", 30);
            }
        break;
        case "mp_checkpoint":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("randombox", (2740,2738,8),(0,90,0));
                spawnMapEditObject("power", (2597,2610,3),(0,0,0));
                spawnMapEditObject("perk8", (2361,2807,11),(0,90,0));
                spawnMapEditObject("ammo", (2582,2892,8),(0,0,0));
                spawnMapEditObject("gambler", (2701,2889,3),(0,0,0));
                spawnMapEditObject("killstreak", (2377,3162,11),(0,90,0));
                spawnMapEditObject("pap", (2588,2714,3),(0,90,0));
                spawnMapEditObject("perk1", (2490,2216,12),(0,90,0));
                spawnMapEditObject("perk7", (2364,2267,11),(0,90,0));
                spawnMapEditObject("spawn", (2367,1941,47), (0, 90, 0));
                spawnMapEditObject("spawn", (2485,1943,47), (0, 90, 0));
                spawnMapEditObject("spawn", (2435,2052,21), (0, 90, 0));
                spawnMapEditObject("zombiespawn", (2584,5298,0), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2280,5295,0), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-42,3239,16), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-39,3020,16), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (4030,2730,0), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (4083,3150,0), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-68,2785,19), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (4308,2511,3), (0, 0, 0));
                spawnMapEditObject("mapname", "Shipping Dock");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -50);
            }
        break;
        case "mp_derail":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (1506,1760,130), (1501,1462,244));
                spawnMapEditObject("invisiblewall", (1671,3064,130),(1600,2944,244));
                spawnMapEditObject("invisiblewall", (2711,1122,130),(2523,1152,244));
                spawnMapEditObject("invisiblewall", (2713,3136,142),(2520,3131,244));
                spawnMapEditObject("invisiblewall", (1680,3110,158),(1687,3345,227));
                spawnMapEditObject("crate", (2346,3447,294),(0,0,0));
                spawnMapEditObject("crate", (2346,3447,250),(0,0,0));
                spawnMapEditObject("crate", (2346,3447,350),(0,0,0));
                spawnMapEditObject("crate", (1884,3190,456),(0,90,0));
                spawnMapEditObject("crate", (1884,3190,500),(0,90,0));
                spawnMapEditObject("crate", (1884,3190,550),(0,90,0));
                spawnMapEditObject("crate", (1884,3254,450),(0,90,0));
                spawnMapEditObject("crate", (1884,3254,500),(0,90,0));
                spawnMapEditObject("crate", (1884,3254,550),(0,90,0));
                spawnMapEditObject("crate", (2602,2809,158),(0,0,0));
                spawnMapEditObject("crate", (2602,2809,200),(0,0,0));
                spawnMapEditObject("crate", (2602,2809,250),(0,0,0));
                spawnMapEditObject("crate", (1820,2127,320),(0,90,0));
                spawnMapEditObject("crate", (1820,2127,370),(0,90,0));
                spawnMapEditObject("crate", (1820,2198,320),(0,90,0));
                spawnMapEditObject("crate", (1820,2198,370),(0,90,0));
                spawnMapEditObject("crate", (1683,3186,344),(0,90,0));
                spawnMapEditObject("crate", (1684,3269,344),(0,90,0));

                spawnMapEditObject("randombox", (1790,3371,294),(0,0,0), (2191,2949,158),(0,90,0), (1901,2060,294),(0,0,0));
                spawnMapEditObject("power", (1959,2233,294),(0,90,0));
                spawnMapEditObject("perk8", (1738,3371,158),(0,0,0));
                spawnMapEditObject("ammo", (1888,2672,158),(0,90,0));
                spawnMapEditObject("gambler", (1810,3084,158),(0,0,0));
                spawnMapEditObject("killstreak", (2488,2400,153),(0,105,0));
                spawnMapEditObject("pap", (2495,3319,294),(0,90,0));
                spawnMapEditObject("perk1", (2154,2606,282),(0,0,0));
                spawnMapEditObject("perk2", (1824,2450,158),(0,90,0));
                spawnMapEditObject("perk3", (1896,2060,158),(0,0,0));
                spawnMapEditObject("perk4", (2153,3196,425),(0,90,0));
                spawnMapEditObject("perk5", (1824,2308,158),(0,90,0));
                spawnMapEditObject("perk6", (1824,2158,158),(0,90,0));
                spawnMapEditObject("perk7", (2299,2788,153),(0,0,0));
                spawnMapEditObject("spawn", (1759,3281,158), (0, 90, 0));
                spawnMapEditObject("spawn", (1748,3223,158), (0, 90, 0));
                spawnMapEditObject("spawn", (1753,3150,158), (0, 90, 0));
                spawnMapEditObject("spawn", (1826,3156,158), (0, 90, 0));
                spawnMapEditObject("spawn", (1828,3198,158), (0, 90, 0));
                spawnMapEditObject("spawn", (1832,3249,158), (0, 90, 0));
                spawnMapEditObject("spawn", (1974,3267,158), (0, 90, 0));
                spawnMapEditObject("spawn", (1973,3137,158), (0, 90, 0));
                spawnMapEditObject("zombiespawn", (981,3216,192), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1042,3240,192), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (914,1633,198), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (933,1567,176), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2760,819,186), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2987,823,188), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2541,3475,247), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1695,2781,129), (0, 0, 0));
                spawnMapEditObject("fallLimit", 100);
                spawnMapEditObject("mapname", "Frozen Warehouse");
                spawnMapEditObject("maxWave", 30);
            }
        break;
        case "mp_estate":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("radiation", (-2276,-1298,-434),55,150);
                spawnMapEditObject("radiation", (-2168,-1125,-369),55,150);

                spawnMapEditObject("hellMap", true);
                spawnMapEditObject("randombox", (-3191,-1275,-527),(0,156,0));
                spawnMapEditObject("perk8", (-2042,-525,-341),(0,113,0));
                spawnMapEditObject("ammo", (-3473,-814,-575),(0,116,0));
                spawnMapEditObject("gambler", (-2321,-45,-286),(0,0,0));
                spawnMapEditObject("killstreak", (-2067,-901,-333),(0,237,0));
                spawnMapEditObject("pap", (-3591,-749,-527),(0,24,0));
                spawnMapEditObject("spawn", (-2586,-243,-312), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2602,-2388,-490), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2698,-2395,-491), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2771,-2384,-489), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-4069,-5,106), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-4164,-81,100), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2316,-2096,-610), (0, 0, 0));
                spawnMapEditObject("mapname", "Falls of Hell");
                spawnMapEditObject("maxWave", 20);
                spawnMapEditObject("fallLimit", -713);

                deleteDeathTriggers();
            }
        break;
        case "mp_favela":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (2740,2858,250),(3047,3047,469));
                spawnMapEditObject("invisiblewall", (1340,2442,408),(1719,2657,448));
                spawnMapEditObject("invisiblewall", (987,2440,408),(1366,2446,470));
                
                spawnMapEditObject("randombox", (1873,2458,296),(0,207,0));
                spawnMapEditObject("power", (2189,2635,296),(0,207,0));
                spawnMapEditObject("perk8", (2034,2829,296),(0,25,0));
                spawnMapEditObject("ammo", (1717,2640,296),(0,25,0));
                spawnMapEditObject("gambler", (2292,2692,296),(0,207,0));
                spawnMapEditObject("killstreak", (1266,2254,327),(0,105,0));
                spawnMapEditObject("pap", (2043,2561,291),(0,207,0));
                spawnMapEditObject("perk1", (2695,3160,291),(0,352,0));
                spawnMapEditObject("perk2", (1756,2400,291),(0,207,0));
                spawnMapEditObject("perk3", (1468,2492,291),(0,25,0));
                spawnMapEditObject("perk4", (2149,2889,291),(0,25,0));
                spawnMapEditObject("perk5", (1572,2310,291),(0,207,0));
                spawnMapEditObject("perk6", (1606,2570,291),(0,25,0));
                spawnMapEditObject("perk7", (1049,2424,292),(0,90,0));
                spawnMapEditObject("spawn", (1505,2348,298), (0, 0, 0));
                spawnMapEditObject("spawn", (1492,2397,298), (0, 0, 0));
                spawnMapEditObject("spawn", (1474,2453,298), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2951,3108,296), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2892,3025,296), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2699,3120,296), (0, 0, 0));
                spawnMapEditObject("mapname", "^1Rundown Town");
                spawnMapEditObject("maxWave", 30);
            }
        break;
        case "mp_highrise":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("ramp", (-2368,10168,2256), (-2368,11271,2256));
                spawnMapEditObject("ramp", (-2368,11271,2256), (-2655,11271,2256));
                spawnMapEditObject("ramp", (-2655,11271,2256), (-2655,10168,2256));
                spawnMapEditObject("ramp", (-2655,10168,2256), (-2368,10168,2256));
                spawnMapEditObject("ramp", (-2525,10916,2192), (-2521,11271,2256));
                spawnMapEditObject("ramp", (-2503,10469,2192), (-2507,10168,2256));
                spawnMapEditObject("randombox", (-1608,9688,2179), (0,90,0), (-1939,10416,2275), (0,0,0), (-942,10876,2179), (0,90,0), (-666,11472,2179), (0,0,0));
                spawnMapEditObject("power", (-2824,11461,2179), (0,90,0));
                spawnMapEditObject("perk8", (-2297,9593,2275), (0,0,0));
                spawnMapEditObject("ammo", (-551,11091,2179), (0,90,0));
                spawnMapEditObject("gambler", (-2754,9895,2275), (0,90,0));
                spawnMapEditObject("killstreak", (-1210,10063,2179), (0,0,0));
                spawnMapEditObject("pap", (-1471,10415,2179), (0,0,0));
                spawnMapEditObject("fallLimit", -2200);
                spawnMapEditObject("perk1", (-850,11023,2179), (0,0,0));
                spawnMapEditObject("perk2", (-1642,11089,2179), (0,0,0));
                spawnMapEditObject("perk3", (-1096,10414,2179), (0,90,0));
                spawnMapEditObject("perk4", (-1224,10757,2179), (0,90,0));
                spawnMapEditObject("perk5", (-1458,11087,2179), (0,0,0));
                spawnMapEditObject("perk6", (-1096,10962,2179), (0,90,0));
                spawnMapEditObject("perk7", (-2184,10012,2275), (0,90,0));
                spawnMapEditObject("spawn", (-667,9679,2184), (0, 90, 0));
                spawnMapEditObject("spawn", (-793,9681,2184), (0, 90, 0));
                spawnMapEditObject("spawn", (-912,9683,2184), (0, 90, 0));
                spawnMapEditObject("spawn", (-1078,9684,2184), (0, 90, 0));
                spawnMapEditObject("zombiespawn", (-2727,11367,2275), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1677,11280,2179), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1684,11124,2179), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-558,9998,2179), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2362,11359,2275), (0, 0, 0));
                spawnMapEditObject("mapname", "High Hilton");
                spawnMapEditObject("maxWave", 30);

                deleteDeathTriggers();
            }
            else if (level.mapVariation == 1)
            {
                spawnMapEditObject("elevator", (1319,10828,3376), (0,90,0), (1319,10828,4100), (1319,10828,4100));
                spawnMapEditObject("elevator", (1808,11462,4075), (0,0,0), (1808,11462,3376), (1808,11300,3376));
                spawnMapEditObject("elevator", (3000,9943,3376), (0,0,0), (3705,3599,2420), (3705,3550,2420));//Zipline
                spawnMapEditObject("elevator", (4191,3705,2360), (0,0,0), (1681,10073,3429), (1681,10125,3429));//Zipline
                spawnMapEditObject("randombox", (2308,10069,4075), (0,0,0), (1439,10831,3371), (0,90,0), (5066,2931,2355), (0,0,0), (2727,11599,3371), (0,0,0));
                spawnMapEditObject("power", (1451,10172,4075), (0,0,0));
                spawnMapEditObject("perk8", (2242,11440,4075), (0,90,0));
                spawnMapEditObject("ammo", (5046,2666,2355), (0,180,0));
                spawnMapEditObject("ammo", (1384,10768,3371), (0,180,0));
                spawnMapEditObject("ammo", (1896,10863,4075), (0,90,0));
                spawnMapEditObject("gambler", (1383,10895,3371), (0,180,0));
                spawnMapEditObject("killstreak", (3513,3144,2355), (0,0,0));
                spawnMapEditObject("pap", (1707,10096,3371), (0,0,0));
                spawnMapEditObject("ramp", (2314,-9299,-287), (2654,-8577,-287));
                spawnMapEditObject("perk1", (1394,11458,4075), (0,0,0));
                spawnMapEditObject("perk2", (4981,3698,2355), (0,0,0));
                spawnMapEditObject("perk3", (2943,11008,3371), (0,90,0));
                spawnMapEditObject("perk4", (2943,10664,3371), (0,90,0));
                spawnMapEditObject("perk5", (3089,3237,2355), (0,90,0));
                spawnMapEditObject("perk6", (2943,10310,3371), (0,90,0));
                spawnMapEditObject("perk7", (1936,10035,3371), (0,0,0));
                spawnMapEditObject("spawn", (1278,10408,3376), (0, 0, 0));
                spawnMapEditObject("spawn", (1337,10648,3376), (0, 0, 0));
                spawnMapEditObject("spawn", (5144,2945,2360), (0, 0, 0));
                spawnMapEditObject("spawn", (5503,2899,2360), (0, 0, 0));
                spawnMapEditObject("spawn", (1320,11286,4080), (0, 0, 0));
                spawnMapEditObject("spawn", (1349,11041,4080), (0, 0, 0));
                spawnMapEditObject("mapname", "The Twin Buildings");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -108);

                deleteDeathTriggers();

                highrise_createProgressArea((2208,10676,3371),1500,150,0);
	            highrise_createProgressArea((2230,10895,4075),1500,150,1);
	            highrise_createProgressArea((5074,2460,2355),2500,150,2);
            }
            if (level.mapVariation == 2)
            {
                spawnMapEditObject("randombox", (-8060.7,6789.3,2331.1), (0,0,0), (-9049.5,6786.7,2331.1), (0,0,0), (-8942.2,4284.3,2331.1), (0,225,0), (-9248.9,5427.1,2331.1),(0,90,0));
                spawnMapEditObject("power", (-7898.1,5330.9,2331.1), (0,224.9,0));
                spawnMapEditObject("perk8", (-8124.8,5095.5,2331.1), (0,224.9,0));
                spawnMapEditObject("ammo", (-8245.9,6795.1,2331.1), (0,0,0));
                spawnMapEditObject("gambler", (-8471.1,4745.8,2331.1), (0,224.9,0));
                spawnMapEditObject("killstreak", (-8767.7,6789.3,2331.1), (0,0,0));
                spawnMapEditObject("pap", (-8493.3,5516.3,2331.1), (0,0,0));
                spawnMapEditObject("perk1", (-8767.5,5348.4,2331.1), (0,0,0));
                spawnMapEditObject("perk2", (-8642.2,5469.6,2331.1), (0,90,0));
                spawnMapEditObject("perk3", (-8487.1,5452.1,2331.1), (0,0,0));
                spawnMapEditObject("perk4", (-9728,6049,2331), (0,90,0));
                spawnMapEditObject("perk5", (-8666.7,5587.1,2331.1), (0,0,0));
                spawnMapEditObject("perk6", (-8791.6,5474.1,2331.1), (0,90,0));
                spawnMapEditObject("perk7", (-8443,5731,2331), (0,0,0));
                spawnMapEditObject("spawn", (-7981,5599,2331), (0, 180, 0));
                spawnMapEditObject("spawn", (-7976,5762,2331), (0, 180, 0));
                spawnMapEditObject("spawn", (-7977,5979,2331), (0, 180, 0));
                spawnMapEditObject("spawn", (-7980,6285,2331), (0, 180, 0));
                spawnMapEditObject("spawn", (-7950,6566,2331), (0, 180, 0));
                spawnMapEditObject("spawn", (-7962,6746,2331), (0, 180, 0));
                spawnMapEditObject("spawn", (-8206,5374,2331), (0, 180, 0));
                spawnMapEditObject("zombiespawn", (-10570.8,3467.6,2331.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-10585.3,4465.4,2331.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-10584.8,5087.2,2331.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-10582.4,5734.4,2331.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-10585.2,6343.9,2331.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-10590.7,6788.7,2331.1), (0, 0, 0));
                spawnMapEditObject("mapname", "Sunset ^5Infestation");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -2200);

                deleteDeathTriggers();
            }
            if (level.mapVariation == 3)
            {
                spawnMapEditObject("ramp", (-14404,7069.8,5300), (-14380,6890.9,5419.1));

                spawnMapEditObject("randombox", (-13630.1,3855.1,5439.1), (0,0,0), (-14032.2,7520.0,5391.1), (0,35,0), (-15771.6,6051.3,5439.1), (0,90,0), (-14614.7,7443.9,5386.1),(0,33,0));
                spawnMapEditObject("power", (-12808.9,3855.1,5439.1), (0,0,0));
                spawnMapEditObject("perk8", (-15781.4,4024.6,5439.1), (0,90,0));
                spawnMapEditObject("ammo", (-13051.8,3855.1,5439.1), (0,0,0));
                spawnMapEditObject("gambler", (-15781.4,4223.6,5439.1), (0,90,0));
                spawnMapEditObject("killstreak", (-15781.4,5044.6,5439.1), (0,90,0));
                spawnMapEditObject("pap", (-8493.3,5516.3,2331.1), (0,0,0));
                spawnMapEditObject("perk1", (-12757.6,5044.7,5439.1), (0,90,0));
                spawnMapEditObject("perk2", (-12757.6,4640.9,5439.1), (0,90,0));
                spawnMapEditObject("perk3", (-12757.6,4033.2,5439.1), (0,90,0));
                spawnMapEditObject("perk4", (-14593,5474,5434), (0,0,0));
                spawnMapEditObject("perk5", (-12757.6,4373.7,5439.1),(0,90,0));
                spawnMapEditObject("perk6", (-12757.6,4232.4,5439.1), (0,90,0));
                spawnMapEditObject("perk7", (-14313,3862,5434), (0,0,0));
                spawnMapEditObject("spawn", (-14749.7,3934,5439.1), (0, 180, 0));
                spawnMapEditObject("spawn", (-14530.5,3917,5439.1), (0, 180, 0));
                spawnMapEditObject("zombiespawn", (-12790.8,6852.1,5439.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-13306.1,6843.3,5439.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-13634.1,6833.1,5439.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-14091.3,6824.7,5439.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-15127.1,6834.4,5439.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-15743.5,6837.2,5439.1), (0, 0, 0));
                spawnMapEditObject("mapname", "Infestation");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -2200);

                deleteDeathTriggers();
            }
        break;
        case "mp_nightshift":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (-760.1, -918.8, 12.1), (-760.1, -918.8, 100.9));
                spawnMapEditObject("invisiblewall", (-856.2, 343.4, 152.1), (-856.8, 235.9, 235.9));
                spawnMapEditObject("invisiblewall", (-152.7, 719.5, 101.2), (55.9, 722.2, 236.8));
                spawnMapEditObject("invisiblewall", (-266.6, -720.1, 16.1), (-266.6, -767.9, 100.0));
                spawnMapEditObject("invisiblewall", (-2.1, -1840.1, 16.1), (-5.5, -1935.7, 111.8));
                spawnMapEditObject("invisiblewall", (-647.9, -1676.0, 152.1), (-536.1, -1676.3, 253.9));

                spawnMapEditObject("randombox", (-2000.1,-366.9,144.1),(0,90,0), (-2356.7,-912.9,139.1),(0,0,0), (-1176.0,-1986.6,11.1),(0,180,0), (-1432.0,-192.9,3.1),(0,180,0));
                level.boxLocations[level.boxLocations.size] = [(-1414.8,-1984.9,3.1),(0,180,0)];
                spawnMapEditObject("power", (-923.7,217.4,152.1),(0,0,0));
                spawnMapEditObject("perk8", (-2082.8,-1556.8,-39.9),(0,0,0));
                spawnMapEditObject("ammo", (-2281.3,267.9,32.1),(0,0,0));
                spawnMapEditObject("gambler", (-2496.9,-433.0,139.1),(0,90,0));
                spawnMapEditObject("killstreak", (-1087,155,8),(0,0,0));
                spawnMapEditObject("pap", (-2016.4,-50.8,8.1),(0,90,0));
                spawnMapEditObject("perk1", (-752.6,-883.2,12.2),(0,0,0));
                spawnMapEditObject("perk2", (-496.1,-1728.4,152.1),(0,90,0));
                spawnMapEditObject("perk3", (-1576.1,-2213.3,27.1),(0,90,0));
                spawnMapEditObject("perk4", (-1757,304,3),(0,0,0));
                spawnMapEditObject("perk5", (-318.6,-2023.9,16.1),(0,0,0));
                spawnMapEditObject("perk6", (-1328.1,-1864.5,8.1),(0,90,0));
                spawnMapEditObject("perk7", (-1968,-292,3),(0,90,0));
                spawnMapEditObject("spawn", (-2387.2, -350.7, 144.1), (0, 0, 0));
                spawnMapEditObject("spawn", (-2349.1, -793.4, 144.1), (0, 0, 0));
                spawnMapEditObject("spawn", (-2215.3, 203.2, 32.1), (0, 0, 0));
                spawnMapEditObject("spawn", (-1596.6, -17.4, 8.1), (0, 0, 0));
                spawnMapEditObject("spawn", (-1728.4, -533.1, 8.1), (0, 0, 0));
                spawnMapEditObject("spawn", (-1202.0, -1668.5, 16.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-103.6,-1894.1,11.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (48.9,927.4,91.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (48.9,805.9,91.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1856.9,-2192.3,11.9), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1803.5,-2203.2,16.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-323.3,-713.0,7.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-364.8,-538.5,7.1), (0, 0, 0));
                spawnMapEditObject("mapname", "Sunrise Apartments");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -200);
            }
            else if (level.mapVariation == 1)
            {
                spawnMapEditObject("invisiblewall", (-760,-918,12),(-760, -918, 100));
                spawnMapEditObject("invisiblewall", (-856,343,152),(-856, 235, 235));
                spawnMapEditObject("invisiblewall", (-152,719,101),(55, 722, 236));
                spawnMapEditObject("invisiblewall", (-266,-720,16),(-266, -767, 100.0));
                spawnMapEditObject("invisiblewall", (-685,-1840,16),(-684,-1935,111));
                spawnMapEditObject("invisiblewall", (-647,-1676,152),(-536, -1676, 253));
                spawnMapEditObject("invisiblewall", (-197,-275,200),(-200,-448,263));
                spawnMapEditObject("invisiblecrate", (-126,-458,214),(0, 0, 0));
                spawnMapEditObject("elevator", (822,-1730,190), (0,0,0),(1785,-43,223), (1825,-43,223));//Zipline

                spawnMapEditObject("randombox", (1965,-500,16),(0,90,0), (1574,426,24),(0,90,0), (505,-734,11),(0,90,0), (865,-2096,43),(0,180,0));
                level.boxLocations[level.boxLocations.size] = [(1631,-770,119),(0,90,0)];
                spawnMapEditObject("power", (-185,96,16),(0,90,0));
                spawnMapEditObject("perk8", (-2082,-1556,-39),(0,0,0));
                spawnMapEditObject("ammo", (1772,-284,16),(0,0,0));
                spawnMapEditObject("gambler", (1818,-185,227),(0,0,0));
                spawnMapEditObject("killstreak", (543,-696,11),(0,90,0));
                spawnMapEditObject("pap", (1947,309,119),(0,360,0));
                spawnMapEditObject("perk1", (1867,186,224),(0,245,0));
                spawnMapEditObject("perk2", (615,-112,19),(0,180,0));
                spawnMapEditObject("perk3", (31,-991,11),(0,0,0));
                spawnMapEditObject("perk4", (-309,-2016,11),(0,0,0));
                spawnMapEditObject("perk5", (504,-912,11),(0,90,0));
                spawnMapEditObject("perk6", (827,-1799,43),(0,0,0));
                spawnMapEditObject("perk7", (1104,-2112,43),(0,90,0));
                spawnMapEditObject("spawn", (793.4,-1855.6,192.1), (0, 90, 0));
                spawnMapEditObject("spawn", (887.7,-1855.2,192.1), (0, 90, 0));
                spawnMapEditObject("spawn", (1006.8,-1854.7,192.1), (0, 90, 0));
                spawnMapEditObject("spawn", (1068.2,-1851.8,192.1),(0, 90, 0));
                spawnMapEditObject("spawn", (1045,-2027.6,192.1), (0, 90, 0));
                spawnMapEditObject("spawn", (1029.6,-2112.3,192.1), (0, 90, 0));
                spawnMapEditObject("zombiespawn", (-610,-1922,16), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1904,-1258,3), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-205,-745,16), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-107,672,24), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-6,593,24), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-611,-1873,16), (0, 0, 0));
                spawnMapEditObject("mapname", "Rundown Apartments");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -200);
            }
            if (level.mapVariation == 2)
            {
                spawnMapEditObject("invisiblewall", (2057,-3601,0),(1576,-3623,200));
                spawnMapEditObject("invisiblecrate", (2032,-833,16),(0,180,0));
                spawnMapEditObject("invisiblecrate", (2032,-833,50),(0,180,0));
                spawnMapEditObject("invisiblecrate", (2032,-833,100),(0,180,0));

                spawnMapEditObject("randombox", (2040,-1266,16),(0,90,0), (1590,-1393,8),(0,90,0), (1830,-2360,4),(0,0,0));
                spawnMapEditObject("power", (1584,-1842,16),(0,90,0));
                spawnMapEditObject("perk8", (1825,-1967,8),(0,0,0));
                spawnMapEditObject("ammo", (1608,-1247,8),(0,90,0));
                spawnMapEditObject("gambler", (1792,-1580,8),(0,90,0));
                spawnMapEditObject("killstreak", (1591,-2068,11),(0,90,0));
                spawnMapEditObject("pap", (1834,-2794,8),(0,0,0));
                spawnMapEditObject("perk1", (1576,-2863,16),(0,90,0));
                spawnMapEditObject("perk2", (1576,-2521,16),(0,90,0));
                spawnMapEditObject("perk3", (2023,-1613,16),(0,90,0));
                spawnMapEditObject("perk4", (1828,-2283,134),(0,0,0));
                spawnMapEditObject("perk5", (2023,-1990,16),(0,90,0));
                spawnMapEditObject("perk6", (2022,-1792,16),(0,90,0));
                spawnMapEditObject("perk7", (1787,-1748,3),(0,90,0));
                spawnMapEditObject("spawn", (1602,-847,16), (0, 270, 0));
                spawnMapEditObject("spawn", (1653,-851,16), (0, 270, 0));
                spawnMapEditObject("spawn", (1724,-855,16), (0, 270, 0));
                spawnMapEditObject("spawn", (1816,-861,16), (0, 270, 0));
                spawnMapEditObject("spawn", (1889,-862,16), (0, 270, 0));
                spawnMapEditObject("spawn", (1952,-862,16), (0, 270, 0));
                spawnMapEditObject("zombiespawn", (1963,-3377,8), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1740,-3359,16), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1666,-3366,16), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1599,-3368,16), (0, 0, 0));
                spawnMapEditObject("mapname", "River Canal");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -200);
            }
        break;
        case "mp_invasion":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("randombox", (2335,12023,11),(0,90,0));
                spawnMapEditObject("power", (2403,12760,11),(0,0,0));
                spawnMapEditObject("perk8", (2471,11593,11),(0,90,0));
                spawnMapEditObject("ammo", (2335,11223,11),(0,90,0));
                spawnMapEditObject("gambler", (2472,10874,11),(0,90,0));
                spawnMapEditObject("killstreak", (2335,11788,11),(0,90,0));
                spawnMapEditObject("pap", (2403,12760,11),(0,0,0));
                spawnMapEditObject("perk1", (2472,10567,11),(0,90,0));
                spawnMapEditObject("perk2", (2335,10865,11),(0,90,0));
                spawnMapEditObject("perk3", (2335,12127,11),(0,90,0));
                spawnMapEditObject("perk4", (2335,10182,11),(0,90,0));
                spawnMapEditObject("perk5", (2476,11173,11),(0,90,0));
                spawnMapEditObject("perk6", (2335,11544,11),(0,90,0));
                spawnMapEditObject("perk7", (2474,10170,11),(0,90,0));
                spawnMapEditObject("spawn", (2411,12662,11), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (4707,12271,4), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (4656,11899,9), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (4139,11325,-37), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2401,8462,16), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2460,8366,16), (0, 0, 0));
                spawnMapEditObject("mapname", "Dam Sea");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", 0);
            }
        break;
        case "mp_quarry":
            if (level.mapVariation == 0)
            {
                //Additions for map bounds
                spawnMapEditObject("invisiblewall", (-1850, 690, 0),(-2289, 665, 175));
                spawnMapEditObject("crate", (-2495, 677, 190),(0, 0, 0));
                spawnMapEditObject("crate", (-3320, 1452, 25),(0, 0, 0));
                spawnMapEditObject("crate", (-3320, 1452, 75),(0, 0, 0));
                spawnMapEditObject("crate", (-5450, 1793, 110),(0, 0, 0));
                spawnMapEditObject("crate", (-5450, 1793, 150),(0, 0, 0));
                spawnMapEditObject("crate", (-5450, 1793, 190),(0, 0, 0));
                spawnMapEditObject("crate", (-5130, 1798, 110),(0, 0, 0));
                spawnMapEditObject("crate", (-5130, 1798, 150),(0, 0, 0));
                spawnMapEditObject("invisiblewall", (-4591, 2057, -50),(-4103, 1908, 200));
                spawnMapEditObject("invisiblewall", (-3791, 1525, 125),(-4110, 1525, 200));
                spawnMapEditObject("invisiblewall", (-4090, 1515, 125),(-4090, 1875, 200));

                spawnMapEditObject("powerramp", (-1634.4,1019.0,20.1),(-1623.5,823.6,176.1));
                
                spawnMapEditObject("randombox", (-1462.1,2046.0,171.1),(0,90,0));
                spawnMapEditObject("power", (-4825.4,1997.4,187.1),(0,90,0));
                spawnMapEditObject("perk8", (-3362.6,1901.5,163.2),(0,90,0));
                spawnMapEditObject("ammo", (-1832.9,2074.2,171.1),(0,90,0));
                spawnMapEditObject("gambler", (-1431.1,1693.2,35.1),(0,90,0));
                spawnMapEditObject("killstreak", (-1678,2152,171),(0,0,0));
                spawnMapEditObject("pap", (-1839.9,768.7,169.5),(0,90,0));
                spawnMapEditObject("perk1", (-1424.1,778.7,171.5),(0,90,0));
                spawnMapEditObject("perk2", (-2020.9,1687.1,35.1),(0,0,0));
                spawnMapEditObject("perk3", (-1660.2,727.1,35.1),(0,0,0));
                spawnMapEditObject("perk4", (-2658,2767,84),(0,0,0));
                spawnMapEditObject("perk5", (-1815.1,2789.7,84.9),(0,90,0));
                spawnMapEditObject("perk6", (-2395.3,1288.9,31.1),(0,0,0));
                spawnMapEditObject("perk7", (-1565,727,169),(0,0,0));
                spawnMapEditObject("spawn", (-1725.1, 2015, 176.1), (0, 0, 0));
                spawnMapEditObject("spawn", (-1662.3, 2050, 176.1), (0, 0, 0));
                spawnMapEditObject("spawn", (-1621.4, 1213.7, 40.1), (0, 0, 0));
                spawnMapEditObject("spawn", (-1625.4, 1099.8, 40.1), (0, 0, 0));
                spawnMapEditObject("spawn", (-1620.0, 825, 40.1), (0, 0, 0));
                spawnMapEditObject("spawn", (-2564.1, 942.0, 40.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-5450.5,2040.9,98.4), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-5299.9,2052.6,96.5), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-4564.2,3020.4,81.6), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2071.8,765.1,29), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2208.5,762.4,28.8), (0, 0, 0));
                spawnMapEditObject("mapname", "Construction Graveyard");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -300);
            }
        break;
        case "mp_rundown":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("model", "foliage_tree_palm_bushy_1", (984,2536,60),(0,90,0));//Tree1
                spawnMapEditObject("model", "foliage_pacific_fern01_animated", (984,2536,60),(0,90,0));//Tree2
                //Tree collision
                spawnMapEditObject("invisiblecrate", (984,2536,100), (90, 0, 0));
                spawnMapEditObject("invisiblecrate", (984,2536,160), (90, 0, 0));
                spawnMapEditObject("zipline", (1403,3316,75), (0,0,0), 5000, (1638, 3308,252), (1630, 2414,252), (1052, 2402,130), (1047, 2902,96), (1009, 3261,130));

                spawnMapEditObject("invisiblewall", (1536,2303,50),(1472,2300,200));
                spawnMapEditObject("invisiblewall", (695,2131,100),(495,2174,200));
                spawnMapEditObject("invisiblewall", (304,2327,140),(163,2936,250));
                spawnMapEditObject("randombox", (1407,2651,77), (0,0,0));
                spawnMapEditObject("power", (497,3358,59),(0,0,0));
                spawnMapEditObject("perk8", (1496,3056,77),(0,90,0));
                spawnMapEditObject("ammo", (830,2953,75),(0,90,0));
                spawnMapEditObject("gambler", (1215,2988,77),(0,0,0));
                spawnMapEditObject("killstreak", (1535,2699,75),(0,90,0));
                spawnMapEditObject("pap", (1236,2644,82),(0,0,0));
                spawnMapEditObject("perk1", (1708,3040,73),(0,90,0));
                spawnMapEditObject("perk2", (1279,3028,82),(0,0,0));
                spawnMapEditObject("perk3", (1426,3187,82),(0,0,0));
                spawnMapEditObject("perk4", (391,2320,134),(0,0,0));
                spawnMapEditObject("perk5", (1366,3028,82),(0,0,0));
                spawnMapEditObject("perk6", (1343,3187,82),(0,0,0));
                spawnMapEditObject("perk7", (963,2919,80),(0,90,0));
                spawnMapEditObject("spawn", (1432, 2922, 82), (0, 0, 0));
                spawnMapEditObject("spawn", (1238, 2876, 82), (0, 0, 0));
                spawnMapEditObject("spawn", (1327, 3112, 82), (0, 0, 0));
                spawnMapEditObject("spawn", (1425, 3098, 82), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (445,1859,121), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1581,2081,-5), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-86,2560,146), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (117,2234,213), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (514,3748,41), (0, 0, 0));
                spawnMapEditObject("mapname", "Old Shack");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -50);
            }
        break;
        case "mp_rust":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (-579.5,-9976.5,-290.5), (-1192,-9332.6,0));
                spawnMapEditObject("invisiblewall", (3281.4,-10772.8,-271.1), (3136.1,-9614.3,-73.2));
                spawnMapEditObject("randombox", (2749.3,-9489.3,-271.5), (0,-25.1,0));
                spawnMapEditObject("power", (1477.0,-10211.9,-162.4), (0,162.4,0));
                spawnMapEditObject("perk8", (515.5,-10056.6,-67.3), (0,172.1,0));
                spawnMapEditObject("ammo", (1777.3,-10392.6,-201.5), (0,155,0));
                spawnMapEditObject("gambler", (2630.3,-9443.5,-276.5), (0,340.8,0));
                spawnMapEditObject("killstreak", (1402,-9884,-177), (0,90,0));
                spawnMapEditObject("pap", (2649,-8583,-261), (0,329,0));
                spawnMapEditObject("powerramp", (2314,-9299,-287), (2654,-8577,-287));
                spawnMapEditObject("perk1", (-161.8,-10090.0,-155.0), (0,177.6,0));
                spawnMapEditObject("perk2", (756.5,-10078.5,-89.8), (0,180,0));
                spawnMapEditObject("perk3", (1637.8,-9032.8,-274.2), (0,341.8,0));
                spawnMapEditObject("perk4", (1885,-10492,-216), (0,138,0));//AmmoMatic
                spawnMapEditObject("perk5", (3161.6,-10811.7,-176.2), (0,206.2,0));//Stopping Power
                spawnMapEditObject("perk6", (2176.6,-9246.8,-274.8), (0,335.1,0));
                spawnMapEditObject("perk7", (1673,-10304,-187), (0,140,0));
                spawnMapEditObject("spawn", (3024.5, -10978.9, -162.1), (0, 0, 0));
                spawnMapEditObject("spawn", (3028.6, -10879.9, -163.5), (0, 0, 0));
                spawnMapEditObject("spawn", (2658.2, -10886.8, -197.9), (0, 0, 0));
                spawnMapEditObject("spawn", (2551.0, -10848.2, -208.7), (0, 0, 0));
                spawnMapEditObject("spawn", (2408.1, -10792.0, -212.0), (0, 0, 0));
                spawnMapEditObject("spawn", (2683.5, -10662.4, -201.8), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (3703,-6900,-220), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2638,-6917,-258), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2524,-6328,-231), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (4281,-10529,-162), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (4489,-10224,-199), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1342,-9528,-243), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1294,-9813,-191), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1165,-9661,-213), (0, 0, 0));
                spawnMapEditObject("mapname", "Raging River");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -429);
            }
            else if (level.mapVariation == 1)
            {
                spawnMapEditObject("floor", (1302,-6124,-286), (936,-6674,-281));
                spawnMapEditObject("floor", (1338,-5722,-286), (929,-5392,-281));
                spawnMapEditObject("ramp", (1184,-6110,-286), (1174,-5741,-286));
                spawnMapEditObject("ramp", (1370,-5368,-270), (1597,-5147,-255));
                spawnMapEditObject("randombox", (1138,-5393,-255), (0,0,0));
                spawnMapEditObject("power", (1783,-4733,-163), (0,90,0));
                spawnMapEditObject("perk8", (1106,-6128,-255), (0,0,0));
                spawnMapEditObject("ammo", (1092,-6437,-255), (0,0,0));
                spawnMapEditObject("gambler", (924,-6453,-255), (0,90,0));
                spawnMapEditObject("pap", (1580,-4481,-147), (0,0,0));
                spawnMapEditObject("perk1", (1353,-5549,-255), (0,90,0));
                spawnMapEditObject("perk3", (914,-5550,-255), (0,90,0));
                spawnMapEditObject("perk7", (1317,-6359,-255), (0, 90,0));
                spawnMapEditObject("spawn", (1444,-4791,-139), (0, 270, 0));
                spawnMapEditObject("spawn", (1595,-4899,-172), (0, 270, 0));
                spawnMapEditObject("spawn", (1239,-4898,-196), (0, 270, 0));
                spawnMapEditObject("spawn", (1479,-4565,-160), (0, 270, 0));
                spawnMapEditObject("spawn", (1712,-4699,-163), (0, 270, 0));
                spawnMapEditObject("spawn", (1279,-5597,-255), (0, 270, 0));
                spawnMapEditObject("spawn", (986,-5643,-255), (0, 270, 0));
                spawnMapEditObject("spawn", (1152,-5514,-255), (0, 270, 0));
                spawnMapEditObject("spawn", (1178,-5915,-255), (0, 270, 0));
                spawnMapEditObject("spawn", (1004,-6355,-255), (0, 270, 0));
                spawnMapEditObject("spawn", (998,-6475,-255), (0, 270, 0));
                spawnMapEditObject("spawn", (1154,-6598,-255), (0, 270, 0));
                spawnMapEditObject("spawn", (1195,-6393,-255), (0, 270, 0));
                spawnMapEditObject("zombiespawn", (532,-9970,-75), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (842,-10000,-92), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1154,-9684,-131), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1483,-9520,-164), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-651,-5268,-201), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-712,-5424,-217), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2660,-6704,-252), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2775,-7030,-245), (0, 0, 0));
                spawnMapEditObject("mapname", "Raging River Storm");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -300);
            }
        break;
        case "mp_subbase":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("model", "vehicle_uaz_winter_destructible", (-340,-3788,16),(0,26,0));//Car1
                spawnMapEditObject("model", getAlliesFlagModel("mp_subbase"), (-336,-3851,73),(0,180,0));//FlagFriendly
                spawnMapEditObject("model", getAxisFlagModel("mp_subbase"), (133,-4008,472),(0,90,0));//FlagEnemy
                spawnMapEditObject("model", "mil_tntbomb_mp", (-323,-3859,47),(90,90,0));//TNTBomb
                spawnMapEditObject("model", "h1_vehicle_mig29", (-959,-4294,-40),(32,90,45));//Mig
                spawnMapEditObject("model", "h1_vehicle_mig29", (-1140,-3913,-211),(32,-90,45));//Mig
                level thread FXFire((-929,-4227,-20));
	            level thread SmokeFx((-930,-4519,92));
	            level thread SmokeFx((-974,-4495,126));
	            level thread LightFxRed((-1106,-4355,192));

                spawnMapEditObject("hellMap", true);
                spawnMapEditObject("randombox", (-208,-4142,27),(0,90,0), (-412,-6440,0),(0,0,0));
                spawnMapEditObject("ammo", (-495,-4193,17),(0,90,0));
                spawnMapEditObject("gambler", (-488,-4360,25),(0,90,0));
                spawnMapEditObject("killstreak", (-488,-4677,20),(0,105,0));
                spawnMapEditObject("pap", (-339,-6440,11),(0,0,0));
                spawnMapEditObject("perk7", (-215,-4328,22),(0,90,0));
                spawnMapEditObject("spawn", (-254,-3903,16), (0, 0, 0));
                spawnMapEditObject("spawn", (-326,-3906,16), (0, 0, 0));
                spawnMapEditObject("spawn", (-408,-3905,16), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-422,-6429,16), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-339,-6430,16), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-252,-6434,16), (0, 0, 0));
                spawnMapEditObject("mapname", "Sub Pens of Hell");
                spawnMapEditObject("maxWave", 20);
                spawnMapEditObject("fallLimit", -150);
            }
        break;
        case "mp_terminal":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (2295, 4425, 210), (2695, 4435, 400.2));
                spawnMapEditObject("invisiblewall", (1802,4782, 216),(605, 4781, 267));
                spawnMapEditObject("invisiblewall", (407,4646, 207),(304, 4648, 293));
                spawnMapEditObject("invisiblewall", (1858,4435, 324),(1858, 4046, 419));
                spawnMapEditObject("invisiblewall", (1858,3935, 326),(1858, 3554, 418));
                spawnMapEditObject("invisiblewall", (1913,3429, 200),(2151, 3191, 295));
                spawnMapEditObject("invisiblecrate", (2209,4257,315),(0,180,0));
                spawnMapEditObject("invisiblecrate", (1453,4440,315),(0,0,0));
                spawnMapEditObject("invisiblecrate", (1505,4439,315),(0,0,0));

                spawnMapEditObject("elevator", (1595,3988,315),(0,0,0),(1617,3050,197),(1617,3000,197));//Zipline
                spawnMapEditObject("elevator", (1401,4040,315),(0,90,0),(619,3836,357),(619,3775,357));//Zipline2
                spawnMapEditObject("elevator",(1771,3938,42),(0,0,0),(1791,3945,306), (1726.971, 3997, 306));

                spawnMapEditObject("randombox", (1840,4339,179),(0,90,0));
                spawnMapEditObject("power", (1658,2948,195),(0,190,0));
                spawnMapEditObject("perk8", (2038,3294,136),(0,316,0));
                spawnMapEditObject("ammo", (715,2893,56),(0,0,0));
                spawnMapEditObject("gambler", (610,4202,218),(0,180,0));
                spawnMapEditObject("killstreak", (983,4142,51),(0,90,0));
                spawnMapEditObject("pap", (609,2763,213),(0,180,0),(607,2808,213));
                spawnMapEditObject("powerramp", (1739.2, -2213.0, 0), (1741.3, -2479, 190.1));
                spawnMapEditObject("perk1", (1761,4215,448),(0,90,0));
                spawnMapEditObject("perk2", (1392,4730,55),(0,90,0));
                spawnMapEditObject("perk3", (550,3062,213),(0,90,0));
                spawnMapEditObject("perk4", (354,4595,201),(0,0,0));
                spawnMapEditObject("perk5", (550,3527,213),(0,90,0));
                spawnMapEditObject("perk6", (673,3059,213),(0,90,0));
                spawnMapEditObject("perk7", (674,4020,213),(0,90,0));
                spawnMapEditObject("spawn", (1503,4095,184), (0, 0, 0));
                spawnMapEditObject("spawn", (1586,4094,184), (0, 0, 0));
                spawnMapEditObject("spawn", (1700,4084,184), (0, 0, 0));
                spawnMapEditObject("spawn", (1773,4079,184), (0, 0, 0));
                spawnMapEditObject("spawn", (1693,4231,184), (0, 0, 0));
                spawnMapEditObject("spawn", (1582,4237,184), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2814,2838,63), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (45,4253,51), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (11,4157,51), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2917,3983,95), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2426,4398,198), (0, 0, 0));
                spawnMapEditObject("mapname", "Airport Invasion");
                spawnMapEditObject("maxWave", 30);
            }
        break;
        case "mp_underpass":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (4113,3144,432),(4129,3448,500));
                spawnMapEditObject("invisiblewall", (4129,3448,432),(4008,3468,500));
                spawnMapEditObject("invisiblewall", (3669,2446,400),(3426,2553,500));
                spawnMapEditObject("invisiblewall", (3414,2536,400),(3659,2529,500));
                spawnMapEditObject("invisiblewall", (3426,2553,400),(3414,2536,500));
                spawnMapEditObject("invisiblewall", (3669,2446,400),(3659,2529,500));
                
                spawnMapEditObject("randombox", (3975,2304,400),(0,90,0));
                spawnMapEditObject("power", (3655,1726,400),(0,0,0));
                spawnMapEditObject("perk8", (3514,2015,400),(0,132,0));
                spawnMapEditObject("ammo", (3545,1552,400),(0,90,0));
                spawnMapEditObject("gambler", (3691,2508,400),(0,90,0));
                spawnMapEditObject("killstreak", (3651,2240,395),(0,325,0));
                spawnMapEditObject("pap", (3732,2105,395),(0,48,0));
                spawnMapEditObject("ramp", (1739.2, -2213.0, 0), (1741.3, -2479, 190.1));
                spawnMapEditObject("perk1", (3015,3354,395),(0,90,0));
                spawnMapEditObject("perk2", (3660,1968,395),(0,46,0));
                spawnMapEditObject("perk3", (3778,1731,395),(0,0,0));
                spawnMapEditObject("perk4", (3495,2273,395),(0,238,0));
                spawnMapEditObject("perk5", (3542,1426,395),(0,90,0));
                spawnMapEditObject("perk6", (4094,1039,427),(0,0,0));
                spawnMapEditObject("perk7", (4164,1904,427),(0,0,0));
                spawnMapEditObject("spawn", (3949,1062,400), (0, 0, 0));
                spawnMapEditObject("spawn", (3843,1059,400), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2811,3147,400), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (3009,2663,424), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2799,2946,395), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (4036,3602,432), (0, 0, 0));
                spawnMapEditObject("mapname", "Shipping Yard");
                spawnMapEditObject("maxWave", 30);
            }
        break;
        case "mp_overgrown":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (-2250,-5680,-130),(-2900,-5680,0));

                spawnMapEditObject("hellMap", true);
                spawnMapEditObject("randombox", (-1700,-5675,-148),(0,45,0));
                spawnMapEditObject("perk8", (-895,-5675,-157),(0,0,0));
                spawnMapEditObject("ammo", (-1836,-5675,-148),(0,90,0));
                spawnMapEditObject("gambler", (-1287,-5965,-148),(0,223,0));
                spawnMapEditObject("killstreak", (-756,-5675,-159),(0,0,0));
                spawnMapEditObject("pap", (-2788,-6076,-115),(0,90,0));
                spawnMapEditObject("perk1", (-1959,-6334,-145),(0,0,0));
                spawnMapEditObject("perk5", (-1020,-6103,-150), (0, 255, 0));
                spawnMapEditObject("spawn", (-1248,-5800,-153), (0, 245, 0));
                spawnMapEditObject("spawn", (-1317,-5800,-153), (0, 245, 0));
                spawnMapEditObject("spawn", (-1345,-5800,-151), (0, 245, 0));
                spawnMapEditObject("spawn", (-1381,-5800,-157), (0, 245, 0));
                spawnMapEditObject("spawn", (-1617,-5800,-145), (0, 245, 0));
                spawnMapEditObject("spawn", (-1682,-5800,-141), (0, 245, 0));
                spawnMapEditObject("zombiespawn", (-2766,-6210,-143), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2773,-6079,-143), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2766,-5974,-143), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2764,-5577,-144), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1999,-6752,-143), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1461,-6547,-144), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1169,-6295,-144), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-879,-6137,-150), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1522,-6546,-144), (0, 0, 0));
                spawnMapEditObject("mapname", "Overgrown Hell");
                spawnMapEditObject("maxWave", 20);
                spawnMapEditObject("fallLimit", -243);
            }
        break;
        case "mp_trailerpark":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (246,-2267,96), (252,-2599,171));
                spawnMapEditObject("invisiblewall", (-754,-2247,17), (-1424,-2261,120));
                spawnMapEditObject("randombox", (271.1,-2360.1,11.1), (0,90,0));
                spawnMapEditObject("power", (-105,-1470,4), (0,0,0));
                spawnMapEditObject("perk8", (773.1,-2683.9,20.1), (0,0,0));
                spawnMapEditObject("ammo", (2732,-2642,13), (0,90,0));
                spawnMapEditObject("gambler", (858,-2676,15), (0,0,0));
                spawnMapEditObject("killstreak", (2403,-2568,18), (0,90,0));
                spawnMapEditObject("pap", (1958.9,-1706.1,15.4), (0,0,0));
                spawnMapEditObject("powerramp", (1739.2, -2213.0, 0), (1741.3, -2479, 190.1));
                spawnMapEditObject("perk1", (1672.3,-2478.2,190.1), (0,90,0));
                spawnMapEditObject("perk2", (2165.5,-2986.4,190.1), (0,-90,0));
                spawnMapEditObject("perk3", (1613.4,-2907.3,190.1), (0, 73.6,0));
                spawnMapEditObject("perk4", (1468,-2950,15), (0, 0, 0));
                spawnMapEditObject("perk5", (1918.2,-3199.3,190.1), (0, 180, 0));
                spawnMapEditObject("perk6", (2124.6,-3191.7,190.1), (0, 180, 0));
                spawnMapEditObject("perk7", (649,-2676,15), (0, 180, 0));
                spawnMapEditObject("spawn", (1887.5, -2864.0, 24.1), (0, 0, 0));
                spawnMapEditObject("spawn", (1649.6, -2695.0, 24.1), (0, 0, 0));
                spawnMapEditObject("spawn", (1798.7, -2614.4, 24.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2772.9,-2118.9,16.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2785.4,-2068.2,16.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2754.0,-1988.4,17.1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1299.1,-2064.4,16.0), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1176.7,-1980.7,16.0), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1203.7,-2142.3,16.0), (0, 0, 0));
                spawnMapEditObject("mapname", "Abandoned Gas Station");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -50);
            }
        break;
        case "mp_compact":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (1936.1,2335.9,300.9),(2487.9,2339.0,0.8));
                spawnMapEditObject("invisiblewall", (984.1,2623.8,96.1),(1095.9,2614.9,202.4));
                spawnMapEditObject("invisiblecrate",(3505.8,2665.8,11.1),(0,0,0));
                spawnMapEditObject("invisiblecrate",(3505.8,2665.8,51.1),(0,0,0));
                spawnMapEditObject("invisiblecrate",(3505.8,2665.8,91.1),(0,0,0));
                spawnMapEditObject("invisiblecrate",(2044.4,1984.2,42.1),(0,0,0));
                spawnMapEditObject("invisiblecrate",(1998.0,1986.2,42.1),(0,0,0));
                spawnMapEditObject("invisiblecrate",(1846.3,1989.2,178.1),(0,0,0));
                spawnMapEditObject("invisiblecrate",(1787.8,1982.3,178.1),(0,0,0));
                spawnMapEditObject("invisiblecrate",(1595.5,2060.3,45.1),(0,90,0));
                spawnMapEditObject("powerramp", (1957.5,2666.8,0.1),(2027.9,2406.3,130));

                spawnMapEditObject("randombox", (2250.3,3311.6,63.7),(0,0,0));
                spawnMapEditObject("power", (1608.1,2025.3,152.1),(0,90,0));
                spawnMapEditObject("perk8", (2103.8,2230.2,16.1),(0,90,0));
                spawnMapEditObject("ammo", (1644.0,3350.7,87.4),(0,0,0));
                spawnMapEditObject("gambler", (1801.2,2000.1,16.1),(0,0,0));
                spawnMapEditObject("killstreak", (1607,3129,71),(0,90,0));
                spawnMapEditObject("pap", (2807.9,2835.5,70.1),(0,90,0));
                spawnMapEditObject("perk1", (1937.4,2392.1,16.1),(0,0,0));
                spawnMapEditObject("perk2", (2491.9,2472.4,29.0),(0,-90,0));
                spawnMapEditObject("perk3", (2060.0,3351.9,77.5),(0,0,0));
                spawnMapEditObject("perk4", (1753,2360,11),(0,0,0));
                spawnMapEditObject("perk5", (1608.1,2261.2,16.1),(0,90,0));
                spawnMapEditObject("perk6", (2103.9,2078.5,16.1),(0,90,0));
                spawnMapEditObject("perk7", (1718,2399,11),(0,0,0));
                spawnMapEditObject("spawn", (1870.9,2029.6,152.1), (0, 90, 0));
                spawnMapEditObject("spawn", (1876.9,2082.3,152.1), (0, 90, 0));
                spawnMapEditObject("spawn", (1833.3,2271.0,152.1), (0, 90, 0));
                spawnMapEditObject("spawn", (1791.4,2029.6,152.1), (0, 90, 0));
                spawnMapEditObject("spawn", (1718.6,2289.2,152.1), (0, 90, 0));
                spawnMapEditObject("spawn", (1863.5,2302.9,152.1), (0, 90, 0));
                spawnMapEditObject("zombiespawn", (3764,2701,285), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1050,2000,116), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1072,1943,133), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (3763,2759,285), (0, 0, 0));
                spawnMapEditObject("mapname", "Snowy Vacation");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -50);
            }
        break;
        case "mp_strike":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (-3538,1216,32),(-3959,1211,128));
                spawnMapEditObject("invisiblewall", (-3530,1627,16),(-3959,1621,128));
                spawnMapEditObject("invisiblewall", (-2550,1215,0),(-3400,1215,125));
                spawnMapEditObject("invisiblewall", (-3400,1215,0),(-4000,1215,125));
                spawnMapEditObject("invisiblewall", (-2550,1640,0),(-3400,1640,125));
                spawnMapEditObject("invisiblewall", (-3400,1640,0),(-4000,1640,125));
                spawnMapEditObject("invisiblewall", (-4000,1215,0),(-4000,1640,125));
                spawnMapEditObject("invisiblefloor", (-3875,1215,5),(-4000,1400,25));
                spawnMapEditObject("invisibleramp", (-3959,1400,7),(-3959,1650,30));
                spawnMapEditObject("invisibleramp", (-3915,1400,7),(-3915,1650,30));
                spawnMapEditObject("invisibleramp", (-3875,1400,7),(-3875,1650,30));

                spawnMapEditObject("model", "trq_barrier_sawhorse", (-3800,1215,0),(0,0,0));
                spawnMapEditObject("model", "trq_barrier_sawhorse", (-3650,1215,0),(0,10,0));
                spawnMapEditObject("model", "trq_barrier_sawhorse", (-3500,1215,0),(0,-5,0));
                spawnMapEditObject("model", "trq_barrier_sawhorse", (-3800,1640,18),(0,10,0));
                spawnMapEditObject("model", "trq_barrier_sawhorse", (-3650,1640,30),(-5,-5,0));
                spawnMapEditObject("model", "trq_barrier_sawhorse", (-3500,1640,33),(0,0,-6));

                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-3400,1635,33),(1,0,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-3300,1635,30),(1,4,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-3200,1635,28),(1,1,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-3100,1635,26),(1,-2,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-3000,1635,23),(1,0,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-2900,1635,21),(1,-5,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-2800,1635,19),(1,2,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-2700,1635,18),(1,5,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-2600,1635,17),(1,0,-7));

                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-3350,1655,33),(1,5,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-3250,1655,30),(1,-3,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-3150,1655,28),(1,1,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-3050,1655,26),(1,-2,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-2950,1655,23),(1,1,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-2850,1655,21),(1,-5,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-2750,1655,19),(1,3,-7));
                spawnMapEditObject("model", "iw6_concrete_barrier_02_short_mp", (-2650,1655,19),(1,-10,-7));

                spawnMapEditObject("model", "vehicle_delivery_truck", (-4030,1425,28),(-7,180,-1));
                spawnMapEditObject("model", "h1_stk_market_canopy_stall_tarp_green_dlc1", (-4000,1550,35),(0,-90,0));
                spawnMapEditObject("model", "com_folding_table", (-4025,1700,49),(4,0,0));

                spawnMapEditObject("model", "bc_militarytent_wood_table", (-4025,1600,45),(2,0,2));
                spawnMapEditObject("model", "com_trashcan_metal", (-3985,1635,45),(0,0,0));
                spawnMapEditObject("model", "bc_militarytent_wood_table", (-4050,1775,48),(2,90,3));
                spawnMapEditObject("model", "com_folding_chair", (-4050,1700,51),(0,40,0));

                spawnMapEditObject("randombox", (-2199,1240,31),(0,0,0));
                spawnMapEditObject("power", (-3116,1240,20),(0,0,0));
                spawnMapEditObject("perk8", (-3959,1380,30),(0,90,0));
                spawnMapEditObject("ammo", (-2185,1615,24),(0,0,0));
                spawnMapEditObject("gambler", (-2577,1615,24),(0,0,0));
                spawnMapEditObject("killstreak", (-2905,1608,19),(0,0,0));
                spawnMapEditObject("pap", (-2385,1608,19),(0,0,0));
                spawnMapEditObject("perk1", (-3302,1247,12),(0,0,0));
                spawnMapEditObject("perk2", (-2950,1247,15),(0,0,0));
                spawnMapEditObject("perk3", (-2378,1248,22),(0,0,0));
                spawnMapEditObject("perk4", (-2742,1608,19),(0,0,0));
                spawnMapEditObject("perk5", (-2777,1247,16),(0,0,0));
                spawnMapEditObject("perk6", (-2627,1247,17),(0,0,0));
                spawnMapEditObject("perk7", (-3065,1608,19),(0,0,0));
                spawnMapEditObject("spawn", (-2400,1400,24), (0, 180, 0));
                spawnMapEditObject("spawn", (-2300,1400,26), (0, 180, 0));
                spawnMapEditObject("spawn", (-2200,1400,17), (0, 180, 0));
                spawnMapEditObject("zombiespawn", (-3888,1311,17), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-3879,1459,16), (0, 0, 0));
                spawnMapEditObject("mapname", "Back Ally");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -25);
            }
        break;
        case "mp_complex":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (-2135,-62,-1440), (-2209,43,-1297));
                spawnMapEditObject("invisiblewall", (-3501,567,-1443), (-3410,1545,-1233));
                spawnMapEditObject("randombox", (2500,-907,407), (0,90,0));
                spawnMapEditObject("power", (469,-852,407), (0,0,0));
                spawnMapEditObject("perk8", (1236,-1348,407), (0,0,0));
                spawnMapEditObject("ammo", (1695,-543,395), (0,90,0));
                spawnMapEditObject("gambler", (2147,-1132,407), (0,0,0));
                spawnMapEditObject("killstreak", (1120,-541,395), (0,90,0));
                spawnMapEditObject("pap", (844,-47,430), (0,0,0));
                spawnMapEditObject("perk1", (-780,-1294,395), (0,0,0));
                spawnMapEditObject("perk2", (-243,-1062,407), (0,90,0));
                spawnMapEditObject("perk3", (559,-23,395), (0,90,0));
                spawnMapEditObject("perk4", (-1581,-655,395), (0,0,0));
                spawnMapEditObject("perk5", (-108,-852,407), (0,0,0));
                spawnMapEditObject("perk6", (224,-48,395), (0,90,0));
                spawnMapEditObject("perk7", (-597,-69,395), (0,326,0));
                spawnMapEditObject("spawn", (2237,-576,400), (0, 180, 0));
                spawnMapEditObject("spawn", (2252,-711,400), (0, 180, 0));
                spawnMapEditObject("spawn", (2265,-896,400), (0, 180, 0));
                spawnMapEditObject("zombiespawn", (197,-1142,416), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-577,100,402), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1369,100,395), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2105,-164,412), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2076,-426,412), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1925,-1220,412), (0, 0, 0));
                spawnMapEditObject("fallLimit", -250);
                spawnMapEditObject("mapname", "Apartment Invasion");
                spawnMapEditObject("maxWave", 30);

                deleteDeathTriggers();
            }
            if (level.mapVariation == 1)
            {
                spawnMapEditObject("randombox", (2717,-2032,1051), (0,0,0));
                spawnMapEditObject("power", (2620,-1948,1051), (0,90,0));
                spawnMapEditObject("perk8", (2624,-1767,1051), (0,90,0));
                spawnMapEditObject("ammo", (2918,-1806,1056), (0,0,0));
                spawnMapEditObject("gambler", (3164,-1666,1056), (0,90,0));
                spawnMapEditObject("pap", (3164,-1536,1051), (0,90,0));
                spawnMapEditObject("perk1", (2936,-767,1051), (0,0,0));
                spawnMapEditObject("perk2", (3167,-1346,1051), (0,90,0));
                spawnMapEditObject("perk3", (3166,-1787,1051), (0,90,0));
                spawnMapEditObject("perk4", (2628,-1067,1051), (0,90,0));
                spawnMapEditObject("perk5", (2625,-1473,1051), (0,90,0));
                spawnMapEditObject("perk6", (2624,-1642,1051), (0,90,0));
                spawnMapEditObject("perk7", (3138,-899,1051), (0,90,0));
                spawnMapEditObject("spawn", (2864,-2001,1056), (0, 90, 0));
                spawnMapEditObject("spawn", (2974,-1992,1056), (0, 90, 0));
                spawnMapEditObject("spawn", (3068,-1981,1056), (0, 90, 0));
                spawnMapEditObject("zombiespawn", (3133,-849,1056), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2909,-828,1056), (0, 0, 0));
                spawnMapEditObject("fallLimit", 500);
                spawnMapEditObject("mapname", "The Complex");
                spawnMapEditObject("maxWave", 30);

                deleteDeathTriggers();
            }
        break;
        case "mp_abandon":
            if (level.mapVariation == 0)
            {
                trigger = spawn( "trigger_radius", (-2944,3684,3), 0, 100, 200 );
	            trigger.angles = (0,0,0);
	            trigger solid();
	            trigger setContents(1);

                spawnMapEditObject("randombox", (-2779,2928,3), (0,54,0));
                spawnMapEditObject("power", (-2339,2609,3), (0,50,0));
                spawnMapEditObject("perk8", (-2319,1661,3), (0,140,0));
                spawnMapEditObject("ammo", (-2307,3170,3), (0,234,0));
                spawnMapEditObject("gambler", (-1759,2968,3), (0,138,0));
                spawnMapEditObject("killstreak", (-2691,900,-2), (0,50,0));
                spawnMapEditObject("pap", (-1553,2798,3), (0,141,0));
                spawnMapEditObject("perk1", (-2248,1351,3), (0,323,0));
                spawnMapEditObject("perk2", (-3281,2486,3), (0,318,0));
                spawnMapEditObject("perk3", (-2119,3865,3), (0,20,0));
                spawnMapEditObject("perk4", (-2552,1984,3), (0,140,0));
                spawnMapEditObject("perk5", (-3878,2865,3), (0,140,0));
                spawnMapEditObject("perk6", (-2898,3629,3), (0,38,0));
                spawnMapEditObject("perk7", (-1901,1150,3), (0,189,0));
                spawnMapEditObject("spawn", (-2186,2961,3), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1249,1119,3), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2064,1635,3), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1143,1217,3), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-842,2015,3), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-290,3437,3), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-829,4036,3), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-2844,5341,3), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-3144,5303,3), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-3674,4526,3), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-4415,3575,3), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-4112,1326,1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-3793,1030,1), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-3395,777,1), (0, 0, 0));
                spawnMapEditObject("fallLimit", -250);
                spawnMapEditObject("mapname", "Carnival Parking Lot");
                spawnMapEditObject("maxWave", 30);
            }
        break;
        case "mp_vacant":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (-846,-503,-8),(-849,-384,50));
                spawnMapEditObject("invisiblewall", (-520,16,-31),(-518,-96,50));
                spawnMapEditObject("invisiblewall", (-848,640,-8),(-846,520,50));
                spawnMapEditObject("invisiblewall", (-4,677,-32),(-52,675,50));
                spawnMapEditObject("invisiblewall", (72,959,-32),(73,848,46));
                spawnMapEditObject("invisiblewall", (343,-880,-32),(346,-928,50));
                
                spawnMapEditObject("randombox", (445,1526,-96),(0,0,0));
                spawnMapEditObject("power", (-1659,208,-91),(0,90,0));
                spawnMapEditObject("perk8", (-539,86,-36),(0,90,0));
                spawnMapEditObject("ammo", (-241,692,-31),(0,0,0));
                spawnMapEditObject("gambler", (-828,-261,-37),(0,90,0));
                spawnMapEditObject("killstreak", (-1783,512,-91),(0,180,0));
                spawnMapEditObject("pap", (-1625,972,-83),(0,0,0));
                spawnMapEditObject("ramp", (1739.2, -2213.0, 0), (1741.3, -2479, 190.1));
                spawnMapEditObject("perk1", (196,1600,-101),(0,90,0));
                spawnMapEditObject("perk2", (-867,409,-98),(0,90,0));
                spawnMapEditObject("perk3", (-1404,152,-98),(0,0,0));
                spawnMapEditObject("perk4", (764,1663,-100),(0,90,0));
                spawnMapEditObject("perk5", (-659,78,-100),(0,90,0));
                spawnMapEditObject("perk6", (-1760,-62,-100),(0,0,0));
                spawnMapEditObject("perk7", (53,1093,-36),(0,90,0));
                spawnMapEditObject("spawn", (-53,796,-31), (0, 0, 0));
                spawnMapEditObject("spawn", (-39,949,-31), (0, 0, 0));
                spawnMapEditObject("spawn", (-11,1186,-31), (0, 0, 0));
                spawnMapEditObject("spawn", (-135,1278,-31), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1768,1765,-87), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1830,1769,-87), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-734,1782,-97), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (68,-1375,-88), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (494,-1189,-85), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-972,-1366,-91), (0, 0, 0));
                spawnMapEditObject("mapname", "Chernoybl Disaster");
                spawnMapEditObject("fallLimit", -350);
                spawnMapEditObject("maxWave", 30);
            }
        break;
        case "mp_storm":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblewall", (4700,-62,8),(4737,-59,100));
                spawnMapEditObject("invisiblewall", (2163,-843,8),(2120,-842,100));
                spawnMapEditObject("invisiblewall", (5088,-1360,8),(5004,-1347,100));

                spawnMapEditObject("randombox", (3465,-975,-52),(0,0,0));
                spawnMapEditObject("power", (4646,-975,-52),(0,0,0));
                spawnMapEditObject("perk8", (5040,-1235,-52),(0,90,0));
                spawnMapEditObject("ammo", (4207,-1009,-52),(0,90,0));
                spawnMapEditObject("gambler", (4826,-1328,-52),(0,0,0));
                spawnMapEditObject("killstreak", (3424,-2051,3),(0,90,0));
                spawnMapEditObject("pap", (3843,-1903,8),(0,0,0));
                spawnMapEditObject("perk1", (3412,-844,8),(0,90,0));
                spawnMapEditObject("perk2", (2120,-902,8),(0,90,0));
                spawnMapEditObject("perk3", (3913,-1519,16),(0,0,0));
                spawnMapEditObject("perk4", (5056,-1806,8),(0,90,0));
                spawnMapEditObject("perk5", (3668,-1335,-48),(0,0,0));
                spawnMapEditObject("perk6", (3144,-968,-48),(0,0,0));
                spawnMapEditObject("perk7", (5097,-1360,8),(0,0,0));
                spawnMapEditObject("spawn", (2598,-1279,-47), (0, 0, 0));
                spawnMapEditObject("spawn", (2607,-1148,-47), (0, 0, 0));
                spawnMapEditObject("spawn", (2612,-1023,-48), (0, 0, 0));
                spawnMapEditObject("spawn", (2787,-1132,-48), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (5136,-1295,48), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (5120,-1105,48), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (4957,851,-47), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (4787,794,-48), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2851,-1777,8), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (4210,-837,8), (0, 0, 0));
                spawnMapEditObject("mapname", "Dryed Aqueduct");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -150);
            }
        break;
        case "mp_fuel2":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("floor", (17794,27616,6953),(18703,27165,6953));

                spawnMapEditObject("randombox", (18370,27175,6994),(0,0,0));
                spawnMapEditObject("power", (17794,27366,6994),(0,90,0));
                spawnMapEditObject("perk8", (18228,27608,6994),(0,0,0));
                spawnMapEditObject("ammo", (18249,27358,6994),(0,0,0));
                spawnMapEditObject("gambler", (18705,27380,6994),(0,90,0));
                spawnMapEditObject("killstreak", (17790,27364,6994),(0,90,0));
                spawnMapEditObject("pap", (18041,27175,6994),(0,0,0));
                spawnMapEditObject("perk1", (18051,27345,6994),(0,0,0));
                spawnMapEditObject("perk3", (17962,27608,6994),(0,0,0));
                spawnMapEditObject("perk7", (18571,27608,6994),(0,0,0));
                spawnMapEditObject("spawn", (18515,27358,6994), (0, 0, 0));
                spawnMapEditObject("spawn", (18252,27469,6994), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (13102,29849,8033), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (12960,29570,8034), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (12704,28048,8465), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (14617,25078,9050), (0, 0, 0));
                //spawnMapEditObject("zombiespawn", (18060,32789,8633), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (22002,28482,6810), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (21824,28959,6834), (0, 0, 0));
                spawnMapEditObject("mapname", "Nowhere Mountain");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", 4000);
                spawnMapEditObject("mapCenter", (18249,27358,6994));
            }
            else if (level.mapVariation == 1)
            {
                spawnMapEditObject("invisiblewall", (-5649,2185,-250),(-5762,1365,-50));
                spawnMapEditObject("invisiblewall", (-6307,2417,-250),(-6439,1725,-50));
                spawnMapEditObject("minefield", (-5930,2640,-236), 750, 300);

                spawnMapEditObject("hellMap", true);
                spawnMapEditObject("randombox", (-5996,1435,-125),(0,158,0));
                spawnMapEditObject("ammo", (-6251,1552,-125),(0,147,0));
                spawnMapEditObject("gambler", (-5811,1384,-125),(0,158,0));
                spawnMapEditObject("pap", (-6118,1479,-125),(0,154,0));
                spawnMapEditObject("perk5", (-6399,1668,-125),(0,134,0));
                spawnMapEditObject("spawn", (-6144,1633,-125), (0, 70, 0));
                spawnMapEditObject("spawn", (-6009,1602,-125), (0, 70, 0));
                spawnMapEditObject("spawn", (-5886,1570,-125), (0, 70, 0));
                spawnMapEditObject("zombiespawn", (-5488,3207,-125), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-5784,3263,-125), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-6124,3322,-125), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-6633,3433,-128), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-5712,3658,-125), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-5319,3649,-125), (0, 0, 0));
                spawnMapEditObject("mapname", "Royal Oil Industries");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -500);
            }
        break;
        case "mp_crash":
        case "mp_crash_snow":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("hellMap", true);
                spawnMapEditObject("invisiblewall", (-716,-2169,160), (-753,-3861,254));
                spawnMapEditObject("invisiblewall", (-684,-2152,235), (-430,-2152,310));
                spawnMapEditObject("randombox", (-746,-2175,155), (0,0,0), (-1239,-2646,86), (0,90,0));
                spawnMapEditObject("perk8", (-1169,-2146,118), (0,57,0));
                spawnMapEditObject("ammo", (-1045,-2365,106), (0,0,0));
                spawnMapEditObject("gambler", (-873,-3073,81), (0,273,0));
                spawnMapEditObject("killstreak", (-1280,-3015,81), (0,90,0));
                spawnMapEditObject("pap", (-993,-3925,59), (0,180,0));
                spawnMapEditObject("perk1", (-1191,-3578,68), (0,97,0));
                spawnMapEditObject("spawn", (-1055,-2488,107), (0, 270, 0));
                spawnMapEditObject("spawn", (-1117,-2495,105), (0, 270, 0));
                spawnMapEditObject("spawn", (-1116,-2925,88), (0, 270, 0));
                spawnMapEditObject("spawn", (-1047,-3181,83), (0, 270, 0));
                spawnMapEditObject("spawn", (-910,-3350,79), (0, 270, 0));
                spawnMapEditObject("spawn", (-1041,-2174,119), (0, 270, 0));
                spawnMapEditObject("zombiespawn", (-908,-3844,61), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1052,-3826,61), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1156,-3821,62), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-426,-1637,88), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-472,-1567,93), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-436,-1701,88), (0, 0, 0));
                spawnMapEditObject("fallLimit", 30);
                spawnMapEditObject("mapname", "Hell Tunnel");
                spawnMapEditObject("maxWave", 20);
            }
        break;
        case "mp_crossfire":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("ramp", (2750, -4440, -170), (2408, -4127, -160));
                spawnMapEditObject("invisiblewall", (2844, -4400, -125), (2658, -4700, 75));
                spawnMapEditObject("floor", (2300, -3523, -70), (1925, -3171, -70));

                spawnMapEditObject("hellMap", true);
                spawnMapEditObject("randombox", (2391,-3274,-48), (0,60,0));
                spawnMapEditObject("perk8", (3599.09, -2074.29, 8), (0,-120,0));
                spawnMapEditObject("ammo", (2620, -2948, -6), (0,60,0));
                spawnMapEditObject("gambler", (2159, -3964, -85), (0,60,0));
                spawnMapEditObject("killstreak", (3092.75, -2010.46, 41),(0,240,0));
                spawnMapEditObject("pap", (2329, -4530, -136), (0,-40,0));
                spawnMapEditObject("spawn", (3298,-2511,-17), (0, 180, 0));
                spawnMapEditObject("spawn", (2581,-3090,23), (0, 180, 0));
                spawnMapEditObject("spawn", (2204,-3974,-85), (0, 180, 0));
                spawnMapEditObject("spawn", (2907,-2829,-21), (0, 180, 0));
                spawnMapEditObject("zombiespawn", (2932,-4768,-143), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2963,-4694,-147), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (3011,-4581,-129), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2109,-3215,-29), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2060,-3383,-29), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2680,-2509,35), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (2764,-2343,47), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (3008,-3498,3), (0, 0, 0));
                spawnMapEditObject("mapname", "Alley of Hell");
                spawnMapEditObject("maxWave", 20);
                spawnMapEditObject("fallLimit", -200);

                deleteDeathTriggers();
            }
        case "estate":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblecrate", (430,607,230),(0,0,0));
                spawnMapEditObject("invisiblecrate", (450,597,230),(0,0,0));
                spawnMapEditObject("invisiblecrate", (430,607,210),(0,0,0));
                spawnMapEditObject("invisiblecrate", (450,597,210),(0,0,0));
                spawnMapEditObject("invisiblecrate", (430,607,190),(0,0,0));
                spawnMapEditObject("invisiblecrate", (450,597,190),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (840,200,230),(0,0,0));
                spawnMapEditObject("invisiblecrate", (830,180,230),(0,0,0));
                spawnMapEditObject("invisiblecrate", (840,200,210),(0,0,0));
                spawnMapEditObject("invisiblecrate", (830,180,210),(0,0,0));
                spawnMapEditObject("invisiblecrate", (840,200,190),(0,0,0));
                spawnMapEditObject("invisiblecrate", (830,180,190),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (660,410,220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (680,405,220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (700,400,220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (720,395,220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (740,390,220),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (915,13,215),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (640,-238,75),(0,0,0));
                spawnMapEditObject("invisiblecrate", (620,-233,75),(0,0,0));
                spawnMapEditObject("invisiblecrate", (600,-228,75),(0,0,0));
                spawnMapEditObject("invisiblecrate", (580,-223,75),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (350, -180, 60),(0,0,0));
                spawnMapEditObject("invisiblecrate", (335, -175, 60),(0,0,0));
                spawnMapEditObject("invisiblecrate", (320, -170, 60),(0,0,0));
                spawnMapEditObject("invisiblecrate", (305, -165, 60),(0,0,0));
                spawnMapEditObject("invisiblecrate", (290, -160, 60),(0,0,0));
                spawnMapEditObject("invisiblecrate", (280, -155, 60),(0,0,0));
                spawnMapEditObject("invisiblecrate", (350, -180, 90),(0,0,0));
                spawnMapEditObject("invisiblecrate", (335, -175, 90),(0,0,0));
                spawnMapEditObject("invisiblecrate", (320, -170, 90),(0,0,0));
                spawnMapEditObject("invisiblecrate", (305, -165, 90),(0,0,0));
                spawnMapEditObject("invisiblecrate", (290, -160, 90),(0,0,0));
                spawnMapEditObject("invisiblecrate", (280, -155, 90),(0,0,0));
                spawnMapEditObject("invisiblecrate", (350, -180, 30),(0,0,0));
                spawnMapEditObject("invisiblecrate", (335, -175, 30),(0,0,0));
                spawnMapEditObject("invisiblecrate", (320, -170, 30),(0,0,0));
                spawnMapEditObject("invisiblecrate", (305, -165, 30),(0,0,0));
                spawnMapEditObject("invisiblecrate", (290, -160, 30),(0,0,0));
                spawnMapEditObject("invisiblecrate", (280, -155, 30),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (750, 388, 30),(0,0,0));
                spawnMapEditObject("invisiblecrate", (770, 378, 30),(0,0,0));
                spawnMapEditObject("invisiblecrate", (750, 388, 60),(0,0,0));
                spawnMapEditObject("invisiblecrate", (770, 378, 60),(0,0,0));
                spawnMapEditObject("invisiblecrate", (750, 388, 90),(0,0,0));
                spawnMapEditObject("invisiblecrate", (770, 378, 90),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (640, -239, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (620, -234, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (600, -229, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (580, -224, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (560, -219, 220),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (334, -420, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (314, -415, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (294, -410, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (274, -405, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (254, -400, 220),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (188, -381, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (168, -376, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (148, -371, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (128, -366, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (108, -361, 220),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (-350, 207, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-355, 232, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-360, 257, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-365, 282, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-370, 307, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-350, 207, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-355, 232, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-360, 257, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-365, 282, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-370, 307, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-350, 207, 260),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-355, 232, 260),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-360, 257, 260),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-365, 282, 260),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-370, 307, 260),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-350, 207, 280),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-355, 232, 280),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-360, 257, 280),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-365, 282, 280),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-370, 307, 280),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (-347, 411, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-327, 431, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-307, 451, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-287, 471, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-267, 491, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-347, 411, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-327, 431, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-307, 451, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-287, 471, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-267, 491, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-347, 411, 260),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-327, 431, 260),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-307, 451, 260),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-287, 471, 260),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-267, 491, 260),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-347, 411, 280),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-327, 431, 280),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-307, 451, 280),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-287, 471, 280),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-267, 491, 280),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (-71, 663, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-64, 688, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-71, 663, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-64, 688, 240),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (-37, 786, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-30, 811, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-37, 786, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-30, 811, 240),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (81, 904, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (96, 901, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (81, 904, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (96, 901, 240),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (288, 849, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (268, 854, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (248, 859, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (228, 864, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (208, 869, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (288, 849, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (268, 854, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (248, 859, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (228, 864, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (208, 869, 240),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (860, 274, 220),(0,0,0));
                spawnMapEditObject("invisiblecrate", (860, 274, 240),(0,0,0));
                spawnMapEditObject("invisiblecrate", (862, 294, 240),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (866, 297, 350),(0,0,0));
                spawnMapEditObject("invisiblecrate", (859, 273, 350),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (839, 197, 350),(0,0,0));
                spawnMapEditObject("invisiblecrate", (833, 175, 350),(0,0,0));
         
                spawnMapEditObject("invisiblecrate", (640, -239, 350),(0,0,0));
                spawnMapEditObject("invisiblecrate", (620, -234, 350),(0,0,0));
                spawnMapEditObject("invisiblecrate", (600, -229, 350),(0,0,0));
                spawnMapEditObject("invisiblecrate", (580, -224, 350),(0,0,0));
                spawnMapEditObject("invisiblecrate", (560, -219, 350),(0,0,0));

                spawnMapEditObject("zipline", (-213,399,179),(0,80,0), 2000, (497,120,691),(8432,6873,-831));

                spawnMapEditObject("randombox", (-166,63,179),(0,168,0));
                spawnMapEditObject("power", (281,271,27),(0,167,0));
                spawnMapEditObject("ammo", (65,232,27),(0,77,0));
                spawnMapEditObject("gambler", (83,884,179),(0,345,0));
                spawnMapEditObject("killstreak", (557,344,27),(0,345,0));
                spawnMapEditObject("pap", (8144,7377,-838),(0,22,0));
                spawnMapEditObject("perk1", (851,36,307),(0,254,0));
                spawnMapEditObject("perk2", (587,112,179),(0,256,0));
                spawnMapEditObject("perk3", (222,776,179),(0,118,0));
                spawnMapEditObject("perk5", (724,-127,307),(0,255,0));
                spawnMapEditObject("perk6", (3144,-968,-48),(0,0,0));
                spawnMapEditObject("perk7", (8745,6708,-810),(0,224,0));
                spawnMapEditObject("spawn", (399,-355,179), (0, 166, 0));
                spawnMapEditObject("spawn", (427,-250,179), (0, 166, 0));
                spawnMapEditObject("zombiespawn", (946,147,184), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (515,1031,168), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (469,1038,168), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (325,-537,23), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (269,-529,23), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (834,653,33), (0, 0, 0));
                spawnMapEditObject("mapname", "Safehouse");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -1250);
            }
        break;
        case "oilrig":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("floor", (184,768,-1430),(687,999,-1430));
                //spawnMapEditObject("invisiblewall", (941,756,-1360),(1183,748,-1280));
                spawnMapEditObject("invisiblecrate", (940,756,-1360),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (960,756,-1360),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (980,756,-1360),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (1000,756,-1360),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (1020,756,-1360),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (940,756,-1380),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (960,756,-1380),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (980,756,-1380),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (1000,756,-1380),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (1020,756,-1380),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (940,756,-1340),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (960,756,-1340),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (980,756,-1340),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (1000,756,-1340),(0, 0, 0));
                spawnMapEditObject("invisiblecrate", (1020,756,-1340),(0, 0, 0));

                spawnMapEditObject("randombox", (-56,1022,-1388),(0,90,0));
                spawnMapEditObject("power",(109,280,-1388),(0,180,0));
                spawnMapEditObject("pap",(109,280,-1388),(0,180,0));
                spawnMapEditObject("ammo", (-45,413,-1388),(0,90,0));
                spawnMapEditObject("killstreak", (812,362,-1388),(0,90,0));//Added
                spawnMapEditObject("perk1", (1061,1024,-1388),(0,0,0));//Added
                spawnMapEditObject("perk7", (633,268,-1388),(0,0,0));//Added
                spawnMapEditObject("gambler", (259,1086,-1388),(0,90,0));
                spawnMapEditObject("spawn", (440,328,-1383), (0, 90, 0));
                spawnMapEditObject("zombiespawn", (1080,1205,-1383), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1069,1026,-1379), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (1006,790,-1383), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (820,619,-1383), (0, 0, 0));
                spawnMapEditObject("mapname", "Oilrig");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -1500);
            }
        break;
        case "contingency":
            if (level.mapVariation == 0)
            {
                //spawnMapEditObject("radiation", (-14481,2623,645),500,200);
                spawnMapEditObject("zipline", (-13932,2906,640),(0,90,0),2000,(-13932,2906,3000),(-26146,-8946,785));
                thread contingency_mapBounds();

                spawnMapEditObject("randombox", (-13071,2834,620),(0,90,0));
                spawnMapEditObject("power", (-13932,2906,640),(0,90,0));
                spawnMapEditObject("ammo", (-13071,3174,641),(0,90,0));
                spawnMapEditObject("gambler", (-13147,2531,669),(0,0,0));
                spawnMapEditObject("killstreak", (-13660,2531,658),(0,0,0));
                spawnMapEditObject("pap", (-25921,-9067,811),(0,234,0));
                spawnMapEditObject("perk1", (-13392,3311,655),(0,0,0));
                spawnMapEditObject("perk2", (-27064,-8658,840),(0,90,0));
                spawnMapEditObject("perk3", (-26113,-8752,783),(0,315,0));
                spawnMapEditObject("perk5", (-26601,-8943,781),(0,52,0));
                spawnMapEditObject("perk7", (-25863,-8877,834),(0,2,0));
                spawnMapEditObject("spawn", (-13420,2784,617), (0, 180, 0));
                spawnMapEditObject("spawn", (-13218,2717,627), (0, 180, 0));
                spawnMapEditObject("spawn", (-13195,2625,660), (0, 180, 0));
                spawnMapEditObject("spawn", (-13224,3034,636), (0, 180, 0));
                spawnMapEditObject("zombiespawn", (-14833,2490,682), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-14836,2599,660), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-14779,2315,699), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-14849,2656,657), (0, 0, 0));
                spawnMapEditObject("mapname", "Roadblock");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", 0);
            }
        break;
        case "airport":
            if (level.mapVariation == 0)
            {
                thread airport_deleteElevators();

                spawnMapEditObject("invisiblecrate", (5760,4196,340),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5775,4196,340),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5790,4196,340),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5805,4196,340),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5820,4196,340),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5760,4196,360),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5775,4196,360),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5790,4196,360),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5805,4196,360),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5820,4196,360),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5760,4196,380),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5775,4196,380),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5790,4196,380),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5805,4196,380),(0,0,0));
                spawnMapEditObject("invisiblecrate", (5820,4196,380),(0,0,0));

                spawnMapEditObject("randombox", (4863,3583,335),(0,90,0), (4993,3584,335),(0,90,0), (5242,4768,335),(0,90,0));
                spawnMapEditObject("power", (4435,5055,335),(0,0,0));
                spawnMapEditObject("ammo", (5027, 3922,345),(0,31,0));
                spawnMapEditObject("gambler", (4159,3695,335),(0,90,0));
                spawnMapEditObject("killstreak", (4615,4728,335),(0,0,0));
                spawnMapEditObject("pap", (4448,4965,335),(0,0,0));
                spawnMapEditObject("perk1", (5307,4215,335),(0,0,0));
                spawnMapEditObject("perk2", (4797,3257,335),(0,0,0));
                spawnMapEditObject("perk3", (5411,3279,335),(0,0,0));
                spawnMapEditObject("perk4", (4297,3634,335),(0,0,0));
                spawnMapEditObject("perk5", (5494,3808,335),(0,90,0));
                spawnMapEditObject("perk6", (4495,3634,335),(0,0,0));
                spawnMapEditObject("perk7", (4699,4833,335),(0,90,0));
                spawnMapEditObject("perk8", (5058,3257,335),(0,0,0));
                spawnMapEditObject("spawn", (5077,4072,335), (0, 180, 0));
                spawnMapEditObject("spawn", (5037,4494,335), (0, 180, 0));
                spawnMapEditObject("spawn", (4814,4600,335), (0, 180, 0));
                spawnMapEditObject("zombiespawn", (3903,4906,340), (0, 90, 0));
                spawnMapEditObject("zombiespawn", (4927,3197,350), (0, 0, 0));
                spawnMapEditObject("mapname", "The Shoppes");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", 0);
            }
        break;
        case "cliffhanger":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblecrate", (-4305,-24730,990),(0,0,0));
                thread cliffhanger_mapBounds();

                spawnMapEditObject("randombox", (-3454,-24725,970),(0,0,0), (-3447,-24383,970),(0,180,0), (-3250,-24556,975),(0,90,0));
                spawnMapEditObject("power", (-3878,-25641,1125),(0,90,0));
                spawnMapEditObject("ammo", (-3775,-24854,1000),(0,70,0));
                spawnMapEditObject("gambler", (-2800,-24728,1020),(0,90,0));
                spawnMapEditObject("killstreak", (-3791,-24077,990),(0,45,0));
                spawnMapEditObject("pap", (-3620,-24604,1215),(0,0,0));
                spawnMapEditObject("perk1", (-4286,-26000,980),(0,90,0));
                spawnMapEditObject("perk2", (-2876,-24312,1010),(0,90,0));
                spawnMapEditObject("perk3", (-4286,-25800,985),(0,90,0));
                spawnMapEditObject("perk4", (-4289,-24263,990),(0,90,0));
                spawnMapEditObject("perk5", (-4286,-25600,990),(0,90,0));
                spawnMapEditObject("perk6", (-4286,-25400,1005),(0,90,0));
                spawnMapEditObject("perk7", (-3400,-25698,1035),(25,80,-35));
                spawnMapEditObject("perk8", (-4489,-24120,1010),(0,90,0));
                spawnMapEditObject("spawn", (-3207,-24306,975), (0, 180, 0));
                spawnMapEditObject("spawn", (-3301,-24803,975), (0, 90, 0));
                spawnMapEditObject("spawn", (-3826,-24557,975), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-4541,-24665,970), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-3752,-26288,1150), (0, 270, 0));
                spawnMapEditObject("zombiespawn", (-4027,-26340,1090), (0, 270, 0));
                spawnMapEditObject("mapname", "Snow Pit");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", 500);
            }
        break;
        case "dcburning":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblecrate", (-20045,6681,-180),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20065,6681,-180),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20085,6681,-180),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20105,6681,-180),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20125,6681,-180),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20045,6681,-160),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20065,6681,-160),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20085,6681,-160),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20105,6681,-160),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20125,6681,-160),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20045,6681,-140),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20065,6681,-140),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20085,6681,-140),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20105,6681,-140),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-20125,6681,-140),(0,0,0));

                spawnMapEditObject("invisiblecrate", (-22050,6681,-180),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22070,6681,-180),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22090,6681,-180),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22110,6681,-180),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22130,6681,-180),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22050,6681,-160),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22070,6681,-160),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22090,6681,-160),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22110,6681,-160),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22130,6681,-160),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22050,6681,-140),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22070,6681,-140),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22090,6681,-140),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22110,6681,-140),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-22130,6681,-140),(0,0,0));

                spawnMapEditObject("randombox", (-20535, 6859, -190), (0, 90, 0), (-21639, 6861, -190), (0, 90, 0));
                spawnMapEditObject("power", (-21090, 6850, -190),(0,0,0));
                spawnMapEditObject("ammo", (-21310, 7979, -190),(0,0,0));
                spawnMapEditObject("gambler", (-21914, 7027, -190),(0,0,0));
                spawnMapEditObject("killstreak", (-20249, 7027, -190),(0,0,0));
                spawnMapEditObject("pap", (-21087, 8107, -190),(0,0,0));
                spawnMapEditObject("perk1", (-21361, 7612, -190),(0,90,0));
                spawnMapEditObject("perk2", (-20959, 7611, -190),(0,90,0));
                spawnMapEditObject("perk3", (-19808, 6956, -190),(0,90,0));
                spawnMapEditObject("perk4", (-21215, 6572, -190),(0,90,0));
                spawnMapEditObject("perk5", (-21210, 7356, -190),(0,90,0));
                spawnMapEditObject("perk6", (-20959, 7355, -190),(0,90,0));
                spawnMapEditObject("perk7", (-22367, 6960, -190),(0,90,0));
                spawnMapEditObject("perk8", (-20976, 7900, -190),(0,90,0));
                spawnMapEditObject("spawn", (-20932, 6858, -190), (0, 180, 0));
                spawnMapEditObject("spawn", (-21085, 7011, -190), (0, 90, 0));
                spawnMapEditObject("spawn", (-21085, 6700, -190), (0, 90, 0));
                spawnMapEditObject("spawn", (-21246, 6860, -190), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-22083, 6594, -180), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-20077, 6596, -180), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-21942, 8072, -180), (0, 0, 0));
                spawnMapEditObject("mapname", "Whitehouse Defense");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -250);
            }
            if (level.mapVariation == 1)
            {
                spawnMapEditObject("invisiblewall", (-22570, 2980, -275), (-22272, 2458, -150));
                spawnMapEditObject("invisiblewall", (-22272, 2458, -220), (-21915, 1840, -150));
                spawnMapEditObject("invisiblecrate", (-22186, 2309, -230), (0, 0, 0));
                spawnMapEditObject("invisiblecrate", (-22195, 2325, -230), (0, 0, 0));
                spawnMapEditObject("invisiblecrate", (-22169, 2280, -220), (0, 0, 0));
                spawnMapEditObject("invisiblecrate", (-22177, 2292, -222), (0, 0, 0));

                spawnMapEditObject("invisiblewall", (-21325, 650, -260), (-21268, 575, -180));

                spawnMapEditObject("randombox", (-22828, 1858, -240), (0, -62, 0));
                spawnMapEditObject("power", (-22340, 1115, -245),(0,30,0));
                spawnMapEditObject("ammo", (-22792, 2407, -200),(0,-27,0));
                spawnMapEditObject("gambler", (-22080, 1432, -270),(0,-65,0));
                spawnMapEditObject("killstreak", (-21964, 1880, -245),(0,-60,0));
                spawnMapEditObject("pap", (-22335, 915, -240),(0,-65,0));
                spawnMapEditObject("perk1", (-21733, 201, -240),(0,20,0));
                spawnMapEditObject("perk2", (-21452, 575, -245),(0,30,0));
                spawnMapEditObject("perk3", (-22465, 2081, -245),(0,90,0));
                spawnMapEditObject("perk4", (-22641, 2948, -250),(0,85,0));
                spawnMapEditObject("perk5", (-22590, 1442, -245),(0,-62,0));
                spawnMapEditObject("perk6", (-21834, 1010, -280),(0,-70,0));
                spawnMapEditObject("perk7", (-22316, 1744, -235),(0,70,0));
                spawnMapEditObject("perk8", (-22066, 788, -245),(0,0,0));
                spawnMapEditObject("spawn", (-22140, 990, -245), (0, 0, 0));
                spawnMapEditObject("spawn", (-22329, 1329, -245), (0, 0, 0));
                spawnMapEditObject("spawn", (-22541, 1661, -245), (0, 0, 0));
                spawnMapEditObject("spawn", (-21246, 6860, -190), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-22277, 2915, -300), (0, 180, 0));
                spawnMapEditObject("zombiespawn", (-21100, 705, -300), (0, 180, 0));
                spawnMapEditObject("zombiespawn", (-22120, 2502, -295), (0, 180, 0));
                spawnMapEditObject("zombiespawn", (-23064, 2936, -250), (0, 90, 0));
                spawnMapEditObject("mapname", "Monument Attack");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -350);
            }
        break;
        case "boneyard":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblecrate", (-5013, -6375, 25),(0,0,0));

                spawnMapEditObject("invisiblecrate", (-4200, -7925, 50),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-4180, -7925, 50),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-4160, -7925, 50),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-4200, -7925, 70),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-4180, -7925, 70),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-4160, -7925, 70),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-4200, -7925, 90),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-4180, -7925, 90),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-4160, -7925, 90),(0,0,0));
                thread boneyard_mapBounds();

                spawnMapEditObject("randombox", (-4781, -7559, 10), (0, 90, 0));
                spawnMapEditObject("power", (-3774, -7428, 5),(0,75,0));
                spawnMapEditObject("ammo", (-4608, -7268, 5),(0,110,0));
                spawnMapEditObject("gambler", (-4103, -7723, 0),(0,75,0));
                spawnMapEditObject("killstreak", (-4801, -7872, 0),(0,85,0));
                spawnMapEditObject("pap", (-3426, -6965, 25),(0,70,0));
                spawnMapEditObject("perk1", (-4991, -6444, 0),(0,100,0));
                spawnMapEditObject("perk2", (-4131, -7822, 40),(0,75,0));
                spawnMapEditObject("perk3", (-3718, -7233, 5),(0,75,0));
                spawnMapEditObject("perk4", (-4269, -6649, 10),(0,100,0));
                spawnMapEditObject("perk5", (-4113, -6923, 5),(0,5,0));
                spawnMapEditObject("perk6", (-3679, -7098, 5),(0,75,0));
                spawnMapEditObject("perk7", (-3939, -7425, -10),(0,-10,0));
                spawnMapEditObject("perk8", (-4252, -6769, 40),(0,100,0));
                spawnMapEditObject("spawn", (-4651, -6988, 5), (0, 90, 0));
                spawnMapEditObject("spawn", (-4433, -6961, 5), (0, 90, 0));
                spawnMapEditObject("spawn", (-4342, -7638, 5), (0, -90, 0));
                spawnMapEditObject("spawn", (-4603, -7628, 5), (0, -90, 0));
                spawnMapEditObject("zombiespawn", (-4657, -8103, 5), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-4439, -8026, 5), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-4600, -6221, 5), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-4910, -6214, 5), (0, 0, 0));
                spawnMapEditObject("mapname", "Abandoned Trailer Park");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -100);
            }
        break;
        case "gulag":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("randombox", (-339, 476, 320), (0, 55, 0));
                spawnMapEditObject("power", (-27, 256, 325),(0,55,0));
                spawnMapEditObject("ammo", (20, 672, 300),(0,90,0));
                spawnMapEditObject("gambler", (-339, 99, 300),(0,55,0));
                spawnMapEditObject("killstreak", (343, -2, 300),(0,55,0));
                spawnMapEditObject("pap", (-27, 256, 325),(0,55,0));
                spawnMapEditObject("perk1", (400, 128, 350),(0,55,0));
                spawnMapEditObject("perk2", (2, 1241, 345),(0,-35,0));
                spawnMapEditObject("perk3", (-293, 1068, 315),(0,-35,0));
                spawnMapEditObject("perk4", (-154, -153, 350),(0,-35,0));
                spawnMapEditObject("perk5", (276, 706, 300),(0,90,0));
                spawnMapEditObject("perk6", (-10, 569, 300),(0,55,0));
                spawnMapEditObject("perk7", (240, -100, 350),(0,55,0));
                spawnMapEditObject("perk8", (-327, -102, 300),(0,-35,0));
                spawnMapEditObject("spawn", (171, 115, 300), (0, 0, 0));
                spawnMapEditObject("spawn", (-152, 86, 300), (0, 0, 0));
                spawnMapEditObject("spawn", (-212, 383, 300), (0, 0, 0));
                spawnMapEditObject("spawn", (104, 446, 300), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-471, 1305, 345), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-339, -150, 315), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (360, -14, 350), (0, 0, 0));
                spawnMapEditObject("mapname", "Infected Sewers");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", 200);
            }
        break;
        case "dc_whitehouse":
            if (level.mapVariation == 0)
            {
                spawnMapEditObject("invisiblecrate", (-2139, 9025, -90),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-2139, 9000, -90),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-2139, 8975, -90),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-2139, 9025, -70),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-2139, 9000, -70),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-2139, 8975, -70),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-2139, 9025, -50),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-2139, 9000, -50),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-2139, 8975, -50),(0,0,0));

                spawnMapEditObject("invisiblecrate", (-1937, 8150, 25),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-1937, 8130, 25),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-1937, 8110, 25),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-1937, 8090, 25),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-1937, 8150, 50),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-1937, 8130, 50),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-1937, 8110, 50),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-1937, 8090, 50),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-1937, 8150, 75),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-1937, 8130, 75),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-1937, 8110, 75),(0,0,0));
                spawnMapEditObject("invisiblecrate", (-1937, 8090, 75),(0,0,0));

                spawnMapEditObject("hellMap", true);
                spawnMapEditObject("randombox", (-2347, 8575, -110), (0, 90, 0));
                spawnMapEditObject("ammo", (-2051, 8512, -110),(0,0,0));
                spawnMapEditObject("gambler", (-1815, 8824, -110),(0,0,0));
                spawnMapEditObject("killstreak", (-1970, 8824, -110),(0,25,0));
                spawnMapEditObject("pap", (-1800, 8594, -75),(0,90,0));
                spawnMapEditObject("perk1", (-2254, 9068, -110),(0,0,0));
                spawnMapEditObject("perk7", (-2248, 8123, -110),(0,0,0));
                spawnMapEditObject("spawn", (-2243, 8392, -110), (0, 0, 0));
                spawnMapEditObject("spawn", (-2223, 8573, -110), (0, 0, 0));
                spawnMapEditObject("spawn", (-2230, 8754, -110), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1775, 8425, -75), (0, 0, 0));
                spawnMapEditObject("zombiespawn", (-1775, 8525, -75), (0, 0, 0));
                spawnMapEditObject("mapname", "Back Room of Hell");
                spawnMapEditObject("maxWave", 20);
                //spawnMapEditObject("fallLimit", -150);
            }
            if (level.mapVariation == 1)
            {
                thread whitehouse2_mapBounds();
                spawnMapEditObject("floor", (2100, 8500, -250), (2300, 6500, -250));

                spawnMapEditObject("model", "h2_concrete_barrier_damaged_1", (1745, 5664, -230), (0, 0, 0));
                spawnMapEditObject("model", "h2_concrete_barrier_damaged_1", (1875, 5664, -230), (0, 0, 0));
                spawnMapEditObject("model", "h2_concrete_barrier_damaged_1", (2000, 5664, -230), (0, 0, 0));
                spawnMapEditObject("model", "h2_concrete_barrier_damaged_1", (1745, 9080, -230), (0, 0, 0));
                spawnMapEditObject("model", "h2_concrete_barrier_damaged_1", (1875, 9080, -230), (0, 0, 0));
                spawnMapEditObject("model", "h2_concrete_barrier_damaged_1", (2000, 9080, -230), (0, 0, 0));

                spawnMapEditObject("randombox", (1967, 7358, -215), (0,90,0));
                spawnMapEditObject("power", (2060, 7360, -215),(0,90,0));
                spawnMapEditObject("ammo", (1695, 6880, -215),(0,90,0));
                spawnMapEditObject("gambler", (1695, 8800, -215),(0,90,0));
                spawnMapEditObject("killstreak", (1695, 6050, -215),(0,90,0));
                spawnMapEditObject("pap", (1695, 7350, -215),(0,90,0));
                spawnMapEditObject("perk1", (1695, 8000, -215),(0,90,0));
                spawnMapEditObject("perk2", (2050, 8250, -215),(0,90,0));
                spawnMapEditObject("perk3", (2050, 9000, -215),(0,90,0));
                spawnMapEditObject("perk4", (2050, 6750, -215),(0,90,0));
                spawnMapEditObject("perk5", (2050, 7200, -215),(0,90,0));
                spawnMapEditObject("perk6", (2050, 6050, -215),(0,90,0));
                spawnMapEditObject("perk7", (1695, 6500, -215),(0,90,0));
                spawnMapEditObject("perk8", (2050, 7500, -215),(0,90,0));
                spawnMapEditObject("spawn", (1800, 8500, -215), (0,0,0));
                spawnMapEditObject("spawn", (1800, 7500, -215), (0,0,0));
                spawnMapEditObject("spawn", (1800, 6500, -215), (0,0,0));
                spawnMapEditObject("zombiespawn", (2600, 6700, -225), (0, 180, 0));
                spawnMapEditObject("zombiespawn", (2600, 7700, -225), (0, 180, 0));
                spawnMapEditObject("zombiespawn", (2600, 8500, -225), (0, 180, 0));
                spawnMapEditObject("mapname", "Whitehouse Gates");
                spawnMapEditObject("maxWave", 30);
                spawnMapEditObject("fallLimit", -300);
            }
        break;
    }
}

FXFire(pos)
{
    fx = level.fx_flamethrowerFlame;
    fxEnt = spawnFX(fx, pos);
	while(true)
	{
		triggerFX(fxEnt);
		wait(1);
	}
}
SmokeFx(pos)
{
    fx = level.fx_flamethrowerImpact;
    fxEnt = spawnFX(fx, pos);
	while(true)
	{
		triggerFX(fxEnt);
		wait(1);
	}
}
LightFxGreen(pos)
{
    fxEnt = spawnFX(level.fx_rayGun, pos);
	while(true)
	{
		triggerFX(fxEnt);
		wait(10);
	}
}

LightFxRed(pos)
{
    fx = loadFX("fx/misc/aircraft_light_red_blink");
    playFX(fx, pos);
}

deleteDestructables(excludedModel)
{
    if (!isDefined(excludedModel))
        excludedModel = "";

    destructables = getEntArray("destructable", "targetname");
    destructibles = getEntArray("destructible", "targetname");

    foreach (destructable in destructables)
    {
        if (destructable.model != excludedModel)
        {
            if (isDefined(destructable.target))
            {
                col = getEnt(destructable.target, "targetname");
                if (isDefined(col)) col delete();
            }
            destructable delete();
        }
    }
    foreach (destructable in destructibles)
    {
        if (destructable.model != excludedModel)
        {
            if (isDefined(destructable.target))
            {
                col = getEnt(destructable.target, "targetname");
                if (isDefined(col)) col delete();
            }
            destructable delete();
        }
    }
}
deleteBarrels()
{
    barrels = getEntArray("explodable_barrel", "targetname");
    foreach (destructable in barrels)
    {
        if (isDefined(destructable.target))
        {
            col = getEnt(destructable.target, "targetname");
            if (isDefined(col)) col delete();
        }
        destructable delete();
    }
}
deleteDeathTriggers()
{
    triggers = getEntArray("trigger_hurt", "classname");
    foreach (trigger in triggers)
    {
        trigger.dmg = 0;
        //trigger.origin -= (0, 0, 10000);//Move triggers away from map
        trigger delete();
    }
}
highrise_createProgressArea(pos, radius, height, num)
{
	trigger = spawn("trigger_radius", pos, 0, radius, height);
	trigger thread highrise_playerEnterArea(radius, num);
}
highrise_playerEnterArea(radius, num)
{
    self waittill("trigger", player);

    switch (num)
    {
        case 0:
            highrise_zone1();
            break;
        case 1:
            highrise_zone2();
            break;
        case 2:
            highrise_zone3();
            break;
    }

    self delete();
}
highrise_zone1()
{
    spawnMapEditObject("zombiespawn", (2150,11342,3371), (0, 0, 0));
    spawnMapEditObject("zombiespawn", (2150,10473,3371), (0, 0, 0));
    spawnMapEditObject("zombiespawn", (3037,11690,3371), (0, 0, 0));
    spawnMapEditObject("zombiespawn", (2150,11300,3371), (0, 0, 0));
}
highrise_zone2()
{
    spawnMapEditObject("zombiespawn", (2906,10116,4075), (0, 0, 0));
    spawnMapEditObject("zombiespawn", (2896,10614,4075), (0, 0, 0));
    spawnMapEditObject("zombiespawn", (2892,11239,4075), (0, 0, 0));
    spawnMapEditObject("zombiespawn", (2903,11563,4075), (0, 0, 0));
}
highrise_zone3()
{
    spawnMapEditObject("zombiespawn", (3866,2155,2355), (0, 0, 0));
    spawnMapEditObject("zombiespawn", (5016,1005,2355), (0, 0, 0));
    spawnMapEditObject("zombiespawn", (6005,912,2355), (0, 0, 0));
    spawnMapEditObject("zombiespawn", (6380,964,2355), (0, 0, 0));
}
contingency_mapBounds()
{
    while (true)
    {
        wait(0.1);
        if (level.players.size == 0)
            continue;

        foreach (player in level.players)
        {
            if (isDefined(player.isAlive) && player.isAlive && !player.notTargetable)
            {
                origin = player.origin;
                if (origin[0] < -15300 && origin[0] > -20000)
                {
                    origin = (-15300, origin[1], origin[2]);
                    player setOrigin(origin);
                }
                if (origin[1] > 3300)
                {
                    origin = (origin[0], 3300, origin[2]);
                    player setOrigin(origin);
                }
            }
        }
    }
}
cliffhanger_mapBounds()
{
    while (true)
    {
        wait(0.1);
        if (level.players.size == 0)
            continue;

        foreach (player in level.players)
        {
            if (isDefined(player.isAlive) && player.isAlive)
            {
                origin = player.origin;
                if (origin[0] < -4305 && origin[1] < -24350)
                {
                    origin = (-4305, origin[1], origin[2]);
                    player setOrigin(origin);
                }
            }
        }
    }
}
boneyard_mapBounds()
{
    while (true)
    {
        wait(0.1);
        if (level.players.size == 0)
            continue;

        foreach (player in level.players)
        {
            if (isDefined(player.isAlive) && player.isAlive)
            {
                origin = player.origin;
                if (origin[1] > -6375)
                {
                    origin = (origin[0], -6375, origin[2]);
                    player setOrigin(origin);
                }
            }
        }
    }
}
airport_deleteElevators()
{
    foreach (elevator in level.elevators)
        elevator delete();
    level.elevators = [];
    foreach (button in level.elevator_callbuttons)
        button delete();
    level.elevator_callbuttons = [];

    wait(1);

    glassHousing = getentarray("elevator_housing_glass", "targetname");
    glass = getentarray("airport_glass_elevator", "targetname");
    glassDoors = getentarray("airport_glass_elevator_door", "targetname");
    doors = getentarray("elevator_doors", "targetname");
    housing = getentarray("elevator_housing", "targetname");
    cable = getentarray("elevator_cable", "targetname");
    wheels = getentarray("elevator_wheels", "targetname");

    foreach (part in glassHousing)
        part delete();
    foreach (part in glass)
        part delete();
    foreach (part in glassDoors)
        part delete();
    foreach (part in doors)
        part delete();
    foreach (part in housing)
        part delete();
    foreach (part in cable)
        part delete();
    foreach (part in wheels)
        part delete();
}
whitehouse2_mapBounds()
{
    while (true)
    {
        wait(0.05);
        if (level.players.size == 0)
            continue;

        foreach (player in level.players)
        {
            if (isDefined(player.isAlive) && player.isAlive)
            {
                origin = player.origin;
                if (origin[0] > 2050)
                {
                    origin = (2050, origin[1], -228);
                    player setOrigin(origin);
                    velocity = player getVelocity();
                    player setVelocity((0, velocity[1], velocity[2]));
                }
                else if (origin[0] < 1680)
                {
                    origin = (1680, origin[1], -228);
                    player setOrigin(origin);
                    velocity = player getVelocity();
                    player setVelocity((0, velocity[1], velocity[2]));
                }

                if (origin[1] > 9075)
                {
                    origin = (origin[0], 9075, -228);
                    player setOrigin(origin);
                    velocity = player getVelocity();
                    player setVelocity((velocity[0], 0, velocity[2]));
                }
                else if (origin[1] < 5675)
                {
                    origin = (origin[0], 5675, -228);
                    player setOrigin(origin);
                    velocity = player getVelocity();
                    player setVelocity((velocity[0], 0, velocity[2]));
                }
            }
        }
    }
}