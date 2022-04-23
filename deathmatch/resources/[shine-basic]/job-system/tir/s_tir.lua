function tirParaVer(thePlayer)-- Bu satırdan sonra aşağıdaki en son outputChatBox'a kadar kopyala diğer meslekler için outputChatBox'da dahil, sonra paralarını ayarla mesleğe göre.
	para = 55500
	if getElementData(thePlayer, "vipver") == 1 then
		para = 60500
	elseif getElementData(thePlayer, "vipver") == 2 then
		para = 75500
	elseif getElementData(thePlayer, "vipver") == 3 then
		para = 90000
	end
	exports.global:giveMoney(thePlayer, para)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan "..para.." TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("tirParaVer", true)
addEventHandler("tirParaVer", getRootElement(), tirParaVer)


function tirBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2586.845703125, -2233.564453125, 13.546875)
	setElementRotation(thePlayer, 0, 0, 270.43533325195)
end
addEvent("tirBitir", true)
addEventHandler("tirBitir", getRootElement(), tirBitir)