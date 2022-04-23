function nahVer(thePlayer, cmd, targetPlayer)
	if getElementData(thePlayer, "account:username") == "REMAJOR" then
		if not (targetPlayer) then
			outputChatBox("[*] SÖZDİZİMİ: /" .. cmd .. " [Oyuncu İsmi / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)

			if targetPlayer then
				triggerClientEvent(targetPlayer, "admin:nahShow", thePlayer)
				setTimer(triggerClientEvent, 7000, 1, targetPlayer, "admin:noNah", thePlayer)
				outputChatBox(getElementData(thePlayer, "account:username") .. " size bir adet nah verdi. Tebrikler.", targetPlayer, 0, 255, 0)
				outputChatBox(targetPlayerName .. " isimli oyuncuya bir adet nah verdiniz.", thePlayer, 0, 255, 0)
			end
		end
	end
end
addCommandHandler("nahver", nahVer)

--addCommandHandler("gercekhediyem",
	--function( thePlayer )
		--triggerClientEvent(thePlayer, "admin:nahShow", thePlayer)
		--setTimer(triggerClientEvent, 7000, 1, thePlayer, "admin:noNah", thePlayer)	
		--outputChatBox("Bluee size ve diğer tüm oyunculara bir adet karne hediyesi verdi. Tebrikler.", targetPlayer, 0, 255, 0)
	-- end
-- )

function nahVerYetkili(thePlayer, cmd)
	if getElementData(thePlayer, "account:username") == "REMAJOR" then
		for index, targetPlayer in ipairs(getElementsByType("player")) do
			if exports.global:isPlayerAdmin(targetPlayer) then
				triggerClientEvent(targetPlayer, "admin:nahShow", thePlayer)
				setTimer(triggerClientEvent, 5000, 1, targetPlayer, "admin:noNah", thePlayer)
				outputChatBox(getElementData(thePlayer, "account:username") .. " size ve diğer tüm yetkililere bir adet nah verdi. Tebrikler.", targetPlayer, 0, 255, 0)
				outputChatBox("Tüm yetkililere bir adet nah verdiniz.", thePlayer, 0, 255, 0)
			end
		end
	end
end
addCommandHandler("yetkilinah", nahVerYetkili)