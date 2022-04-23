function ickiParaVer(thePlayer)-- Bu satırdan sonra aşağıdaki en son outputChatBox'a kadar kopyala diğer meslekler için outputChatBox'da dahil, sonra paralarını ayarla mesleğe göre.
	para = 70500
	if getElementData(thePlayer, "vipver") == 1 then
		para = 82500
	elseif getElementData(thePlayer, "vipver") == 2 then
		para = 90500
	elseif getElementData(thePlayer, "vipver") == 3 then
		para = 100500
	end
	exports.global:giveMoney(thePlayer, para)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan "..para.." TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("ickiParaVer", true)
addEventHandler("ickiParaVer", getRootElement(), ickiParaVer)


function ickiBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2222.615234375, -2216.9619140625, 13.546875)
	setElementRotation(thePlayer, 0, 0, 312.48065185547)
end
addEvent("ickiBitir", true)
addEventHandler("ickiBitir", getRootElement(), ickiBitir)