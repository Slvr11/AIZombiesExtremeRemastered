#include common_scripts\utility;
#include maps\mp\_utility;

createWaypoints()
{
    waypoints = getWaypointsForMap();
    foreach (point in waypoints)
    {
        if (!isDefined(point) || point == (0, 0, 0)) continue;

        wp = spawnStruct();
        wp.origin = point;
        level.waypoints[level.waypoints.size] = wp;
    }
    if (level.waypoints.size > 0) bakeWaypoints();
}

bakeWaypoints()
{
    badPoints = [];
    foreach (wp in level.waypoints)
    {
        if (!isDefined(wp))
            continue;

        bakes = [];
        foreach (p in level.waypoints)
        {
            if (!isDefined(p))
                continue;

            if (p == wp) continue;//No unneccesary trace

            if (distance(p.origin, wp.origin) > 1500) continue;//Don't trace for too far away points

            trace = sightTracePassed(wp.origin, p.origin, false, undefined);
            trace2 = bulletTracePassed(wp.origin, p.origin, false, undefined);
            if ((isDefined(trace) && trace) || (isDefined(trace2) && trace2))
                bakes[bakes.size] = p;
        }
        if (bakes.size > 0) wp.visiblePoints = bakes;
        else
            badPoints[badPoints.size] = wp;
    }

    validateWaypoints(badPoints);

    /*
    //Set current wps to never change
    foreach (wp in level.waypoints)
    {
        if (isDefined(wp))
        {
            wp willNeverChange();
        }
    }
    */
}
validateWaypoints(badPoints)
{
    if (badPoints.size > 0)
    {
        foreach (p in badPoints)
        {
            foreach (goodPoint in level.waypoints)
            {
                if (goodPoint == p)
                    continue;

                if (user_scripts\mp\aizombies\_aiz::array_contains(badPoints, goodPoint))
                    continue;

                visiblePoints = goodPoint.visiblePoints;
                for (i = 0; i < visiblePoints.size; i++)
                {
                    if (visiblePoints[i] == p)//If a good point linked to this bad point, unlink them
                    {
                        visiblePoints = array_remove(visiblePoints, p);
                    }
                }

                if (visiblePoints.size == 0)//If that was the only link to the good point, it is now bad.
                {
                    badPoints[badPoints.size] = goodPoint;
                    validateWaypoints(badPoints);
                    return;
                }

                goodPoint.visiblePoints = visiblePoints;
            }

            level.waypoints = array_remove(level.waypoints, p);
            //p delete();
            printLn("A waypoint had no visible links! Deleting waypoint...");
        }
    }
}

getWaypointsForMap()
{
    currentMap = level._mapname;
    waypoints = [];

    switch (currentMap)
    {
        case "mp_terminal":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (246.6061,4167.143,40.125);
            waypoints[waypoints.size] = (624.7712,3753.226,40.125);
            waypoints[waypoints.size] = (1130.358,4027.027,40.125);
            waypoints[waypoints.size] = (1087.296,4586.28,40.125);
            waypoints[waypoints.size] = (1313.875,3320.234,40.125);
            waypoints[waypoints.size] = (1449.158,3819.982,38.125);
            waypoints[waypoints.size] = (1877.665,3746.595,52.12454);
            waypoints[waypoints.size] = (2432.747,3782.803,48.125);
            waypoints[waypoints.size] = (2431.024,4194.254,48.125);
            waypoints[waypoints.size] = (2431.89,4409.198,191.5181);
            waypoints[waypoints.size] = (2759.16,3982.838,84.125);
            waypoints[waypoints.size] = (2595.402,3442.513,48.125);
            waypoints[waypoints.size] = (2419.577,3148.779,72.125);
            waypoints[waypoints.size] = (1813.192,3018.418,40.125);
            waypoints[waypoints.size] = (1692.714,3377.876,40.125);
            waypoints[waypoints.size] = (1696.307,3805.034,40.125);
            waypoints[waypoints.size] = (1128.519,2845.981,40.125);
            waypoints[waypoints.size] = (627.8413,2635.537,40.125);
            waypoints[waypoints.size] = (322.6416,3256.328,40.125);
            waypoints[waypoints.size] = (111.4816,3831.948,40.125);
            waypoints[waypoints.size] = (610.4529,2813.211,45.7037);
            waypoints[waypoints.size] = (609.9446,3008.77,203.625);
            waypoints[waypoints.size] = (608.8327,3772.375,203.625);
            waypoints[waypoints.size] = (727.4998,3767.509,193.0807);
            waypoints[waypoints.size] = (960.3929,3766.779,52.02162);
        }
        break;
        case "mp_afghan":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] =  (-2199,-400,-1440);
            waypoints[waypoints.size] =  (-2692,-400,-1440);
            waypoints[waypoints.size] = (-2863,-400,-1445);
            waypoints[waypoints.size] = (-3481,-400,-1425);
            waypoints[waypoints.size] = (-3750,379,-1448);
            waypoints[waypoints.size] = (-3750,920,-1448);
            waypoints[waypoints.size] = (-3541,-1314,-1448);
        }
        break;
        case "mp_boneyard":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (22,-811,-124);
            waypoints[waypoints.size] = (60,-1777,-124);
            waypoints[waypoints.size] = (206,-2395,-123);
            waypoints[waypoints.size] = (673,-2961,-123);
            waypoints[waypoints.size] = (205,-3216,-75);
            waypoints[waypoints.size] = (-319,-2314,-72);
            waypoints[waypoints.size] = (-425,-1825,-73);
            waypoints[waypoints.size] = (-315,-3271,-1);
            waypoints[waypoints.size] = (-730,-2772,-3);
            waypoints[waypoints.size] = (-136,-2508,-67);
            waypoints[waypoints.size] = (1004,-4099,-46);
            waypoints[waypoints.size] = (697,-2318,-52);
            waypoints[waypoints.size] = (1040,-2853,-51);
            waypoints[waypoints.size] = (330,-1689,-52);
            waypoints[waypoints.size] = (-583,-1375,-82);
            waypoints[waypoints.size] = (-245,-2019,-64);
            waypoints[waypoints.size] = (-100,-2449,-63);
        }
        break;
        case "mp_brecourt":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (10860,6414,358);
            waypoints[waypoints.size] = (9972,6588,358);
            waypoints[waypoints.size] = (9901,7736,358);
            waypoints[waypoints.size] = (9856,8772,358);
            waypoints[waypoints.size] = (9535,8017,358);
            waypoints[waypoints.size] = (9591,6754,358);
            waypoints[waypoints.size] = (10570,6826,358);
            waypoints[waypoints.size] = (10855,7218,1486);
            waypoints[waypoints.size] = (12034,7271,1494);
            waypoints[waypoints.size] = (12824,7364,1486);
        }
        if (level.mapVariation == 1)
        {
            waypoints[waypoints.size] = (679,229,30);
            waypoints[waypoints.size] = (877,-552,-32);
            waypoints[waypoints.size] = (851,-993,-41);
            waypoints[waypoints.size] = (1258,-856,-51);
            waypoints[waypoints.size] = (753,-913,-39);
            waypoints[waypoints.size] = (2230,-919,-33);
            waypoints[waypoints.size] = (-1104,-456,-14);
            waypoints[waypoints.size] = (-223,-682,-40);
            waypoints[waypoints.size] = (-89,-730,-10);
            waypoints[waypoints.size] = (661,-819,-19);
        }
        break;
        case "mp_checkpoint":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (2425,2216,11);
            waypoints[waypoints.size] = (2425,2800,11);
            waypoints[waypoints.size] = (2425,3400,11);
            waypoints[waypoints.size] = (3000,2216,11);
            waypoints[waypoints.size] = (3000,2800,11);
            waypoints[waypoints.size] = (3000,3400,11);
            waypoints[waypoints.size] = (3600,2216,11);
            waypoints[waypoints.size] = (3600,2800,11);
            waypoints[waypoints.size] = (3600,3400,11);
            waypoints[waypoints.size] = (2400,2216,11);
            waypoints[waypoints.size] = (2400,2800,11);
            waypoints[waypoints.size] = (2400,3400,11);
            waypoints[waypoints.size] = (1800,2216,11);
            waypoints[waypoints.size] = (1800,2800,11);
            waypoints[waypoints.size] = (1800,3400,11);
            waypoints[waypoints.size] = (1000,2216,11);
            waypoints[waypoints.size] = (1000,2800,11);
            waypoints[waypoints.size] = (1000,3400,11);
            waypoints[waypoints.size] = (200,2216,11);
            waypoints[waypoints.size] = (200,2800,11);
            waypoints[waypoints.size] = (200,3400,11);
        }
        break;
        case "mp_derail":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (1685,2654,130);
            waypoints[waypoints.size] = (1736,1901,139);
            waypoints[waypoints.size] = (2021,1458,144);
            waypoints[waypoints.size] = (2253,1239,144);
            waypoints[waypoints.size] = (2774,1221,144);
            waypoints[waypoints.size] = (2715,1686,144);
            waypoints[waypoints.size] = (2373,1630,144);
            waypoints[waypoints.size] = (2861,2018,144);
            waypoints[waypoints.size] = (2856,2620,144);
            waypoints[waypoints.size] = (2367,2265,158);
            waypoints[waypoints.size] = (2371,2702,158);
            waypoints[waypoints.size] = (2580,2701,160);
            waypoints[waypoints.size] = (1896,2368,158);
            waypoints[waypoints.size] = (1905,2736,294);
            waypoints[waypoints.size] = (1981,2994,294);
            waypoints[waypoints.size] = (2428,2952,294);
            waypoints[waypoints.size] = (2361,3383,294);
            waypoints[waypoints.size] = (1963,3291,294);
            waypoints[waypoints.size] = (2157,3412,294);
            waypoints[waypoints.size] = (1927,3414,430);
            waypoints[waypoints.size] = (2061,3113,158);
            waypoints[waypoints.size] = (1850,2699,294);
            waypoints[waypoints.size] = (1816,3217,158);

            waypoints[waypoints.size] = (1600,1567,158);
            waypoints[waypoints.size] = (1600,3100,158);
        }
        break;
        case "mp_estate":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-2067,-1275,-400);
            waypoints[waypoints.size] = (-2500,-1400,-500);
            waypoints[waypoints.size] = (-2300,-350,-310);
            waypoints[waypoints.size] = (-2300,-800,-475);
            waypoints[waypoints.size] = (-3591,-700,-475);
            waypoints[waypoints.size] = (-2321,-901,-300);
        }
        break;
        case "mp_favela":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (1953,2640,296);
            waypoints[waypoints.size] = (1670,2492,291);
            waypoints[waypoints.size] = (2300,2889,291);
        }
        break;
        case "mp_highrise":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-1067,-10013,2184);
            waypoints[waypoints.size] = (-1230,9703,2184);
            waypoints[waypoints.size] = (-1558,9688,2184);
            waypoints[waypoints.size] = (-612,9679,2184);
            waypoints[waypoints.size] = (-1278,10221,2184);
            waypoints[waypoints.size] = (-1047,10340,2184);
            waypoints[waypoints.size] = (-1052,11253,2184);
            waypoints[waypoints.size] = (-1627,11258,2184);
            waypoints[waypoints.size] = (-588,11323,2184);
            waypoints[waypoints.size] = (-667,10841,2184);
            waypoints[waypoints.size] = (-652,10338,2184);
            waypoints[waypoints.size] = (-1771,9922,2280);
            waypoints[waypoints.size] = (-2172,9890,2280);
            waypoints[waypoints.size] = (-2646,9902,2280);
            waypoints[waypoints.size] = (-2683,11197,2280);
            waypoints[waypoints.size] = (-1880,11312,2280);
            waypoints[waypoints.size] = (-2319,10223,2280);
            waypoints[waypoints.size] = (-1959,10209,2280);
            waypoints[waypoints.size] = (-1935,9645,2280);
            waypoints[waypoints.size] = (-829,-1855,128);
            waypoints[waypoints.size] = (-989,-2222,119);
            waypoints[waypoints.size] = (-1049,-3115,85);
            waypoints[waypoints.size] = (-983,-3778,68);
        }
        else if (level.mapVariation == 1)
        {
            waypoints[waypoints.size] = (2000,11342,3380);
            waypoints[waypoints.size] = (2000,11300,3380);
            waypoints[waypoints.size] = (2500,11690,3380);
            waypoints[waypoints.size] = (2000,11690,3380);
            waypoints[waypoints.size] = (1750,11342,3380);
            waypoints[waypoints.size] = (1750,11300,3380);

            waypoints[waypoints.size] = (2308,10863,4080);
            waypoints[waypoints.size] = (2308,10400,4080);
            waypoints[waypoints.size] = (2308,11200,4080);
            waypoints[waypoints.size] = (1896,10400,4080);
            waypoints[waypoints.size] = (1896,11200,4080);
            waypoints[waypoints.size] = (1500,10863,4080);
            waypoints[waypoints.size] = (1500,10400,4080);
            waypoints[waypoints.size] = (1500,11200,4080);

            waypoints[waypoints.size] = (4191,2666,2355);
            waypoints[waypoints.size] = (6000,2666,2355);
            waypoints[waypoints.size] = (4191,3144,2355);
            waypoints[waypoints.size] = (6000,3144,2355);
            waypoints[waypoints.size] = (4191,2000,2355);
            waypoints[waypoints.size] = (6000,2000,2355);
        }
        else if (level.mapVariation == 2)
        {
            waypoints[waypoints.size] = (-9161, 4163, 2320);
            waypoints[waypoints.size] = (-9161, 4863, 2320);
            waypoints[waypoints.size] = (-9161, 5563, 2320);
            waypoints[waypoints.size] = (-9161, 6263, 2320);
            waypoints[waypoints.size] = (-9761, 4163, 2320);
            waypoints[waypoints.size] = (-9761, 4863, 2320);
            waypoints[waypoints.size] = (-9761, 5563, 2320);
            waypoints[waypoints.size] = (-9761, 6263, 2320);
            waypoints[waypoints.size] = (-10261, 4163, 2320);
            waypoints[waypoints.size] = (-10261, 4863, 2320);
            waypoints[waypoints.size] = (-10261, 5563, 2320);
            waypoints[waypoints.size] = (-10261, 6263, 2320);
        }
        else if (level.mapVariation == 3)
        {
            waypoints[waypoints.size] = (-15333, 4210, 5423);
            waypoints[waypoints.size] = (-14633, 4210, 5423);
            waypoints[waypoints.size] = (-13933, 4210, 5423);
            waypoints[waypoints.size] = (-13233, 4210, 5423);
            waypoints[waypoints.size] = (-15333, 5010, 5423);
            waypoints[waypoints.size] = (-14633, 5010, 5423);
            waypoints[waypoints.size] = (-13933, 5010, 5423);
            waypoints[waypoints.size] = (-13233, 5010, 5423);
            waypoints[waypoints.size] = (-15333, 5810, 5423);
            waypoints[waypoints.size] = (-14633, 5810, 5423);
            waypoints[waypoints.size] = (-13933, 5810, 5423);
            waypoints[waypoints.size] = (-13233, 5810, 5423);
            waypoints[waypoints.size] = (-15333, 6510, 5423);
            waypoints[waypoints.size] = (-14633, 6510, 5423);
            waypoints[waypoints.size] = (-13933, 6510, 5423);
            waypoints[waypoints.size] = (-13233, 6510, 5423);
        }
        break;
        case "mp_nightshift":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-711,-651,12);
            waypoints[waypoints.size] = (-1724,-542,8);
            waypoints[waypoints.size] = (-1641,-1004,9);
            waypoints[waypoints.size] = (-1787,-1353,4);
            waypoints[waypoints.size] = (-1758,-2129,10);
            waypoints[waypoints.size] = (-1422,-1803,8);
            waypoints[waypoints.size] = (-1134,-1686,16);
            waypoints[waypoints.size] = (-920,-1911,16);
            waypoints[waypoints.size] = (-920,-2112,96);
            waypoints[waypoints.size] = (-617,-2106,96);
            waypoints[waypoints.size] = (-600,-1986,152);
            waypoints[waypoints.size] = (-985,-1248,16);
            waypoints[waypoints.size] = (-1249,-1207,4);
            waypoints[waypoints.size] = (-2155,-1272,56);
            waypoints[waypoints.size] = (-2197,-1095,136);
            waypoints[waypoints.size] = (-2214,-765,144);
            waypoints[waypoints.size] = (-2370,-461,144);
            waypoints[waypoints.size] = (-2257,-206,144);
            waypoints[waypoints.size] = (-2259,-60,144);
            waypoints[waypoints.size] = (-2257,203,32);
            waypoints[waypoints.size] = (-1655,212,16);
            waypoints[waypoints.size] = (-1659,-63,8);
            waypoints[waypoints.size] = (-1193,-39,2);
            waypoints[waypoints.size] = (-1472,318,8);
            waypoints[waypoints.size] = (-1447,811,8);
            waypoints[waypoints.size] = (-1136,847,96);
            waypoints[waypoints.size] = (-942,706,96);
            waypoints[waypoints.size] = (-963,514,152);
            waypoints[waypoints.size] = (-957,279,152);
        }
        else if (level.mapVariation == 1)
        {
            waypoints[waypoints.size] = (1450,-968,16);
            waypoints[waypoints.size] = (1438,-1278,8);
            waypoints[waypoints.size] = (1168,-961,16);
            waypoints[waypoints.size] = (1035,-1194,8);
            waypoints[waypoints.size] = (1011,-1427,8);
            waypoints[waypoints.size] = (1235,-1509,16);
            waypoints[waypoints.size] = (1410,-1618,16);
            waypoints[waypoints.size] = (554,-1093,8);
            waypoints[waypoints.size] = (444,-1485,8);
            waypoints[waypoints.size] = (418,-1900,16);
            waypoints[waypoints.size] = (722,-1979,48);
            waypoints[waypoints.size] = (935,-1966,48);
            waypoints[waypoints.size] = (1001,-2135,49);
            waypoints[waypoints.size] = (837,-2147,192);
            waypoints[waypoints.size] = (922,-2143,113);
            waypoints[waypoints.size] = (909,-1858,192);
            waypoints[waypoints.size] = (1249,-576,16);
            waypoints[waypoints.size] = (1542,-400,16);
            waypoints[waypoints.size] = (1650,-113,16);
            waypoints[waypoints.size] = (1487,140,16);
            waypoints[waypoints.size] = (1192,100,8);
            waypoints[waypoints.size] = (894,3,16);
            waypoints[waypoints.size] = (777,-556,16);
            waypoints[waypoints.size] = (761,-850,16);
            waypoints[waypoints.size] = (790,-227,20);
            waypoints[waypoints.size] = (158,-189,16);
            waypoints[waypoints.size] = (-96,18,16);
            waypoints[waypoints.size] = (-5,-412,24);
            waypoints[waypoints.size] = (6,-760,16);
            waypoints[waypoints.size] = (397,-743,16);
            waypoints[waypoints.size] = (231,-134,24);
        }
        else if (level.mapVariation == 2)
        {
            waypoints[waypoints.size] = (1850,-1580,18);
            waypoints[waypoints.size] = (1850,-2500,18);
            waypoints[waypoints.size] = (1850,-3000,18);
            waypoints[waypoints.size] = (1950,-1580,8);
            waypoints[waypoints.size] = (1950,-2500,8);
            waypoints[waypoints.size] = (1950,-3000,8);
        }
        break;
        case "mp_invasion":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (2400,12127,11);
            waypoints[waypoints.size] = (2900,12127,11);
            waypoints[waypoints.size] = (3500,12127,11);
            waypoints[waypoints.size] = (4000,12127,11);
            waypoints[waypoints.size] = (2400,11173,11);
            waypoints[waypoints.size] = (2900,11173,11);
            waypoints[waypoints.size] = (3500,11173,11);
            waypoints[waypoints.size] = (4000,11173,11);
            waypoints[waypoints.size] = (2400,10567,11);
            waypoints[waypoints.size] = (2900,10567,11);
            waypoints[waypoints.size] = (3500,10567,11);
            waypoints[waypoints.size] = (4000,10567,11);
            waypoints[waypoints.size] = (2400,10000,11);
            waypoints[waypoints.size] = (2400,8500,11);
        }
        break;
        case "mp_quarry":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-2020.9,1400,35.1);
            waypoints[waypoints.size] = (-2020.9,1000,35.1);
            waypoints[waypoints.size] = (-1634.4,1050,35);
            waypoints[waypoints.size] = (-1634.4,1687,35);
            waypoints[waypoints.size] = (-2658,2152,35);
            waypoints[waypoints.size] = (-2658,1400,35.1);
            waypoints[waypoints.size] = (-3000,2152,35);
            waypoints[waypoints.size] = (-4000,2152,35);
            waypoints[waypoints.size] = (-3000,2152,35);
            waypoints[waypoints.size] = (-4000,2152,70);
            waypoints[waypoints.size] = (-4825.4,2152,160);
        }
        break;
        case "mp_rundown":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (577,2398,84);
            waypoints[waypoints.size] = (1616,2496,75);
            waypoints[waypoints.size] = (1625,3240,80);
            waypoints[waypoints.size] = (683,3222,79);
            waypoints[waypoints.size] = (618,2783,78);
            waypoints[waypoints.size] = (924,2687,80);
            waypoints[waypoints.size] = (1148,2925,83);
            waypoints[waypoints.size] = (1510,2917,82);
            waypoints[waypoints.size] = (1666,2930,74);
            waypoints[waypoints.size] = (1437,3096,82);
            waypoints[waypoints.size] = (1219,3115,82);
            waypoints[waypoints.size] = (1502,2320,64);
            waypoints[waypoints.size] = (232,2730,116);
            waypoints[waypoints.size] = (282,2479,150);
            waypoints[waypoints.size] = (611,2200,103);
            waypoints[waypoints.size] = (654,3296,75);
        }
        break;
        case "mp_rust":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (3002,-9871,-244);
            waypoints[waypoints.size] = (2630,-10112,-225);
            waypoints[waypoints.size] = (2368,-10356,-199);
            waypoints[waypoints.size] = (1819,-10242,-192);
            waypoints[waypoints.size] = (2015,-9838,-201);
            waypoints[waypoints.size] = (2034,-9395,-221);
            waypoints[waypoints.size] = (1497,-9355,-181);
            waypoints[waypoints.size] = (1118,-9720,-129);
            waypoints[waypoints.size] = (648,-9955,-86);
            waypoints[waypoints.size] = (314,-9580,-205);
            waypoints[waypoints.size] = (202,-9624,-204);
            waypoints[waypoints.size] = (-328,-9727,-221);
            waypoints[waypoints.size] = (-594,-9864,-206);
            waypoints[waypoints.size] = (724,-9315,-228);
            waypoints[waypoints.size] = (1431,-9296,-184);
            waypoints[waypoints.size] = (509,-9727,-132);
            waypoints[waypoints.size] = (1955,-10430,-210);
            waypoints[waypoints.size] = (2568,-10673,-206);
            waypoints[waypoints.size] = (2377,-9932,-217);
        }
        else if (level.mapVariation == 1)
        {
            waypoints[waypoints.size] = (1264,-6562,-255);
            waypoints[waypoints.size] = (970,-6556,-255);
            waypoints[waypoints.size] = (988,-6240,-255);
            waypoints[waypoints.size] = (1284,-6201,-255);
            waypoints[waypoints.size] = (1182,-6131,-255);
            waypoints[waypoints.size] = (1169,-5529,-255);
            waypoints[waypoints.size] = (1434,-4841,-124);
            waypoints[waypoints.size] = (1299,-5068,-189);
            waypoints[waypoints.size] = (1593,-4717,-255);
            waypoints[waypoints.size] = (1640,-5091,-214);
            waypoints[waypoints.size] = (1453,-4572,-155);
            waypoints[waypoints.size] = (1732,-4594,-125);
        }
        break;
        case "mp_subbase":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-323,-4193,17);
            waypoints[waypoints.size] = (-323,-4677,17);
            waypoints[waypoints.size] = (-323,-5000,17);
            waypoints[waypoints.size] = (-323,-5600,17);
        }
        break;
        case "mp_terminal":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (246.6061,4167.143,40.125);
            waypoints[waypoints.size] = (624.7712,3753.226,40.125);
            waypoints[waypoints.size] = (1130.358,4027.027,40.125);
            waypoints[waypoints.size] = (1087.296,4586.28,40.125);
            waypoints[waypoints.size] = (1313.875,3320.234,40.125);
            waypoints[waypoints.size] = (1449.158,3819.982,38.125);
            waypoints[waypoints.size] = (1877.665,3746.595,52.12454);
            waypoints[waypoints.size] = (2432.747,3782.803,48.125);
            waypoints[waypoints.size] = (2431.024,4194.254,48.125);
            waypoints[waypoints.size] = (2431.89,4409.198,191.5181);
            waypoints[waypoints.size] = (2759.16,3982.838,84.125);
            waypoints[waypoints.size] = (2595.402,3442.513,48.125);
            waypoints[waypoints.size] = (2419.577,3148.779,72.125);
            waypoints[waypoints.size] = (1813.192,3018.418,40.125);
            waypoints[waypoints.size] = (1692.714,3377.876,40.125);
            waypoints[waypoints.size] = (1696.307,3805.034,40.125);
            waypoints[waypoints.size] = (1128.519,2845.981,40.125);
            waypoints[waypoints.size] = (627.8413,2635.537,40.125);
            waypoints[waypoints.size] = (322.6416,3256.328,40.125);
            waypoints[waypoints.size] = (111.4816,3831.948,40.125);
            waypoints[waypoints.size] = (610.4529,2813.211,45.7037);
            waypoints[waypoints.size] = (609.9446,3008.77,203.625);
            waypoints[waypoints.size] = (608.8327,3772.375,203.625);
            waypoints[waypoints.size] = (727.4998,3767.509,193.0807);
            waypoints[waypoints.size] = (960.3929,3766.779,52.02162);
        }
        break;
        case "mp_underpass":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (4035,3004,432);
            waypoints[waypoints.size] = (4045,2773,432);
            waypoints[waypoints.size] = (4048,2364,432);
            waypoints[waypoints.size] = (4049,2018,432);
            waypoints[waypoints.size] = (4064,1219,432);
            waypoints[waypoints.size] = (3091,2595,417);
            waypoints[waypoints.size] = (3071,2862,426);
            waypoints[waypoints.size] = (3077,3131,412);
            waypoints[waypoints.size] = (3163,3380,400);
            waypoints[waypoints.size] = (3562,3143,400);
            waypoints[waypoints.size] = (3604,3351,400);
            waypoints[waypoints.size] = (3569,2352,400);
            waypoints[waypoints.size] = (3838,2738,400);
            waypoints[waypoints.size] = (3888,2470,400);
            waypoints[waypoints.size] = (3888,1986,400);
            waypoints[waypoints.size] = (3481,1786,400);
            waypoints[waypoints.size] = (3488,1358,400);
            waypoints[waypoints.size] = (3800,1339,400);
            waypoints[waypoints.size] = (3924,1878,400);
            waypoints[waypoints.size] = (3251,2396,430);
            waypoints[waypoints.size] = (3540,2548,400);
            waypoints[waypoints.size] = (3699,2556,400);
            waypoints[waypoints.size] = (3820,3132,400);
        }
        break;
        case "mp_overgrown":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-1087,-5965,-153);
            waypoints[waypoints.size] = (-1587,-5965,-153);
            waypoints[waypoints.size] = (-2000,-5965,-153);
            waypoints[waypoints.size] = (-2500,-5965,-153);
            waypoints[waypoints.size] = (-1836,-5700,-148);
            waypoints[waypoints.size] = (-1836,-6100,-148);
        }
        break;
        case "mp_trailerpark":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (66,-2053,16);
            waypoints[waypoints.size] = (602,-2455,16);
            waypoints[waypoints.size] = (1165,-2384,16);
            waypoints[waypoints.size] = (1821,-2632,24);
            waypoints[waypoints.size] = (2225,-2169,16);
            waypoints[waypoints.size] = (1304,-2011,22);
            waypoints[waypoints.size] = (1119,-1849,24);
            waypoints[waypoints.size] = (804,-1853,28);
            waypoints[waypoints.size] = (548,-2022,18);
            waypoints[waypoints.size] = (2639,-2357,16);
            waypoints[waypoints.size] = (2940,-2062,16);
            waypoints[waypoints.size] = (1219,-2967,16);
            waypoints[waypoints.size] = (587,-2609,16);
            waypoints[waypoints.size] = (1174,-2935,16);
            waypoints[waypoints.size] = (-283,-1576,22);
            waypoints[waypoints.size] = (662,-2552,16);
        }
        break;
        case "mp_compact":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (3050,2724,40);
            waypoints[waypoints.size] = (2579,2791,37);
            waypoints[waypoints.size] = (2213,2807,57);
            waypoints[waypoints.size] = (2239,3211,60);
            waypoints[waypoints.size] = (1683,2902,46);
            waypoints[waypoints.size] = (1254,2882,64);
            waypoints[waypoints.size] = (1031,2863,96);
            waypoints[waypoints.size] = (1877,2481,16);
            waypoints[waypoints.size] = (1863,2102,16);
        }
        break;
        case "mp_strike":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-2185,1425,24);
            waypoints[waypoints.size] = (-2500,1425,24);
            waypoints[waypoints.size] = (-3000,1425,24);
            waypoints[waypoints.size] = (-3500,1425,24);
            waypoints[waypoints.size] = (-2185,1500,24);
            waypoints[waypoints.size] = (-2500,1500,24);
            waypoints[waypoints.size] = (-3000,1500,24);
            waypoints[waypoints.size] = (-3500,1500,24);
            waypoints[waypoints.size] = (-2185,1350,24);
            waypoints[waypoints.size] = (-2500,1350,24);
            waypoints[waypoints.size] = (-3000,1350,24);
            waypoints[waypoints.size] = (-3500,1350,24);
        }
        break;
        case "mp_complex":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (1358,-200,400);
            waypoints[waypoints.size] = (320,-376,400);
            waypoints[waypoints.size] = (224,-838,412);
            waypoints[waypoints.size] = (-327,-629,400);
            waypoints[waypoints.size] = (-479,-1103,400);
            waypoints[waypoints.size] = (-545,-312,400);
            waypoints[waypoints.size] = (-1444,-313,400);
            waypoints[waypoints.size] = (-1351,-869,400);
            waypoints[waypoints.size] = (-784,-1140,400);
            waypoints[waypoints.size] = (806,-1165,400);
            waypoints[waypoints.size] = (1429,-1050,400);
            waypoints[waypoints.size] = (2256,-797,400);
            waypoints[waypoints.size] = (2295,-345,400);
            waypoints[waypoints.size] = (2289,-5,400);
            waypoints[waypoints.size] = (1374,-592,412);
        }
        if (level.mapVariation == 1)
        {
            waypoints[waypoints.size] = (2798.63, -1931.75, 1040.13);
            waypoints[waypoints.size] = (3036.63, -1931.75, 1040.13);
            waypoints[waypoints.size] = (2798.63, -1631.75, 1040.13);
            waypoints[waypoints.size] = (3036.63, -1631.75, 1040.13);
            waypoints[waypoints.size] = (2798.63, -1331.75, 1040.13);
            waypoints[waypoints.size] = (3036.63, -1331.75, 1040.13);
            waypoints[waypoints.size] = (2798.63, -1031.75, 1040.13);
            waypoints[waypoints.size] = (3036.63, -1031.75, 1040.13);
        }
        break;
        case "mp_abandon":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-3454,-3475,1);
            waypoints[waypoints.size] = (-2954,3136,1);
            waypoints[waypoints.size] = (-2087,1759,1);
            waypoints[waypoints.size] = (-1268,1108,1);
            waypoints[waypoints.size] = (-1092,1825,5);
            waypoints[waypoints.size] = (-401,2349,1);
            waypoints[waypoints.size] = (-579,2781,1);
            waypoints[waypoints.size] = (-359,3336,1);
            waypoints[waypoints.size] = (-1302,4566,1);
            waypoints[waypoints.size] = (-2586,5430,1);
            waypoints[waypoints.size] = (-3442,4566,1);
            waypoints[waypoints.size] = (-4097,4079,1);
            waypoints[waypoints.size] = (-2971,3461,-4);
            waypoints[waypoints.size] = (-3761,1983,6);
            waypoints[waypoints.size] = (-3194,1270,6);
            waypoints[waypoints.size] = (-3289,206,6);
            waypoints[waypoints.size] = (-4456,1214,6);
            waypoints[waypoints.size] = (-4620,2052,6);
            waypoints[waypoints.size] = (-4466,2611,6);
            waypoints[waypoints.size] = (-4494,3190,6);
            waypoints[waypoints.size] = (-3952,2975,6);
            waypoints[waypoints.size] = (-3434,2581,6);
        }
        break;
        case "mp_vacant":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (129,-1184,-87);
            waypoints[waypoints.size] = (-102,-998,-87);
            waypoints[waypoints.size] = (512,-1227,-86);
            waypoints[waypoints.size] = (-1037,-1199,-88);
            waypoints[waypoints.size] = (995,-220,-101);
            waypoints[waypoints.size] = (-988,1179,-99);
            waypoints[waypoints.size] = (-448,1232,-88);
            waypoints[waypoints.size] = (-551,1724,-87);
            waypoints[waypoints.size] = (677,1760,-95);
            waypoints[waypoints.size] = (68,1406,-92);
            waypoints[waypoints.size] = (-509,1436,-92);
            waypoints[waypoints.size] = (-1791,1320,-100);
            waypoints[waypoints.size] = (-1892,687,-95);
            waypoints[waypoints.size] = (-2015,-219,-91);
            waypoints[waypoints.size] = (-1521,52,-100);
            waypoints[waypoints.size] = (-957,-31,-96);
            waypoints[waypoints.size] = (-1628,708,-95);
            waypoints[waypoints.size] = (-1437,-223,-95);
            waypoints[waypoints.size] = (-1135,-247,-94);
        }
        break;
        case "mp_storm":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (4826,-1328,-52);
            waypoints[waypoints.size] = (4826,-800,-52);
            waypoints[waypoints.size] = (4826, 0,-52);
            waypoints[waypoints.size] = (4826, 800,-52);
            waypoints[waypoints.size] = (4400,-1328,-52);
            waypoints[waypoints.size] = (3700,-1328,-52);
            waypoints[waypoints.size] = (3000,-1328,-52);
            waypoints[waypoints.size] = (5000,-1806,8);
            waypoints[waypoints.size] = (4400,-1806,8);
            waypoints[waypoints.size] = (3700,-1806,8);
            waypoints[waypoints.size] = (3000,-1806,8);
        }
        break;
        case "mp_fuel2":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (18150,27358,7000);
            waypoints[waypoints.size] = (18600,27358,7000);
            waypoints[waypoints.size] = (17800,27358,7000);
            waypoints[waypoints.size] = (19000,27358,7000);
            waypoints[waypoints.size] = (17500,27358,7000);
            waypoints[waypoints.size] = (16500,27358,7000);
            waypoints[waypoints.size] = (20000,27358,7000);
            waypoints[waypoints.size] = (21000,27358,7000);
            waypoints[waypoints.size] = (15500,27358,7000);
            waypoints[waypoints.size] = (18150,27000,7000);
            waypoints[waypoints.size] = (18600,27000,7000);
            waypoints[waypoints.size] = (17800,27000,7000);
            waypoints[waypoints.size] = (18150,27700,7000);
            waypoints[waypoints.size] = (18600,27700,7000);
            waypoints[waypoints.size] = (17800,27700,7000);
        }
        else if (level.mapVariation == 1)
        {
            waypoints[waypoints.size] = (-6251,1700,-130);
            waypoints[waypoints.size] = (-5996,1700,-130);
            waypoints[waypoints.size] = (-6251,2700,-250);
            waypoints[waypoints.size] = (-5996,2700,-250);
        }
        break;
        case "mp_crash":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-829,-1855,128);
            waypoints[waypoints.size] = (-989,-2222,119);
            waypoints[waypoints.size] = (-1049,-3115,85);
            waypoints[waypoints.size] = (-983,-3778,68);
        }
        break;
        case "mp_crossfire":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (2629.74, -4495, -150.715);
            waypoints[waypoints.size] = (2174.32, -4232.14, -119.379);
            waypoints[waypoints.size] = (2366.53, -3859.87, -89.747);
            waypoints[waypoints.size] = (2568.79, -3490.41, -71.178);
            waypoints[waypoints.size] = (2781.1, -3107.02, -49.7082);
            waypoints[waypoints.size] = (3049.5, -2616.42, -27.2612);
            waypoints[waypoints.size] = (3226.63, -2321.09, -4.18731);
            waypoints[waypoints.size] = (2796.76, -3372.43, 10.4963);
            waypoints[waypoints.size] = (2984.83, -3479.45, 23.9299);
        }
        break;
        case "estate":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (423,509,184);
            waypoints[waypoints.size] = (342,30,312);
            waypoints[waypoints.size] = (303,-80,312);
            waypoints[waypoints.size] = (631,-152,312);
            waypoints[waypoints.size] = (430,-14,312);
            waypoints[waypoints.size] = (588,214,312);
            waypoints[waypoints.size] = (739,74,312);
            waypoints[waypoints.size] = (700,341,312);
            waypoints[waypoints.size] = (741,216,184);
            waypoints[waypoints.size] = (605,-124,184);
            waypoints[waypoints.size] = (332,-278,184);
            waypoints[waypoints.size] = (138,-230,184);
            waypoints[waypoints.size] = (879,25,160);
            waypoints[waypoints.size] = (807,-244,48);
            waypoints[waypoints.size] = (641,-115,32);
            waypoints[waypoints.size] = (702,82,32);
            waypoints[waypoints.size] = (495,126,32);
            waypoints[waypoints.size] = (548,311,32);
            waypoints[waypoints.size] = (330,354,28);
            waypoints[waypoints.size] = (378,145,32);
            waypoints[waypoints.size] = (341,-90,32);
            waypoints[waypoints.size] = (111,217,32);
        }
        break;
        case "contingency":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-13869,2645,611);
            waypoints[waypoints.size] = (-13883,3155,704);
            waypoints[waypoints.size] = (-13866,2550,652);
        }
        case "oilrig":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (989, 1165, -1390);
            waypoints[waypoints.size] = (989, 812, -1390);
            waypoints[waypoints.size] = (748, 720, -1390);
            waypoints[waypoints.size] = (748, 1147, -1390);
            waypoints[waypoints.size] = (84, 1139, -1390);
            waypoints[waypoints.size] = (100, 683, -1390);
        }
        break;
        case "airport":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (5096, 3408, 340);
            waypoints[waypoints.size] = (4757, 3408, 340);
            waypoints[waypoints.size] = (4826, 4008, 340);
            waypoints[waypoints.size] = (5169, 4000, 340);
            waypoints[waypoints.size] = (4762, 4610, 340);
            waypoints[waypoints.size] = (5079, 4449, 340);
            waypoints[waypoints.size] = (4432, 4633, 340);
            waypoints[waypoints.size] = (4005, 4635, 380);
            waypoints[waypoints.size] = (3867, 4683, 345);
        }
        break;
        case "cliffhanger":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-3743, -26000, 1056);
            waypoints[waypoints.size] = (-4023, -26012, 1020);
            waypoints[waypoints.size] = (-4087, -25223, 1030);
            waypoints[waypoints.size] = (-3498, -25236, 1010);
            waypoints[waypoints.size] = (-3474, -24954, 1001);
            waypoints[waypoints.size] = (-3453, -24813, 977);
            waypoints[waypoints.size] = (-3072, -24501, 979);
            waypoints[waypoints.size] = (-3471, -24242, 974);
            waypoints[waypoints.size] = (-3935, -24535, 964);
            waypoints[waypoints.size] = (-3671, -24886, 1006);
        }
        break;
        case "dcburning":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-21950, 7900, -180);
            waypoints[waypoints.size] = (-21611, 7897, -125);
            waypoints[waypoints.size] = (-21088, 7901, -180);
            waypoints[waypoints.size] = (-21088, 7339, -180);
            waypoints[waypoints.size] = (-21089, 6909, -180);
            waypoints[waypoints.size] = (-20545, 7006, -180);
            waypoints[waypoints.size] = (-20300, 6859, -180);
            waypoints[waypoints.size] = (-20078, 6759, -180);
            waypoints[waypoints.size] = (-20518, 6717, -180);
            waypoints[waypoints.size] = (-21630, 6718, -180);
            waypoints[waypoints.size] = (-21635, 7004, -180);
            waypoints[waypoints.size] = (-21869, 6877, -180);
            waypoints[waypoints.size] = (-22091, 6779, -180);
        }
        if (level.mapVariation == 1)
        {
            waypoints[waypoints.size] = (-22487, 2787, -260);
            waypoints[waypoints.size] = (-22326, 2526, -245);
            waypoints[waypoints.size] = (-22624, 2590, -245);
            waypoints[waypoints.size] = (-22716, 2261, -245);
            waypoints[waypoints.size] = (-22565, 2027, -225);
            waypoints[waypoints.size] = (-22564, 1721, -245);
            waypoints[waypoints.size] = (-22177, 1100, -245);
            waypoints[waypoints.size] = (-22320, 1570, -270);
            waypoints[waypoints.size] = (-21946, 1172, -275);
            waypoints[waypoints.size] = (-21882, 656, -260);
            waypoints[waypoints.size] = (-21754, 398, -280);
            waypoints[waypoints.size] = (-21430, 512, -245);
            waypoints[waypoints.size] = (-21217, 640, -265);
        }
        break;
        case "boneyard":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-4775, -6561, 5);
            waypoints[waypoints.size] = (-4484, -6549, 5);
            waypoints[waypoints.size] = (-4565, -7055, 10);
            waypoints[waypoints.size] = (-4023, -7165, 0);
            waypoints[waypoints.size] = (-4403, -7724, 5);
            waypoints[waypoints.size] = (-4564, -7719, 5);
        }
        break;
        case "gulag":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (207, 107, 325);
            waypoints[waypoints.size] = (-161, 65, 325);
            waypoints[waypoints.size] = (186, 659, 325);
            waypoints[waypoints.size] = (-35, 979, 325);
            waypoints[waypoints.size] = (-411, 1265, 345);
        }
        break;
        case "dc_whitehouse":
        if (level.mapVariation == 0)
        {
            waypoints[waypoints.size] = (-1992, 8645, -110);
            waypoints[waypoints.size] = (-1982, 8401, -110);
            waypoints[waypoints.size] = (-2242, 8399, -110);
            waypoints[waypoints.size] = (-2246, 8588, -110);
        }
        if (level.mapVariation == 1)
        {
            waypoints[waypoints.size] = (1875, 8620, -225);
            waypoints[waypoints.size] = (1875, 7830, -225);
            waypoints[waypoints.size] = (1875, 7040, -225);
            waypoints[waypoints.size] = (1875, 6450, -225);
        }
        break;
    }

    return waypoints;
}