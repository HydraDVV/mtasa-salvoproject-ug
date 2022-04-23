function kargoParaVer(thePlayer)-- Bu satırdan sonra aşağıdaki en son outputChatBox'a kadar kopyala diğer meslekler için outputChatBox'da dahil, sonra paralarını ayarla mesleğe göre.
	para = 16500
	if getElementData(thePlayer, "vipver") == 1 then
		para = 21500
	elseif getElementData(thePlayer, "vipver") == 2 then
		para = 25500
	elseif getElementData(thePlayer, "vipver") == 3 then
		para = 30500
	end
	exports.global:giveMoney(thePlayer, para)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan "..para.." TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("kargoParaVer", true)
addEventHandler("kargoParaVer", getRootElement(), kargoParaVer)

function kargoBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 1235.0244140625, -1823.8974609375, 13.590950012207)
	setElementRotation(thePlayer, 0, 0, 1.3486022949219)
end
addEvent("kargoBitir", true)
addEventHandler("kargoBitir", getRootElement(), kargoBitir)