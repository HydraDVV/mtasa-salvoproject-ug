weapons = {
	["Fist"] = { aggroDistance = 3, soundDistance = 10 },
	["Brassknuckle"] = { aggroDistance = 3, soundDistance = 10 },
	
	["Golfclub"] = { aggroDistance = 3, soundDistance = 20 },
	["Nightstick"] = { aggroDistance = 3, soundDistance = 20 },
	["Knife"] = { aggroDistance = 3, soundDistance = 20 },
	["Bat"] = { aggroDistance = 3, soundDistance = 20 },
	["Shovel"] = { aggroDistance = 3, soundDistance = 20 },
	["Poolstick"] = { aggroDistance = 3, soundDistance = 20 },
	["Katana"] = { aggroDistance = 3, soundDistance = 20 },
	["Chainsaw"] = { aggroDistance = 3, soundDistance = 20 },
	
	["Colt 45"] = { aggroDistance = 20, soundDistance = 140 },
	["Silenced"] = { aggroDistance = 0.1, soundDistance = 70 },
	["Deagle"] = { aggroDistance = 30, soundDistance = 200 },
	["Shotgun"] = { aggroDistance = 40, soundDistance = 240 },
	["Sawed-off"] = { aggroDistance = 30, soundDistance = 200 },
	["Combat Shotgun"] = { aggroDistance = 30, soundDistance = 180 },
	
	["Uzi"] = { aggroDistance = 50, soundDistance = 320 },
	["MP5"] = { aggroDistance = 50, soundDistance = 320 },
	["Tec-9"] = { aggroDistance = 50, soundDistance = 320 },
	
	["AK-47"] = { aggroDistance = 70, soundDistance = 400 },
	["M4"] = { aggroDistance = 60, soundDistance = 270 },
	
	["Rifle"] = { aggroDistance = 80, soundDistance = 400 },
	["Sniper"] = { aggroDistance = 100, soundDistance = 2000 },
	
	["Rocket Launcher"] = { damage = 100, aggroDistance = 200, soundDistance = 1000 },
	
	["Rocket Launcher HS"] = { damage = 100, aggroDistance = 200, soundDistance = 1000 },
}

addEventHandler ( "onClientExplosion", root,
function ( x, y, z, type )
	if type == 2 then
		local explosion = playSound3D ( "files/explosion.ogg", x, y, z, false )
		
		setSoundMaxDistance ( explosion, 1000 )
	end
end )