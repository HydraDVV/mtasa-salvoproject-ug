﻿function clear ( thePlayer )
local cuenta = getAccountName( getPlayerAccount(thePlayer) )
if (exports.global:isPlayerAdmin(thePlayer)) then --Admin Grubu
	spaces(thePlayer)
elseif (exports.global:isPlayerLeadAdmin(thePlayer)) then --SuperModerator Grubu
	spaces(thePlayer)
elseif (exports.global:isPlayerSuperAdmin(thePlayer)) then --Moderator Grubu
	spaces(thePlayer)
else
outputChatBox("Bunu Yapma Yetkin Yok!", thePlayer, 255, 0, 0, true) --Admin Olmayanlar Yazýnca Bu Yazý Çýkar.
end
end
addCommandHandler("temizle", clear)

function spaces(thePlayer)
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox(" ")
outputChatBox("#00B3C7[Sohbet Temizlendi , Salvo World  iyi Oyunlar Diler. . ]#ffffff==>"..getPlayerName(thePlayer), getRootElement(), 255, 255, 255, true)
end