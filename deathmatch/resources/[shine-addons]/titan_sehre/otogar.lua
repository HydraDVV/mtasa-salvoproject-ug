function sehireGondert(thePlayer, cmd, targetPlayer)
       if (exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
      if not targetPlayer then
         outputChatBox("Komut Kullanımı: /" .. cmd .. " [Oyuncunun Adı/ Id]", thePlayer, 255, 194, 14)
      else
         local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayer )
         setElementPosition(targetPlayer, 2420.31640625, -2073.580078125, 13.553834915161)
         setElementInterior(targetPlayer, 0)
         setElementDimension(targetPlayer, 0)
    --     outputChatBox("#63a6e2[+]"..targetPlayerName.." Adlı Oyuncuyu Jefferson'a Gönderen Admin :"..getPlayerName(thePlayer), getRootElement() ,0, 255, 0, true)
         outputChatBox("[!] #ffff00"..targetPlayerName.." #ffffff isimli oyuncuyu başarıyla şehire gönderdiniz.", thePlayer, 0, 255, 0, true)
                 end
	 end
end
addCommandHandler("otogar", sehireGondert)
