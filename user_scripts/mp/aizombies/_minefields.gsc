minefields()
{
	minefields = getentarray("minefield", "targetname");
	if (minefields.size > 0)
	{
		level._effect["mine_explosion"] = loadfx ("vfx/explosion/frag_grenade_dirt");
	}
	
	for(i = 0; i < minefields.size; i++)
	{
		minefields[i] thread minefield_think();
	}	
}

minefield_think()
{
	while (1)
	{
		self waittill ("trigger",other);
		
		if(isPlayer(other))
			other thread minefield_kill(self);
	}
}

minefield_kill(trigger)
{
	if(isDefined(self.minefield) || !isdefined(self.isDown) || (isDefined(self.isDown) && self.isDown))
		return;
		
	self.minefield = true;
	self playsound ("weap_claymore_pin");

	wait(.5);
	wait(randomFloat(.5));

	if(self istouching(trigger))
	{
		origin = self getorigin();
		range = 300;
		maxdamage = 2000;
		mindamage = 50;

		self playsound("wpn_explosive_drone_exp");
		playfx(level._effect["mine_explosion"], origin);
		self finishPlayerDamage(level, level, self.maxHealth - 1, 0, "MOD_FALLING", "none", self.origin, (0,0,0), "none", 0, 0);
	}

	wait(3);
	
	self.minefield = undefined;
}
