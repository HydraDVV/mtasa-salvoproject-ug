local damage = {
	["Sniper"] = { player = 100, vehicle = 300 },
	["M4"] = { player = 20, vehicle = 300 },
	["AK-47"] = { player = 10, vehicle = 300 },
	["Colt 45"] = { player = 3, vehicle = 300 },
	["Spraycan"] = { player = -0.4, vehicle = 1 },
	["Deagle"] = { player = 6, vehicle = 150 },
	["Uzi"] = { player = 2, vehicle = 150 },
	["Silenced"] = { player = 8.5, vehicle = 150 },
	["MP5"] = { player = 3, vehicle = 150 },
	["Tec-9"] = { player = 2, vehicle = 150 },
}

addEventHandler ( "onClientPlayerDamage", localPlayer,
function ( attacker, weapon, bodypart, loss )

	if attacker and damage[getWeaponNameFromID(weapon)] then
	
		local health = getElementHealth ( source )
		
		if bodypart == 9 then
			setElementHealth ( source, health - damage[getWeaponNameFromID(weapon)].player * 4 )
		end
	end
end )