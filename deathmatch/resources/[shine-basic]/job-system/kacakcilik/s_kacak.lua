function kacakcilikParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 100000)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan $100000 kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("kacakcilikParaVer", true)
addEventHandler("kacakcilikParaVer", getRootElement(), kacakcilikParaVer)

function kacakcilikBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2575.2900390625, -2422.5078125, 13.635113716125)
	setElementRotation(thePlayer, 0, 0, 312.48065185547)
end
addEvent("kacakcilikBitir", true)
addEventHandler("kacakcilikBitir", getRootElement(), kacakcilikBitir)