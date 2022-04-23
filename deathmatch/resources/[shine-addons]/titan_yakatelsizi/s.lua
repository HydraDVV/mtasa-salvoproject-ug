
function yakaTelsiz(thePlayer, commandName, ...)
        local logged = getElementData(thePlayer, "loggedin")
        if (logged==1) and getElementData(thePlayer, "faction") == 1   then -- Kodun Uygulanacağı Fact ID'ı
		if not (...) then
			outputChatBox("KOMUT: /yt [Mesaj]", thePlayer, 255, 194, 14)
		else
			local theTeam = getPlayerTeam(thePlayer)
			local factionRank = tonumber(getElementData(thePlayer,"factionrank"))
			local factionRanks = getElementData(theTeam, "ranks")
			local factionRankTitle = factionRanks[factionRank]
			local message = table.concat({...}, " ")
			local username = getPlayerName(thePlayer)
            for k, arrayPlayer in ipairs(getPlayersInTeam(getTeamFromName ("İstanbul İl Emniyet Mudurlugu"))) do  -- Kodun Uygulanacağı Fact Adı
				if getElementData(thePlayer, "faction")==1 then -- Kodun Uygulanacağı Fact ID'ı
					outputChatBox("[YAKA TELSIZ] ".. factionRankTitle .. " " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 50, 125, 200, true)
					triggerClientEvent(thePlayer,"telsiz2",thePlayer)
					triggerClientEvent(arrayPlayer,"telsiz2",arrayPlayer)
				end
				
			end
		end
		 else

	end
end
addCommandHandler("yt", yakaTelsiz, false, false)
