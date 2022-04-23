function flip (player, command)
	local car = getPedOccupiedVehicle(player)
		if isPedInVehicle ( player ) then
    local PlayerMoney = exports.global:getMoney(player)
    if ( PlayerMoney >= 2500) then
		exports.global:takeMoney(player, 2500)
		setElementRotation(car,180,180,180)
		outputChatBox("#ff0000[!] #ffffffAracını başarıyla döndürdün",player,0,225,255,true)
	else
		outputChatBox("#ff0000[!] #ffffffBu komutu kullanabilmek için yeterli paran yok!",player,0,225,255,true)
	end
end
end
addCommandHandler ( "flipver", flip )