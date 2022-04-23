function flip (player, command)
	local car = getPedOccupiedVehicle(player)
		if isPedInVehicle ( player ) then
    local PlayerMoney = exports.global:getMoney(player)
    if ( PlayerMoney >= 2500) then
		exports.global:takeMoney(player, 2500)
		fixVehicle(car)
		exports['anticheat-system']:changeProtectedElementDataEx(car, "enginebroke", 0, false)
		outputChatBox("#ff0000[!] #ffffffAracını başarıyla tamir etttin (-2500₺)",player,0,225,255,true)
	else
		outputChatBox("#ff0000[!] #ffffffBu komutu kullanabilmek için yeterli paran yok!",player,0,225,255,true)
	end
end
end
addCommandHandler ( "fix", flip )