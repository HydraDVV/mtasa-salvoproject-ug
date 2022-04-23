function pizzaParaVer(thePlayer)-- Bu satırdan sonra aşağıdaki en son outputChatBox'a kadar kopyala diğer meslekler için outputChatBox'da dahil, sonra paralarını ayarla mesleğe göre.
	para = 27500
	if getElementData(thePlayer, "vipver") == 1 then
		para = 30500
	elseif getElementData(thePlayer, "vipver") == 2 then
		para = 42500
	elseif getElementData(thePlayer, "vipver") == 3 then
		para = 55500
	end
	exports.global:giveMoney(thePlayer, para)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan "..para.." TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("pizzaParaVer", true)
addEventHandler("pizzaParaVer", getRootElement(), pizzaParaVer)

function pizzaBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2091.0595703125, -1786.98046875, 13.546875)
	setElementRotation(thePlayer, 0, 0, 1.3486022949219)
end
addEvent("pizzaBitir", true)
addEventHandler("pizzaBitir", getRootElement(), pizzaBitir)