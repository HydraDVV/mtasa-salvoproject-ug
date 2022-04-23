function muteVoice(thePlayer, commandName, targetPlayer, ...)
	if (exports.global:isPlayerLeadAdmin(thePlayer)) then
	    local targetPlayer, targetPlayerName = exports.titan_global:findPlayerByPartialNick(thePlayer, targetPlayer)	
		if targetPlayer then
			if not getElementData(targetPlayer, "voicemute") then 
			setElementData(targetPlayer, "voicemute", true)
			exports["titan_infobox"]:addBox(thePlayer, "success", getPlayerName(targetPlayer).." adlı oyuncuyu susturdunuz.")
			exports["titan_infobox"]:addBox(targetPlayer, "error", getPlayerName(targetPlayer).." isimli yetkili sizi susturdu.")
            else
			setElementData(targetPlayer, "voicemute", nil)		
			exports["titan_infobox"]:addBox(thePlayer, "success", getPlayerName(targetPlayer).." adlı oyuncuyunun susturmasını kaldırdınız.")
			exports["titan_infobox"]:addBox(targetPlayer, "success", getPlayerName(targetPlayer).." isimli yetkili susturma cezanızı kaldırdı. Bir dahakine dikkat edin.")
			end
		else
			exports["titan_infobox"]:addBox(thePlayer, "error", "Kullanımı: /voicemute [Karakter Adı & ID]")
		end
	end
end
addCommandHandler("voicemute", muteVoice)
