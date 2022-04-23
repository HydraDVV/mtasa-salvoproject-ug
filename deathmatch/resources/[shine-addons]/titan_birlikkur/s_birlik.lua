mysql = exports.mysql
function birlikKur(thePlayer, birlikName, birlikType)
	local para = exports.global:getMoney(thePlayer)	
	
	if string.len(birlikName) < 4 then
	    outputChatBox("#cc0000[!] #FFFFFFBirlik ismi en az 4 karakterden oluşmalıdır!", thePlayer, 0, 255, 0, true)
		return false
	elseif string.len(birlikName) > 36 then
	    outputChatBox("#cc0000[!] #FFFFFFBirlik ismi en fazla 36 karakterden oluşmalıdır!", thePlayer, 0, 255, 0, true)
		return false
	end
	
	if para >= 750000 then
		factionName = birlikName
		factionType = tonumber(birlikType)
		local getrow = mysql:query("SELECT * FROM factions WHERE name='" .. factionName .. "'")
		local numrows = mysql:num_rows(getrow)
		if numrows > 0 then
		    outputChatBox("#cc0000[!] #FFFFFFMaalesef, birlik ismi kullanımda.", thePlayer, 0, 255, 0, true)
			return false
		end
		
		local theTeam = createTeam(tostring(factionName))
		if theTeam then
			if mysql:query_free("INSERT INTO factions SET name='" .. mysql:escape_string(factionName) .. "', bankbalance='0', type='" .. mysql:escape_string(factionType) .. "'") then
				local id = mysql:insert_id()
				exports.pool:allocateElement(theTeam, id)
				
				mysql:query_free("UPDATE characters SET faction_leader = 1, faction_id = " .. id .. ", faction_rank = 1, duty = 0 WHERE id = " .. getElementData(thePlayer, "dbid"))
				
				exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "faction", id, true)
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "type", tonumber(factionType))
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "id", tonumber(id))
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "onay", 0, true)
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "level", 1, true)
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "money", 0)
					
				setPlayerTeam(thePlayer, theTeam)
				if id > 0 then
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "faction", id, true)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "factionrank", 1, true)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "factionphone", nil, true)
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "factionleader", 1, true)
					triggerEvent("duty:offduty", thePlayer)
					
					triggerEvent("onPlayerJoinFaction", thePlayer, theTeam)
				end
				
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "note", "", false)
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "fnote", "", false)
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "phone", nil, false)
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "max_interiors", 20, false, true)
		
				mysql:query_free("UPDATE factions SET rank_1='Dynamic Rank #1', rank_2='Dynamic Rank #2', rank_3='Dynamic Rank #3', rank_4='Dynamic Rank #4', rank_5='Dynamic Rank #5', rank_6='Dynamic Rank #6', rank_7='Dynamic Rank #7', rank_8='Dynamic Rank #8', rank_9='Dynamic Rank #9', rank_10='Dynamic Rank #10', rank_11='Dynamic Rank #11', rank_12='Dynamic Rank #12', rank_13='Dynamic Rank #13', rank_14='Dynamic Rank #14', rank_15='Dynamic Rank #15', rank_16='Dynamic Rank #16', rank_17='Dynamic Rank #17', rank_18='Dynamic Rank #18', rank_19='Dynamic Rank #19', rank_20='Dynamic Rank #20',  motd='Birliğe hoş geldiniz.', note = 'Birlik ID:"..id.."' WHERE id='" .. id .. "'")
				outputChatBox("[!] #FFFFFF'" .. factionName .. "' isimli birliğiniz başarıyla oluşturuldu! ID #" .. id .. ".", thePlayer, 0, 255, 0, true)
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "type", tonumber(factionType))
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "id", tonumber(id))
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "money", 0)
					
				local factionRanks = {}
				local factionWages = {}
				for i = 1, 20 do
					factionRanks[i] = "Dynamic Rank #" .. i
					factionWages[i] = 100
				end
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "ranks", factionRanks, false)
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "wages", factionWages, false)
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "motd", "Birliğe hoş geldiniz.", false)
				exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "note", "Birlik ID:".. id, false)
				exports.logs:dbLog(thePlayer, 4, theTeam, "MAKE FACTION")
				exports.global:takeMoney(thePlayer, 750000)
				exports.global:sendMessageToAdmins("AdmWarn: " .. getPlayerName(thePlayer) .. " yeni birlik oluşturdu! Birlik Ismi: '" .. factionName .. "' Birlik ID #" .. id)
			else
				destroyElement(theTeam)
				outputChatBox("#cc0000[!] #FFFFFFBirliğinizi oluştururken bir hata meydana geldi.", thePlayer, 255, 0, 0, true)
			end
		else
			outputChatBox("#cc0000[!] #FFFFFF'" .. tostring(factionName) .. "' isimli birlik zaten var.", thePlayer, 255, 0, 0, true)
		end
	else
	    outputChatBox("#cc0000[!] #FFFFFFMaalesef, birlik kuracak paranız yok.", thePlayer, 255, 0, 0, true)
	end
end
addEvent("birlikKur", true)
addEventHandler("birlikKur", getRootElement(), birlikKur)

function birlikSeviye(thePlayer, birlikIsmi, birlikSeviye, birlikFiyat)
	local para = exports.global:getMoney(thePlayer)
	if para >= birlikFiyat then
		if birlikIsmi and birlikSeviye then
			local theTeam = getTeamFromName(birlikIsmi)
			outputChatBox(birlikIsmi, thePlayer)
			local birlikLevelArttir = exports['anticheat-system']:changeProtectedElementDataEx(theTeam, "level", birlikSeviye, false)
			local result = mysql:query_free("UPDATE factions SET level='" .. birlikSeviye .. "' WHERE name='" .. birlikIsmi .. "'")
			if not result then
			    --exports["titan_infobox"]:addBox(thePlayer, "Birliğinizin seviyesini arttırırken bir hata meydana geldi.", "error")
			end
			
			if result and birlikLevelArttir then
			    --exports["titan_infobox"]:addBox(thePlayer, "Birliğinizin seviyesi başarıyla arttırılmıştır!", "success")
				setElementData(theTeam, "level", birlikSeviye )
				exports.global:takeMoney(thePlayer, birlikFiyat)
			end
		end
	else
		--exports["titan_infobox"]:addBox(thePlayer, "Yeterli miktarda paranız yok!", "error")
	end
end
addEvent("birlikSeviye", true)
addEventHandler("birlikSeviye", getRootElement(), birlikSeviye)