function KamyonParaVer(thePlayer)-- Bu satırdan sonra aşağıdaki en son outputChatBox'a kadar kopyala diğer meslekler için outputChatBox'da dahil, sonra paralarını ayarla mesleğe göre.
	para = 40000
	if getElementData(thePlayer, "vipver") == 1 then
		para = 45000
	elseif getElementData(thePlayer, "vipver") == 2 then
		para = 50000
	elseif getElementData(thePlayer, "vipver") == 3 then
		para = 60000
	end
	exports.global:giveMoney(thePlayer, para)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan "..para.." TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("KamyonParaVer", true)
addEventHandler("KamyonParaVer", getRootElement(), KamyonParaVer)

function KamyonBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2221.287109375, -2665.4521484375, 13.540906906128)
	setElementRotation(thePlayer, 0, 0, 1.3486022949219)
end
addEvent("KamyonBitir", true)
addEventHandler("KamyonBitir", getRootElement(), KamyonBitir)