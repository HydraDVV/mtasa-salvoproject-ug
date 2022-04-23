function busiParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 15500)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan 25.500 TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("busiParaVer", true)
addEventHandler("busiParaVer", getRootElement(), busiParaVer)

function busiBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 1791.4921875, -2297.9384765625, -2.5139412879944)
	setElementRotation(thePlayer, 0, 0, 1.3486022949219)
end
addEvent("busiBitir", true)
addEventHandler("busiBitir", getRootElement(), busiBitir)