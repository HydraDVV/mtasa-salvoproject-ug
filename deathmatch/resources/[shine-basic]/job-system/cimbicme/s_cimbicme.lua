function cimbicmeParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 32500)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan 32.500 TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("cimbicmeParaVer", true)
addEventHandler("cimbicmeParaVer", getRootElement(), cimbicmeParaVer)

function cimbicmeBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2052.9228515625, -1252.7294921875, 23.984375)
	setElementRotation(thePlayer, 0, 0, 1.3486022949219)
end
addEvent("cimbicmeBitir", true)
addEventHandler("cimbicmeBitir", getRootElement(), cimbicmeBitir)