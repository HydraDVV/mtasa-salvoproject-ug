function SeyahatParaVer(thePlayer)-- Bu satırdan sonra aşağıdaki en son outputChatBox'a kadar kopyala diğer meslekler için outputChatBox'da dahil, sonra paralarını ayarla mesleğe göre.
	para = 175000
	if getElementData(thePlayer, "vipver") == 1 then
		para = 200000
	elseif getElementData(thePlayer, "vipver") == 2 then
		para = 225000
	elseif getElementData(thePlayer, "vipver") == 3 then
		para = 250000
	end
	exports.global:giveMoney(thePlayer, para)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan "..para.." TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("SeyahatParaVer", true)
addEventHandler("SeyahatParaVer", getRootElement(), SeyahatParaVer)

function SeyahatBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2420.103515625, -2076.5419921875, 13.553834915161)
	setElementRotation(thePlayer, 0, 0, 270.43533325195)
end
addEvent("SeyahatBitir", true)
addEventHandler("SeyahatBitir", getRootElement(), SeyahatBitir)