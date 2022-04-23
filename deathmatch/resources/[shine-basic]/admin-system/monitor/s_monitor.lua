function doMonitorList(sourcePlayer, command, targetPlayerName, ...)
	if (exports.global:isPlayerAdmin(sourcePlayer) or exports.global:isPlayerGameMaster(sourcePlayer)) then
		if not targetPlayerName then
			local dataTable = { }
			for key, value in ipairs( getElementsByType( "player" ) ) do
				local loggedin = getElementData(value, "loggedin")
				if (loggedin == 1) then
					local reason = getElementData(value, "admin:monitor")
					if reason and #reason > 0 then
						local playerAccount = getElementData(value, "account:username")
						local playerName = getPlayerName(value):gsub("_", " ")
						table.insert(dataTable, { playerAccount, playerName, reason } )
					end
				end
			end
			triggerClientEvent( sourcePlayer, "onMonitorPopup", sourcePlayer, dataTable, exports.global:isPlayerAdmin(sourcePlayer) or exports.global:isPlayerGameMaster(sourcePlayer))		
		else
			if not ... then
				outputChatBox("SYNTAX: /" .. command .. " [player] [reason]", sourcePlayer, 255, 194, 14)
			else
				local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(sourcePlayer, targetPlayerName)
				if targetPlayer then
					local accountID = tonumber(getElementData(targetPlayer, "account:id"))
					local month = getRealTime().month + 1
					local timeStr = tostring(getRealTime().monthday) .. "/" ..tostring(month)  
					local reason = table.concat({...}, " ") .. " (" .. getElementData(sourcePlayer, "account:username") .. " "..timeStr..")"
					if exports.mysql:query_free("UPDATE accounts SET monitored = '" .. exports.mysql:escape_string(reason) .. "' WHERE id = " .. exports.mysql:escape_string(accountID)) then
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "admin:monitor", reason, false)
						outputChatBox("You added " .. getPlayerName(targetPlayer):gsub("_", " ") .. " to the monitor list.", sourcePlayer, 0, 255, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("monitor", doMonitorList)

addEvent("monitor:onSaveEdittedMonitor", true)
addEventHandler("monitor:onSaveEdittedMonitor", getRootElement( ),
	function (sourcePlayer, username, monitorContent, targetPlayerName1)
		local staffUsername = getElementData(sourcePlayer, "account:username")
		local staffTitle = exports.global:getPlayerGMTitle(sourcePlayer)
		local month = getRealTime().month + 1
		local timeStr = tostring(getRealTime().monthday) .. "/" ..tostring(month)  
		local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(sourcePlayer, targetPlayerName1)
		local reason = monitorContent .. " (" .. staffUsername .. " "..timeStr..")"
		if exports.mysql:query_free("UPDATE accounts SET monitored = '" .. exports.mysql:escape_string(reason) .. "' WHERE username = '" .. exports.mysql:escape_string(username).."'") then
			exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "admin:monitor", reason, false)
			outputChatBox("[MONITOR] You updated " .. username .. " to the monitor list.", sourcePlayer, 0, 255, 0)
			doMonitorList(sourcePlayer, "monitor") 
			if exports.global:isPlayerAdmin(sourcePlayer) then
				staffTitle = exports.global:getPlayerAdminTitle(sourcePlayer)
			end
			exports.global:sendMessageToAdmins("[MONITOR] "..staffTitle.." "..staffUsername.." modified monitor on player '"..targetPlayerName.."' ("..monitorContent..").")
			exports.global:sendMessageToGameMasters("[MONITOR] "..staffTitle.." "..staffUsername.." modified monitor on player '"..targetPlayerName.."' ("..monitorContent..").")
		else
			outputChatBox("[MONITOR] Failed to update " .. username .. " to the monitor list.", sourcePlayer, 255, 0, 0) 
		end
	end	
)

function offlineMonitorADD(sourcePlayer, command, username, ...)
	if (exports.global:isPlayerAdmin(sourcePlayer) or exports.global:isPlayerGameMaster(sourcePlayer)) then
		if not ... then
			triggerClientEvent(sourcePlayer, "monitor:oadd", sourcePlayer)
			--outputChatBox("SYNTAX: /" .. command .. " [username] [reason]", sourcePlayer, 255, 194, 14)
		else
			local name = mysql:query_fetch_assoc("SELECT `id`,`username`, `monitored` FROM `accounts` WHERE `username` = '" .. mysql:escape_string(username) .. "'" )
			if name then
				local uname = name["username"]
				local uid = name["id"]
			
				local month = getRealTime().month + 1
				local timeStr = tostring(getRealTime().monthday) .. "/" ..tostring(month)  
				local staffUsername = getElementData(sourcePlayer, "account:username")
				local staffTitle = exports.global:getPlayerGMTitle(sourcePlayer)
				
				local reasonTemp = table.concat({...}, " ")
				local reason =  reasonTemp .. " (" .. staffUsername .. " "..timeStr..")"
				
				
				
				if name["monitored"] and #name["monitored"] > 0 then
					reason = name["monitored"] .. " | "..reason
				end
				
				if exports.mysql:query_free("UPDATE accounts SET monitored = '" .. exports.mysql:escape_string(reason) .. "' WHERE id = " .. exports.mysql:escape_string(uid)) then
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "admin:monitor", reason, false)
					outputChatBox("You added " .. name["username"] .. " to the monitor list.", sourcePlayer, 0, 255, 0)
					if exports.global:isPlayerAdmin(sourcePlayer) then
						staffTitle = exports.global:getPlayerAdminTitle(sourcePlayer)
					end
					exports.global:sendMessageToAdmins("[OMONITOR] "..staffTitle.." "..staffUsername.." added an offline monitor on player '"..username.."' ("..reasonTemp..").")
					exports.global:sendMessageToGameMasters("[OMONITOR] "..staffTitle.." "..staffUsername.." added an offline monitor on player '"..username.."' ("..reasonTemp..").")
				end
			end
		end
	end
end
addCommandHandler("omonitor", offlineMonitorADD)

function offlineMonitorADD2(sourcePlayer, command, username, ...)
	if (exports.global:isPlayerAdmin(sourcePlayer) or exports.global:isPlayerGameMaster(sourcePlayer)) then
		if not ... then
			triggerClientEvent(sourcePlayer, "monitor:oadd2", sourcePlayer)
			--outputChatBox("SYNTAX: /" .. command .. " [username] [reason]", sourcePlayer, 255, 194, 14)
		else
			local name = mysql:query_fetch_assoc("SELECT `id`,`username`, `monitored` FROM `accounts` WHERE `username` = '" .. mysql:escape_string(username) .. "'" )
			if name then
				local uname = name["username"]
				local uid = name["id"]
			
				local month = getRealTime().month + 1
				local timeStr = tostring(getRealTime().monthday) .. "/" ..tostring(month)  
			
				local reason =  table.concat({...}, " ") .. " (" .. getElementData(sourcePlayer, "account:username") .. " "..timeStr..")"
				
				
				
				if name["monitored"] and #name["monitored"] > 0 then
					reason = name["monitored"] .. " | "..reason
				end
				
				if exports.mysql:query_free("UPDATE accounts SET monitored = '" .. exports.mysql:escape_string(reason) .. "' WHERE id = " .. exports.mysql:escape_string(uid)) then
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "admin:monitor", reason, false)
					outputChatBox("You added " .. name["username"] .. " to the monitor list.", sourcePlayer, 0, 255, 0)
				end
			end
		end
	end
end
addCommandHandler("omonitor2", offlineMonitorADD2)

addEvent("monitor:add", true)
addEventHandler("monitor:add", getRootElement( ),
	function( name, reason)
		if exports.global:isPlayerAdmin(client) or exports.global:isPlayerGameMaster(client) then
			offlineMonitorADD(client, "omonitor", name, reason)
		end
	end
)

addEvent("monitor:checkUsername", true)
addEventHandler("monitor:checkUsername", getRootElement( ),
	-- function( name, reason)
		-- if exports.global:isPlayerAdmin(client) or exports.global:isPlayerGameMaster(client) then
			-- offlineMonitorADD(client, "omonitor", name, reason)
		-- end
	-- end
	function (username)
		local name = mysql:query_fetch_assoc("SELECT `id`,`username`, `monitored` FROM `accounts` WHERE `username` = '" .. mysql:escape_string(username) .. "'" )
			if name then
				local uname = name["username"]
				local uid = name["id"]
				local month = getRealTime().month + 1
				local timeStr = tostring(getRealTime().monthday) .. "/" ..tostring(month)  
				--local reason =  table.concat({...}, " ") .. " (" .. getElementData(sourcePlayer, "account:username") .. " "..timeStr..")"
				
				triggerClientEvent()
			else
			
			
			end
	end
)

addEvent("monitor:remove", true)
addEventHandler("monitor:remove", getRootElement( ),
	function( )
		if exports.global:isPlayerAdmin(client) or exports.global:isPlayerGameMaster(client) then
			local staffUsername = getElementData(client, "account:username")
			local staffTitle = exports.global:getPlayerGMTitle(client)
			local playerUsername = getElementData(source, "account:username")
			local accountID = tonumber(getElementData(source, "account:id"))
			if exports.mysql:query_free("UPDATE accounts SET monitored = '' WHERE id = " .. exports.mysql:escape_string(accountID)) then
				exports['anticheat-system']:changeProtectedElementDataEx(source, "admin:monitor", false, false)
				outputChatBox("You removed " .. getPlayerName(source):gsub("_", " ") .. " from the monitor list.", client, 0, 255, 0)
				
				if exports.global:isPlayerAdmin(client) then
					staffTitle = exports.global:getPlayerAdminTitle(client)
				end
				exports.global:sendMessageToAdmins("[MONITOR] "..staffTitle.." "..staffUsername.." removed monitor on player '"..playerUsername.."'.")
				exports.global:sendMessageToGameMasters("[MONITOR] "..staffTitle.." "..staffUsername.." removed monitor on player '"..playerUsername.."'.")
				
				doMonitorList(client)
			end
		end
	end
)


--[[
function onCharacterLogin(characterName, factionID)
	local thePlayer = source
	local reason = getElementData(thePlayer, "admin:monitor")
	if reason and #reason > 0 then
		local playerAccount = getElementData(thePlayer, "account:username")
		local playerName = getPlayerName(thePlayer):gsub("_", " ")
		exports.global:sendMessageToAdmins("[MONITOR] Player '"..playerName.."' ("..playerAccount..") logged in. MR: "..reason)
	end
end
addEventHandler("onCharacterLogin", getRootElement(), onCharacterLogin)]]