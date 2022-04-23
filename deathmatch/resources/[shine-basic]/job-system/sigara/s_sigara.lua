function sigaraParaVer(thePlayer)-- Bu satırdan sonra aşağıdaki en son outputChatBox'a kadar kopyala diğer meslekler için outputChatBox'da dahil, sonra paralarını ayarla mesleğe göre.
	para = 65000
	if getElementData(thePlayer, "vipver") == 1 then
		para = 70500
	elseif getElementData(thePlayer, "vipver") == 2 then
		para = 85500
	elseif getElementData(thePlayer, "vipver") == 3 then
		para = 95500
	end
	exports.global:giveMoney(thePlayer, para)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan "..para.." TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("sigaraParaVer", true)
addEventHandler("sigaraParaVer", getRootElement(), sigaraParaVer)

function sigaraBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 2232.7412109375, -2228.7109375, 13.554685592651)
	setElementRotation(thePlayer, 0, 0, 267.11743164063)
end
addEvent("sigaraBitir", true)
addEventHandler("sigaraBitir", getRootElement(), sigaraBitir)