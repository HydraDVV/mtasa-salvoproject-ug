function sehireGondert(thePlayer, cmd, targetPlayer)
   if (exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
		if not targetPlayer then
			outputChatBox("Salvo: /" .. cmd .. " [Oyuncunun Adı/ Id]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayer )
			setElementPosition(targetPlayer, 1968.3681640625, -1764.0224609375, 13.546875)
			setElementInterior(targetPlayer, 0)
			setElementDimension(targetPlayer, 0)
      --   outputChatBox("#63a6e2[+]"..targetPlayerName.." Adlı Oyuncuyu İGS'ye.Gönderen Admin :"..getPlayerName(thePlayer), getRootElement() ,0, 255, 0, true)
			outputChatBox("[!] #ffff00"..targetPlayerName.." #ffffff isimli oyuncuyu başarıyla şehire gönderdiniz.", thePlayer, 0, 255, 0, true)
		end
	 end
end
addCommandHandler("igs", sehireGondert)
