function GazeteParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 250)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan $250 kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("GazeteParaVer", true)
addEventHandler("GazeteParaVer", getRootElement(), GazeteParaVer)

function GazeteBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 1663.0537109375, -1882.712890625, 13.546875)
	setElementRotation(thePlayer, 0, 0, 1.3486022949219)
end
addEvent("GazeteBitir", true)
addEventHandler("GazeteBitir", getRootElement(), GazeteBitir)