init()
{
	setDvarIfUninitialized("aiz_enabled", 0);
	if (getDvar("g_gametype") == "war" || getDvar("g_gametype") == "zombies")
	{
		if (getDvarInt("aiz_enabled"))
			user_scripts\mp\aizombies\_aiz::init();
	}
}