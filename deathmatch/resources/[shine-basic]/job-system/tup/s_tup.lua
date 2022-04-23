function tupParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 50000)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan $50000 kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("tupParaVer", true)
addEventHandler("tupParaVer", getRootElement(), tupParaVer)

function tupBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2298.287109375, -2076.712890625, 13.546875)
	setElementRotation(thePlayer, 0, 0, 270.43533325195)
end
addEvent("tupBitir", true)
addEventHandler("tupBitir", getRootElement(), tupBitir)