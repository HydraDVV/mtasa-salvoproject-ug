function sehireGondert(thePlayer, cmd, targetPlayer)
       if (exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
      if not targetPlayer then
         outputChatBox("Komut Kullanımı: /" .. cmd .. " [Oyuncunun Adı/ Id]", thePlayer, 255, 194, 14)
      else
         local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayer )
         setElementPosition(targetPlayer,    1644.603515625, -1170.1923828125, 24.078125)
         setElementInterior(targetPlayer, 0)
         setElementDimension(targetPlayer, 0)
    --     outputChatBox("#63a6e2[+]"..targetPlayerName.." Adlı Oyuncuyu Temizlik Mesleğine Gönderen Admin :"..getPlayerName(thePlayer), getRootElement() ,0, 255, 0, true)
         outputChatBox("[!] #ffff00"..targetPlayerName.." #ffffff isimli oyuncuyu başarıyla İkinciel galeriye  gönderdiniz.", thePlayer, 0, 255, 0, true)
                 end
	 end
end
addCommandHandler("ikinciel", sehireGondert)
