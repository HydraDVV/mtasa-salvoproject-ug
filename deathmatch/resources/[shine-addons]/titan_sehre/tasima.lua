function sehireGondert(thePlayer, cmd, targetPlayer)
       if (exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
      if not targetPlayer then
         outputChatBox("Komut Kullanımı: /" .. cmd .. " [Oyuncunun Adı/ Id]", thePlayer, 255, 194, 14)
      else
         local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayer )
         setElementPosition(targetPlayer, 2718.4228515625, -2396.0498046875, 13.6328125)
         setElementInterior(targetPlayer, 0)
         setElementDimension(targetPlayer, 0)
      --   outputChatBox("#63a6e2[+]"..targetPlayerName.." Adlı Oyuncuyu İGS'ye.Gönderen Admin :"..getPlayerName(thePlayer), getRootElement() ,0, 255, 0, true)
         outputChatBox("[!] #ffff00"..targetPlayerName.." #ffffff isimli oyuncuyu başarıyla şehire gönderdiniz.", thePlayer, 0, 255, 0, true)
                 end
	 end
end
addCommandHandler("tasima", sehireGondert)
