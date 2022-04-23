
function yakaTelsiz(thePlayer, commandName, ...)
        local logged = getElementData(thePlayer, "loggedin")
        if (logged==1) and getElementData(thePlayer, "faction")==2   then -- Kodun Uygulanacağı Fact ID'ı
		if not (...) then
			outputChatBox("KOMUT: /yt [Mesaj]", thePlayer, 226, 53, 58)
		else
			local theTeam = getPlayerTeam(thePlayer)
			local factionRank = tonumber(getElementData(thePlayer,"factionrank"))
			local factionRanks = getElementData(theTeam, "ranks")
			local factionRankTitle = factionRanks[factionRank]
			local message = table.concat({...}, " ")
			local username = getPlayerName(thePlayer)
            for k, arrayPlayer in ipairs(getPlayersInTeam(getTeamFromName ("Istanbul Acil Servisleri"))) do  -- Kodun Uygulanacağı Fact Adı
				if getElementData(thePlayer, "faction")==2 then -- Kodun Uygulanacağı Fact ID'ı
					outputChatBox("[YAKA TELSIZ] ".. factionRankTitle .. " " .. username:gsub("_", " ") .. " :#e2353a " .. message, arrayPlayer, 226, 53, 58, true)
					triggerClientEvent(thePlayer,"telsiz2",thePlayer)
					triggerClientEvent(arrayPlayer,"telsiz2",arrayPlayer)
				end
				
			end
		end
		 else

	end
end
addCommandHandler("at", yakaTelsiz, false, false)
