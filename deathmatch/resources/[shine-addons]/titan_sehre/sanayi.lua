﻿function sehireGondert(thePlayer, cmd, targetPlayer)
       if (exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
      if not targetPlayer then
         outputChatBox("Komut Kullanımı: /" .. cmd .. " [Oyuncunun Adı/ Id]", thePlayer, 255, 194, 14)
      else
         local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayer )
         setElementPosition(targetPlayer, 2896.7980957031, -1980.822265625, 11.115623474121)
         setElementInterior(targetPlayer, 0)
         setElementDimension(targetPlayer, 0)
     --    outputChatBox("#63a6e2[+]"..targetPlayerName.." Adlı Oyuncuyu Grotti Gönderen Admin : "..getPlayerName(thePlayer), getRootElement() ,0, 255, 0, true)
         outputChatBox("[!] #ffff00"..targetPlayerName.." #ffffff isimli oyuncuyu başarıyla sanayi'ye gönderdiniz.", thePlayer, 0, 255, 0, true)
                 end
	 end
end
addCommandHandler("sanayi", sehireGondert)
