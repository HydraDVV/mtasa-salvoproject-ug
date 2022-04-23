local damage = {
	["Sniper"] = { player = 100, vehicle = 300 },
	["M4"] = { player = 15, vehicle = 300 },
	["AK-47"] = { player = 10, vehicle = 300 },
	["Colt 45"] = { player = 1, vehicle = 300 },
}

addEventHandler ( "onClientPlayerDamage", localPlayer,
function ( attacker, weapon, bodypart, loss )
	if getElementData ( source, "player.duty" ) then return end

	if attacker and damage[getWeaponNameFromID(weapon)] then
		cancelEvent ( )
	
		local health = getElementHealth ( source )
		
		if bodypart ~= 9 then
			setElementHealth ( source, health - damage[getWeaponNameFromID(weapon)].player )
		else
			setElementHealth ( source, health - damage[getWeaponNameFromID(weapon)].player * 3 )
		end
	end
end )