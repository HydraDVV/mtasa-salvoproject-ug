
function yakaTelsiz(thePlayer, commandName, ...)
        local logged = getElementData(thePlayer, "loggedin")
        if (logged==1) and getElementData(thePlayer, "faction")==79   then -- Kodun Uygulanacağı Fact ID'ı
		if not (...) then
			outputChatBox("KOMUT: /yt [Mesaj]", thePlayer, 18, 184, 193)
		else
			local theTeam = getPlayerTeam(thePlayer)
			local factionRank = tonumber(getElementData(thePlayer,"factionrank"))
			local factionRanks = getElementData(theTeam, "ranks")
			local factionRankTitle = factionRanks[factionRank]
			local message = table.concat({...}, " ")
			local username = getPlayerName(thePlayer)
            for k, arrayPlayer in ipairs(getPlayersInTeam(getTeamFromName ("İstanbul Oto Çekim & Tamirat"))) do  -- Kodun Uygulanacağı Fact Adı
				if getElementData(thePlayer, "faction")==79 then -- Kodun Uygulanacağı Fact ID'ı
					outputChatBox("[YAKA TELSIZ] ".. factionRankTitle .. " " .. username:gsub("_", " ") .. " :#12b8c1 " .. message, arrayPlayer, 18, 184, 193, true)
					triggerClientEvent(thePlayer,"telsiz2",thePlayer)
					triggerClientEvent(arrayPlayer,"telsiz2",arrayPlayer)
				end
				
			end
		end
		 else

	end
end
addCommandHandler("ot", yakaTelsiz, false, false)
