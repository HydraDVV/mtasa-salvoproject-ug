function gazeteParaVer(thePlayer)-- Bu satırdan sonra aşağıdaki en son outputChatBox'a kadar kopyala diğer meslekler için outputChatBox'da dahil, sonra paralarını ayarla mesleğe göre.
	para = 9000
	if getElementData(thePlayer, "vipver") == 1 then
		para = 13500
	elseif getElementData(thePlayer, "vipver") == 2 then
		para = 15500
	elseif getElementData(thePlayer, "vipver") == 3 then
		para = 20000
	end
	exports.global:giveMoney(thePlayer, para)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan "..para.." TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("gazeteParaVer", true)
addEventHandler("gazeteParaVer", getRootElement(), gazeteParaVer)

function gazeteBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 1235.2861328125, -1821.3984375, 13.594610214233)
	setElementRotation(thePlayer, 0, 0, 1.3486022949219)
end
addEvent("gazeteBitir", true)
addEventHandler("gazeteBitir", getRootElement(), gazeteBitir)