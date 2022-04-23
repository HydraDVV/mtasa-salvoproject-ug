function sehireGondert(thePlayer, cmd, targetPlayer)
       if (exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
      if not targetPlayer then
         outputChatBox("Komut Kullanımı: /" .. cmd .. " [Oyuncunun Adı/ Id]", thePlayer, 255, 194, 14)
      else
         local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayer )
         setElementPosition(targetPlayer, 1514.9560546875, -1740.505859375, 13.546875)
         setElementInterior(targetPlayer, 0)
         setElementDimension(targetPlayer, 0)
   --      outputChatBox("#63a6e2[+]"..targetPlayerName.." Adlı Oyuncuyu Şehire Gönderdi.Gönderen Admin-"..getPlayerName(thePlayer), getRootElement() ,0, 255, 0, true)
         outputChatBox("[!] #ffff00"..targetPlayerName.." #ffffff isimli oyuncuyu başarıyla İEM'e gönderdiniz.", thePlayer, 0, 255, 0, true)
                 end
	 end
end
addCommandHandler("pd", sehireGondert)
