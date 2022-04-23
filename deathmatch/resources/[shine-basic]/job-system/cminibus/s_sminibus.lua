function cminibusParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 27500)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan 27.500 TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("cminibusParaVer", true)
addEventHandler("cminibusParaVer", getRootElement(), cminibusParaVer)

function cminibusBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, -1983.7666015625, 128.4521484375, 27.6875)
	setElementRotation(thePlayer, 0, 0, 1.3486022949219)
end
addEvent("cminibusBitir", true)
addEventHandler("cminibusBitir", getRootElement(), cminibusBitir)