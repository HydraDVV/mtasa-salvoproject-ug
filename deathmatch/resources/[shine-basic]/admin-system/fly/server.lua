function fly(thePlayer, commandName)
	local veh = getPedOccupiedVehicle(thePlayer)
	if exports.global:isPlayerAdmin(thePlayer) then
		if veh then outputChatBox("#822828"..exports["pool"]:getServerName()..":#f9f9f9 Bir araç içerisinde /fly komutunu kullanamazsınız.", thePlayer, 255, 0, 0, true) return end
		triggerClientEvent(thePlayer, "onClientFlyToggle", thePlayer)
	end
end
addCommandHandler("fly", fly, false, false)