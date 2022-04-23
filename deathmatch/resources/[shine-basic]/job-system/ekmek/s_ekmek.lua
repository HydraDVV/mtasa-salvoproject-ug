function ekmekParaVer(thePlayer)-- Bu satırdan sonra aşağıdaki en son outputChatBox'a kadar kopyala diğer meslekler için outputChatBox'da dahil, sonra paralarını ayarla mesleğe göre.
	para = 10500
	if getElementData(thePlayer, "vipver") == 1 then
		para = 12500
	elseif getElementData(thePlayer, "vipver") == 2 then
		para = 14500
	elseif getElementData(thePlayer, "vipver") == 3 then
		para = 17000
	end
	exports.global:giveMoney(thePlayer, para)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan "..para.." TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("ekmekParaVer", true)
addEventHandler("ekmekParaVer", getRootElement(), ekmekParaVer)



function ekmekBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2073.8701171875, -1909.3515625, 13.546875)
	setElementRotation(thePlayer, 0, 0, 1.3486022949219)
end
addEvent("ekmekBitir", true)
addEventHandler("ekmekBitir", getRootElement(), ekmekBitir)