function cayParaVer(thePlayer)
	exports.global:giveMoney(thePlayer, 40000)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan $40000 kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("cayParaVer", true)
addEventHandler("cayParaVer", getRootElement(), cayParaVer)

function cayBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 691.7666015625, -471.5517578125, 16.536296844482)
	setElementRotation(thePlayer, 0, 0, 270.43533325195)
end
addEvent("cayBitir", true)
addEventHandler("cayBitir", getRootElement(), cayBitir)