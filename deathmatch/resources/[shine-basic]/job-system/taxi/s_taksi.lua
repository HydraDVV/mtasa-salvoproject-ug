function taksiParaVer(thePlayer)-- Bu satırdan sonra aşağıdaki en son outputChatBox'a kadar kopyala diğer meslekler için outputChatBox'da dahil, sonra paralarını ayarla mesleğe göre.
	para = 32500
	if getElementData(thePlayer, "vipver") == 1 then
		para = 50500
	elseif getElementData(thePlayer, "vipver") == 2 then
		para = 55500
	elseif getElementData(thePlayer, "vipver") == 3 then
		para = 60000
	end
	exports.global:giveMoney(thePlayer, para)
	outputChatBox("[!] #FFFFFFTebrikler, bu turdan "..para.." TL kazandınız!", thePlayer, 0, 255, 0, true)
end
addEvent("taksiParaVer", true)
addEventHandler("taksiParaVer", getRootElement(), taksiParaVer)


function taksiBitir(thePlayer)
	local pedVeh = getPedOccupiedVehicle(thePlayer)
	removePedFromVehicle(thePlayer)
	respawnVehicle(pedVeh)
	setElementPosition(thePlayer, 1814.4443359375, -1896.5556640625, 13.578125)
	setElementRotation(thePlayer, 0, 0, 270.43533325195)
end
addEvent("taksiBitir", true)
addEventHandler("taksiBitir", getRootElement(), taksiBitir)