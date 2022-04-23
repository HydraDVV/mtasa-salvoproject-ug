
function yakaTelsiz(thePlayer, commandName, ...)
        local logged = getElementData(thePlayer, "loggedin")
        if (logged==1) and getElementData(thePlayer, "faction")==79 and getElementData(thePlayer, "faction")==2 and getElementData(thePlayer, "faction")==6 then -- Kodun Uygulanacağı Fact ID'ı
		if not (...) then
			outputChatBox("KOMUT: /yt [Mesaj]", thePlayer, 18, 184, 193)
		else
			local theTeam = getPlayerTeam(thePlayer)
			local factionRank = tonumber(getElementData(thePlayer,"factionrank"))
			local factionRanks = getElementData(theTeam, "ranks")
			local factionRankTitle = factionRanks[factionRank]
			local message = table.concat({...}, " ")
			local username = getPlayerName(thePlayer)
            for k, arrayPlayer in ipairs(getPlayersInTeam(getTeamFromName ("Istanbul Emnıyet Genel Mudurlugu"))) do  -- Kodun Uygulanacağı Fact Adı
			for k, arrayPlayer in ipairs(getPlayersInTeam(getTeamFromName ("Istanbul Acil Servisleri"))) do  -- Kodun Uygulanacağı Fact Adı
			for k, arrayPlayer in ipairs(getPlayersInTeam(getTeamFromName ("'Istanbul Yoldaş Televizyonu"))) do  -- Kodun Uygulanacağı Fact Adı
			for k, arrayPlayer in ipairs(getPlayersInTeam(getTeamFromName ("'Istanbul Otomotiv"))) do  -- Kodun Uygulanacağı Fact Adı
				if getElementData(thePlayer, "faction")==79 then -- Kodun Uygulanacağı Fact ID'ı
				if getElementData(thePlayer, "faction")==2 then -- Kodun Uygulanacağı Fact ID'ı
				if getElementData(thePlayer, "faction")==6 then -- Kodun Uygulanacağı Fact ID'ı
				if getElementData(thePlayer, "faction")==1 then -- Kodun Uygulanacağı Fact ID'ı
					outputChatBox("[YAKA TELSIZ] ".. factionRankTitle .. " " .. username:gsub("_", " ") .. " :#ffffff " .. message, arrayPlayer, 18, 184, 193, true)
					triggerClientEvent(thePlayer,"telsiz2",thePlayer)
					triggerClientEvent(arrayPlayer,"telsiz2",arrayPlayer)
				end
				
			end
		end
		 else

	end
end
addCommandHandler("att", yakaTelsiz, false, false)
addCommandHandler("ctt", yakaTelsiz, false, false)
addCommandHandler("ytt", yakaTelsiz, false, false)
addCommandHandler("stt", yakaTelsiz, false, false)
