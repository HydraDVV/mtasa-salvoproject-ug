function kacaketParaVer(thePlayer)-- Bu satırdan sonra aşağıdaki en son outputChatBox'a kadar kopyala diğer meslekler için outputChatBox'da dahil, sonra paralarını ayarla mesleğe göre.
	para = 25500
	if getElementData(thePlayer, "vipver") == 1 then
		para = 30500
	elseif getElementData(thePlayer, "vipver") == 2 then
		para = 35000
	elseif getElementData(thePlayer, "vipver") == 3 then
		para = 40000
	end
	exports.global:giveMoney(thePlayer, para)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan "..para.." TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("kacaketParaVer", true)
addEventHandler("kacaketParaVer", getRootElement(), kacaketParaVer)

function kacaketBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2772.3564453125, -2499.013671875, 13.663354873657)
	setElementRotation(thePlayer, 0, 0, 1.3486022949219)
end
addEvent("kacaketBitir", true)
addEventHandler("kacaketBitir", getRootElement(), kacaketBitir)