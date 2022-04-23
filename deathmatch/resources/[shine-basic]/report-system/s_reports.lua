mysql = exports.mysql

reports = { }

local getPlayerName_ = getPlayerName
getPlayerName = function( ... )
	if isElement( ... ) then
		if getPlayerName_( ... ) then 
			s = getPlayerName_( ... )
			return s and s:gsub( "_", " " ) or s
		end
	else
		outputDebugString("Bu isimde kullanici adi bulunamadi.", 2)
	end
end

--MAXIME TWEAKS
MTAoutputChatBox = outputChatBox
local function outputChatBox( text, visibleTo, r, g, b, colorCoded )
	--outputDebugString(tostring(getElementData(visibleTo, "report-system:isAdminPanelEnabled") ))
	if getElementData(visibleTo, "report-system:isAdminPanelEnabled") then
		showToAdminPanel(text, visibleTo, r,g,b)
	else
		if string.len(text) > 128 then -- MTA Chatbox size limit
			MTAoutputChatBox( string.sub(text, 1, 127), visibleTo, r, g, b, colorCoded  )
			outputChatBox( string.sub(text, 128), visibleTo, r, g, b, colorCoded  )
		else
			MTAoutputChatBox( text, visibleTo, r, g, b, colorCoded  )
		end
	end
end

local function outputChatBoxFuckMaxime( text, visibleTo, r, g, b, colorCoded )
 if string.len(text) > 128 then
  MTAoutputChatBox( string.sub(text, 1, 127), visibleTo, r, g, b, colorCoded )
  outputChatBoxFuckMaxime( string.sub(text, 128), visibleTo, r, g, b, colorCoded )
 else
  MTAoutputChatBox( text, visibleTo, r, g, b, colorCoded )
 end
end

function resourceStart(res)
	for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
		exports['anticheat-system']:changeProtectedElementDataEx(value, "adminreport", false, true)
		exports['anticheat-system']:changeProtectedElementDataEx(value, "gmreport", false, true)
		exports['anticheat-system']:changeProtectedElementDataEx(value, "reportadmin", false, false)
	end	
end
addEventHandler("onResourceStart", getResourceRootElement(), resourceStart)

function getAdminCount()
	local online, duty, lead, leadduty, gm, gmduty = 0, 0, 0, 0,0,0
	for key, value in ipairs(getElementsByType("player")) do
		if (isElement(value)) then
			local level = getElementData( value, "adminlevel" ) or 0
			if level >= 1 and level <= 6 then
				online = online + 1
				
				local aod = getElementData( value, "adminduty" ) or 0
				if aod == 1 then
					duty = duty + 1
				end
				
				if level >= 5 then
					lead = lead + 1
					if aod == 1 then
						leadduty = leadduty + 1
					end
				end
			end
			
			local level = getElementData( value, "account:gmlevel" ) or 0
			if level >= 1 and level <= 6 then
				gm = gm + 1
				
				local aod = getElementData( value, "account:gmduty" )
				if aod == true then
					gmduty = gmduty + 1
				end
			end
		end
	end
	return online, duty, lead, leadduty, gm, gmduty
end

--[[function spamAdminsWithBullshit()
	local adminFucker = {
		"Server Owner (Hidden) Matthew McReary (Chuevo)",
		"Server Owner (Hidden) Tyrone Lawrence (tamfire)",
		"Admin Jason Roberts (forrest)",
		"Admin Dexter Moran (Jevi)"
	}
	local messages = { 
		"Get the fuck off duty if you're not going to do shit.", 
		"Start taking reports, you useless peasants!", 
		"Guys.. Are you going to do your jobs or not?", 
		"Reports guys, do your job..",
		"Sometimes, I ask myself: Are you guys in this team just for your administrative rights?",
		"I wonder who is going to be removed next update, for letting reports stack up..",
		"Get the fuck off duty if you aren't doing shit.",
		"More admins on duty who contributes, pls.",
		"Reports.",
		"I hate you all." }
	local affectedFuckers = {}
	local players = exports.pool:getPoolElementsByType("player")
	if (tonumber(#unanswered) >= 5) then
		for k, v in ipairs(players) do
			local logged = getElementData(v, "loggedin")
			local hidea = getElementData(v, "hidea")
			if (exports.global:isPlayerSuspendedAdmin(v)) and (logged == 1) and (not hidea or hidea == "false") then
				table.insert(affectedFuckers, v)
				outputChatBoxFuckMaxime("[ADM] " .. adminFucker[math.random(1,#adminFucker)] .. ": " ..messages[math.random(1,#messages)], v, 51, 255, 102)
			end
		end
	end
end
addCommandHandler("spamadmins1", spamAdminsWithBullshit)
setTimer(spamAdminsWithBullshit, 500000, 0)]]

function updateReportCount()
	local open = 0
	local handled = 0
	
	unanswered = {}
	local byadmin = {}
	
	for key, value in pairs(reports) do
		if not value[7] then
			open = open + 1
			if value[5] then
				handled = handled + 1
				if not byadmin[value[5]] then
					byadmin[value[5]] = { key }
				else
					table.insert(byadmin[value[5]], key)
				end
			else
				table.insert(unanswered, tostring(key)) 
			end
		else
			if not value[5] then
				table.insert(unanswered, "GM"..tostring(key)) 
			end
		end
	end
	
	local gmopen = 0
	local gmhandled = 0
	local gmunanswered = {}
	
	for key, value in pairs(reports) do
		if value[7] then
			gmopen = gmopen + 1
			if value[5] then
				gmhandled = gmhandled + 1
				if not byadmin[value[5]] then
					byadmin[value[5]] = { key }
				else
					table.insert(byadmin[value[5]], key)
				end
			else
				table.insert(gmunanswered, tostring(key)) 
			end
		end
	end
	
	-- admstr
	local online, duty, lead, leadduty, gm, gmduty = getAdminCount()
	local admstr = ":: "..gmduty.."/"..gm.." GMs :: " .. duty .."/".. online .." admins :: "..leadduty.."/"..lead.." leads"
	local gmstr = ":: "..gmduty.."/"..gm.." GMs"
	
	for key, value in ipairs(exports.global:getAdmins()) do
		triggerClientEvent( value, "updateReportsCount", value, open, handled, unanswered, byadmin[value], admstr )
	end
	
	for key, value in ipairs(exports.global:getGameMasters()) do
		triggerClientEvent( value, "updateReportsCount", value, gmopen, gmhandled, gmunanswered, byadmin[value], gmstr )
	end
end

addEventHandler( "onElementDataChange", getRootElement(), 
	function(n)
		if getElementType(source) == "player" and ( n == "adminlevel" or n == "adminduty" or  n == "account:gmlevel" or n == "account:gmduty" ) then
			--sortReports(false)
			updateReportCount()
		end
	end
)
--[[
function maximeReportsReminder()
	for key, value in ipairs(getElementsByType("player")) do
		local level = getElementData( value, "adminlevel" ) or 0
		local aod = getElementData( value, "adminduty" ) or 0
		local god = getElementData( value, "account:gmduty" ) or 0
		if (exports.global:isPlayerGameMaster(value) and god == 1) then
			showUnansweredReportsGMs(value)
		end
		if (exports.global:isPlayerAdmin(value) and aod == 1) then
			showUnansweredReportsAdmins(value)
		end
	end
end]]
--setTimer(maximeReportsReminder, 5*60*1000 , 0) -- every 5 mins.

function sortReports(showMessage) --MAXIME
	-- reports[slot] = { }
	-- reports[slot][1] = source -- Reporter
	-- reports[slot][2] = reportedPlayer -- Reported Player
	-- reports[slot][3] = reportedReason -- Reported Reason
	-- reports[slot][4] = timestring -- Time reported at
	-- reports[slot][5] = nil -- Admin dealing with the report
	-- reports[slot][6] = alertTimer -- Alert timer of the report
	-- reports[slot][7] = isGMreport -- Type report
	-- reports[slot][8] = slot -- Report ID/Slot, used in rolling queue function / Maxime
	local sortedReports = {}
	local adminNotice = ""
	local gmNotice = ""
	local unsortedReports = reports
	
	for key , report in pairs(reports) do  
		table.insert(sortedReports, report)
	end
	
	reports = sortedReports
	
	for key , report in pairs(reports) do 
		if report[8] ~= key then
			if report[7] then --GM report
				adminNotice = adminNotice.."#"..report[8]..", "
				if showMessage then
					outputChatBox("Senin Reportunun ID#"..report[8].." Dusen Rapor ID#"..key.." On Raporlar nedeniyle cozuldu.", report[1], 70, 200, 30)
				end
			else -- Admin report
				adminNotice = adminNotice.."#"..report[8]..", "
				gmNotice = gmNotice.."#"..report[8]..", "
				if showMessage then 
					outputChatBox("Senin Reportunun ID#"..report[8].." Dusen Rapor ID#"..key.." On Raporlar nedeniyle cozuldu.", report[1], 255, 195, 15) 
				end
			end
			report[8] = key
		end
	end
	
	if showMessage then
	
		if adminNotice ~= "" then
			adminNotice = string.sub(adminNotice, 1, (string.len(adminNotice) - 2))
			local admins = exports.global:getAdmins()
			for key, value in ipairs(admins) do
				local adminduty = getElementData(value, "adminduty")
				if (adminduty==1) then
					outputChatBox(" Report ID'si "..adminNotice.." rapor zamandan dustu.", value, 255, 195, 15) 
				end
			end
		end
		if gmNotice ~= "" then
			gmNotice = string.sub(gmNotice, 1, (string.len(gmNotice) - 2))
			local gms = exports.global:getGameMasters()
			for key, value in ipairs(gms) do
				local gmDuty = getElementData(value, "account:gmduty")
				if (gmDuty) then
					outputChatBox(" Reports ID'si "..gmNotice.." dustu.", value, 70, 200, 30)
				end
			end
		end
		
	end

end

function showCKList(thePlayer)
	if exports.global:isPlayerSuspendedAdmin(thePlayer) then
		outputChatBox("~~~~~~~~~ CK Istekleri ~~~~~~~~~", thePlayer, 255, 194, 15)
		
		local ckcount = 0
		local players = exports.pool:getPoolElementsByType("player")
		for key, value in ipairs(players) do
			local logged = getElementData(value, "loggedin")
			if (logged==1) then
				local requested = getElementData(value, "ckstatus")
				local reason = getElementData(value, "ckreason")
				local pname = getPlayerName(value):gsub("_", " ")
				local playerID = getElementData(value, "playerid")
				if requested=="requested" then
					ckcount = 1
					outputChatBox("Self-CK Request from '" .. pname .. "' ("..playerID..") for the reason '" .. reason .. "'.", thePlayer, 255, 195, 15)
				end
			end
		end
						
		if ckcount == 0 then
			outputChatBox("Acik rapor bulunmamaktadir.", thePlayer, 255, 194, 15)
		else
			outputChatBox("Use /cka [id] or /ckd [id] to answer the request(s).", thePlayer, 255, 194, 15)
		end
	end
end
addCommandHandler("cks", showCKList)

function reportInfo(thePlayer, commandName, id)
	if (exports.global:isPlayerSuspendedAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
		if not (id) then
			outputChatBox("SYNTAX: " .. commandName .. " [ID]", thePlayer, 255, 194, 15)
		else
			local isOverlayDisabled = getElementData(thePlayer, "hud:isOverlayDisabled")
			id = tonumber(id)
			if reports[id] then
				local reporter = reports[id][1]
				local reported = reports[id][2]
				local reason = reports[id][3]
				local timestring = reports[id][4]
				local admin = reports[id][5]
				local isGMreport = reports[id][7]
				
				local playerID = getElementData(reporter, "playerid") or "Unknown"
				local reportedID = getElementData(reported, "playerid") or "Unknown"
				
				--local reason1 = reason:sub( 0, 70 )
				--local reason2 = reason:sub( 71 )
				
				if isGMreport then
					outputChatBox(" [GM #" .. id .."] (" .. playerID .. ") " .. tostring(getPlayerName(reporter)) .. " requires assistance since " .. timestring .. ".", thePlayer, 70, 200, 30)
					outputChatBox("Aciklama: " .. reason, thePlayer, 70, 200, 30)
					
					local handler = ""
					if (isElement(admin)) then
						local adminName = getElementData(admin, "account:username")
						outputChatBox(" [#" .. id .."] This report is being handled by " .. getPlayerName(admin) .. " ("..adminName..").", thePlayer, 70, 200, 30)
					else
						--outputChatBox("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", thePlayer, 255, 221, 117)
						--outputChatBox("   Rapor /ar " .. id .. " rapor ID'si kabul edildi. Type /togautocheck to turn on/off auto-check when accepting reports.", thePlayer, 255, 194, 15)
					end
				else
					outputChatBox(" [ADM #" .. id .."] (" .. playerID .. ") " .. tostring(getPlayerName(reporter)) .. " report edildi (" .. reportedID .. ") " .. tostring(getPlayerName(reported)) .. " at " .. timestring .. ".", thePlayer, 255, 126, 0)--200, 240, 120)
					outputChatBox("Aciklama: " .. reason, thePlayer, 200, 240, 120)
					-- if reason2 and #reason2 > 0 then
						-- outputChatBox(reason2, thePlayer, 200, 240, 120)
					-- end
					
					local handler = ""
					if (isElement(admin)) then
						local adminName = getElementData(admin, "account:username")
						outputChatBox(" [#" .. id .."] This report is being handled by " .. getPlayerName(admin) .. " ("..adminName..").", thePlayer, 255, 126, 0)--200, 240, 120)
					else
						--outputChatBox("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", thePlayer, 255, 221, 117)
						--outputChatBox("   Type /ar " .. id .. " to accept this report. Type /togautocheck to turn on/off auto-check when accepting reports.", thePlayer, 255, 194, 15)
					end
				end
				
				
			else
				outputChatBox("Rapor ID Bulunamadi.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("reportinfo", reportInfo, false, false)
addCommandHandler("ri", reportInfo, false, false)

function playerQuit()
	local report = getElementData(source, "adminreport") or getElementData(source, "gmreport")
	local update = false
	
	if report and reports[report] then
		local theAdmin = reports[report][5]
		local isGMreport = reports[report][7]
		
		
		if (isElement(theAdmin)) then
			if isGMreport then
				outputChatBox(" [GM #" .. report .."] Oyuncu " .. getPlayerName(source) .. " oyundan cikti.", theAdmin, 255, 126, 0)--200, 240, 120)
			else
				outputChatBox(" [ADM #" .. report .."] Oyuncu " .. getPlayerName(source) .. " oyundan cikti.", theAdmin, 255, 126, 0)--200, 240, 120)
			end
		else
			if isGMreport then
				for key, value in ipairs(exports.global:getAdmins()) do
					local adminduty = getElementData(value, "adminduty")
					if adminduty == 1 then
						outputChatBox(" [ADM #" .. report .."] Oyuncu " .. getPlayerName(source) .. " oyundan cikti.", value, 255, 126, 0)--200, 240, 120)
						update = true
					end
				end
			else
				for key, value in ipairs(exports.global:getGameMasters()) do
					local adminduty = getElementData(value, "account:gmduty")
					if adminduty == true then
						outputChatBox(" [GM #" .. report .."] Oyuncu " .. getPlayerName(source) .. " oyundan cikti.", value, 255, 126, 0)--200, 240, 120)
						update = true
					end
				end			
			end
		end
		
		local alertTimer = reports[report][6]
		--local timeoutTimer = reports[report][7]
		
		if isTimer(alertTimer) then
			killTimer(alertTimer)
		end
		
		--[[if isTimer(timeoutTimer) then
			killTimer(timeoutTimer)
		end]]
		
		reports[report] = nil -- Destroy any reports made by the player
		update = true
	end
	
	-- check for reports assigned to him, unassigned if neccessary
	if isGMreport then
		for i = 1, 300 do
			if reports[i] then
				if reports[i][5] == source then
					reports[i][5] = nil
					for key, value in ipairs(exports.global:getGameMasters()) do
						local adminduty = getElementData(value, "account:gmduty")
						if adminduty == true then
							local adminName = getElementData(source, "account:username")
							outputChatBox(" [GM #" .. i .."] Rapor atanmamis (" .. adminName .. " oyundan cikti.)", value, 255, 126, 0)--200, 240, 120)
							update = true
						end
					end
				end
				if reports[i][2] == source then
					for key, value in ipairs(exports.global:getGameMasters()) do
						local adminduty = getElementData(value, "account:gmduty")
						if adminduty == true then
							outputChatBox(" [GM #" .. i .."] Bildirilen Oyuncu " .. getPlayerName(source) .. " oyundan cikti.", value, 255, 126, 0)--200, 240, 120)
							update = true
						end
					end
					
					local reporter = reports[i][1]
					if reporter ~= source then
						local adminName = getElementData(source, "account:username")
						outputChatBox("Raporunuzu GM#" .. i .. " kapatti (" .. adminName .. " oyundan cikti.)", reporter, 255, 126, 0)--200, 240, 120)
						exports['anticheat-system']:changeProtectedElementDataEx(reporter, "gmreport", false, true)
						exports['anticheat-system']:changeProtectedElementDataEx(reporter, "reportadmin", false, false)
					end
					
					local alertTimer = reports[i][6]
					--local timeoutTimer = reports[i][7]

					if isTimer(alertTimer) then
						killTimer(alertTimer)
					end

					--[[if isTimer(timeoutTimer) then
						killTimer(timeoutTimer)
					end]]

					reports[i] = nil -- Destroy any reports made by the player
				end
			end
		end
	else
		for i = 1, 300 do -- Support 128 reports at any one time, since each player can only have one report
			if reports[i] then
				if reports[i][5] == source then
					reports[i][5] = nil
					for key, value in ipairs(exports.global:getAdmins()) do
						local adminduty = getElementData(value, "adminduty")
						if adminduty == 1 then
							local adminName = getElementData(source, "account:username")
							outputChatBox(" [#" .. i .."] Rapor atanmamis (" .. adminName .. " oyundan cikti.)", value, 255, 126, 0)--200, 240, 120)
							update = true
						end
					end
				end
				if reports[i][2] == source then
					for key, value in ipairs(exports.global:getAdmins()) do
						local adminduty = getElementData(value, "adminduty")
						if adminduty == 1 then
							outputChatBox(" [#" .. i .."] Bildirilen Oyuncu " .. getPlayerName(source) .. " oyundan cikti.", value, 255, 126, 0)--200, 240, 120)
							update = true
						end
					end
					
					local reporter = reports[i][1]
					if reporter ~= source then
						local adminName = getElementData(source, "account:username")
						outputChatBox("Bildiren oyuncu #" .. i .. " raporu kapadi. (" .. adminName .. " oyundan cikti)", reporter, 255, 126, 0)--200, 240, 120)
						exports['anticheat-system']:changeProtectedElementDataEx(reporter, "adminreport", false, true)
						exports['anticheat-system']:changeProtectedElementDataEx(reporter, "reportadmin", false, false)
					end
					
					local alertTimer = reports[i][6]
					--local timeoutTimer = reports[i][7]

					if isTimer(alertTimer) then
						killTimer(alertTimer)
					end

					--[[if isTimer(timeoutTimer) then
						killTimer(timeoutTimer)
					end]]

					reports[i] = nil -- Destroy any reports made by the player
				end
			end
		end	
	end
	
	local requested = getElementData(source, "ckstatus") -- Clear any Self-CK requests the player may have.
	if (requested=="requested") then
		for key, value in ipairs(exports.global:getAdmins()) do
			triggerClientEvent( value, "CK Istegi", value )
		end
		setElementData(source, "ckstatus", 0)
		setElementData(source, "ckreason", 0)
	end
	
	if update then
		--sortReports(true)
		updateReportCount()
	end
end
addEventHandler("onPlayerQuit", getRootElement(), playerQuit)
	
	
function playerConnect()
	if exports.global:isPlayerAdmin(source) then
		local players = exports.pool:getPoolElementsByType("player")
		for key, value in ipairs(players) do 
			local logged = getElementData(value, "loggedin")
			if (logged==1) then
				local requested = getElementData(value, "ckstatus")
				if requested=="requested" then
					triggerClientEvent( source, "addOneToCKCountFromSpawn", source )
				end
			end
		end
	end
end
addEventHandler("accounts:characters:spawn", getRootElement(), playerConnect)


function handleReport(reportedPlayer, reportedReason, isGMreport)
	if not isGMreport then
		isGMreport = false
	end
	
	if getElementData(reportedPlayer, "loggedin") ~= 1 then
		outputChatBox("Bildirmekte oldugunuz oyuncu giris yapti.", source, 255, 0, 0)
		return
	end
	-- Find a free report slot
	local slot = nil
	
	--sortReports(false)

	for i = 1, 300 do 
		if not reports[i] then
			slot = i
			break
		end
	end
	
	local hours, minutes = getTime()
	
	-- Fix hours
	if (hours<10) then
		hours = "0" .. hours
	end
	
	-- Fix minutes
	if (minutes<10) then
		minutes = "0" .. minutes
	end
	
	local timestring = hours .. ":" .. minutes
	

	--local alertTimer = setTimer(alertPendingReport, 123500, 2, slot)
	--local alertTimer = setTimer(alertPendingReport, 123500, 0, slot)
	--local timeoutTimer = setTimer(pendingReportTimeout, 300000, 1, slot)
	
	-- Store report information
	reports[slot] = { }
	reports[slot][1] = source -- Reporter
	reports[slot][2] = reportedPlayer -- Reported Player
	reports[slot][3] = reportedReason -- Reported Reason
	reports[slot][4] = timestring -- Time reported at
	reports[slot][5] = nil -- Admin dealing with the report
	reports[slot][6] = alertTimer -- Alert timer of the report
	reports[slot][7] = isGMreport -- Type report
	reports[slot][8] = slot -- Report ID/Slot, used in rolling queue function / Maxime
	
	local playerID = getElementData(source, "playerid")
	local reportedID = getElementData(reportedPlayer, "playerid")
	
	exports['anticheat-system']:changeProtectedElementDataEx(source, "adminreport", slot, true)
	exports['anticheat-system']:changeProtectedElementDataEx(source, "reportadmin", false)
	local count = 0
	local nigger = 0
	local skipadmin = false	
	
	if isGMreport then
		exports['anticheat-system']:changeProtectedElementDataEx(source, "gmreport", slot, true)
		local GMs = exports.global:getGameMasters()
		
		-- Show to GMs
		-- local reason1 = reportedReason:sub( 0, 70 )
		-- local reason2 = reportedReason:sub( 71 )
		for key, value in ipairs(GMs) do
			local gmDuty = getElementData(value, "account:gmduty")
			if (gmDuty == true) then
				nigger = nigger + 1
				outputChatBox(" [GM #" .. slot .."] (" .. playerID .. ") " .. tostring(getPlayerName(source)) .. " yardim istedi.", value, 70, 200, 30)
				outputChatBox("Soru: " .. reportedReason, value, 70, 220, 30)
				-- if reason2 and #reason2 > 0 then
					-- outputChatBox(reason2, value, 70, 220, 30)
				-- end
				skipadmin = true
			end
			count = count + 1
		end
		
		
		-- No GMS online
		if not skipadmin then
			local GMs = exports.global:getAdmins()
			-- Show to GMs
			--local reason1 = reportedReason:sub( 0, 70 )
			--local reason2 = reportedReason:sub( 71 )
			for key, value in ipairs(GMs) do
				local gmDuty = getElementData(value, "adminduty")
				if (gmDuty == 1) then
					outputChatBox(" [GM #" .. slot .."] (" .. playerID .. ") " .. tostring(getPlayerName(source)) .. " yardim istedi.", value, 255, 126, 0)--200, 240, 120)
					outputChatBox("Soru: " .. reportedReason, value, 200, 240, 120)
					-- if reason2 and #reason2 > 0 then
						-- outputChatBox(reason2, value, 200, 240, 120)
					-- end
				end
				count = count - 1
			end			
		end
		
		outputChatBox("Raporunuzu gönderdiğiniz için teşekkür ederiz. (Report ID: #" .. tostring(slot) .. ").", source, 70, 200, 30)
		if count < 0 then
			outputChatBox("Currently there are 0 gamemaster" .. ( count == 1 and "" or "s" ) .. " available, your report has been forwarded to admins.", source, 70, 200, 30)
		elseif count == 0 then
			outputChatBox("Currently there are 0 gamemasters available, please standby.", source, 70, 200, 30)
		else
			outputChatBox("Bir GameMaster raporuna cevap vericektir suanda oyunda aktif GameMaster var. " .. nigger .. " gamemaster" .. ( count == 1 and "" or "s" ) .. " available.", source, 70, 200, 30)
		end
		
		outputChatBox("Raporu kapatmak istersen /er yazman yeterli olucaktir.", source, 70, 200, 30)
		
	else
		local admins = exports.global:getAdmins()
		local count = 0
		local faggots = 0
		-- Show to admins
		--local reason1 = reportedReason:sub( 0, 70 )
		--local reason2 = reportedReason:sub( 71 )
		for key, value in ipairs(admins) do
			local adminduty = getElementData(value, "adminduty")
			if (adminduty==1) then
				faggots = faggots + 1
				outputChatBox(" [ADM #" .. slot .."] (" .. playerID .. ") " .. tostring(getPlayerName(source)) .. " report edildi (" .. reportedID .. ") " .. tostring(getPlayerName(reportedPlayer)) .. " at " .. timestring .. ".", value, 255, 126, 0)--200, 240, 120)
				outputChatBox("Aciklama: " .. reportedReason, value, 200, 240, 120)
				-- if reason2 and #reason2 > 0 then
					-- outputChatBox(reason2, value, 200, 240, 120)
				-- end
				
			end
			if getElementData(value, "hiddenadmin") ~= 1 then
				count = count + 1
			end
		end
		
		local GMs = exports.global:getGameMasters()
		for key, value in ipairs(GMs) do
			local gmDuty = getElementData(value, "account:gmduty")
			if (gmDuty) and getElementData(value, "report-system:subcribeToAdminReports") then
				outputChatBox(" [ADM #" .. slot .."] (" .. playerID .. ") " .. tostring(getPlayerName(source)) .. " report edildi (" .. reportedID .. ") " .. tostring(getPlayerName(reportedPlayer)) .. " at " .. timestring .. ".", value, 255, 126, 0)--200, 240, 120)
				outputChatBox("Aciklama: " .. reportedReason, value, 200, 240, 120)
			end
		end
		
		
		outputChatBox("Yonetici raporu gönderdiginiz için tesekkur ederiz. (Report ID: #" .. tostring(slot) .. ").", source, 200, 240, 120)
		outputChatBox("Bildirilen oyuncu (" .. reportedID .. ") " .. tostring(getPlayerName(reportedPlayer)) .. ". Sebep: ", source, 237, 145, 33 )
		outputChatBox(reportedReason, source, 200, 240, 120)
		-- if reason2 and #reason2 > 0 then
			-- outputChatBox(reason2, source, 200, 240, 120)
		-- end
		outputChatBox("Bir Admin raporuna cevap vericektir suanda oyunda aktif admin var. " .. faggots .. " admin" .. ( count == 1 and "" or "s" ) .. " available.", source, 200, 240, 120)
		outputChatBox("Raporu kapatmak istersen /er yazman yeterli olucaktir.", source, 200, 240, 120)
	end
	updateReportCount()
end

function subscribeToAdminsReports(thePlayer)
	if exports.global:isPlayerGameMaster(thePlayer) then
		if getElementData(thePlayer, "report-system:subcribeToAdminReports") then
			setElementData(thePlayer, "report-system:subcribeToAdminReports", false)
			outputChatBox("Yonetici raporlari bolumunden cikti.",thePlayer, 255,0,0)
		else
			setElementData(thePlayer, "report-system:subcribeToAdminReports", true)
			outputChatBox("Yonetici raporlari bolumune girdi.",thePlayer, 0,255,0)
		end
	end
end
addCommandHandler("showadminreports", subscribeToAdminsReports)

function GMhandleReport(reportedReason)
	handleReport(client, reportedReason, true)
end
addEvent("GMclientSendReport", true)
addEventHandler("GMclientSendReport", getRootElement(), GMhandleReport)

addEvent("clientSendReport", true)
addEventHandler("clientSendReport", getRootElement(), handleReport)

function alertPendingReport(id)
	if (reports[id]) then
		local reportingPlayer = reports[id][1]
		local reportedPlayer = reports[id][2]
		local reportedReason = reports[id][3]
		local timestring = reports[id][4]
		local isGMreport = reports[id][7]
		local playerID = getElementData(reportingPlayer, "playerid")
		local reportedID = getElementData(reportedPlayer, "playerid")
		
		if isGMreport then
			local GMs = exports.global:getGameMasters()
			local reason1 = reportedReason:sub( 0, 70 )
			local reason2 = reportedReason:sub( 71 )
			for key, value in ipairs(GMs) do
				local gmduty = getElementData(value, "account:gmduty")
				if (gmduty== true) then
					outputChatBox(" [GM #" .. id .. "] is still not answered: (" .. playerID .. ") " .. tostring(getPlayerName(reportingPlayer)) .. " beri " .. timestring .. ".", value, 200, 240, 120)
					--outputChatBox(" [GM #" .. id .. "] " .. "Aciklama: " .. reason1, value, 210, 105, 50)
					--if reason2 and #reason2 > 0 then
					--	outputChatBox(" [GM #" .. id .. "] " .. reason2, value, 210, 105, 50)
					--end
				end
			end
		else
			local admins = exports.global:getAdmins()
			-- Show to admins
			local reason1 = reportedReason:sub( 0, 70 )
			local reason2 = reportedReason:sub( 71 )
			for key, value in ipairs(admins) do
				local adminduty = getElementData(value, "adminduty")
				if (adminduty==1) then
					outputChatBox(" [#" .. id .. "] is still not answered: (" .. playerID .. ") " .. tostring(getPlayerName(reportingPlayer)) .. " report edildi (" .. reportedID .. ") " .. tostring(getPlayerName(reportedPlayer)) .. " at " .. timestring .. ".", value, 200, 240, 120)
					--outputChatBox(" [#" .. id .. "] " .. "Aciklama: " .. reason1, value, 210, 105, 50)
					--if reason2 and #reason2 > 0 then
					--	outputChatBox(" [#" .. id .. "] " .. reason2, value, 210, 105, 50)
					--end
				end
			end
		end
	end
end
--[[
function pendingReportTimeout(id)
	if (reports[id]) then
		
		local reportingPlayer = reports[id][1]
		local isGMreport = reports[id][8]
		-- Destroy the report
		local alertTimer = reports[id][6]
		local timeoutTimer = reports[id][7]
		
		if isTimer(alertTimer) then
			killTimer(alertTimer)
		end
		
		if isTimer(timeoutTimer) then
			killTimer(timeoutTimer)
		end
		
		reports[id] = nil -- Destroy any reports made by the player
		
		
		exports['anticheat-system']:changeProtectedElementDataEx(reportingPlayer, "reportadmin", false, false)
		
		local hours, minutes = getTime()
		
		-- Fix hours
		if (hours<10) then
			hours = "0" .. hours
		end
		
		-- Fix minutes
		if (minutes<10) then
			minutes = "0" .. minutes
		end
		
		local timestring = hours .. ":" .. minutes
		
		if isGMreport then
			exports['anticheat-system']:changeProtectedElementDataEx(reportingPlayer, "gmreport", false, false)
			local GMs = exports.global:getGameMasters()
			for key, value in ipairs(GMs) do
				local gmduty = getElementData(value, "account:gmduty")
				if (gmduty== true) then
					outputChatBox(" [GM #" .. id .. "] - REPORT #" .. id .. " has expired!", value, 200, 240, 120)
				end
			end
		else
			exports['anticheat-system']:changeProtectedElementDataEx(reportingPlayer, "report", false, false)
			local admins = exports.global:getAdmins()
			-- Show to admins
			for key, value in ipairs(admins) do
				local adminduty = getElementData(value, "adminduty")
				if (adminduty==1) then
					outputChatBox(" [#" .. id .. "] - REPORT #" .. id .. " has expired!", value, 200, 240, 120)
				end
			end
		end
		
		outputChatBox("[" .. timestring .. "] Your report (#" .. id .. ") has expired.", reportingPlayer, 200, 240, 120)
		outputChatBox("[" .. timestring .. "] If you still require assistance, please resubmit your report or visit our forums (http://unitedgaming.org/forums).", reportingPlayer, 200, 240, 120)
		sortReports(false)
		updateReportCount()
	end
end]]

function falseReport(thePlayer, commandName, id)
	if (exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
		if not (id) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Report ID]", thePlayer, 255, 194, 14)
		else
			local id = tonumber(id)
			if not (reports[id]) then
				outputChatBox("Rapor ID Bulunamadi.", thePlayer, 255, 0, 0)
			else
				local reportHandler = reports[id][5]
				
				if (reportHandler) then
					
					outputChatBox("Report #" .. id .. " is already being handled by " .. getPlayerName(reportHandler) .. " ("..getElementData(reportHandler,"account:username")..")", thePlayer, 255, 0, 0)
				else
					local reportingPlayer = reports[id][1]
					local reportedPlayer = reports[id][2]
					
					if reportedPlayer == thePlayer and not exports.global:isPlayerScripter(thePlayer) then
						outputChatBox("You better let someone else to handler this report because it's against you.",thePlayer, 255,0,0)
						return false
					end
					
					local reason = reports[id][3]
					local alertTimer = reports[id][6]
					--local timeoutTimer = reports[id][7]
					local isGMreport = reports[id][7]
					
					local adminTitle = "Player"
					if exports.global:isPlayerSuspendedAdmin(thePlayer) then
						adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
					else
						adminTitle = exports.global:getPlayerGMTitle(thePlayer)			
					end
					local adminUsername = getElementData(thePlayer, "account:username")
					
					if isTimer(alertTimer) then
						killTimer(alertTimer)
					end
					
					--[[if isTimer(timeoutTimer) then
						killTimer(timeoutTimer)
					end]]

					reports[id] = nil
					
					local hours, minutes = getTime()
					
					-- Fix hours
					if (hours<10) then
						hours = "0" .. hours
					end
					
					-- Fix minutes
					if (minutes<10) then
						minutes = "0" .. minutes
					end
					
					local timestring = hours .. ":" .. minutes
					exports['anticheat-system']:changeProtectedElementDataEx(reportingPlayer, "adminreport", false, true)
					exports['anticheat-system']:changeProtectedElementDataEx(reportingPlayer, "gmreport", false, true)
					exports['anticheat-system']:changeProtectedElementDataEx(reportingPlayer, "reportadmin", true, true)
					
					
					if isGMreport then
						
						local admins = exports.global:getGameMasters()
						for key, value in ipairs(admins) do
							local adminduty = getElementData(value, "account:gmduty")
							if (adminduty== true) then
								outputChatBox(" [GM #" .. id .. "] - "..adminTitle.." ".. getPlayerName(thePlayer) .. " has marked report #" .. id .. " as false. -", value, 70, 200, 30)
							end
						end		
						outputChatBox("[" .. timestring .. "] Bildirilen Rapor (#" .. id .. ") tarafindan yalanlandi. "..adminTitle.." ".. getPlayerName(thePlayer) .. ".", reportingPlayer, 70, 200, 30)
					else
						local admins = exports.global:getAdmins()
						for key, value in ipairs(admins) do
							local adminduty = getElementData(value, "adminduty")
							if (adminduty==1) then
								outputChatBox(" [#" .. id .. "] - "..adminTitle.." ".. getPlayerName(thePlayer) .. " Isretli rapor #" .. id .. " reddedildi. -", value, 255, 126, 0)--200, 240, 120)
							end
						end
						
						outputChatBox("[" .. timestring .. "] Bildirilen Rapor (#" .. id .. ") tarafindan yalanlandi. "..adminTitle.." ".. getPlayerName(thePlayer) .. ".", reportingPlayer, 255, 126, 0)--200, 240, 120)
					end
					local accountID = getElementData(thePlayer, "account:id")
					--exports.logs:dbLog({"ac"..tostring(accountID), thePlayer }, 38, {reportingPlayer, reportedPlayer}, getPlayerName(thePlayer) .. " maked a report as false. Report: " .. reason )
					--sortReports(true)
					updateReportCount()
				end
			end
		end
	end
end
addCommandHandler("falsereport", falseReport, false, false)
addCommandHandler("fr", falseReport, false, false)

function arBind()
	if exports.global:isPlayerSuspendedAdmin(client) then
		--[[for k, arrayPlayer in ipairs(exports.global:getAdmins()) do
			local logged = getElementData(arrayPlayer, "loggedin")
			if (logged) then
				exports.global:isPlayerLeadAdmin(arrayPlayer) then
					outputChatBox( "LeadAdmWarn: " .. getPlayerName(client) .. " has accept report bound to keys. ", arrayPlayer, 200, 240, 120)
				end
				
			end
		end]]
		exports.global:sendMessageToAdmins("Admin ".. getPlayerName(client) .. ", Bind olarak rapor kabul etti!")
	end
end
addEvent("arBind", true)
addEventHandler("arBind", getRootElement(), arBind)

function acceptReport(thePlayer, commandName, id)
	if (exports.global:isPlayerSuspendedAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
		if not (id) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Report ID]", thePlayer, 255, 194, 14)
		else
			local id = tonumber(id)
			if not (reports[id]) then
				outputChatBox("Rapor ID Bulunamadi.", thePlayer, 255, 0, 0)
			else
				local reportHandler = reports[id][5]
				
				if (reportHandler) then
					outputChatBox("Rapor #" .. id .. " is already being handled by " .. getPlayerName(reportHandler) .. ".", thePlayer, 255, 0, 0)
				else
					
					local reportingPlayer = reports[id][1]
					local reportedPlayer = reports[id][2]
					
					if reportingPlayer == thePlayer and not exports.global:isPlayerScripter(thePlayer) then
						outputChatBox("Kendi raporunuzu kabul edemezsiniz.",thePlayer, 255,0,0)
						return false
					elseif reportedPlayer == thePlayer and not exports.global:isPlayerScripter(thePlayer) then
						outputChatBox("Raporunuza bakacak baska bir rapor isleyicisi bulun.",thePlayer, 255,0,0)
						return false
					end
					
					local reason = reports[id][3]
					local alertTimer = reports[id][6]
					--local timeoutTimer = reports[id][7]
					local isGMreport = reports[id][7]
					
					if isTimer(alertTimer) then
						killTimer(alertTimer)
					end
					
					--[[if isTimer(timeoutTimer) then
						killTimer(timeoutTimer)
					end]]
					
					reports[id][5] = thePlayer -- Admin dealing with this report
					
					local hours, minutes = getTime()
					
					-- Fix hours
					if (hours<10) then
						hours = "0" .. hours
					end
					
					-- Fix minutes
					if (minutes<10) then
						minutes = "0" .. minutes
					end
					
					local adminreports = getElementData(thePlayer, "adminreports")
					exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "adminreports", adminreports+1, false)
					mysql:query_free("UPDATE accounts SET adminreports=adminreports+1 WHERE id = " .. mysql:escape_string(getElementData( thePlayer, "account:id" )) )
					exports['anticheat-system']:changeProtectedElementDataEx(reportingPlayer, "reportadmin", thePlayer, false)
					
					local timestring = hours .. ":" .. minutes
					local playerID = getElementData(reportingPlayer, "playerid")
					
					local adminName = getElementData(thePlayer,"account:username")
					local adminTitle = "Player"
					if exports.global:isPlayerSuspendedAdmin(thePlayer) then
						adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
					else
						adminTitle = exports.global:getPlayerGMTitle(thePlayer)			
					end
					
					if isGMreport then
						local admins = exports.global:getGameMasters()
						for key, value in ipairs(admins) do
							local adminduty = getElementData(value, "account:gmduty")
							if (adminduty==true) then
								outputChatBox(" [GM #" .. id .. "] - "..adminTitle.." "..getPlayerName(thePlayer) .. "  raporunu kabul etti #" .. id .. " -", value, 70, 200, 30)
							end
						end
						
						outputChatBox(adminTitle.." " .. getPlayerName(thePlayer) .. " raporun kabul edildi (#" .. id .. ") at "..timestring..", Biraz bekleyin yetkili kisi sizinle iletisime gececektir.", reportingPlayer, 70, 200, 30)
						
						outputChatBox("Raporun kabul edildi #" .. id .. ". Oyuncu Iletisim ID #" .. playerID .. " (" .. getPlayerName(reportingPlayer) .. ").", thePlayer, 70, 200, 30)
					else
						local admins = exports.global:getAdmins()
						for key, value in ipairs(admins) do
							local adminduty = getElementData(value, "adminduty")
							if (adminduty==1) then
								outputChatBox(" [#" .. id .. "] - "..adminTitle.." "..getPlayerName(thePlayer) .. " Raporun kabul edildi #" .. id .. " -", value, 255,126, 0)--200, 240, 120)
							end
						end	
						
						outputChatBox(adminTitle.." " .. getPlayerName(thePlayer) .. " has accepted your report (#" .. id .. ") at "..timestring..", Biraz bekleyin yetkili kisi sizinle iletisime gececektir.", reportingPlayer, 255,126, 0)--200, 240, 120)
						
						outputChatBox("Raporun kabul edildi #" .. id .. ". Oyuncu Iletisim ID #" .. playerID .. " (" .. getPlayerName(reportingPlayer) .. ").", thePlayer, 255,126, 0)--200, 240, 120)
					end
					
					if getElementData(thePlayer, "report:autocheck") then
						triggerClientEvent( thePlayer, "report:onOpenCheck", thePlayer, tostring(playerID) )
					end
					
					setElementData(thePlayer, "targetPMer", getPlayerName(reportingPlayer):gsub(" ","_"), false)
					
					local accountID = getElementData(thePlayer, "account:id")
					--exports.logs:dbLog({"ac"..tostring(accountID), thePlayer }, 38, {reportingPlayer, reportedPlayer}, getPlayerName(thePlayer) .. " accepted a report. Report: " .. reason )
					--sortReports(false)
					exports.global:giveMoney(thePlayer, 300)
					updateReportCount()
				end
			end
		end
	end
end
addCommandHandler("acceptreport", acceptReport, false, false)
addCommandHandler("ar", acceptReport, false, false)

function toggleAutoCheck(thePlayer)
	if (exports.global:isPlayerSuspendedAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
		if getElementData(thePlayer, "report:autocheck") then
			setElementData(thePlayer, "report:autocheck", false)
			outputChatBox(" You've just disabled auto /check on /ar.", thePlayer, 255, 0,0)
		else
			setElementData(thePlayer, "report:autocheck", true)
			outputChatBox(" You've just enabled auto /check on /ar.", thePlayer, 0, 255,0)
		end
	end
end
addCommandHandler("toggleautocheck", toggleAutoCheck, false, false)
addCommandHandler("togautocheck", toggleAutoCheck, false, false)

function acceptAdminReport(thePlayer, commandName, id, ...)
	local adminName = table.concat({...}, " ")
	if (exports.global:isPlayerHeadAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Rapor ID] [Admin Adi]", thePlayer, 255, 194, 14)
		else
			local targetAdmin, username = exports.global:findPlayerByPartialNick(thePlayer, adminName)
			if targetAdmin then
				local id = tonumber(id)
				if not (reports[id]) then
					outputChatBox("Yanlis Rapor ID'si.", thePlayer, 255, 0, 0)
				else
					local reportHandler = reports[id][5]
					
					if (reportHandler) then
						outputChatBox("Rapor #" .. id .. " zaten rapor kontrol ediliyor " .. getPlayerName(reportHandler) .. "Tarafindan.", thePlayer, 255, 0, 0)
					else
						local reportingPlayer = reports[id][1]
						local reportedPlayer = reports[id][2]
						local reason = reports[id][3]
						local alertTimer = reports[id][6]
						--local timeoutTimer = reports[id][7]
						local isGMreport = reports[id][7]
						if isTimer(alertTimer) then
							killTimer(alertTimer)
						end
						
						--[[if isTimer(timeoutTimer) then
							killTimer(timeoutTimer)
						end]]
						
						reports[id][5] = targetAdmin -- Admin dealing with this report
						
						local hours, minutes = getTime()
						
						-- Fix hours
						if (hours<10) then
							hours = "0" .. hours
						end
						
						-- Fix minutes
						if (minutes<10) then
							minutes = "0" .. minutes
						end
						
						local adminreports = getElementData(targetAdmin, "adminreports")
						exports['anticheat-system']:changeProtectedElementDataEx(targetAdmin, "adminreports", adminreports+1, false)
						mysql:query_free("UPDATE accounts SET adminreports=adminreports+1 WHERE id = " .. mysql:escape_string(getElementData( targetAdmin, "account:id" )) )
						exports['anticheat-system']:changeProtectedElementDataEx(reportingPlayer, "reportadmin", targetAdmin, false)
						
						local timestring = hours .. ":" .. minutes
						local playerID = getElementData(reportingPlayer, "playerid")
						
						if exports.global:isPlayerGameMaster(targetAdmin) then
							outputChatBox("[" .. timestring .. "] Gamemaster " .. getPlayerName(targetAdmin) .. " raporunuzu kabul etti. (#" .. id .. "), Please wait for them to contact you.", reportingPlayer, 200, 240, 120)
						else
							outputChatBox("[" .. timestring .. "] Admin " .. getPlayerName(targetAdmin) .. " raporunuzu kabul etti. (#" .. id .. "), Please wait for them to contact you.", reportingPlayer, 200, 240, 120)
						end
						outputChatBox("Yoneticiye atanan rapor #" .. id .. " Sizinle iletisime gececektir biraz bekleyin. ( (" .. playerID .. ") " .. getPlayerName(reportingPlayer) .. ").", targetAdmin, 200, 240, 120)
						
						if isGMreport then
							local admins = exports.global:getGameMasters()
							for key, value in ipairs(admins) do
								local adminduty = getElementData(value, "account:gmduty")
								if (adminduty==true) then
									outputChatBox(" [GM #" .. id .. "] - " .. getPlayerName(theAdmin) .. " raporun kabul edildi. #" .. id .. " (Assigned) -", value, 200, 240, 120)
								end
							end
						else
							local admins = exports.global:getAdmins()
							for key, value in ipairs(admins) do
								local adminduty = getElementData(value, "adminduty")
								if (adminduty==1) then
									outputChatBox(" [#" .. id .. "] - " .. getPlayerName(theAdmin) .. " raporun kabul edildi. #" .. id .. " (Assigned) -", value, 200, 240, 120)
								end
							end
						end
						local accountID = getElementData(thePlayer, "account:id")
						--exports.logs:dbLog({"ac"..tostring(accountID), thePlayer }, 38, {reportingPlayer, reportedPlayer}, getPlayerName(thePlayer) .. " was assigned a report. Report: " .. reason )
						--sortReports(false)
						updateReportCount()
					end
				end
			end
		end
	end
end
addCommandHandler("ara", acceptAdminReport, false, false)


function transferReport(thePlayer, commandName, id, ...)
	local adminName = table.concat({...}, " ")
	if (exports.global:isPlayerHeadAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Rapor ID] [Admin Adi]", thePlayer, 200, 240, 120)
		else
			local targetAdmin, username = exports.global:findPlayerByPartialNick(thePlayer, adminName)
			if targetAdmin then
				local id = tonumber(id)
				if not (reports[id]) then
					outputChatBox("Rapor ID Bulunamadi.", thePlayer, 255, 0, 0)
				elseif (reports[id][5] ~= thePlayer) and not (exports.global:isPlayerLeadAdmin(thePlayer)) then
					outputChatBox("Bu rapor senin degil dostum.", thePlayer, 255, 0, 0)
				else
					local reportingPlayer = reports[id][1]
					local reportedPlayer = reports[id][2]
					local report = reports[id][3]
					local isGMreport = reports[id][7]
					reports[id][5] = targetAdmin -- Admin dealing with this report
					
					local hours, minutes = getTime()
					
					-- Fix hours
					if (hours<10) then
						hours = "0" .. hours
					end
					
					-- Fix minutes
					if (minutes<10) then
						minutes = "0" .. minutes
					end
							
					local timestring = hours .. ":" .. minutes
					local playerID = getElementData(reportingPlayer, "playerid")
					
					outputChatBox("[" .. timestring .. "] " .. getPlayerName(thePlayer) .. " yetkili repor edildi ".. getPlayerName(targetAdmin) .." (#" .. id .. "), Biraz bekleyin sizinle iletisime gececekler.", reportingPlayer, 200, 240, 120)
					outputChatBox(getPlayerName(thePlayer) .. " Rapor ID #" .. id .. " sana. Biraz bekleyin sizinle iletisime gececekler. ( (" .. playerID .. ") " .. getPlayerName(reportingPlayer) .. ").", targetAdmin, 200, 240, 120)
					
					if isGMreport then
						local admins = exports.global:getGameMasters()
						for key, value in ipairs(admins) do
							local adminduty = getElementData(value, "account:gmduty")
							if (adminduty==true) then
								outputChatBox(" [GM #" .. id .. "] - " .. getPlayerName(thePlayer) .. " Rapor #" .. id .. " uzerinde  ".. getPlayerName(targetAdmin) , value, 200, 240, 120)
							end
						end					
					else
						local admins = exports.global:getAdmins()
						for key, value in ipairs(admins) do
							local adminduty = getElementData(value, "adminduty")
							if (adminduty==1) then
								outputChatBox(" [#" .. id .. "] - " .. getPlayerName(thePlayer) .. " Rapor #" .. id .. " uzerinde  ".. getPlayerName(targetAdmin) , value, 200, 240, 120)
							end
						end
					end
					local accountID = getElementData(thePlayer, "account:id")
					--exports.logs:dbLog({"ac"..tostring(accountID), thePlayer }, 38, {reportingPlayer, reportedPlayer}, getPlayerName(thePlayer) .. " had a report transfered to them. Report: " .. reason )
					--sortReports(false)
					updateReportCount()
				end
			end
		end
	end
end
addCommandHandler("transferreport", transferReport, false, false)
addCommandHandler("tr", transferReport, false, false)

function closeReport(thePlayer, commandName, id)
	if (exports.global:isPlayerSuspendedAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
		if not (id) then
			closeAllReports(thePlayer)
			--outputChatBox("SYNTAX: " .. commandName .. " [ID]", thePlayer, 255, 194, 14)
		else
			id = tonumber(id)
			if (reports[id]==nil) then
				outputChatBox("Rapor ID Bulunamadi.", thePlayer, 255, 0, 0)
			elseif (reports[id][5] ~= thePlayer) then
				outputChatBox("Bu rapor senin degil dostum.", thePlayer, 255, 0, 0)
			else
				local reporter = reports[id][1]
				local reported = reports[id][2]
				local reason = reports[id][3]
				local alertTimer = reports[id][6]
				local isGMreport = reports[id][7]
				
				if isTimer(alertTimer) then
					killTimer(alertTimer)
				end
				
				--[[if isTimer(timeoutTimer) then
					killTimer(timeoutTimer)
				end]]
				
				reports[id] = nil
				
				local adminName = getElementData(thePlayer,"account:username")
				local adminTitle = "Player"
				if exports.global:isPlayerSuspendedAdmin(thePlayer) then
					adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
				else
					adminTitle = exports.global:getPlayerGMTitle(thePlayer)			
				end
				
				if (isElement(reporter)) then
					exports['anticheat-system']:changeProtectedElementDataEx(reporter, "adminreport", false, true)
					exports['anticheat-system']:changeProtectedElementDataEx(reporter, "gmreport", false, true)
					exports['anticheat-system']:changeProtectedElementDataEx(reporter, "reportadmin", false, false)
					if isGMreport then
						outputChatBox(adminTitle.." "..getPlayerName(thePlayer) .. " raporunuzu kapadi.", reporter, 70, 200, 30)
					else
						outputChatBox(adminTitle.." "..getPlayerName(thePlayer) .. " raporunuzu kapadi.", reporter, 255, 126, 0)
					end
				end
				
				
				
				if not isGMreport then
					local admins = exports.global:getAdmins()
					for key, value in ipairs(admins) do
						local adminduty = getElementData(value, "adminduty")
						if (adminduty==1) then
							outputChatBox(" [ADMIN #" .. id .. "] - "..adminTitle.." " .. getPlayerName(thePlayer) .. " raporunuzu kapadi #" .. id .. ". -", value, 255, 126, 0)--200, 240, 120)
						end
					end					
				else
					local admins = exports.global:getGameMasters()
					for key, value in ipairs(admins) do
						local adminduty = getElementData(value, "account:gmduty")
						if (adminduty==true) then
							outputChatBox(" [GM #" .. id .. "] - "..adminTitle.." " .. getPlayerName(thePlayer) .. "  raporunuzu kapadi #" .. id .. ". -", value, 70, 200, 30)
						end
					end
				end
				local accountID = getElementData(thePlayer, "account:id")
				--exports.logs:dbLog({"ac"..tostring(accountID), thePlayer }, 38, {reporter, reported}, getPlayerName(thePlayer) .. " closed a report. Report: " .. reason )
				
				--sortReports(true)
				updateReportCount()
			end
		end
	end
end
addCommandHandler("closereport", closeReport, false, false)
addCommandHandler("cr", closeReport, false, false)

function closeAllReports(thePlayer)
	if (exports.global:isPlayerSuspendedAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
		--outputChatBox("~~~~~~~~~ Unanswered Reports ~~~~~~~~~", thePlayer, 0, 255, 15)
		--reports = sortReportsByTime(reports)
		local count = 0
		for i = 1, 300 do
			local report = reports[i]
			if report then
				local admin = report[5]
				if isElement(admin) and admin == thePlayer then
					closeReport(thePlayer, "cr" , i)
					count = count + 1
				end
			end
		end
		
		if count == 0 then
			outputChatBox(" Bulunamayan rapor kapandi.", thePlayer, 255, 126, 0)--255, 194, 15)
		else
			outputChatBox(" Sen "..count.." raporunu kapadin.", thePlayer, 255, 126, 0)--255, 194, 15)
		end
	end
end
addCommandHandler("closeallreports", closeAllReports, false, false)
addCommandHandler("car", closeAllReports, false, false)

function dropReport(thePlayer, commandName, id)
	if (exports.global:isPlayerSuspendedAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
		if not (id) then
			outputChatBox("KULLANIM: " .. commandName .. " [ID]", thePlayer, 255, 195, 14)
		else
			id = tonumber(id)
			if (reports[id] == nil) then
				outputChatBox("Rapor ID Bulunamadi.", thePlayer, 255, 0, 0)
			else
				if (reports[id][5] ~= thePlayer) then
					outputChatBox("Bu rapor islemde degil.", thePlayer, 255, 0, 0)
				else
					--local alertTimer = setTimer(alertPendingReport, 123500, 2, id)
					--local timeoutTimer = setTimer(pendingReportTimeout, 300000, 1, id)
					
					local reportingPlayer = reports[id][1]
					local reportedPlayer = reports[id][2]
					local reason = reports[id][3]
					reports[id][5] = nil
					reports[id][6] = alertTimer
					--reports[id][7] = timeoutTimer
					
					local adminName = getElementData(thePlayer,"account:username")
					local adminTitle = "Player"
					if exports.global:isPlayerSuspendedAdmin(thePlayer) then
						adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
					else
						adminTitle = exports.global:getPlayerGMTitle(thePlayer)			
					end
					
					local reporter = reports[id][1]
					if (isElement(reporter)) then
						exports['anticheat-system']:changeProtectedElementDataEx(reporter, "adminreport", true, true)
						exports['anticheat-system']:changeProtectedElementDataEx(reporter, "gmreport", true, true)
						exports['anticheat-system']:changeProtectedElementDataEx(reporter, "reportadmin", false, false)
						outputChatBox(adminTitle.." "..getPlayerName(thePlayer) .. " ("..adminName..") Raporunuz yayinlandi. Baska bir yonetici raporunuzu kabul edene kadar bekleyin.", reporter, 210, 105, 50)
					end
					
					if reports[id][7] then
						local admins = exports.global:getGameMasters()
						for key, value in ipairs(admins) do
							local adminduty = getElementData(value, "account:gmduty")
							if (adminduty==true) then
								outputChatBox(" [GM #" .. id .. "] - "..adminTitle.." "..getPlayerName(thePlayer) .. " ("..adminName..") rapor dustu #" .. id .. ". -", value, 255, 126, 0)--200, 240, 120)
							end
						end
					else
						local admins = exports.global:getAdmins()
						for key, value in ipairs(admins) do
							local adminduty = getElementData(value, "adminduty")
							if (adminduty==1) then
								outputChatBox(" [ADMIN #" .. id .. "] - "..adminTitle.." "..getPlayerName(thePlayer) .. " ("..adminName..") rapor dustu #" .. id .. ". -", value, 255, 126, 0)--200, 240, 120)
							end
						end
					end
					local accountID = getElementData(thePlayer, "account:id")
					--exports.logs:dbLog({"ac"..tostring(accountID), thePlayer }, 38, {reportingPlayer, reportedPlayer}, getPlayerName(thePlayer) .. " dropped a report. Report: " .. reason )
					--sortReports(false)
					updateReportCount()
				end
			end
		end
	end
end
addCommandHandler("dropreport", dropReport, false, false)
addCommandHandler("dr", dropReport, false, false)

function endReport(thePlayer, commandName)
	local adminreport = getElementData(thePlayer, "adminreport")
	local gmreport = getElementData(thePlayer, "gmreport")
	
	local report = false
	for i=1,50 do 
		if reports[i] and (reports[i][1] == thePlayer) then
			report = i 
			break
		end
	end
	
	if not adminreport or not report then
		outputChatBox("Bekleyen raporlar var Rapor olusturmak icin 'F2' tusuna basin.", thePlayer, 255, 0, 0)
	else
		local hours, minutes = getTime()
		
		-- Fix hours
		if (hours<10) then
			hours = "0" .. hours
		end
					
		-- Fix minutes
		if (minutes<10) then
			minutes = "0" .. minutes
		end
					
		local timestring = hours .. ":" .. minutes
		local reportedPlayer = reports[report][2]
		--local reason = reports[report][3]
		local reportHandler = reports[report][5]
		local alertTimer = reports[report][6]
		--local timeoutTimer = reports[report][7]
		
		if isTimer(alertTimer) then
			killTimer(alertTimer)
		end
		
		--[[if isTimer(timeoutTimer) then
			killTimer(timeoutTimer)
		end]]

		reports[report] = nil
		exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "adminreport", false, true)
		exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "gmreport", false, true)
		exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "reportadmin", false, false)
		
		outputChatBox("[" .. timestring .. "] Sen bu raporu kapadin ID #"..report, thePlayer, 200, 240, 120)
		local otherAccountID = nil
		if (isElement(reportHandler)) then
			outputChatBox(getPlayerName(thePlayer) .. " kendi raporunu kapatti. (#" .. report .. ").", reportHandler, 255, 126, 0)--200, 240, 120)
			otherAccountID = getElementData(reportHandler, "account:id")
		end
		
		--local accountID = getElementData(thePlayer, "account:id")
		--local affected = { }
		-- table.insert(affected, reportedPlayer)
		-- if isElement(reportHandler) then
			-- table.insert(affected, reportHandler)
			-- table.insert(affected, "ac"..tostring(otherAccountID))
		-- end
		--exports.logs:dbLog({"ac"..tostring(accountID), thePlayer }, 38, affected, getPlayerName(thePlayer) .. " accepted a report. Report: " .. reason )
		--sortReports(true)
		updateReportCount()
	end
end
addCommandHandler("endreport", endReport, false, false)
addCommandHandler("er", endReport, false, false)

-- Output unanswered reports for admins.
function showUnansweredReportsAdmins(thePlayer)
	if (exports.global:isPlayerSuspendedAdmin(thePlayer)) then
		if getElementData(thePlayer, "report-system:isAdminPanelEnabled") then
			setElementData(thePlayer, "report:topRight", 1, true)
		else
			outputChatBox("~~~~~~~~~ TUM RAPORLAR ~~~~~~~~~", thePlayer, 0, 255, 15)
			--reports = sortReportsByTime(reports)
			local count = 0
			for i = 1, 300 do
				local report = reports[i]
				if report then
					local reporter = report[1]
					local reported = report[2]
					local timestring = report[4]
					local admin = report[5]
					local isGMreport = report[7]
					
					local handler = ""
					if (isElement(admin)) then
						--handler = tostring(getPlayerName(admin))
					else
						handler = "None."
						if isGMreport then
							--outputChatBox("GM Report #" .. tostring(i) .. ": '" .. tostring(getPlayerName(reporter)) .. "' reporting '" .. tostring(getPlayerName(reported)) .. "' at " .. timestring .. ". Handler: " .. handler .. ".", thePlayer, 70, 200, 30)
						else
							outputChatBox("Admin Report #" .. tostring(i) .. ": '" .. tostring(getPlayerName(reporter)) .. "' reporting '" .. tostring(getPlayerName(reported)) .. "' at " .. timestring .. ". Handler: " .. handler .. ".", thePlayer, 255, 195, 15)
							count = count + 1
						end
					end
				end
			end
			
			if count == 0 then
				outputChatBox("None.", thePlayer, 255, 194, 15)
			else
				outputChatBox("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", thePlayer, 0, 255, 15)
				outputChatBox("Raporlarla ilgili daha fazla bilgi edinmek icin /ri [ID] yaziniz .", thePlayer, 255, 194, 15)
			end
		end
	end
end
addCommandHandler("ur", showUnansweredReportsAdmins, false, false)

-- Output unanswered reports for GMs
function showUnansweredReportsGMs(thePlayer)
	if (exports.global:isPlayerGameMaster(thePlayer)) then
		if getElementData(thePlayer, "report-system:isAdminPanelEnabled") then
			setElementData(thePlayer, "report:topRight", 2, true)
		else
			outputChatBox("~~~~~~~~~ TUM RAPORLAR ~~~~~~~~~", thePlayer, 0, 255, 15)
			--reports = sortReportsByTime(reports)
			local count = 0
			for i = 1, 300 do
				local report = reports[i]
				if report then
					local reporter = report[1]
					local reported = report[2]
					local timestring = report[4]
					local admin = report[5]
					local isGMreport = report[7]
					
					local handler = ""
					if (isElement(admin)) then
						--handler = tostring(getPlayerName(admin))
					else
						handler = "None."
						if isGMreport then
							outputChatBox("GM Report #" .. tostring(i) .. ": '" .. tostring(getPlayerName(reporter)) .. "' reporting '" .. tostring(getPlayerName(reported)) .. "' at " .. timestring .. ". Handler: " .. handler .. ".", thePlayer, 70, 200, 30)
							count = count + 1
						else
							--outputChatBox("Admin Report #" .. tostring(i) .. ": '" .. tostring(getPlayerName(reporter)) .. "' reporting '" .. tostring(getPlayerName(reported)) .. "' at " .. timestring .. ". Handler: " .. handler .. ".", thePlayer, 255, 195, 15)
							--count = count + 1
						end
					end
				end
			end
			
			if count == 0 then
				outputChatBox("None.", thePlayer, 255, 194, 15)
			else
				--outputChatBox("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", thePlayer, 0, 255, 15)
				--outputChatBox("Raporlarla ilgili daha fazla bilgi edinmek icin /ri [ID] yaziniz .", thePlayer, 255, 194, 15)
			end
		end
	end
end
addCommandHandler("ur", showUnansweredReportsGMs, false, false)

function showReports(thePlayer)
	if (exports.global:isPlayerSuspendedAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
		if getElementData(thePlayer, "report-system:isAdminPanelEnabled") then
			setElementData(thePlayer, "report:topRight", 3, true)
		else
			outputChatBox("~~~~~~~~~ Raporlar ~~~~~~~~~", thePlayer, 255, 194, 15)
			--reports = sortReportsByTime(reports)
			local count = 0
			for i = 1, 300 do
				local report = reports[i]
				if report then
					local reporter = report[1]
					local reported = report[2]
					local timestring = report[4]
					local admin = report[5]
					local isGMreport = report[7]
					
					local handler = ""
					
					if (isElement(admin)) then
						local adminName = getElementData(admin, "account:username")
						handler = tostring(getPlayerName(admin)).." ("..adminName..")"
					else
						handler = "None."
					end
					if isGMreport then
						outputChatBox("GM Raporu #" .. tostring(i) .. ": '" .. tostring(getPlayerName(reporter)) .. "' rapor edildi '" .. tostring(getPlayerName(reported)) .. "' bulunamadi " .. timestring .. ". Isleyen: " .. handler .. ".", thePlayer, 70, 200, 30)
					else
						outputChatBox("Admin Raporu #" .. tostring(i) .. ": '" .. tostring(getPlayerName(reporter)) .. "' rapor edildi '" .. tostring(getPlayerName(reported)) .. "' bulunamadi " .. timestring .. ". Isleyen: " .. handler .. ".", thePlayer, 255, 195, 15) 
					end
					count = count + 1
				end
			end
			
			if count == 0 then
				outputChatBox("None.", thePlayer, 255, 194, 15)
			else
				--outputChatBox("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", thePlayer, 255, 221, 117)
				--outputChatBox("Raporlarla ilgili daha fazla bilgi edinmek icin /ri [ID] yaziniz .", thePlayer, 255, 194, 15)
			end
		end
	end
end
addCommandHandler("reports", showReports, false, false)