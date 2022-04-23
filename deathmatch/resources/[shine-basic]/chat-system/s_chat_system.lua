mysql = exports.mysql

MTAoutputChatBox = outputChatBox
function outputChatBox( text, visibleTo, r, g, b, colorCoded )
	if string.len(text) > 128 then -- MTA Chatbox size limit
		MTAoutputChatBox( string.sub(text, 1, 127), visibleTo, r, g, b, colorCoded  )
		outputChatBox( string.sub(text, 128), visibleTo, r, g, b, colorCoded  )
	else
		MTAoutputChatBox( text, visibleTo, r, g, b, colorCoded  )
	end
end

function trunklateText(thePlayer, text, factor)
	if getElementData(thePlayer,"alcohollevel") and getElementData(thePlayer,"alcohollevel") > 0 then
		local level = math.ceil( getElementData(thePlayer,"alcohollevel") * #text / ( factor or 15 ) )
		for i = 1, level do
			x = math.random( 1, #text )
			-- dont replace spaces
			if text.sub( x, x ) == ' ' then
				i = i - 1
			else
				local a, b = text:sub( 1, x - 1 ) or "", text:sub( x + 1 ) or ""
				local c = ""
				if math.random( 1, 6 ) == 1 then
					c = string.char(math.random(65,90))
				else
					c = string.char(math.random(97,122))
				end
				text = a .. c .. b
			end
		end
	end
	return (tostring(text):gsub("^%l", string.upper))
end

function getElementDistance( a, b )
	if not isElement(a) or not isElement(b) or getElementDimension(a) ~= getElementDimension(b) then
		return math.huge
	else
		local x, y, z = getElementPosition( a )
		return getDistanceBetweenPoints3D( x, y, z, getElementPosition( b ) )
	end
end

local gpn = getPlayerName
function getPlayerName(p)
	local name = gpn(p) or getElementData(p, "ped:name")
	return string.gsub(name, "_", " ")
end
--accent --
local accent = {}
local accents = {
	"İstanbul Türkçesi",
	"Trakya Şivesi",
	"Ege Şivesi",
	"Karadeniz Şivesi",
	"Orta Anadolu Şivesi",
	"Güney Doğu Anadolu Şivesi",
	"Erzurum Şivesi",

}
addCommandHandler ("sivesec", 
	function (player, cmd, ac)
		if ac and tonumber (ac) and accents[tonumber (ac)] then 
			local ac = tonumber (ac) 
			accent[player] = ac
			outputChatBox ("[!]#ffffffŞive başarıyla ayarlanmıştır. Şive kullanmayı kapatmak için /sivekapat yazabilirsiniz.", player, 0, 255, 0, true)
		else	
			outputChatBox ("[!]#ffffffŞive tanımlanamadı, yardım için /sivelistesi komutunu giriniz.", player, 0, 255, 0, true)
		end
	end
)	

addCommandHandler ("sivelistesi", 
	function (player)
		outputChatBox ("[!]#ffffffŞive Listesi:", player, 0, 0, 255, true)
		for i, v in ipairs (accents) do 
			outputChatBox ("#FFFFCC"..i.." - "..v, player, 255, 255, 255, true)
		end
	end
)

addCommandHandler ("sivekapat", 
	function (player)
				outputChatBox ("#CC9900[!]#ffffff Şiveyi kapattınız.", player, 0, 255, 0, true)
		accent[player] = nil
	end
)	
-- Main chat: Local IC, Me Actions & Faction IC Radio
function localIC(source, message, language)
	if message == ":)" or message == ":D" or message == ";)" or message == ":(" then
		return;
	end
	if exports['freecam']:isPlayerFreecamEnabled(source) then return end
	local affectedElements = { }
	table.insert(affectedElements, source)
	local x, y, z = getElementPosition(source)
	local playerName = getPlayerName(source)
	local ac = accents[tonumber (accent[source])] and "["..accents[tonumber (accent[source])].."]" or ""
	message = string.gsub(message, "#%x%x%x%x%x%x", "") -- Remove colour codes
	message = trunklateText( source, message )

	local color = {0xEE,0xEE,0xEE}

	local focus = getElementData(source, "focus")
	local focusColor = false
	if type(focus) == "table" then
		for player, color2 in pairs(focus) do
			if player == source then
				color = color2
			end
		end
	end
	local playerVehicle = getPedOccupiedVehicle(source)
	if playerVehicle then
		if (exports['vehicle-system']:isVehicleWindowUp(playerVehicle)) then
			table.insert(affectedElements, playerVehicle)
			outputChatBox( "" .. ac .. "" .. playerName .. " ((Araç ici)) diyor ki: " .. message, source, unpack(color))
		else
			outputChatBox( "" .. ac .. "" .. playerName .. " diyor ki: " .. message, source, unpack(color))
		end
	else
		--exports.global:applyAnimation(source, "GANGS", "prtial_gngtlkA", -1, false, false, false)
		outputChatBox( "" .. ac .. "" .. playerName .. " diyor ki: " .. message, source, unpack(color))
	end

	local dimension = getElementDimension(source)
	local interior = getElementInterior(source)
	local shownto = 1

	if dimension ~= 0 then
		table.insert(affectedElements, "in"..tostring(dimension))
	end




	-- Chat Commands tooltip
	if(getResourceFromName("tooltips-system"))then
		triggerClientEvent(source,"tooltips:showHelp", source,17)
	end

	for key, nearbyPlayer in ipairs(getElementsByType( "player" )) do
		local dist = getElementDistance( source, nearbyPlayer )

		if dist < 20 then
			local nearbyPlayerDimension = getElementDimension(nearbyPlayer)
			local nearbyPlayerInterior = getElementInterior(nearbyPlayer)

			if (nearbyPlayerDimension==dimension) and (nearbyPlayerInterior==interior) then
				local logged = tonumber(getElementData(nearbyPlayer, "loggedin"))
				if not (isPedDead(nearbyPlayer)) and (logged==1) and (nearbyPlayer~=source) then
					local message2 = call(getResourceFromName("language-system"), "applyLanguage", source, nearbyPlayer, message, language)
					message2 = trunklateText( nearbyPlayer, message2 )

					local pveh = getPedOccupiedVehicle(source)
					local nbpveh = getPedOccupiedVehicle(nearbyPlayer)
					local color = {0xEE,0xEE,0xEE}

					local focus = getElementData(nearbyPlayer, "focus")
					local focusColor = false
					if type(focus) == "table" then
						for player, color2 in pairs(focus) do
							if player == source then
								focusColor = true
								color = color2
							end
						end
					end
					if pveh then
						if (exports['vehicle-system']:isVehicleWindowUp(pveh)) then
							for i = 0, getVehicleMaxPassengers(pveh) do
								local lp = getVehicleOccupant(pveh, i)

								if (lp) and (lp~=source) then
									outputChatBox(" [" .. ac .. "] " .. playerName .. " ((Araç içi)) diyor ki: " .. message2, lp, unpack(color))
									table.insert(affectedElements, lp)
								end
							end
							-- Removed so that people outside of the vehicle can't hear whats being said inside
							--[[if (getElementData(nearbyPlayer, "adminduty") == 1) and (getPedOccupiedVehicle(nearbyPlayer) ~= pveh) then
								outputChatBox(" [" .. ac .. "] " .. playerName .. " ((In Car)) says: " .. message2, nearbyPlayer, unpack(color))
							end]]

							table.insert(affectedElements, pveh)
							exports.logs:dbLog(source, 7, affectedElements, ac.." INCAR: ".. message)
							return
						end
					end
					if nbpveh and exports['vehicle-system']:isVehicleWindowUp(nbpveh) == true then
						--[[if not focusColor then
							if dist < 3 then
							elseif dist < 6 then
								color = {0xDD,0xDD,0xDD}
							elseif dist < 9 then
								color = {0xCC,0xCC,0xCC}
							elseif dist < 12 then
								color = {0xBB,0xBB,0xBB}
							else
								color = {0xAA,0xAA,0xAA}
							end
						end
						-- for players in vehicle
						outputChatBox(" [" .. ac .. "] " .. playerName .. " says: " .. message2, nearbyPlayer, unpack(color))]]
						table.insert(affectedElements, nearbyPlayer)
					else
						if not focusColor then
							if dist < 4 then
							elseif dist < 8 then
								color = {0xDD,0xDD,0xDD}
							elseif dist < 12 then
								color = {0xCC,0xCC,0xCC}
							elseif dist < 16 then
								color = {0xBB,0xBB,0xBB}
							else
								color = {0xAA,0xAA,0xAA}
							end
						end
						outputChatBox("" .. ac .. " " .. playerName .. " diyor ki: " .. message2, nearbyPlayer, unpack(color))
						table.insert(affectedElements, nearbyPlayer)
					end

					shownto = shownto + 1
				end
			end
		end
	end
	exports.logs:dbLog(source, 7, affectedElements, ac..": ".. message)
	exports['freecam']:add(shownto, playerName .. " diyor ki: " .. message, source)
end

for i = 1, 3 do
	addCommandHandler( tostring( i ),
		function( thePlayer, commandName, ... )
			local lang = tonumber( getElementData( thePlayer, "languages.lang" .. i ) )
			if lang ~= 0 then
				localIC( thePlayer, table.concat({...}, " "), lang )
			end
		end
	)
end

function meEmote(source, cmd, ...)
	local logged = getElementData(source, "loggedin")
	if not(isPedDead(source) and (logged == 1)) then
		local message = table.concat({...}, " ")
		if not (...) then
			outputChatBox("SYNTAX: /me [EYLEM]", source, 0, 255, 0)
		else
			local result, affectedPlayers = exports.global:sendLocalMeAction(source, message)
			local name = getPlayerName(source) or getElementData(source, "ped:name")
			triggerClientEvent(root,"addChatBubble",source, "*" ..  string.gsub(name, "_", " ").. ( message:sub( 1, 1 ) == "'" and "" or " " ) .. message, cmd)
			exports.logs:dbLog(source, 12, affectedPlayers, message)
		end
	end
end
addCommandHandler("ME", meEmote, false, true)
addCommandHandler("Me", meEmote, false, true)

function outputChatBoxCar( vehicle, target, text1, text2, color )
	if vehicle and exports['vehicle-system']:isVehicleWindowUp( vehicle ) then
		if getPedOccupiedVehicle( target ) == vehicle then
			outputChatBox( text1 .. " ((Arac ici))" .. text2, target, unpack(color))
			return true
		else
			return false
		end
	end
	outputChatBox( text1 .. text2, target, unpack(color))
	return true
end
 


--Encrypted radio's // work in progress - Bean
--[[local radioEncryption = {
-- ( [Faction ID], [Radio Frequency] )
{ 1, "#911" },
{ 1, "#911.76" },
{ 1, "#911.64" }
}]]

function radio(source, radioID, message)
	local affectedElements = { }
	local indirectlyAffectedElements = { }
	table.insert(affectedElements, source)
	radioID = tonumber(radioID) or 1
	local hasRadio, itemKey, itemValue, itemID = exports.global:hasItem(source, 6)
	if hasRadio or getElementType(source) == "ped" or radioID == -2 then
		local theChannel = itemValue
		if radioID < 0 then
			theChannel = radioID
		elseif radioID == 1 and exports.global:isPlayerAdmin(source) and tonumber(message) and tonumber(message) >= 1 and tonumber(message) <= 10 then
			return
		elseif radioID ~= 1 then
			local count = 0
			local items = exports['item-system']:getItems(source)
			for k, v in ipairs(items) do
				if v[1] == 6 then
					count = count + 1
					if count == radioID then
						theChannel = v[2]
						break
					end
				end
			end
		end

		if theChannel == 1 or theChannel == 0 then
			outputChatBox("/tuneradio ile frekansınızı ayarladıktan sonra tekrar deneyiniz.", source, 255, 194, 14)
		elseif theChannel > 1 or radioID < 0 then
			triggerClientEvent (source, "playRadioSound", getRootElement())
			local username = getPlayerName(source)
			local languageslot = getElementData(source, "languages.current")
			local language = getElementData(source, "languages.lang" .. languageslot)
			local ac = call(getResourceFromName("language-system"), "getLanguageName", language)
			local channelName = "#" .. theChannel

			message = trunklateText( source, message )
			local r, g, b = 0, 102, 255
			local focus = getElementData(source, "focus")
			if type(focus) == "table" then
				for player, color in pairs(focus) do
					if player == source then
						r, g, b = unpack(color)
					end
				end
			end

			if radioID == -1 then
				local teams = {
					getTeamFromName("Istanbul Emnıyet Genel Mudurlugu"),
					getTeamFromName("Istanbul Acil Servisleri"),
					getTeamFromName("Istanbul Safak Televizyonu"),
					getTeamFromName("Istanbul Otomotiv"),
					getTeamFromName("Istanbul Buyuksehir Belediyesi"),
					getTeamFromName("Los Santos Hükümeti"),
					getTeamFromName("Los Santos Uluslararası Havalimanı"),
					getTeamFromName("San Andreas Televizyonu"),
					getTeamFromName("İstanbul Zabıta Müdürlüğü"),
				}

				for _, faction in ipairs(teams) do
					if faction and isElement(faction) then
						for key, value in ipairs(getPlayersInTeam(faction)) do
							for _, itemRow in ipairs(exports['item-system']:getItems(value)) do
								if (itemRow[1] == 6 and itemRow[2] > 0) then
									table.insert(affectedElements, value)
									break
								end
							end
						end
					end
				end

				channelName = "DEPARTMENT"
			elseif radioID == -2 then
				local a = {}
				for key, value in ipairs(exports.sfia:getPlayersInAircraft( )) do
					table.insert(affectedElements, value)
					a[value] = true
				end

				for key, value in ipairs( getPlayersInTeam( getTeamFromName( "Los Santos Uluslararası Havalimanı" ) ) ) do
					if not a[value] then
						for _, itemRow in ipairs(exports['item-system']:getItems(value)) do
							if (itemRow[1] == 6 and itemRow[2] > 0) then
								table.insert(affectedElements, value)
								break
							end
						end
					end
				end

				channelName = "AIR"
			else
				for key, value in ipairs(getElementsByType( "player" )) do
					if exports.global:hasItem(value, 6, theChannel) then
						table.insert(affectedElements, value)
					end
				end
			end
			if channelName == "DEPARTMENT" then
			outputChatBoxCar(getPedOccupiedVehicle( source ), source, "[" .. ac .. "] [" .. channelName .. "] " .. username, " diyor ki: " .. message, {r,162,b})
			else
			outputChatBoxCar(getPedOccupiedVehicle( source ), source, "[" .. ac .. "] [" .. channelName .. "] " .. username, " diyor ki: " .. message, {r,g,b})
			end

			-- Encrypted radio's // work in progress - Bean
			--[[for k = #radioEncryption, 1, -1 do
				if (channelName==radioEncryption[k][2]) then
					for i = #affectedElements, 1, -1 do
						local faction = getElementData(affectedElements[i], "faction")
						for _,radioTable in ipairs ( radioEncryption ) do
							if encryptedChannel then
								outputDebugString("really encrypted.")
								if exports.global:hasItem(affectedElements[i], 6, radioTable[2]) and (getElementData(affectedElements[i], "faction" == radioTable[1])) then
									outputDebugString("faction " .. radioTable[1] .. ", value: " .. radioTable[2] .. " playername: " ..getPlayerName(affectedElements[i]))
									return true
								else
									table.remove( affectedElements, i )
									return
								end
							end
						end

						if getElementData(affectedElements[i], "loggedin") ~= 1 then
							table.remove( affectedElements, i )
						end
					end
				else
					for i = #affectedElements, 1, -1 do
						if getElementData(affectedElements[i], "loggedin") ~= 1 then
							table.remove( affectedElements, i )
						end
					end
				end
			end]]

			for i = #affectedElements, 1, -1 do
				if getElementData(affectedElements[i], "loggedin") ~= 1 then
					table.remove( affectedElements, i )
				end
			end

			for key, value in ipairs(affectedElements) do
				if value ~= source then
					triggerClientEvent (value, "playRadioSound", getRootElement())
					local message2 = call(getResourceFromName("language-system"), "applyLanguage", source, value, message, language)
					local r, g, b = 0, 102, 255
					local focus = getElementData(value, "focus")
					if type(focus) == "table" then
						for player, color in pairs(focus) do
							if player == source then
								r, g, b = unpack(color)
							end
						end
					end
					if channelName == "DEPARTMENT" then
					outputChatBoxCar( getPedOccupiedVehicle( value ), value, "[" .. ac .. "] [" .. channelName .. "] " .. username, " says: " .. trunklateText( value, message2 ), {r,162,b} )
					else
					outputChatBoxCar( getPedOccupiedVehicle( value ), value, "[" .. ac .. "] [" .. channelName .. "] " .. username, " says: " .. trunklateText( value, message2 ), {r,g,b} )
					end

					--if not exports.global:hasItem(value, 88) == false then  ***Earpiece Fix***
					if exports.global:hasItem(value, 88) == false then
						-- Show it to people near who can hear his radio
						for k, v in ipairs(exports.global:getNearbyElements(value, "player",7)) do
							local logged2 = getElementData(v, "loggedin")
							if (logged2==1) then
								local found = false
								for kx, vx in ipairs(affectedElements) do
									if v == vx then
										found = true
										break
									end
								end

								if not found then
									local message2 = call(getResourceFromName("language-system"), "applyLanguage", source, v, message, language)
									local text1 = "[" .. ac .. "] " .. getPlayerName(value) .. "'in radyosu"
									local text2 = ": " .. trunklateText( v, message2 )

									if outputChatBoxCar( getPedOccupiedVehicle( value ), v, text1, text2, {255, 255, 255} ) then
										table.insert(indirectlyAffectedElements, v)
									end
								end
							end
						end
					end
				end
			end
			--
			--Show the radio to nearby listening in people near the speaker
			for key, value in ipairs(getElementsByType("player")) do
				if getElementDistance(source, value) < 10 then
					if (value~=source) then
						local message2 = call(getResourceFromName("language-system"), "applyLanguage", source, value, message, language)
						local text1 = "[" .. ac .. "] " .. getPlayerName(source) .. " [RADIO]"
						local text2 = " diyor ki: " .. trunklateText( value, message2 )

						if outputChatBoxCar( getPedOccupiedVehicle( source ), value, text1, text2, {255, 255, 255} ) then
							table.insert(indirectlyAffectedElements, value)
						end
					end
				end
			end

			if #indirectlyAffectedElements > 0 then
				table.insert(affectedElements, "Dolayli Olarak Etkilenen:")
				for k, v in ipairs(indirectlyAffectedElements) do
					table.insert(affectedElements, v)
				end
			end
			exports.logs:dbLog(source, radioID < 0 and 10 or 9, affectedElements, ( radioID < 0 and "" or ( theChannel .. " " ) ) ..ac.." "..message)
		else
			outputChatBox("Radyo kapali. ((/toggleradio))", source, 255, 0, 0)
		end
	else
		outputChatBox("Radyon yok.", source, 255, 0, 0)
	end
end
function chatMain(message, messageType)
	if exports['freecam']:isPlayerFreecamEnabled(source) then cancelEvent() return end

	local logged = getElementData(source, "loggedin")

	if (messageType == 1 or not (isPedDead(source))) and (logged==1) and not (messageType==2) then -- Player cannot chat while dead or not logged in, unless its OOC
		local dimension = getElementDimension(source)
		local interior = getElementInterior(source)
		-- Local IC
		if message == ":)" then
			exports.global:sendLocalMeAction(source, "gülümser.")
		elseif message == ":D" then
			exports.global:sendLocalMeAction(source, "kahkaha atar.")
		elseif message == ";)" then
			exports.global:sendLocalMeAction(source, "göz kırpar.")
		elseif message == ":(" then
			exports.global:sendLocalDoAction(source, "Yüzünde üzgün bir ifade oluştuğu görülebilir.")
		end
		if (messageType==0) then
			local languageslot = getElementData(source, "languages.current")
			local language = getElementData(source, "languages.lang" .. languageslot)

			localIC(source,	message, language)
			triggerClientEvent(root,"addChatBubble",source,message)
		elseif (messageType==1) then -- Local /me action
			meEmote(source, "me", message)
		end
	elseif (messageType==2) and (logged==1) then -- Radio
		radio(source, 1, message)
	end
end
addEventHandler("onPlayerChat", getRootElement(), chatMain)

function msgRadio(thePlayer, commandName, ...)
	if (...) then
		local message = table.concat({...}, " ")
		radio(thePlayer, 1, message)
	else
		outputChatBox("SYNTAX: /" .. commandName .. " [IC Mesaj]", thePlayer, 255, 194, 14)
	end
end
addCommandHandler("r", msgRadio, false, false)
addCommandHandler("radio", msgRadio, false, false)

for i = 1, 20 do
	addCommandHandler( "r" .. tostring( i ),
		function( thePlayer, commandName, ... )
			if i <= exports['item-system']:countItems(thePlayer, 6) then
				if (...) then
					radio( thePlayer, i, table.concat({...}, " ") )
				else
					outputChatBox("SYNTAX: /" .. commandName .. " [IC Mesaj]", thePlayer, 255, 194, 14)
				end
			end
		end
	)
end

function govAnnouncement(thePlayer, commandName, ...)
	local theTeam = getPlayerTeam(thePlayer)

	if (theTeam) then
		local teamID = tonumber(getElementData(theTeam, "id"))

		if (teamID==1 or teamID==2 or teamID==3 or teamID==94 or teamID==87 or teamID==45) then
			local message = table.concat({...}, " ")
			local factionRank = tonumber(getElementData(thePlayer,"factionrank"))

			if (factionRank<8) then
				outputChatBox("Bu komutu kullanma iznin yok.", thePlayer, 255, 0, 0)
			elseif #message == 0 then
				outputChatBox("SYNTAX: " .. commandName .. " [mesaj]", thePlayer, 255, 194, 14)
			else
				local ranks = getElementData(theTeam,"ranks")
				local factionRankTitle = ranks[factionRank]

				--exports.logs:logMessage("[IC: Government Message] " .. factionRankTitle .. " " .. getPlayerName(thePlayer) .. ": " .. message, 6)
				exports.logs:dbLog(source, 16, source, message)
				for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
					local logged = getElementData(value, "loggedin")

					if (logged==1) then
						outputChatBox(" *Hükümet - " .. getPlayerName(thePlayer) .. ": " .. message, value, 160, 164, 104)
					end
				end
			end
		end
	end
end
addCommandHandler("gov", govAnnouncement)

function playerToggleDonatorChat(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	local hasPerk, perkValue = exports.donators:hasPlayerPerk(thePlayer, 9)
	if (logged==1 and hasPerk) then
		local enabled = getElementData(thePlayer, "donatorchat")
		if (tonumber(perkValue)==1) then
			outputChatBox("Donator Chat'i gizledin.", thePlayer, 255, 194, 14)
			exports.donators:updatePerkValue(thePlayer, 9, 0)
		else
			outputChatBox("Donator Chat'i etkin hale getirdin.", thePlayer, 255, 194, 14)
			exports.donators:updatePerkValue(thePlayer, 9, 1)
		end
	end
end
addCommandHandler("toggledonatorchat", playerToggleDonatorChat, false, false)
addCommandHandler("toggledon", playerToggleDonatorChat, false, false)
addCommandHandler("toggledchat", playerToggleDonatorChat, false, false)

function donatorchat(thePlayer, commandName, ...)
	if ( exports.donators:hasPlayerPerk(thePlayer, 10) or exports.global:isPlayerAdmin(thePlayer) ) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Mesaj]", thePlayer, 255, 194, 14)
		else
			local logged = tonumber(getElementData(thePlayer, "loggedin"))
			if (logged ~= 1) then
				return
			end

			local affectedElements = { }
			table.insert(affectedElements, thePlayer)
			local message = table.concat({...}, " ")
			local title = ""
			local hidden = getElementData(thePlayer, "hiddenadmin") or 0

			for key, value in ipairs(getElementsByType("player")) do
				local hasAccess, isEnabled = exports.donators:hasPlayerPerk(value, 10)
				local logged = tonumber(getElementData(value, "loggedin"))
				if (logged == 1) and (hasAccess or exports.global:isPlayerAdmin(value) ) then
					if ( tonumber(isEnabled) ~= 0 ) then
						table.insert(affectedElements, value)
						outputChatBox("[Donator] " .. getPlayerName(thePlayer) .. ": " .. message, value, 160, 164, 104)
					end
				end
			end
			exports.logs:dbLog(thePlayer, 17, affectedElements, message)
		end
	end
end
--addCommandHandler("donator", donatorchat, false, false)
--addCommandHandler("don", donatorchat, false, false)
--addCommandHandler("dchat", donatorchat, false, false)

function departmentradio(thePlayer, commandName, ...)
	local theTeam = getElementType(thePlayer) == "player" and getPlayerTeam(thePlayer)
	local tollped = getElementType(thePlayer) == "ped" and getElementData(thePlayer, "toll:key")
	if (theTeam)  or (tollped) then
		local teamID = nil
		if not tollped then
			teamID = tonumber(getElementData(theTeam, "id"))
		end

		if (teamID==1 or teamID==2 or teamID==3 or teamID==116 or teamID==194 or teamID==50 or teamID==59 or teamID==64 or tollped) then --47=FAA 64=SAPT
			if (...) then
				local message = table.concat({...}, " ")
				radio(thePlayer, -1, message)
			elseif not tollped then
				outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
			end
		end
	end
end
addCommandHandler("dep", departmentradio, false, false)
addCommandHandler("department", departmentradio, false, false)

function airradio(thePlayer, commandName, ...)
	local playersInAir = exports.sfia:getPlayersInAircraft( )
	if playersInAir then
		local found = false
		if getPlayerTeam( thePlayer ) == getTeamFromName( "Los Santos Uluslararası Havalimanı" ) then
			for _, itemRow in ipairs(exports['item-system']:getItems(thePlayer)) do
				if (itemRow[1] == 6 and itemRow[2] > 0) then
					found = true
					break
				end
			end
		end

		if not found then
			for k, v in ipairs( playersInAir ) do
				if v == thePlayer then
					found = true
					break
				end
			end
		end

		if found then
			if not ... then
				outputChatBox("SYNTAX: /" .. commandName .. " [Mesaj]", thePlayer, 255, 194, 14)
			else
				radio(thePlayer, -2, table.concat({...}, " "))
			end
		else
			outputChatBox("Hava frekansinin ustunde konusamazsin(Sinyal Yok).", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("air", airradio, false, false)
addCommandHandler("airradio", airradio, false, false)

function blockChatMessage()
	cancelEvent()
end
addEventHandler("onPlayerChat", getRootElement(), blockChatMessage)
-- End of Main Chat

function globalOOC(thePlayer, commandName, ...)
	local logged = tonumber(getElementData(thePlayer, "loggedin"))

	if (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Mesaj]", thePlayer, 255, 194, 14)
		else
			local oocEnabled = exports.global:getOOCState()
			message = table.concat({...}, " ")
			local muted = getElementData(thePlayer, "muted")
			if (oocEnabled==0) and not (exports.global:isPlayerAdmin(thePlayer)) then --[[and not (exports.global:isPlayerGameMaster(thePlayer))]]
				outputChatBox("OOC Chat is currently disabled.", thePlayer, 255, 0, 0)
			elseif (muted==1) then
				outputChatBox("OOC Chat'ten susturuldun.", thePlayer, 255, 0, 0)
			else
				local affectedElements = { }
				local players = exports.pool:getPoolElementsByType("player")
				local playerName = getPlayerName(thePlayer)
				local playerID = getElementData(thePlayer, "playerid")

				--exports.logs:logMessage("[OOC: Global Chat] " .. playerName .. ": " .. message, 1)
				for k, arrayPlayer in ipairs(players) do
					local logged = tonumber(getElementData(arrayPlayer, "loggedin"))
					local targetOOCEnabled = getElementData(arrayPlayer, "globalooc")

					if (logged==1) and (targetOOCEnabled==1) then
						table.insert(affectedElements, arrayPlayer)
						if exports.global:isPlayerAdmin(thePlayer) then
                            local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
							if getElementData(thePlayer, "hiddenadmin") then
								outputChatBox("(( (" .. playerID .. ") " .. playerName .. ": " .. message .. " ))", arrayPlayer, 196, 255, 255)
							else
								outputChatBox("(( (" .. playerID .. ") [" .. adminTitle .."] " .. playerName .. ": " .. message .. " ))", arrayPlayer, 196, 255, 255)
							end
                        else
							outputChatBox("(( (" .. playerID .. ") " .. playerName .. ": " .. message .. " ))", arrayPlayer, 196, 255, 255)
                        end
					end
				end
				exports.logs:dbLog(thePlayer, 18, affectedElements, message)
			end
		end
	end
end
addCommandHandler("ooc", globalOOC, false, false)
addCommandHandler("GlobalOOC", globalOOC)

function playerToggleOOC(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		local playerOOCEnabled = getElementData(thePlayer, "globalooc")

		if (playerOOCEnabled==1) then
			outputChatBox("Global OOC'yi gizledin.", thePlayer, 255, 194, 14)
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "globalooc", 0, false)
		else
			outputChatBox("Global OOC'yi etkin hale getirdin.", thePlayer, 255, 194, 14)
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "globalooc", 1, false)
		end
		mysql:query_free("UPDATE accounts SET globalooc=" .. mysql:escape_string(getElementData(thePlayer, "globalooc")) .. " WHERE id = " .. mysql:escape_string(getElementData(thePlayer, "account:id")))
	end
end
addCommandHandler("toggleooc", playerToggleOOC, false, false)

local advertisementMessages = { "samp", "SA-MP", "Kye", "shodown", "Vedic", "vedic","ventro","Ventro", "server", "sincityrp", "ls-rp", "sincity", "tri0n3", "www.", ".com", "co.cc", ".net", ".co.uk", "everlast", "neverlast", "www.everlastgaming.com", "trueliferp", "truelife", "root", "rootgaming", "mtarp", "mta:rp", "mta-rp", "rg"}

function isFriendOf(thePlayer, targetPlayer)
	return exports['social-system']:isFriendOf( getElementData( thePlayer, "account:id"), getElementData( targetPlayer, "account:id" ))
end

function scripterChat(thePlayer, commandName, ...)
    local logged = getElementData(thePlayer, "loggedin")

    if(logged==1) and (exports.global:isPlayerScripter(thePlayer))  then
        if not (...) then
            outputChatBox("SYNTAX: /ss [Message]", thePlayer, 255, 194, 14)
        else
            local message = table.concat({...}, " ")
            local players = exports.pool:getPoolElementsByType("player")
            local username = getElementData(thePlayer,"account:username")

            for k, arrayPlayer in ipairs(players) do
                local logged = getElementData(arrayPlayer, "loggedin")

                if(exports.global:isPlayerScripter(arrayPlayer)) and (logged==1) then
                    outputChatBox("Scripter " .. username .. " : " .. message, arrayPlayer, 222, 222, 31)
                end
            end
        end
    end
end
addCommandHandler("ss", scripterChat, false, false)
addCommandHandler("sc", scripterChat, false, false)
addCommandHandler("u", scripterChat, false, false)


ignoreList = {}
function ignoreOnePlayer(thePlayer, commandName, targetPlayerNick)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) then
		if not (targetPlayerNick) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerNick)
			local existed = false
			for k, v in ipairs(ignoreList) do
				if v[2] == targetPlayer then
					table.remove(ignoreList, k)
					outputChatBox("Bu oyuncudan daha fazla pm bloklamıyorsunuz " .. targetPlayerName .. ".", thePlayer, 0, 255, 0)
					existed = true
					break
				end
			end
			if not existed then
				table.insert(ignoreList, {thePlayer, targetPlayer})
				outputChatBox("Bu kisiden PM leri blokluyorsunuz " .. targetPlayerName .. ".", thePlayer, 0, 255, 0)
				outputChatBox("/ignorelist yazarak PM blokladığın oyuncuların listesini görebilirsin.", thePlayer, 0, 255, 0)
			end
		end
	end
end
addCommandHandler("ignore", ignoreOnePlayer)

function checkifiamfucked(thePlayer, commandName)
	outputChatBox(" ~~~~~~~~~ Bloklananlar Listesi ~~~~~~~~~ ", thePlayer, 237, 172, 19)
	outputChatBox("    -- Su anda bloklananlar --", thePlayer, 2, 172, 19)
	for k, v in ipairs(ignoreList) do
		if v[1] == thePlayer then
			outputChatBox(getPlayerName(v[2]):gsub("_"," "), thePlayer, 255, 255, 255)
		end
	end
	outputChatBox(" ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ", thePlayer, 237, 172, 19)
end
addCommandHandler("ignorelist", checkifiamfucked)

function pmPlayer(thePlayer, commandName, who, ...)
	local message = nil
	if tostring(commandName):lower() == "quickreply" then
		if not who then 
			return false
		end
		local temp = nil
		temp = who
		who = getElementData(thePlayer, "targetPMer") or false 
		if not who then
			outputChatBox("No one is PM'ing you.", thePlayer)
			return false
		end
		message = temp.." "..table.concat({...}, " ")
	else
		if not (who) or not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick] [Message]", thePlayer, 255, 194, 14)
			return false
		end
		message = table.concat({...}, " ")
	end
		
	
	
	if who and message then
		
		local loggedIn = getElementData(thePlayer, "loggedin")
		if (loggedIn==0) then
			return
		end
		
		local targetPlayer, targetPlayerName
		if (isElement(who)) then
			if (getElementType(who)=="player") then
				targetPlayer = who
				targetPlayerName = getPlayerName(who)
				message = string.gsub(message, string.gsub(targetPlayerName, " ", "_", 1) .. " ", "", 1)
			end
		else
			targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, who)
			if targetPlayer and thePlayer then
				setElementData(targetPlayer, "targetPMer", getPlayerName(thePlayer):gsub(" ","_"), false)
			end
		end
		
		if (targetPlayer) then
			local logged = getElementData(targetPlayer, "loggedin")
			local pmblocked = getElementData(targetPlayer, "pmblocked")
			local amiblocked = 0
			for k, v in ipairs(ignoreList) do
				if (v[1] == targetPlayer) and (v[2] == thePlayer) then
					amiblocked = 1
				end
			end
			if not (pmblocked) then
				pmblocked = 0
				exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "pmblocked", 0, false)
			end
			
			--if (logged==1) and not getElementData(targetPlayer, "disablePMs") and (pmblocked==0 or exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer) or exports.global:isPlayerScripter(thePlayer) or getElementData(thePlayer, "reportadmin") == targetPlayer or isFriendOf(thePlayer, targetPlayer)) then
			if (logged==1) and not getElementData(targetPlayer, "disablePMs") and (amiblocked==0) and (pmblocked == 0 or getElementData(thePlayer, "gmduty") == 1 or getElementData(thePlayer, "adminduty") == 1 or getElementData(thePlayer, "reportadmin") == targetPlayer) then
			local playerName = getPlayerName(thePlayer):gsub("_", " ")
			local targetUsername = ""
			local username = ""
			--if exports.global:isPlayerGameMaster(thePlayer) or exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerScripter(thePlayer) then
				targetUsername = " ("..tostring(getElementData(targetPlayer, "account:username"))..")"
			--end
			if exports.global:isPlayerGameMaster(targetPlayer) or exports.global:isPlayerAdmin(targetPlayer) or exports.global:isPlayerScripter(targetPlayer) then --or exports.global:isPlayerScripter(thePlayer) then
				username = " ("..tostring(getElementData(thePlayer, "account:username"))..")"
			end
				
				if not exports.global:isPlayerHeadAdmin(thePlayer) and not exports.global:isPlayerHeadAdmin(targetPlayer) then
					-- Check for advertisements
					for k,v in ipairs(advertisementMessages) do
						local found = string.find(string.lower(message), "%s" .. tostring(v))
						local found2 = string.find(string.lower(message), tostring(v) .. "%s")
						if (found) or (found2) or (string.lower(message)==tostring(v)) then
							exports.global:sendMessageToAdmins("AdmWrn: " .. tostring(playerName) .. " sent a possible advertisement PM to " .. tostring(targetPlayerName) .. ".")
							exports.global:sendMessageToAdmins("AdmWrn: Message: " .. tostring(message))
							break
						end
					end
				end
				
				-- Send the message
				local playerid = getElementData(thePlayer, "playerid")
				local targetid = getElementData(targetPlayer, "playerid")
				outputChatBox("#FFDD00[Gelen] (" .. playerid .. ") " .. playerName ..": " .. message, targetPlayer, 0,0,0, true)
				outputChatBox("#FFDD00[Giden] (" .. targetid .. ") " .. targetPlayerName .. ": " .. message, thePlayer,0,0,0,true)
				triggerClientEvent(targetPlayer,"pmSoundFX",targetPlayer)
				triggerClientEvent(thePlayer,"pmSoundFX",thePlayer)
				if getElementData(targetPlayer, "hud:minimized") then
					outputChatBox("#FFDD00[!]#ffffffOyuncu şuanda MTA dışında.", thePlayer, 255, 255, 0, true)
				end
				--exports.logs:logMessage("[PM From " ..playerName .. " TO " .. targetPlayerName .. "]" .. message, 8)
				exports.logs:dbLog(thePlayer, 15, { thePlayer, targetPlayer }, message)
				--outputDebugString("[PM From " ..playerName .. " TO " .. targetPlayerName .. "]" .. message)
				
				--if not exports.global:isPlayerScripter(thePlayer) and not exports.global:isPlayerScripter(targetPlayer) then
					-- big ears
					local received = {}
					received[thePlayer] = true
					received[targetPlayer] = true
					for key, value in pairs( getElementsByType( "player" ) ) do
						if isElement( value ) and not received[value] then
							local listening = getElementData( value, "bigears" )
							if listening == thePlayer or listening == targetPlayer then
								received[value] = true
								outputChatBox("(" .. playerid .. ") " .. playerName .. " -> (" .. targetid .. ") " .. targetPlayerName .. ": " .. message, value, 255, 255, 0)
								triggerClientEvent(value,"pmSoundFX",value)
							end
						end
					end
				--end
			elseif (logged==0) then
				outputChatBox("Bu oyuncuya ozel mesaj yollamak icin oyuna giris yapmasi gerekmektedir.", thePlayer, 255, 255, 0)
			elseif (pmblocked==1) then
				outputChatBox("Oyuncu ozel mesaj kabul etmiyor.", thePlayer, 255, 255, 0)
			elseif (amiblocked==1) then
				outputChatBox("Bu oyuncu ozel mesaj kabul etmiyor.", thePlayer, 255, 255, 0)
			end
		end
	end
end
addCommandHandler("pm", pmPlayer, false, false)
addCommandHandler("quickreply", pmPlayer, false, false)


function localOOC(thePlayer, commandName, ...)
	if exports['freecam']:isPlayerFreecamEnabled(thePlayer) then return end

	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)

	if (logged==1) and not (isPedDead(thePlayer)) then
		local muted = getElementData(thePlayer, "muted")
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Mesaj]", thePlayer, 255, 194, 14)
		elseif (muted==1) then
			outputChatBox("Su anda OOC Chat ten susturuldun.", thePlayer, 255, 0, 0)
		else
			local message = table.concat({...}, " ")
			local adminLevel = tonumber(getElementData(thePlayer, "adminlevel")) or 0
			local gmLevel = tonumber(getElementData(thePlayer, "account:admin")) or 0
			local adminDuty =  tonumber(getElementData(thePlayer, "adminduty")) or 0
			local gmDuty =  tonumber(getElementData(thePlayer, "account:gmduty")) or 0
			local hiddenAdmin = tonumber(getElementData(thePlayer, "hiddenadmin")) or 0
			if exports.global:isPlayerGameMaster(thePlayer) and getElementData(thePlayer, "account:gmduty") then
				local result, affectedElements = exports.global:sendLocalText(thePlayer, "[Helper] " .. getPlayerName(thePlayer) .. ": (( " .. message .. " ))", 70, 200, 30)
			elseif (adminLevel==0) or (hiddenAdmin==1) or (adminDuty==0) then
				local result, affectedElements = exports.global:sendLocalText(thePlayer, getPlayerName(thePlayer) .. ": (( " .. message .. " ))", 196, 255, 255)
			elseif (adminDuty==1) and (adminLevel==1) then
				local result, affectedElements = exports.global:sendLocalText(thePlayer, "[Yetkisiz Admin] " .. getPlayerName(thePlayer) .. ": (( " .. message .. " ))", 32, 178, 170)
			elseif (adminDuty==1) and (adminLevel==2) then
				local result, affectedElements = exports.global:sendLocalText(thePlayer, "[Deneme Admin] " .. getPlayerName(thePlayer) .. ": (( " .. message .. " ))", 	255, 165, 0)
			elseif (adminDuty==1) and (adminLevel==3) then
				local result, affectedElements = exports.global:sendLocalText(thePlayer, "[Stajyer Admin] " .. getPlayerName(thePlayer) .. ": (( " .. message .. " ))", 250, 128, 114)
			elseif (adminDuty==1) and (adminLevel==4) then
				local result, affectedElements = exports.global:sendLocalText(thePlayer, "[Kıdemli Admin] " .. getPlayerName(thePlayer) .. ": (( " .. message .. " ))", 173, 255, 47)
			elseif (adminDuty==1) and (adminLevel==5) then
				local result, affectedElements = exports.global:sendLocalText(thePlayer, "[Baş Admin] " .. getPlayerName(thePlayer) .. ": (( " .. message .. " ))", 32, 178, 170)
			elseif (adminDuty==1) and (adminLevel==6) then
				local result, affectedElements = exports.global:sendLocalText(thePlayer, "[Yönetim Ekibi Üyesi] " .. getPlayerName(thePlayer) .. ": (( " .. message .. " ))", 32, 178, 170)
			elseif (adminDuty==1) and (adminLevel==7) then
				local result, affectedElements = exports.global:sendLocalText(thePlayer, "[Genel Yetkili] " .. getPlayerName(thePlayer) .. ": (( " .. message .. " ))", 32, 178, 170)
			elseif (adminDuty==1) and (adminLevel==8) then
				local result, affectedElements = exports.global:sendLocalText(thePlayer, "[Developer] " .. getPlayerName(thePlayer) .. ": (( " .. message .. " ))", 32, 178, 170)
			elseif (adminDuty==1) and (adminLevel==9) then
				local result, affectedElements = exports.global:sendLocalText(thePlayer, "[Kurucu] " .. getPlayerName(thePlayer) .. ": (( " .. message .. " ))", 35, 120, 170)
			elseif (adminDuty==1) and (adminLevel==10) then
				local result, affectedElements = exports.global:sendLocalText(thePlayer, "Scripter " .. getPlayerName(thePlayer) .. ": (( " .. message .. " ))", 32, 178, 170)
			--exports.logs:logMessage("[OOC: Local Chat] " .. getPlayerName(thePlayer) .. ": " .. table.concat({...}, " "), 1)
			end
		end
	end
end
addCommandHandler("b", localOOC, false, false)
addCommandHandler("LocalOOC", localOOC)

function districtIC(thePlayer, commandName, ...)
	if exports['freecam']:isPlayerFreecamEnabled(thePlayer) then return end

	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)

	if (logged==1) and not (isPedDead(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local affectedElements = { }
			local playerName = getPlayerName(thePlayer)
			local message = table.concat({...}, " ")
			local zonename = exports.global:getElementZoneName(thePlayer)
			local x, y = getElementPosition(thePlayer)

			for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
				local playerzone = exports.global:getElementZoneName(value)
				local playerdimension = getElementDimension(value)
				local playerinterior = getElementInterior(value)

				if (zonename==playerzone) and (dimension==playerdimension) and (interior==playerinterior) and getDistanceBetweenPoints2D(x, y, getElementPosition(value)) < 200 then
					local logged = getElementData(value, "loggedin")
					if (logged==1) then
						table.insert(affectedElements, value)
						if exports.global:isPlayerAdmin(value) then
							outputChatBox("Uzak IC: " .. message .. " ((".. playerName .."))", value, 255, 255, 255)
						else
							outputChatBox("Uzak IC: " .. message, value, 255, 255, 255)
						end
					end
				end
			end
			exports.logs:dbLog(thePlayer, 13, affectedElements, message)
		end
	end
end
addCommandHandler("district", districtIC, false, false)

function localDo(thePlayer, commandName, ...)
	if exports['freecam']:isPlayerFreecamEnabled(thePlayer) then return end

	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)

	if not (isPedDead(thePlayer)) and (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Eylem]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			--exports.logs:logMessage("[IC: Local Do] * " .. message .. " *      ((" .. getPlayerName(thePlayer) .. "))", 19)
			local result, affectedElements = exports.global:sendLocalDoAction(thePlayer, message)
			local name = getPlayerName(thePlayer) or getElementData(thePlayer, "ped:name")
			triggerClientEvent(root,"addChatBubble",thePlayer, " *" .. message .. " *      ((" .. getPlayerName(thePlayer):gsub("_", " ") .. "))", commandName)
			exports.logs:dbLog(thePlayer, 14, affectedElements, message)
		end
	end
end
addCommandHandler("do", localDo, false, false)


function localShout(thePlayer, commandName, ...)
	if exports['freecam']:isPlayerFreecamEnabled(thePlayer) then return end
	local affectedElements = { }
	table.insert(affectedElements, thePlayer)
	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)

	if not (isPedDead(thePlayer)) and (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local playerName = getPlayerName(thePlayer)

			local languageslot = getElementData(thePlayer, "languages.current")
			local language = getElementData(thePlayer, "languages.lang" .. languageslot)
			local ac = accents[tonumber (accent[thePlayer])] and "["..accents[tonumber (accent[thePlayer])].."]" or ""

			local message = trunklateText(thePlayer, table.concat({...}, " "))
			local r, g, b = 255, 255, 255
			local focus = getElementData(thePlayer, "focus")
			if type(focus) == "table" then
				for player, color in pairs(focus) do
					if player == thePlayer then
						r, g, b = unpack(color)
					end
				end
			end
			outputChatBox("" .. ac .. "" .. playerName .. " bağırır: " .. message .. "!", thePlayer, r, g, b)
			triggerClientEvent(root,"addChatBubble",thePlayer," bağırır: " .. message .. "!")
			--exports.logs:logMessage("[IC: Local Shout] " .. playerName .. ": " .. message, 1)
			for index, nearbyPlayer in ipairs(getElementsByType("player")) do
				if getElementDistance( thePlayer, nearbyPlayer ) < 40 then
					local nearbyPlayerDimension = getElementDimension(nearbyPlayer)
					local nearbyPlayerInterior = getElementInterior(nearbyPlayer)

					if (nearbyPlayerDimension==dimension) and (nearbyPlayerInterior==interior) and (nearbyPlayer~=thePlayer) then
						local logged = getElementData(nearbyPlayer, "loggedin")

						if (logged==1) and not (isPedDead(nearbyPlayer)) then
							table.insert(affectedElements, nearbyPlayer)
							local message2 = call(getResourceFromName("language-system"), "applyLanguage", thePlayer, nearbyPlayer, message, language)
							message2 = trunklateText(nearbyPlayer, message2)
							local r, g, b = 255, 255, 255
							local focus = getElementData(nearbyPlayer, "focus")
							if type(focus) == "table" then
								for player, color in pairs(focus) do
									if player == thePlayer then
										r, g, b = unpack(color)
									end
								end
							end
							outputChatBox("" .. ac .. "" .. playerName .. " bağırır: " .. message2 .. "!", nearbyPlayer, r, g, b)
							
						end
					end
				end
			end
			exports.logs:dbLog(thePlayer, 19, affectedElements, ac.." "..message)
		end
	end
end
addCommandHandler("s", localShout, false, false)


function megaphoneShout(thePlayer, commandName, ...)
	if exports['freecam']:isPlayerFreecamEnabled(thePlayer) then return end

	local logged = getElementData(thePlayer, "loggedin")
	local dimension = getElementDimension(thePlayer)
	local interior = getElementInterior(thePlayer)
	local vehicle = getPedOccupiedVehicle(thePlayer)
	local seat = getPedOccupiedVehicleSeat(thePlayer)

	if not (isPedDead(thePlayer)) and (logged==1) then
		local faction = getPlayerTeam(thePlayer)
		local factiontype = getElementData(faction, "type")

		if (factiontype==2) or (factiontype==3) or (factiontype==4) or (exports.global:hasItem(thePlayer, 141)) or ( isElement(vehicle) and exports.global:hasItem(vehicle, 141) and (seat==1 or seat==0)) then
			local affectedElements = { }

			if not (...) then
				outputChatBox("SYNTAX: /" .. commandName .. " [Mesaj]", thePlayer, 255, 194, 14)
			else
				local playerName = getPlayerName(thePlayer)
				local message = trunklateText(thePlayer, table.concat({...}, " "))

				local languageslot = getElementData(thePlayer, "languages.current")
				local language = getElementData(thePlayer, "languages.lang" .. languageslot)
				local langname = call(getResourceFromName("language-system"), "getLanguageName", language)

				for index, nearbyPlayer in ipairs(getElementsByType("player")) do
					if getElementDistance( thePlayer, nearbyPlayer ) < 40 then
						local nearbyPlayerDimension = getElementDimension(nearbyPlayer)
						local nearbyPlayerInterior = getElementInterior(nearbyPlayer)

						if (nearbyPlayerDimension==dimension) and (nearbyPlayerInterior==interior) then
							local logged = getElementData(nearbyPlayer, "loggedin")

							if (logged==1) and not (isPedDead(nearbyPlayer)) then
								local message2 = message
								if nearbyPlayer ~= thePlayer then
									message2 = call(getResourceFromName("language-system"), "applyLanguage", thePlayer, nearbyPlayer, message, language)
								end
								table.insert(affectedElements, nearbyPlayer)
								outputChatBox(" [" .. langname .. "] ((" .. playerName .. ")) Megafon <O: " .. trunklateText(nearbyPlayer, message2), nearbyPlayer, 255, 255, 0)
							end
						end
					end
				end
				exports.logs:dbLog(thePlayer, 20, affectedElements, langname.." "..message)
			end
		else
			outputChatBox("Olmayan megafonla nasil konusacaksin merak ediyorum....", thePlayer, 255, 0 , 0)
		end
	end
end
addCommandHandler("m", megaphoneShout, false, false)

local togState = { }
function toggleFaction(thePlayer, commandName, State)
	local pF = getElementData(thePlayer, "faction")
	local fL = getElementData(thePlayer, "factionleader")
	local theTeam = getPlayerTeam(thePlayer)

	if fL == 1 then
		if togState[pF] == false or not togState[pF] then
			togState[pF] = true
			outputChatBox("Faction chat kapatildi.", thePlayer)
			for index, arrayPlayer in ipairs( getElementsByType( "player" ) ) do
				if isElement( arrayPlayer ) then
					if getPlayerTeam( arrayPlayer ) == theTeam and getElementData(thePlayer, "loggedin") == 1 then
						outputChatBox("OOC Faction Chat kapatildi", arrayPlayer, 255, 0, 0)
					end
				end
			end
		else
			togState[pF] = false
			outputChatBox("Faction chat su anda acildi.", thePlayer)
			for index, arrayPlayer in ipairs( getElementsByType( "player" ) ) do
				if isElement( arrayPlayer ) then
					if getPlayerTeam( arrayPlayer ) == theTeam and getElementData(thePlayer, "loggedin") == 1 then
						outputChatBox("OOC Faction Chat acildi", arrayPlayer, 0, 255, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("togglef", toggleFaction)
addCommandHandler("togf", toggleFaction)

function toggleFactionSelf(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if(logged==1) then
		local factionBlocked = getElementData(thePlayer, "chat-system:blockF")

		if (factionBlocked==1) then
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "chat-system:blockF", 0, false)
			outputChatBox("Faction chat su anda acildi.", thePlayer, 0, 255, 0)
		else
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "chat-system:blockF", 1, false)
			outputChatBox("Faction chat su anda kapandi.", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("togglefactionchat", toggleFactionSelf)
addCommandHandler("togglefaction", toggleFactionSelf)
addCommandHandler("togfaction", toggleFactionSelf)

function factionOOC(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local theTeam = getPlayerTeam(thePlayer)
			local theTeamName = getTeamName(theTeam)
			local playerName = getPlayerName(thePlayer)
			local playerFaction = getElementData(thePlayer, "faction")


			if not(theTeam) or (theTeamName=="Citizen") then
				outputChatBox("Sen herhangi bir faction da degilsin.", thePlayer)
			else
				local affectedElements = { }
				table.insert(affectedElements, theTeam)
				local message = table.concat({...}, " ")

				if (togState[playerFaction]) == true then
					return
				end
				--exports.logs:logMessage("[OOC: " .. theTeamName .. "] " .. playerName .. ": " .. message, 6)

				for index, arrayPlayer in ipairs( getElementsByType( "player" ) ) do
					if isElement( arrayPlayer ) then
						if getElementData( arrayPlayer, "bigearsfaction" ) == theTeam then
							outputChatBox("((" .. theTeamName .. ")) " .. playerName .. ": " .. message, arrayPlayer, 3, 157, 157)
						elseif getPlayerTeam( arrayPlayer ) == theTeam and getElementData(arrayPlayer, "loggedin") == 1 and getElementData(arrayPlayer, "chat-system:blockF") ~= 1 then
							table.insert(affectedElements, arrayPlayer)
							outputChatBox("#fdc044[Birlik] #11c7ff" .. playerName .. ": " .. message, arrayPlayer,0,0,0,true)
						end
					end
				end
				exports.logs:dbLog(thePlayer, 11, affectedElements, message)
			end
		end
	end
end
addCommandHandler("f", factionOOC, false, false)

--HQ CHAT FOR PD / MAXIME
function sfpdHq(thePlayer, commandName, ...)
	local theTeam = getPlayerTeam(thePlayer)
	local factionType = getElementData(theTeam, "type")

	if (factionType == 2) then
		local message = table.concat({...}, " ")
		local factionRank = tonumber(getElementData(thePlayer, "factionrank"))

		if (factionRank<12) then
			outputChatBox("Bu komutu kullanma izniniz yok.", thePlayer, 255, 0, 0)
		elseif #message == 0 then
			outputChatBox("SYNTAX: /hq [message]", thePlayer, 255, 194, 14)
		else

			local teamPlayers = getPlayersInTeam(theTeam)
			local factionRanks = getElementData(theTeam, "ranks")
			local factionRankTitle = factionRanks[factionRank]
			local username = getPlayerName(thePlayer)

				for key, value in ipairs(teamPlayers) do
				triggerClientEvent (value, "playHQSound", getRootElement())
				outputChatBox("HQ: ".. factionRankTitle.." ".. username ..": ".. message .."", value, 0, 197, 205)
			end
		end
	end
end
addCommandHandler("hq", sfpdHq)

function factionLeaderOOC(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Mesaj]", thePlayer, 255, 194, 14)
		else
			local theTeam = getPlayerTeam(thePlayer)
			local theTeamName = getTeamName(theTeam)
			local playerName = getPlayerName(thePlayer)
			local playerLeader = getElementData(thePlayer, "factionleader")


			if not(theTeam) or (theTeamName=="Citizen") then
				outputChatBox("Su anda bir factionda degilsin.", thePlayer, 255, 0, 0)
			elseif tonumber(playerLeader) ~= 1 then
				outputChatBox("Sen faction lideri degilsin.", thePlayer, 255, 0, 0)
			else
				local affectedElements = { }
				table.insert(affectedElements, theTeam)
				local message = table.concat({...}, " ")

				if (togState[playerFaction]) == true then
					return
				end
				--exports.logs:logMessage("[OOC: " .. theTeamName .. "] " .. playerName .. ": " .. message, 6)

				for index, arrayPlayer in ipairs( getElementsByType( "player" ) ) do
					if isElement( arrayPlayer ) then
						if getElementData( arrayPlayer, "bigearsfaction" ) == theTeam then
							outputChatBox("((" .. theTeamName .. " Lider )) " .. playerName .. ": " .. message, arrayPlayer, 3, 157, 157)
						elseif getPlayerTeam( arrayPlayer ) == theTeam and getElementData(arrayPlayer, "loggedin") == 1 and getElementData(arrayPlayer, "chat-system:blockF") ~= 1 and getElementData(arrayPlayer, "factionleader") == 1 then
							table.insert(affectedElements, arrayPlayer)
							outputChatBox("((Faction Lideri)) " .. playerName .. ": " .. message, arrayPlayer, 3, 180, 200)
						end
					end
				end
				exports.logs:dbLog(thePlayer, 11, affectedElements, "Lider: " .. message)
			end
		end
	end
end
addCommandHandler("fl", factionLeaderOOC, false, false)

--[[local goocTogState = false
function togGovOOC(thePlayer, theCommand)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if (goocTogState == false) then
			outputChatBox("Government OOC has now been disabled.", thePlayer, 0, 255, 0)
			goocTogState = true
		elseif (goocTogState == true) then
			outputChatBox("Goverment OOC has been enabled.", thePlayer, 0, 255, 0)
			goocTogState = false
		else
			outputChatBox("[TG-G-C-ERR-545] Please report on mantis.", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("toggovooc", togGovOOC)
addCommandHandler("toggooc", togGovOOC)]]


--[[ MOVED TO resource 'chuevo' / test / ]]--[[
function govooc(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	local team = getPlayerTeam(thePlayer)

	if (getTeamName(team) == "Los Santos Emergency Services") or (getTeamName(team) == "Los Santos Police Department") or (getTeamName(team) == "Government of Los Santos") or (getTeamName(team) == "San Andreas State Police") or (getTeamName(team) == "Bureau of Alcohol, Tobacco and Firearms") and (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /gooc [message]", thePlayer, 255, 194, 14)
		else
			local affectedElements = { }
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)

			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				local team = getPlayerTeam(arrayPlayer)

			if goocTogState == true then
				outputChatBox("This chat is currently disabled.", thePlayer, 255, 0, 0)
				return
			end

				if team then
					if (getTeamName(team) == "Los Santos Emergency Services") or (getTeamName(team) == "Los Santos Police Department") or (getTeamName(team) == "Government of Los Santos") or (getTeamName(team) == "San Andreas State Police") or (getTeamName(team) == "Bureau of Alcohol, Tobacco and Firearms") and (logged==1) then
						table.insert(affectedElements, arrayPlayer)
						outputChatBox("[Government OOC] " .. username .. ": " .. message.."", arrayPlayer, 216, 191, 216)
					end
				end
			end
			exports.logs:dbLog(thePlayer, 11, affectedElements, "GOV OOC: " .. message)
		end
	end
end
addCommandHandler("gooc", govooc)--]]

function setRadioChannel(thePlayer, commandName, slot, channel)
	slot = tonumber( slot )
	channel = tonumber( channel )

	if not channel then
		channel = slot
		slot = 1
	end

	if not (channel) then
		outputChatBox("SYNTAX: /" .. commandName .. " [Radyo Boslugu] [Kanal numarasi]", thePlayer, 255, 194, 14)
	else
		if (exports.global:hasItem(thePlayer, 6)) then
			local count = 0
			local items = exports['item-system']:getItems(thePlayer)
			for k, v in ipairs( items ) do
				if v[1] == 6 then
					count = count + 1
					if count == slot then
						if v[2] > 0 then
							if channel > 1 and channel < 1000000000 then
								if exports['item-system']:updateItemValue(thePlayer, k, channel) then
									outputChatBox("Radyo kanalini tekrardan ayarladin #" .. channel .. ".", thePlayer)
									exports.global:sendLocalMeAction(thePlayer, "radyosunu ayarlar.")
								end
							else
								outputChatBox("Radyonu bu frekansa ayarlayamazsin!", thePlayer, 255, 0, 0)
							end
						else
							outputChatBox("Radyon kapali. ((/toggleradio))", thePlayer, 255, 0, 0)
						end
						return
					end
				end
			end
			outputChatBox("Daha fazla radyo alamazsin.", thePlayer, 255, 0, 0)
		else
			outputChatBox("Radyon yok!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("tuneradio", setRadioChannel, false, false)

function toggleRadio(thePlayer, commandName, slot)
	if (exports.global:hasItem(thePlayer, 6)) then
		local slot = tonumber( slot )
		local items = exports['item-system']:getItems(thePlayer)
		local titemValue = false
		local count = 0
		for k, v in ipairs( items ) do
			if v[1] == 6 then
				if slot then
					count = count + 1
					if count == slot then
						titemValue = v[2]
						break
					end
				else
					titemValue = v[2]
					break
				end
			end
		end

		-- gender switch for /me
		local genderm = getElementData(thePlayer, "gender") == 1 and "her" or "his"

		if titemValue < 0 then
			outputChatBox("Radyonu actin.", thePlayer, 255, 194, 14)
			exports.global:sendLocalMeAction(thePlayer, "turns " .. genderm .. " radio on.")
		else
			outputChatBox("Radyonu kapadin.", thePlayer, 255, 194, 14)
			exports.global:sendLocalMeAction(thePlayer, "radyosunu actin.")
		end

		local count = 0
		for k, v in ipairs( items ) do
			if v[1] == 6 then
				if slot then
					count = count + 1
					if count == slot then
						exports['item-system']:updateItemValue(thePlayer, k, ( titemValue < 0 and 1 or -1 ) * math.abs( v[2] or 1))
						break
					end
				else
					exports['item-system']:updateItemValue(thePlayer, k, ( titemValue < 0 and 1 or -1 ) * math.abs( v[2] or 1))
				end
			end
		end
	else
		outputChatBox("Radyon yok!", thePlayer, 255, 0, 0)
	end
end
addCommandHandler("toggleradio", toggleRadio, false, false)

-- Admin chat
function adminChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")

	if(logged==1) and (exports.global:isPlayerSuspendedAdmin(thePlayer))  then
		if not (...) then
			outputChatBox("SYNTAX: /a [Mesaj]", thePlayer, 255, 194, 14)
		else
			local affectedElements = { }
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
			--exports.logs:logMessage("[Admin Chat] " .. username .. ": " .. message, 3)
			local accountName = " ("..tostring(getElementData(thePlayer, "account:username"))..")" -- Maxime on 4/2/2013
			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				local hidea = getElementData(arrayPlayer, "hidea")
				if(exports.global:isPlayerSuspendedAdmin(arrayPlayer)) and (logged==1) and (not hidea or hidea == "false") then
					table.insert(affectedElements, arrayPlayer)
					outputChatBox("[ADM] "..adminTitle .. " " .. username ..accountName..": " .. message, arrayPlayer,51, 255, 102)

				end
			end
			exports.logs:dbLog(thePlayer, 3, affectedElements, message)
		end
	end
end

addCommandHandler("a", adminChat, false, false)

-- Admin announcement
function adminAnnouncement(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")

	if(logged==1) and (exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer))  then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Mesaj]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)

			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")

				if (logged==1) then
					if exports.global:isPlayerAdmin(thePlayer) then
						outputChatBox("#FF0000[!]#FFFFFF[Admin Duyurusu]: * " .. message .. " *", arrayPlayer, 0, 0, 0, true)
					elseif exports.global:isPlayerGameMaster(thePlayer) then
						outputChatBox("GM Duyurusu: * " .. message .. " *", arrayPlayer, 255, 100, 150)
					end
				end
			end
			exports.global:sendMessageToAdmins("Adm/GMCmd: "..username.." anons yaptı.")
			exports.logs:dbLog(thePlayer, 4, thePlayer, "ANN "..message)
		end
	end
end
addCommandHandler("ann", adminAnnouncement, false, false)

function leadAdminChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")

	if(logged==1) and (exports.global:isPlayerLeadAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Mesaj]", thePlayer, 255, 194, 14)
		else
			local affectedElements = { }
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
			local accountName = " ("..tostring(getElementData(thePlayer, "account:username"))..")" -- Maxime on 4/2/2013
			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")

				if (exports.global:isPlayerLeadAdmin(arrayPlayer)) and (logged==1) then
					table.insert(affectedElements, arrayPlayer)
					outputChatBox("*Lead+* " ..adminTitle .. " " .. username ..accountName.. ": " .. message, arrayPlayer, 204, 102, 255)
				end
			end
			exports.logs:dbLog(thePlayer, 2, affectedElements, message)
		end
	end
end

addCommandHandler("l", leadAdminChat, false, false)

function headAdminChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")

	if(logged==1) and (exports.global:isPlayerHeadAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Mesaj]", thePlayer, 255, 194, 14)
		else
			local affectedElements = { }
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
			local accountName = " ("..tostring(getElementData(thePlayer, "account:username"))..")" -- Maxime on 4/2/2013
			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")

				if(exports.global:isPlayerHeadAdmin(arrayPlayer)) and (logged==1) then
					table.insert(affectedElements, arrayPlayer)
					outputChatBox("*Head+* " ..adminTitle .. " " .. username ..accountName.. ": " .. message, arrayPlayer, 255, 204, 51)
				end
			end
			exports.logs:dbLog(thePlayer, 1, affectedElements, message)
		end
	end
end

addCommandHandler("h", headAdminChat, false, false)

-- Misc
local function sortTable( a, b )
	if b[2] < a[2] then
		return true
	end

	if b[2] == a[2] and b[4] > a[4] then
		return true
	end

	return false
end

-- Admin chat
function gmChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")

	if(logged==1) and (exports.global:isPlayerAdmin(thePlayer)  or exports.global:isPlayerGameMaster(thePlayer))  then
		if not (...) then
			outputChatBox("SYNTAX: /".. commandName .. " [Mesaj]", thePlayer, 255, 194, 14)
		else
			local affectedElements = { }
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			local username = getPlayerName(thePlayer)
			local adminTitle = "Alien"
			if exports.global:isPlayerAdmin(thePlayer) then
				adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
			else
				adminTitle = exports.global:getPlayerGMTitle(thePlayer)
			end
			local accountName = " ("..tostring(getElementData(thePlayer, "account:username"))..")" -- Maxime on 4/2/2013
			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				local hideg = getElementData(arrayPlayer, "hideg")
				if(exports.global:isPlayerAdmin(arrayPlayer) or exports.global:isPlayerGameMaster(arrayPlayer)) and (logged==1) and (not hideg or hideg == "false") then
					table.insert(affectedElements, arrayPlayer)
					outputChatBox("[GM] "..adminTitle .. " " .. username ..accountName.. ": " .. message, arrayPlayer,  255, 100, 150)
				end
			end
			exports.logs:dbLog(thePlayer, 24, affectedElements, message)
		end
	end
end
addCommandHandler("g", gmChat, false, false)

function toggleAdminChat(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	if logged==1 and (exports.global:isPlayerHeadAdmin(thePlayer) or exports.global:isPlayerScripter(thePlayer)) then
		local hidea = getElementData(thePlayer, "hidea")
		if not hidea or hidea == "false" then
			setElementData(thePlayer, "hidea", "true")
			outputChatBox("Admin Chat stopped showing on your screen, /toga again to enable it.",thePlayer, 0,255,0)
		elseif hidea=="true" then
			setElementData(thePlayer, "hidea", "false")
			outputChatBox("Admin Chat started showing on your screen, /toga again to disable it.",thePlayer, 0,255,0)
		end
	end
end
addCommandHandler("toga", toggleAdminChat, false, false)
addCommandHandler("togglea", toggleAdminChat, false, false)

function toggleGMChat(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	if logged==1 and (exports.global:isPlayerHeadAdmin(thePlayer) or exports.global:isPlayerScripter(thePlayer)) then
		local hideg = getElementData(thePlayer, "hideg")
		if not hideg or hideg == "false" then
			setElementData(thePlayer, "hideg", "true")
			outputChatBox("Gamemaster Chat stopped showing on your screen, /togg again to enable it.",thePlayer, 0,255,0)
		elseif hideg=="true" then
			setElementData(thePlayer, "hideg", "false")
			outputChatBox("Gamemaster Chat started showing on your screen, /togg again to disable it.",thePlayer, 0,255,0)
		end
	end
end
addCommandHandler("togg", toggleGMChat, false, false)
addCommandHandler("toggleg", toggleGMChat, false, false)


function toggleOOC(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if(logged==1) and (exports.global:isPlayerAdmin(thePlayer)) then
		local players = exports.pool:getPoolElementsByType("player")
		local oocEnabled = exports.global:getOOCState()
		if (commandName == "togooc") then
			if (oocEnabled==0) then
				exports.global:setOOCState(1)

				for k, arrayPlayer in ipairs(players) do
					local logged = getElementData(arrayPlayer, "loggedin")

					if	(logged==1) then
						outputChatBox("OOC Chat Admin tarafindan acildi.", arrayPlayer, 0, 255, 0)
					end
				end
			elseif (oocEnabled==1) then
				exports.global:setOOCState(0)

				for k, arrayPlayer in ipairs(players) do
					local logged = getElementData(arrayPlayer, "loggedin")

					if	(logged==1) then
						outputChatBox("OOC Chat Admin tarafindan kapatildi.", arrayPlayer, 255, 0, 0)
					end
				end
			end
		elseif (commandName == "stogooc") then
			if (oocEnabled==0) then
				exports.global:setOOCState(1)

				for k, arrayPlayer in ipairs(players) do
					local logged = getElementData(arrayPlayer, "loggedin")
					local admin = getElementData(arrayPlayer, "adminlevel")

					if	(logged==1) and (tonumber(admin)>0)then
						outputChatBox("OOC Chat Admin tarafindan sessizce acildi " .. getPlayerName(thePlayer) .. ".", arrayPlayer, 0, 255, 0)
					end
				end
			elseif (oocEnabled==1) then
				exports.global:setOOCState(0)

				for k, arrayPlayer in ipairs(players) do
					local logged = getElementData(arrayPlayer, "loggedin")
					local admin = getElementData(arrayPlayer, "adminlevel")

					if	(logged==1) and (tonumber(admin)>0)then
						outputChatBox("OOC Chat Admin tarafindan kapandi " .. getPlayerName(thePlayer) .. ".", arrayPlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end

addCommandHandler("togooc", toggleOOC, false, false)
addCommandHandler("stogooc", toggleOOC, false, false)

function togglePM(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then--[[and ((exports.global:isPlayerFullGameMaster(thePlayer)) or(exports.global:isPlayerAdmin(thePlayer)))]]
		local pmenabled = getElementData(thePlayer, "pmblocked")

		if (pmenabled==1) then
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "pmblocked", 0, false)
			outputChatBox("PM ler acildi.", thePlayer, 0, 255, 0)
			exports.donators:updatePerkValue(thePlayer, 2, 0)
		else
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "pmblocked", 1, false)
			outputChatBox("PM ler kapandi.", thePlayer, 255, 0, 0)
			exports.donators:updatePerkValue(thePlayer, 2, 1)
		end
	end
end
addCommandHandler("togpm", togglePM)
addCommandHandler("togglepm", togglePM)

function toggleAds(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if(logged==1) and (exports.donators:hasPlayerPerk(thePlayer, 2))then
		local adblocked = getElementData(thePlayer, "disableAds")
		if (adblocked) then -- enable the ads again
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "disableAds", false, false)
			outputChatBox("Reklamlar acildi.", thePlayer, 0, 255, 0)
			exports.donators:updatePerkValue(thePlayer, 1, 0)
		else -- disable them D:
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "disableAds", true, false)
			outputChatBox("Reklamlar kapatildi.", thePlayer, 255, 0, 0)
			exports.donators:updatePerkValue(thePlayer, 1, 1)
		end
	end
end
addCommandHandler("togad", toggleAds)
addCommandHandler("togglead", toggleAds)

-- /pay
function payPlayer(thePlayer, commandName, targetPlayerNick, amount)
	if exports['freecam']:isPlayerFreecamEnabled(thePlayer) then return end

	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		if not (targetPlayerNick) or not (amount) or not tonumber(amount) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Oyuncu Nick] [Miktar]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerNick)

			if targetPlayer then
				local x, y, z = getElementPosition(thePlayer)
				local tx, ty, tz = getElementPosition(targetPlayer)

				local distance = getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)

				if (distance<=10) then
					amount = math.floor(math.abs(tonumber(amount)))

					local hoursplayed = getElementData(thePlayer, "hoursplayed")

					if (targetPlayer==thePlayer) then
						outputChatBox("Kendine para odeyemezsin.", thePlayer, 255, 0, 0)
					elseif amount == 0 then
						outputChatBox("0 dan daha yuksek bir miktar girmelisin.", thePlayer, 255, 0, 0)
					elseif (hoursplayed<5) and (amount>50) and not exports.global:isPlayerAdmin(thePlayer) and not exports.global:isPlayerAdmin(targetPlayer) and not exports.global:isPlayerFullGameMaster(thePlayer) and not exports.global:isPlayerFullGameMaster(targetPlayer) then
						outputChatBox("50$ in uzerinde para odeyebilmek icin en az 5 oyun saatin olmasi lazim.", thePlayer, 255, 0, 0)
					elseif exports.global:hasMoney(thePlayer, amount) then
						if hoursplayed < 5 and not exports.global:isPlayerAdmin(targetPlayer) and not exports.global:isPlayerAdmin(thePlayer) and not exports.global:isPlayerFullGameMaster(targetPlayer) and not exports.global:isPlayerFullGameMaster(thePlayer) then
							local totalAmount = ( getElementData(thePlayer, "payAmount") or 0 ) + amount
							if totalAmount > 200 then
								outputChatBox( "Her 5 dakikada bir sadece /pay 200 yapabilirsin.Daha yuksek miktarlar icin adminlere basvurun.", thePlayer, 255, 0, 0 )
								return
							end
							exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "payAmount", totalAmount, false)
							setTimer(
								function(thePlayer, amount)
									if isElement(thePlayer) then
										local totalAmount = ( getElementData(thePlayer, "payAmount") or 0 ) - amount
										exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "payAmount", totalAmount <= 0 and false or totalAmount, false)
									end
								end,
								300000, 1, thePlayer, amount
							)
						end
						--exports.logs:logMessage("[Money Transfer From " .. getPlayerName(thePlayer) .. " To: " .. targetPlayerName .. "] Value: " .. amount .. "$", 5)
						exports.logs:dbLog(thePlayer, 25, targetPlayer, "PAY " .. amount)

						if (hoursplayed<5) then
							exports.global:sendMessageToAdmins("AdmWarn: Yeni Oyuncu '" .. getPlayerName(thePlayer) .. "'  $" .. exports.global:formatMoney(amount) .. " transfer etti '" .. targetPlayerName .. "'.")
						end

						-- DEAL!
						exports.global:takeMoney(thePlayer, amount)
						exports.global:giveMoney(targetPlayer, amount)

						local gender = getElementData(thePlayer, "gender")
						local genderm = "his"
						if (gender == 1) then
							genderm = "her"
						end

						exports.global:sendLocalMeAction(thePlayer, "cuzdanindan birkac banknot alarak " .. genderm .. " karsisindaki kisiye verir " .. targetPlayerName .. ".")
						outputChatBox("Sen" .. exports.global:formatMoney(amount) .. " $ " .. targetPlayerName .. "'a odeme yaptin", thePlayer)
						outputChatBox(getPlayerName(thePlayer) .. " gave you $" .. exports.global:formatMoney(amount) .. ".", targetPlayer)

						exports.global:applyAnimation(thePlayer, "DEALER", "shop_pay", 4000, false, true, true)
					else
						outputChatBox("Yeterli paran yok.", thePlayer, 255, 0, 0)
					end
				else
					outputChatBox("Sen " .. targetPlayerName .. " dan uzaktasin", thePlayer, 255, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("paraver", payPlayer, false, false)

function removeAnimation(thePlayer)
	exports.global:removeAnimation(thePlayer)
end

-- /w(hisper)
function localWhisper(thePlayer, commandName, targetPlayerNick, ...)
	if exports['freecam']:isPlayerFreecamEnabled(thePlayer) then return end

	local logged = tonumber(getElementData(thePlayer, "loggedin"))

	if (logged==1) then
		if not (targetPlayerNick) or not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Message]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerNick)

			if targetPlayer then
				local x, y, z = getElementPosition(thePlayer)
				local tx, ty, tz = getElementPosition(targetPlayer)

				if (getDistanceBetweenPoints3D(x, y, z, tx, ty, tz)<3) then
					local name = getPlayerName(thePlayer)
					local message = table.concat({...}, " ")
					--exports.logs:logMessage("[IC: Whisper] " .. name .. " to " .. targetPlayerName .. ": " .. message, 1)
					exports.logs:dbLog(thePlayer, 21, targetPlayer, message)
					message = trunklateText( thePlayer, message )

					local languageslot = getElementData(thePlayer, "languages.current")
					local language = getElementData(thePlayer, "languages.lang" .. languageslot)
					local ac = call(getResourceFromName("language-system"), "getLanguageName", language)

					message2 = trunklateText( targetPlayer, message2 )
					local message2 = call(getResourceFromName("language-system"), "applyLanguage", thePlayer, targetPlayer, message, language)

					exports.global:sendLocalMeAction(thePlayer, "whispers to " .. targetPlayerName .. ".")
					local r, g, b = 255, 255, 255
					local focus = getElementData(thePlayer, "focus")
					if type(focus) == "table" then
						for player, color in pairs(focus) do
							if player == thePlayer then
								r, g, b = unpack(color)
							end
						end
					end
					outputChatBox("[" .. ac .. "] " .. name .. " fisildar: " .. message, thePlayer, r, g, b)
					local r, g, b = 255, 255, 255
					local focus = getElementData(targetPlayer, "focus")
					if type(focus) == "table" then
						for player, color in pairs(focus) do
							if player == thePlayer then
								r, g, b = unpack(color)
							end
						end
					end
					outputChatBox("[" .. ac .. "] " .. name .. " fisildar: " .. message2, targetPlayer, r, g, b)
					for i,p in ipairs(getElementsByType( "player" )) do
						--if (getElementData(p, "adminduty") == 1) then
							if p ~= targetPlayer and p ~= thePlayer then
								local ax, ay, az = getElementPosition(p)
								if (getDistanceBetweenPoints3D(x, y, z, ax, ay, az)<4) then
									outputChatBox("[" .. ac .. "] " .. name .. " fisildar: " .. getPlayerName(targetPlayer):gsub("_"," ") .. ": " .. message, p, 255, 255, 255)
								end
							end
						--end
					end
				else
					outputChatBox("Sen " .. targetPlayerName .. " dan uzaktasin", thePlayer, 255, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("w", localWhisper, false, false)

-- /c(lose)
function localClose(thePlayer, commandName, ...)
	if exports['freecam']:isPlayerFreecamEnabled(thePlayer) then return end

	local logged = tonumber(getElementData(thePlayer, "loggedin"))

	if (logged==1) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local affectedElements = { }
			local name = getPlayerName(thePlayer)
			local message = table.concat({...}, " ")
			--exports.logs:logMessage("[IC: Whisper] " .. name .. ": " .. message, 1)
			message = trunklateText( thePlayer, message )

			local languageslot = getElementData(thePlayer, "languages.current")
			local language = getElementData(thePlayer, "languages.lang" .. languageslot)
			local ac = call(getResourceFromName("language-system"), "getLanguageName", language)
			local playerCar = getPedOccupiedVehicle(thePlayer)
			for index, targetPlayers in ipairs( getElementsByType( "player" ) ) do
				if getElementDistance( thePlayer, targetPlayers ) < 5 then
					local message2 = message
					if targetPlayers ~= thePlayer then
						message2 = call(getResourceFromName("language-system"), "applyLanguage", thePlayer, targetPlayers, message, language)
						message2 = trunklateText( targetPlayers, message2 )
					end
					local r, g, b = 255, 255, 255
					local focus = getElementData(targetPlayers, "focus")
					if type(focus) == "table" then
						for player, color in pairs(focus) do
							if player == thePlayer then
								r, g, b = unpack(color)
							end
						end
					end
					local pveh = getPedOccupiedVehicle(targetPlayers)
					if playerCar then
						if not exports['vehicle-system']:isVehicleWindowUp(playerCar) then
							if pveh then
								if playerCar == pveh then
									table.insert(affectedElements, targetPlayers)
									outputChatBox( " [" .. ac .. "] " .. name .. " fisildar: " .. message2, targetPlayers, r, g, b)
								elseif not (exports['vehicle-system']:isVehicleWindowUp(pveh)) then
									table.insert(affectedElements, targetPlayers)
									outputChatBox( " [" .. ac .. "] " .. name .. " fisildar: " .. message2, targetPlayers, r, g, b)
								end
							else
								table.insert(affectedElements, targetPlayers)
								outputChatBox( " [" .. ac .. "] " .. name .. " whispers: " .. message2, targetPlayers, r, g, b)
							end
						else
							if pveh then
								if pveh == playerCar then
									table.insert(affectedElements, targetPlayers)
									outputChatBox( " [" .. ac .. "] " .. name .. " fisildar: " .. message2, targetPlayers, r, g, b)
								end
							end
						end
					else
						if pveh then
							if playerCar then
								if playerCar == pveh then
									table.insert(affectedElements, targetPlayers)
									outputChatBox( " [" .. ac .. "] " .. name .. " fisildar: " .. message2, targetPlayers, r, g, b)
								end
							elseif not (exports['vehicle-system']:isVehicleWindowUp(pveh)) then
								table.insert(affectedElements, targetPlayers)
								outputChatBox( " [" .. ac .. "] " .. name .. " fisildar: " .. message2, targetPlayers, r, g, b)
							end
						else
							table.insert(affectedElements, targetPlayers)
							outputChatBox( " [" .. ac .. "] " .. name .. " fisildar: " .. message2, targetPlayers, r, g, b)
						end
					end
				end
			end
			exports.logs:dbLog(thePlayer, 22, affectedElements, ac .. " "..message)
		end
	end
end
addCommandHandler("c", localClose, false, false)

------------------
-- News Faction --
------------------
-- /tognews
function togNews(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")

	if (logged==1) then
		local newsTog = getElementData(thePlayer, "tognews")

		if (newsTog~=1) then
			outputChatBox("/news disabled.", thePlayer, 255, 194, 14)
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "tognews", 1, false)
			exports.donators:updatePerkValue(thePlayer, 3, 1)
		else
			outputChatBox("/news enabled.", thePlayer, 255, 194, 14)
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "tognews", 0, false)
			exports.donators:updatePerkValue(thePlayer, 3, 0)
		end
	end
end
addCommandHandler("tognews", togNews, false, false)
addCommandHandler("togglenews", togNews, false, false)


-- /startinterview
function StartInterview(thePlayer, commandName, targetPartialPlayer)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) then
		local theTeam = getPlayerTeam(thePlayer)
		local factionType = getElementData(theTeam, "type")
		if(factionType==6)then -- news faction
			if not (targetPartialPlayer) then
				outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick]", thePlayer, 255, 194, 14)
			else
				local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPartialPlayer)
				if targetPlayer then
					local targetLogged = getElementData(targetPlayer, "loggedin")
					if (targetLogged==1) then
						if(getElementData(targetPlayer,"interview"))then
							outputChatBox("Bu oyuncu zaten roportaja davet edildi.", thePlayer, 255, 0, 0)
						else
							exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "interview", true, false)
							local playerName = getPlayerName(thePlayer)
							outputChatBox(playerName .." seninle roportaj yapmayi onerdi.", targetPlayer, 0, 255, 0)
							outputChatBox("(Roportaj sirasinde /i yaparak konusabilirsiniz.)", targetPlayer, 0, 255, 0)
							local NewsFaction = getPlayersInTeam(getPlayerTeam(thePlayer))
							for key, value in ipairs(NewsFaction) do
								outputChatBox("((".. playerName .."  " .. targetPlayerName .. " adli kisiyi roportaja davet etti.))", value, 0, 255, 0)
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler("interview", StartInterview, false, false)

-- /endinterview
function endInterview(thePlayer, commandName, targetPartialPlayer)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) then
		local theTeam = getPlayerTeam(thePlayer)
		local factionType = getElementData(theTeam, "type")
		if(factionType==6)then -- news faction
			if not (targetPartialPlayer) then
				outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick]", thePlayer, 255, 194, 14)
			else
				local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPartialPlayer)
				if targetPlayer then
					local targetLogged = getElementData(targetPlayer, "loggedin")
					if (targetLogged==1) then
						if not(getElementData(targetPlayer,"interview"))then
							outputChatBox("Bu oyuncu roportaj icin davet edilmedi.", thePlayer, 255, 0, 0)
						else
							exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "interview", false, false)
							local playerName = getPlayerName(thePlayer)
							outputChatBox(playerName .." roportajini sonlandirdi.", targetPlayer, 255, 0, 0)

							local NewsFaction = getPlayersInTeam(getPlayerTeam(thePlayer))
							for key, value in ipairs(NewsFaction) do
								outputChatBox("((".. playerName .."  " .. targetPlayerName .. "'in roportajini bitirdi.))", value, 255, 0, 0)
							end
						end
					end
				end
			end
		end
	end
end
addCommandHandler("endinterview", endInterview, false, false)

-- /i
function interviewChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) then
		if(getElementData(thePlayer, "interview"))then
			if not(...)then
				outputChatBox("SYNTAX: /" .. commandName .. "[Mesaj]", thePlayer, 255, 194, 14)
			else
				local message = table.concat({...}, " ")
				local name = getPlayerName(thePlayer)

				local finalmessage = "[HABERLER] Roportaj konugu " .. name .." diyor ki: ".. message
				local theTeam = getPlayerTeam(thePlayer)
				local factionType = getElementData(theTeam, "type")
				if(factionType==6)then -- news faction
					finalmessage = "[HABERLER] " .. name .." diyor ki: ".. message
				end

				for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
					if (getElementData(value, "loggedin")==1) then
						if not (getElementData(value, "tognews")==1) then
							outputChatBox(finalmessage, value, 200, 100, 200)
						end
					end
				end
				exports.logs:dbLog(thePlayer, 23, thePlayer, "NEWS " .. message)
				exports.global:giveMoney(getTeamFromName"San Andreas Televizyonu", 200)
			end
		end
	end
end
addCommandHandler("i", interviewChat, false, false)

-- /charity
function charityCash(thePlayer, commandName, amount)
	if not (amount) then
		outputChatBox("SYNTAX: /" .. commandName .. " Miktar]", thePlayer, 255, 194, 14)
	else
		local donation = tonumber(amount)
		if (donation<=0) then
			outputChatBox("0 dan daha yuksek bir miktar girmelisin.", thePlayer, 255, 0, 0)
		else
			if not exports.global:takeMoney(thePlayer, donation) then
				outputChatBox("Yeterli paran yok.", thePlayer, 255, 0, 0)
			else
				outputChatBox("Hayir kurumuna ".. exports.global:formatMoney(donation) .." $ bagisladin.", thePlayer, 0, 255, 0)
				exports.global:sendMessageToAdmins("AdmWrn: " ..getPlayerName(thePlayer).. " charity'd $" ..exports.global:formatMoney(donation))
				exports.logs:dbLog(thePlayer, 25, thePlayer, "CHARITY $" .. amount)
			end
		end
	end
end
addCommandHandler("charity", charityCash, false, false)

-- /bigears
function bigEars(thePlayer, commandName, targetPlayerNick)
	if exports.global:isPlayerLeadAdmin(thePlayer) then
		local current = getElementData(thePlayer, "bigears")
		if not current and not targetPlayerNick then
			outputChatBox("SYNTAX: /" .. commandName .. " [player]", thePlayer, 255, 194, 14)
		elseif current and not targetPlayerNick then
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "bigears", false, false)
			outputChatBox("Big Ears turned off.", thePlayer, 255, 0, 0)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayerNick)

			if targetPlayer then
				outputChatBox("Now Listening to " .. targetPlayerName .. ".", thePlayer, 0, 255, 0)
				exports.logs:dbLog(thePlayer, 4, targetPlayer, "BIGEARS "..targetPlayerName)
				exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "bigears", targetPlayer, false)
			end
		end
	end
end
addCommandHandler("bigears", bigEars)

function removeBigEars()
	for key, value in pairs( getElementsByType( "player" ) ) do
		if isElement( value ) and getElementData( value, "bigears" ) == source then
			exports['anticheat-system']:changeProtectedElementDataEx( value, "bigears", false, false )
			outputChatBox("Big Ears turned off (Player Left).", value, 255, 0, 0)
		end
	end
end
addEventHandler( "onPlayerQuit", getRootElement(), removeBigEars)

function bigEarsFaction(thePlayer, commandName, factionID)
	if exports.global:isPlayerLeadAdmin(thePlayer) or exports.global:isPlayerFRT(thePlayer) then
		factionID = tonumber( factionID )
		local current = getElementData(thePlayer, "bigearsfaction")
		if not current and not factionID then
			outputChatBox("SYNTAX: /" .. commandName .. " [faction id]", thePlayer, 255, 194, 14)
		elseif current and not factionID then
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "bigearsfaction", false, false)
			outputChatBox("Big Ears turned off.", thePlayer, 255, 0, 0)
		else
			local team = exports.pool:getElement("team", factionID)
			if not team then
				outputChatBox("No faction with that ID found.", thePlayer, 255, 0, 0)
			else
				outputChatBox("Now Listening to " .. getTeamName(team) .. " OOC Chat.", thePlayer, 0, 255, 0)
				exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "bigearsfaction", team, false)
				exports.logs:dbLog(thePlayer, 4, team, "BIGEARSF "..getTeamName(team))
			end
		end
	end
end
addCommandHandler("bigearsf", bigEarsFaction)

function disableMsg(message, player)
	cancelEvent()

	-- send it using our own PM etiquette instead
	pmPlayer(source, "pm", player, message)
end
addEventHandler("onPlayerPrivateMessage", getRootElement(), disableMsg)

-- /focus
function focus(thePlayer, commandName, targetPlayer, r, g, b)
	local focus = getElementData(thePlayer, "focus")
	if targetPlayer then
		local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
		if targetPlayer then
			if type(focus) ~= "table" then
				focus = {}
			end

			if focus[targetPlayer] and not r then
				outputChatBox( "You stopped highlighting " .. string.format("#%02x%02x%02x", unpack( focus[targetPlayer] ) ) .. targetPlayerName .. "#ffc20e.", thePlayer, 255, 194, 14, true )
				focus[targetPlayer] = nil
			else
				color = {tonumber(r) or math.random(63,255), tonumber(g) or math.random(63,255), tonumber(b) or math.random(63,255)}
				for _, v in ipairs(color) do
					if v < 0 or v > 255 then
						outputChatBox("Invalid Color: " .. v, thePlayer, 255, 0, 0)
						return
					end
				end

				focus[targetPlayer] = color
				outputChatBox( "You are now highlighting on " .. string.format("#%02x%02x%02x", unpack( focus[targetPlayer] ) ) .. targetPlayerName .. "#00ff00.", thePlayer, 0, 255, 0, true )
			end
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "focus", focus, false)
		end
	else
		if type(focus) == "table" then
			outputChatBox( "You are watching: ", thePlayer, 255, 194, 14 )
			for player, color in pairs( focus ) do
				outputChatBox( "  " .. getPlayerName( player ):gsub("_", " "), thePlayer, unpack( color ) )
			end
		end
		outputChatBox( "To add someone, /" .. commandName .. " [player] [optional red/green/blue], to remove just /" .. commandName .. " [player] again.", thePlayer, 255, 194, 14)
	end
end
addCommandHandler("focus", focus)
addCommandHandler("highlight", focus)

addEventHandler("onPlayerQuit", root,
	function( )
		for k, v in ipairs( getElementsByType( "player" ) ) do
			if v ~= source then
				local focus = getElementData( v, "focus" )
				if focus and focus[source] then
					focus[source] = nil
					exports['anticheat-system']:changeProtectedElementDataEx(v, "focus", focus, false)
				end
			end
		end
	end
)