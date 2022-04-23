function aractParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 27000)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan 27.000 TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("aractParaVer", true)
addEventHandler("aractParaVer", getRootElement(), aractParaVer)

function aractBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2718.2646484375, -2392.59375, 13.6328125)
	setElementRotation(thePlayer, 0, 0, 1.3486022949219)
end
addEvent("aractBitir", true)
addEventHandler("aractBitir", getRootElement(), aractBitir)