-- BAN
function banAPlayer(thePlayer, commandName, targetPlayer, hours, ...)
	if getElementData(thePlayer, "account:username") == "pabloo50" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "alperen2124" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "HyperMC" or getElementData(thePlayer, "account:username") == "avsar" then 
		if not (targetPlayer) or not (hours) or (tonumber(hours)<0) or not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Time in Hours, 0 = Infinite] [Reason]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			local targetPlayerSerial = getPlayerSerial(targetPlayer)
			hours = tonumber(hours)
			
			if not (targetPlayer) then
			elseif (hours>168) then
				outputChatBox("You cannot ban for more than 7 days (168 Hours).", thePlayer, 255, 194, 14)
			else
				local thePlayerPower = exports.global:getPlayerAdminLevel(thePlayer)
				local targetPlayerPower = exports.global:getPlayerAdminLevel(targetPlayer)
				reason = table.concat({...}, " ")
				
				if (targetPlayerPower <= thePlayerPower) then -- Check the admin isn't banning someone higher rank them him
					local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
					local playerName = getPlayerName(thePlayer)
					local accountID = getElementData(targetPlayer, "account:id")
					
					local seconds = ((hours*60)*60)
					local rhours = hours
					-- text value
					if (hours==0) then
						hours = "Sınırsız"
					elseif (hours==1) then
						hours = "1 Saat"
					else
						hours = hours .. " Saat"
					end
					
					if hours == "Sınırsız" then
						reason = reason .. " - Yasaklanmanın yanlış olduğunu düşünoyrsanız Discord Sunucumuza ulaşın.(" .. hours .. ")"
					else
						reason = reason .. " (" .. hours .. ")"
					end
					reason = tostring(reason):gsub("'","''")
					
					mysql:query_free('INSERT INTO adminhistory (user_char, user, admin_char, admin, hiddenadmin, action, duration, reason) VALUES ("' .. mysql:escape_string(tostring(getPlayerName(targetPlayer)):gsub("'","''")) .. '",' .. mysql:escape_string(tostring(getElementData(targetPlayer, "account:id") or 0)) .. ',"' .. mysql:escape_string(tostring(getPlayerName(thePlayer)):gsub("'","''")) .. '",' .. mysql:escape_string(tostring(getElementData(thePlayer, "account:id") or 0)) .. ',' .. mysql:escape_string(hiddenAdmin) .. ',2,' .. mysql:escape_string(rhours) .. ',"' .. tostring(reason):gsub("'","''") .. '")' )
					local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
					local bannedUserName = getElementData(targetPlayer, "account:username")
					--createForumPost(playerName, adminTitle, targetPlayerName, bannedUserName, hours, reason)
					--Forum End
					
							local showingPlayer = nil
					if (hiddenAdmin==0) then
						if string.lower(commandName) == "sban" then
							exports.global:sendMessageToAdmins("BAN: " .. targetPlayerName .. ", " .. adminTitle .. " " .. playerName .. " Tarafından (" .. hours .. ") Sessiz Banlandı. ")
							exports.global:sendMessageToAdmins("BAN Sebebi: " .. reason .. ".")
						elseif string.lower(commandName) == "forceapp" or string.lower(commandName) == "hızlıban" then
							outputChatBox("#FFC000[HIZLI BAN]#FFFFFF " .. targetPlayerName .. ", #00FF00"..adminTitle .. " " .. playerName .. "#FFFFFF Tarafından Banlandı.", getRootElement(), 255, 0, 51, true)
							hours = "Süresiz"
							reason = "Sunucumuzun Kurallarına Uymadığınızdan Dolayı Banlandınız. Bizimle İletişime Geçebilirsiniz."
							outputChatBox("#FFC000[HIZLI BAN SEBEBİ] #FFFFFF" .. reason .. ".", getRootElement(), 255, 0, 51, true)
						else
							outputChatBox("#FFC000[BAN]#FFFFFF " .. targetPlayerName .. ", #00FF00" .. adminTitle .. " " .. playerName .. "#FFFFFF Tarafından #FFC000(" .. hours .. ")#FFFFFF Banlandı.", getRootElement(), 255, 0, 51, true)
							outputChatBox("#FFC000[BAN SEBEBİ]#FFFFFF " .. reason .. ".", getRootElement(), 255, 0, 51, true)
						end
						showingPlayer = thePlayer
						
						local ban = addBan(nil, nil, targetPlayerSerial, thePlayer, reason, seconds)
						--local ban = banPlayer(targetPlayer, false, false, true, thePlayer, reason, seconds)
						
						if (seconds == 0) then
							mysql:query_free("UPDATE accounts SET banned='1', banned_reason='" .. tostring(reason):gsub("'","''") .. "', banned_by='" .. mysql:escape_string(tostring(playerName):gsub("'","''")) .. "' WHERE id='" .. mysql:escape_string(accountID) .. "'")
						end
						local forumTitle = exports.mysql:escape_string(tostring(targetPlayerName):gsub("'","''") .. "/"..bannedUserName .. " (" .. hours .. ")")
						local firstID = exports.mysql:forum_query_insert_free("insert into post set threadid = '9999', parentid = '0', username = 'TamFire', userid = '1', title = '" .. forumTitle .. "', dateline = unix_timestamp(), pagetext = '[CENTER][uglogo]-[/uglogo][/CENTER][HR][/HR]<br>Player Name: " .. tostring(targetPlayerName):gsub("'","''") .. "<br>Player Account Name: " .. bannedUserName .. "<br>Banning Admin: " .. adminTitle .. " " .. playerName .. " (" .. getElementData(thePlayer, "account:username") .. ")<br>Reason: " .. reason.."<br><br> Note: Please make a reply to this post with any additional information you may have.<br><br><br>[SIZE=1][RIGHT]©Tam-Man 2013[/RIGHT][/SIZE]', allowsmilie = '1', showsignature = '0', ipaddress = '127.0.0.1', iconid = '0', visible = '1', attach = '0', infraction = '0', reportthreadid = '0'")
						local seccondID = exports.mysql:forum_query_insert_free("insert into thread set title = '" .. forumTitle .. "', firstpostid = '" .. firstID .. "', lastpostid = '19285', lastpost = unix_timestamp(), forumid = '47', pollid = '0', open = '1', replycount = '0', postercount = '1', hiddencount = '0', files112count = '0', postusername = 'TamFire', postuserid = '1', lastposter = 'TamFire', lastposterid = '1', dateline = unix_timestamp(), views = '0', iconid = '0', visible = '1', sticky = '0', votenum = '0', votetotal = '0', attach = '0', force_read = '0', force_read_order = '10', force_read_expire_date = '0'")
						exports.mysql:forum_query_free("update post set threadid = '"..seccondID.."' where postid = '"..firstID.."'")
						exports.mysql:forum_query_free("update `user` set posts = posts + 1 where userid = '1'")
						exports.mysql:forum_query_free("UPDATE forum set replycount = replycount + 1, lastpost = unix_timestamp(), lastposter = 'TamFire', lastposterid='1', lastpostid='"..firstID.."', lastthread='"..forumTitle.."', lastthreadid='"..seccondID.."', threadcount = threadcount + 1 WHERE forumid = 47")
						exports.mysql:forum_query_free("UPDATE forum set replycount = replycount + 1, lastpost = unix_timestamp(), lastposter = 'TamFire', lastposterid='1', lastpostid='"..firstID.."', lastthread='"..forumTitle.."' ,lastthreadid='"..seccondID.."', threadcount = threadcount + 1 WHERE forumid = 33")
						exports.mysql:forum_query_free("UPDATE forum set replycount = replycount + 1, lastpost = unix_timestamp(), lastposter = 'TamFire', lastposterid='1', lastpostid='"..firstID.."', lastthread='"..forumTitle.."' ,lastthreadid='"..seccondID.."', threadcount = threadcount + 1 WHERE forumid = 31")
						local link = "http://64.120.158.24/server/bansounds/"..math.random(1, 4)..".wav"
						for k, theAdministrator in ipairs(exports.global:getAdmins()) do
							triggerClientEvent(theAdministrator, "playSound", theAdministrator, link)
						end
						exports.global:sendMessageToAdmins("[TamMan] Ban topic created: http://www.unitedgaming.org/forums/showthread.php/"..seccondID)
					elseif (hiddenAdmin==1) then
						if string.lower(commandName) == "prosban" then
							exports.global:sendMessageToAdmins("TamMan: A Hidden Admin silently banned " .. targetPlayerName .. ". (" .. hours .. ")")
							exports.global:sendMessageToAdmins("TamMan: Reason: " .. reason .. ".")
						else
							outputChatBox("AdmBan: Hidden Admin banned " .. targetPlayerName .. ". (" .. hours .. ")", getRootElement(), 255, 0, 51)
							outputChatBox("AdmBan: Reason: " .. reason, getRootElement(), 255, 0, 51)
						end
						showingPlayer = getRootElement()
						
						local ban = addBan(nil, nil, targetPlayerSerial, thePlayer, reason, seconds)
						--local ban = banPlayer(targetPlayer, false, false, true, getRootElement(), reason, seconds)
						
						if (seconds == 0) then
							mysql:query_free("UPDATE accounts SET banned='1', banned_reason='" .. tostring(reason):gsub("'","''") .. "', banned_by='" .. mysql:escape_string(tostring(playerName):gsub("'","''")) .. "' WHERE id='" .. mysql:escape_string(accountID) .. "'")
						end
						local forumTitle = exports.mysql:escape_string(tostring(targetPlayerName):gsub("'","''") .. "/"..bannedUserName .. " (" .. hours .. ")")
						local firstID = exports.mysql:forum_query_insert_free("insert into post set threadid = '9999', parentid = '0', username = 'TamFire', userid = '1', title = '" .. forumTitle .. "', dateline = unix_timestamp(), pagetext = '[CENTER][uglogo]-[/uglogo][/CENTER][HR][/HR]<br>Player Name: " .. tostring(targetPlayerName):gsub("'","''") .. "<br>Player Account Name: " .. bannedUserName .. "<br>Banning Admin: " .. adminTitle .. " " .. playerName .. " (" .. getElementData(thePlayer, "account:username") .. ")<br>Reason: " .. reason.."<br><br> Note: Please make a reply to this post with any additional information you may have.<br><br><br>[SIZE=1][RIGHT]©Tam-Man 2013[/RIGHT][/SIZE]', allowsmilie = '1', showsignature = '0', ipaddress = '127.0.0.1', iconid = '0', visible = '1', attach = '0', infraction = '0', reportthreadid = '0'")
						local seccondID = exports.mysql:forum_query_insert_free("insert into thread set title = '" .. forumTitle .. "', firstpostid = '" .. firstID .. "', lastpostid = '19285', lastpost = unix_timestamp(), forumid = '47', pollid = '0', open = '1', replycount = '0', postercount = '1', hiddencount = '0', files112count = '0', postusername = 'TamFire', postuserid = '1', lastposter = 'TamFire', lastposterid = '1', dateline = unix_timestamp(), views = '0', iconid = '0', visible = '1', sticky = '0', votenum = '0', votetotal = '0', attach = '0', force_read = '0', force_read_order = '10', force_read_expire_date = '0'")
						exports.mysql:forum_query_free("update post set threadid = '"..seccondID.."' where postid = '"..firstID.."'")
						exports.mysql:forum_query_free("update `user` set posts = posts + 1 where userid = '1'")
						exports.mysql:forum_query_free("UPDATE forum set replycount = replycount + 1, lastpost = unix_timestamp(), lastposter = 'TamFire', lastposterid='1', lastpostid='"..firstID.."', lastthread='"..forumTitle.."', lastthreadid='"..seccondID.."', threadcount = threadcount + 1 WHERE forumid = 47")
						exports.mysql:forum_query_free("UPDATE forum set replycount = replycount + 1, lastpost = unix_timestamp(), lastposter = 'TamFire', lastposterid='1', lastpostid='"..firstID.."', lastthread='"..forumTitle.."' ,lastthreadid='"..seccondID.."', threadcount = threadcount + 1 WHERE forumid = 33")
						exports.mysql:forum_query_free("UPDATE forum set replycount = replycount + 1, lastpost = unix_timestamp(), lastposter = 'TamFire', lastposterid='1', lastpostid='"..firstID.."', lastthread='"..forumTitle.."' ,lastthreadid='"..seccondID.."', threadcount = threadcount + 1 WHERE forumid = 31")
						local link = "http://64.120.158.24/server/bansounds/"..math.random(1, 4)..".wav"
						for k, theAdministrator in ipairs(exports.global:getAdmins()) do
							triggerClientEvent(theAdministrator, "playSound", theAdministrator, link)
						end
						exports.global:sendMessageToAdmins("[TamMan] Ban topic created: http://www.unitedgaming.org/forums/showthread.php/"..seccondID)
					end
					for key, value in ipairs(getElementsByType("player")) do
						if getPlayerSerial(value) == targetPlayerSerial then
							kickPlayer(value, showingPlayer, reason)
						end
					end
				else
					outputChatBox(" This player is a higher level admin than you.", thePlayer, 255, 0, 0)
					outputChatBox(playerName .. " attempted to execute the ban command on you.", targetPlayer, 255, 0 ,0)
				end
			end
		end
	end
end
addCommandHandler("pban", banAPlayer, false, false)
addCommandHandler("pban", banAPlayer, false, false)

--FORCEAPP BY MAXIME
function forceAppPlayer(thePlayer, commandName, targetPlayer, ...)
	if not exports.global:isPlayerAdmin(thePlayer) and not exports.global:isPlayerFullGameMaster(thePlayer) then
		outputChatBox("Only Admins and GameMasters can access /"..commandName..".", thePlayer, 255, 0, 0)
		return false
	end
	
	if not (targetPlayer) or not (...) then
		outputChatBox("SYNTAX: /" .. commandName .. " [Player] [Reason to FA]", thePlayer, 255, 194, 14)
		outputChatBox("DESC: Force player that doesn't meet server standards -and- not willing to improve out of game.", thePlayer, 255, 194, 14)
		return false
	end

	local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
	local targetPlayerSerial = getPlayerSerial(targetPlayer)
	hours = 168 -- 1 week
	
	if not (targetPlayer) then
		outputChatBox("Player not found.", thePlayer, 255, 0, 0)
		return false
	end
	
	local thePlayerPower = exports.global:getPlayerAdminLevel(thePlayer)
	local targetPlayerPower = exports.global:getPlayerAdminLevel(targetPlayer)
	
	local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
	local playerName = getPlayerName(thePlayer)
	local adminUsername = getElementData(thePlayer, "account:username")
	local targetUsername = getElementData(targetPlayer, "account:username")
	local accountID = getElementData(targetPlayer, "account:id")
	
	if (targetPlayerPower > thePlayerPower) then -- Check the admin isn't banning someone higher rank them him
		outputChatBox(" This player is a higher level admin than you.", thePlayer, 255, 0, 0)
		outputChatBox(playerName .. " attempted to execute forceapp command on you.", targetPlayer, 255, 0 ,0)
		return false
	end
	
	local seconds = ((hours*60)*60)
	local rhours = hours
	-- text value
	hours = "7 days"
	reason = table.concat({...}, " ")
	
	mysql:query_free('INSERT INTO adminhistory (user_char, user, admin_char, admin, hiddenadmin, action, duration, reason) VALUES ("' .. mysql:escape_string(tostring(getPlayerName(targetPlayer)):gsub("'","''")) .. '",' .. mysql:escape_string(tostring(getElementData(targetPlayer, "account:id") or 0)) .. ',"' .. mysql:escape_string(tostring(getPlayerName(thePlayer)):gsub("'","''")) .. '",' .. mysql:escape_string(tostring(getElementData(thePlayer, "account:id") or 0)) .. ',' .. mysql:escape_string(hiddenAdmin) .. ',99,' .. mysql:escape_string(rhours) .. ',"' .. tostring(reason):gsub("'","''") .. '")' )
	
	local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
	if not exports.global:isPlayerAdmin(thePlayer) then
		adminTitle = exports.global:getPlayerGMTitle(thePlayer)
	end	
		
	local bannedUserName = getElementData(targetPlayer, "account:username")
	--Forum End
	
	local showingPlayer = nil
	local adminTitle1 = adminTitle
	local adminUsername1 = adminUsername
	if (hiddenAdmin==1) then
		adminTitle1 = "A Hidden"
		adminUsername1 = "Admin"
	end
	outputChatBox("[FA] "..adminTitle1 .. " " .. adminUsername1 .. " forced app " .. targetPlayerName .. ". (7 days)", getRootElement(), 255, 100, 150)
	reason = reason.." - Take time to improve yourself then appeal on www.unitedgaming.org."
	outputChatBox("[FA]: Reason: " .. reason, getRootElement(), 255, 100, 150)
	
	showingPlayer = thePlayer
	
	local ban = addBan(nil, nil, targetPlayerSerial, thePlayer, reason, seconds)
	
	if (seconds == 0) then
		mysql:query_free("UPDATE accounts SET banned='1', banned_reason='" .. tostring(reason):gsub("'","''") .. "', banned_by='" .. mysql:escape_string(tostring(playerName):gsub("'","''")) .. "' WHERE id='" .. mysql:escape_string(accountID) .. "'")
	end
	
	local forumTitle = exports.mysql:escape_string("[FORCE-APP] "..tostring(targetPlayerName):gsub("'","''") .. "/"..bannedUserName .. " (" .. hours .. ")")
	
	local firstID = exports.mysql:forum_query_insert_free("INSERT INTO `post` SET `threadid` = '9999', `parentid` = '0', `username` = 'Maxime', `userid` = '190', `title` = '"..forumTitle.."', `dateline` = unix_timestamp(), `pagetext` = '[CENTER][uglogo]-[/uglogo][/CENTER][HR][/HR]<br>Player Name: N/A<br>Player Account Name: "..targetUsername.."<br>Forced App By: "..adminTitle.." "..playerName.." ("..getElementData(thePlayer,"account:username")..")<br>Reason: "..reason.."<br><br> Note: Please make a reply to this post with any additional information you may have.<br>', `allowsmilie` = '1', `showsignature` = '0', `ipaddress` = '127.0.0.1', `iconid` = '0', `visible` = '1', `attach` = '0', `infraction` = '0', `reportthreadid` = '0'")
			
	local seccondID = exports.mysql:forum_query_insert_free("INSERT INTO `thread` SET `title` = '"..forumTitle.."', `firstpostid` = '"..firstID .."', `lastpostid` = '19285', `lastpost` = unix_timestamp(), `forumid` = '36', `pollid` = '0', `open` = '1', `replycount` = '0', `postercount` = '1', `hiddencount` = '0', `files112count` = '0', `postusername` = 'Maxime', `postuserid` = '190', `lastposter` = 'Maxime', `lastposterid` = '22', `dateline` = unix_timestamp(), `views` = '0', `iconid` = '0', `visible` = '1', `sticky` = '0', `votenum` = '0', `votetotal` = '0', `attach` = '0', `force_read` = '0', `force_read_order` = '10', `force_read_expire_date` = '0'")
	
	exports.mysql:forum_query_free("UPDATE `post` SET `threadid` = '"..seccondID.."' WHERE `postid` = '"..firstID.."'")
	
	exports.mysql:forum_query_free("UPDATE `user` SET `posts` = `posts` + 1 WHERE `userid` = '190'")
	
	exports.mysql:forum_query_free("UPDATE `forum` SET `replycount` = `replycount` + 1, `lastpost` = unix_timestamp(), `lastposter` = 'Maxime', `lastposterid`='190', `lastpostid`='"..firstID.."', `lastthread`='"..forumTitle.."', `lastthreadid`='"..seccondID.."', `threadcount` = `threadcount` + 1 WHERE `forumid` = 36")
	
	exports.mysql:forum_query_free("UPDATE `forum` SET `replycount` = `replycount` + 1, `lastpost` = unix_timestamp(), `lastposter` = 'Maxime', `lastposterid`='190', `lastpostid`='"..firstID.."', `lastthread`='"..forumTitle.."' , `lastthreadid`='"..seccondID.."', `threadcount` = `threadcount` + 1 WHERE `forumid` = 33")
	
	exports.mysql:forum_query_free("UPDATE `forum` SET `replycount` = `replycount` + 1, `lastpost` = unix_timestamp(), `lastposter` = 'Maxime', `lastposterid`='190', `lastpostid`='"..firstID.."', `lastthread`='"..forumTitle.."' , `lastthreadid`='"..seccondID.."', `threadcount` = `threadcount` + 1 WHERE `forumid` = 31")
	
	exports.global:sendMessageToAdmins("[FA] Force-app topic created: http://www.unitedgaming.org/forums/showthread.php/"..seccondID)
	
	for key, value in ipairs(getElementsByType("player")) do
		if getPlayerSerial(value) == targetPlayerSerial then
			kickPlayer(value, showingPlayer, reason)
		end
	end
	
	return true
end
addCommandHandler("zproforceapp", forceAppPlayer, false, false)
addCommandHandler("zprofapp", forceAppPlayer, false, false)

--OFFLINE BAN BY MAXIME
function offlineBanAPlayer(thePlayer, commandName, targetUsername, hours, ...)
	if (exports.global:isPlayerAdmin(thePlayer) and string.lower(commandName) == "1zprooban") or (exports.global:isPlayerLeadAdmin(thePlayer) and string.lower(commandName) == "1zprosoban") then
		if not (targetUsername) or not (hours) or (tonumber(hours)<0) or not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Username] [Time in Hours, 0 = Infinite] [Reason]", thePlayer, 255, 194, 14)
		else
			hours = tonumber(hours) or 0
			if (hours>168) then
				outputChatBox("You cannot ban for more than 7 days (168 Hours).", thePlayer, 255, 194, 14)
				return false
			end
			
			local mQuery1 = mysql:query("SELECT `id`, `ip`, `mtaserial`, `admin`, `banned`, `banned_by`, `banned_reason` FROM `accounts` WHERE `username`='".. mysql:escape_string( targetUsername ) .."'")
			local row = {}
			if mQuery1 then
				row = mysql:fetch_assoc(mQuery1) or false
				mysql:free_result(mQuery1)
			end
			local targetIP, targetSerial, targetPlayerPower, targetAccountID, targetBanned = false
			if row then 
				targetIP = row["ip"]
				targetSerial = row["mtaserial"]
				targetPlayerPower = tonumber(row["admin"])
				targetAccountID = row["id"]
				targetBanned = tonumber(row["banned"])
				if targetBanned ~= 0 then
					local targetBannedBy = row["banned_by"] or "N/A"
					local targetBannedReason = row["banned_reason"] or "N/A"
					outputChatBox("'"..targetUsername.."' has already been banned.", thePlayer, 255, 194, 14)
					outputChatBox("IP: "..targetIP, thePlayer)
					outputChatBox("Serial: "..targetSerial, thePlayer)
					outputChatBox("Banned by: "..targetBannedBy, thePlayer)
					outputChatBox("Banned Reason: "..targetBannedReason, thePlayer)
					return false
				end
			else
				outputChatBox("Player Username not found!", thePlayer, 255, 194, 14)
				return false
			end
			
			local thePlayerPower = exports.global:getPlayerAdminLevel(thePlayer)
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
			local adminUsername = getElementData(thePlayer, "account:username" )
			if (targetPlayerPower > thePlayerPower) then 
				outputChatBox(" '"..targetUsername.."' is a higher level admin than you.", thePlayer, 255, 0, 0)
				exports.global:sendMessageToAdmins("AdmWrn: "..adminTitle.." ".. adminUsername .. " attempted to execute the ban command on higher admin '"..targetUsername.."'.")
				return false 
			end
			local reason = table.concat({...}, " ")
			local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
			local playerName = getPlayerName(thePlayer)
			
			local seconds = ((hours*60)*60)
			local rhours = hours
			-- text value
			if (hours==0) then
				hours = "Sınırsız"
			elseif (hours==1) then
				hours = "1 Saat"
			else
				hours = hours .. " Saat"
			end
			
			reason = reason .. " (" .. hours .. ")"
			reason = tostring(reason):gsub("'","''")
			
			mysql:query_free("INSERT INTO `adminhistory` (`user_char`, `user`, `admin_char`, `admin`, `hiddenadmin`, `action`, `duration`, `reason`) VALUES ('N/A', '"..mysql:escape_string(targetAccountID).."', '"..mysql:escape_string(tostring(getPlayerName(thePlayer)):gsub("'","''")).."', '"..mysql:escape_string(tostring(getElementData(thePlayer, "account:id") or 0)).."', '"..mysql:escape_string(hiddenAdmin).."', 2, '"..mysql:escape_string(rhours).."', '"..tostring(reason):gsub("'","''").."')")

			local showingPlayer = nil
			if (hiddenAdmin==0) then
				if string.lower(commandName) == "soban" then
					exports.global:sendMessageToAdmins("MaxBan: " .. adminTitle .. " " .. adminUsername .. " silently banned " .. targetUsername .. ". (" .. hours .. ")")
					exports.global:sendMessageToAdmins("MaxBan: Reason: " .. reason .. ".")
				else
					outputChatBox("BANHAMMER: " .. adminTitle .. " " .. adminUsername .. " banned " .. targetUsername .. ". (" .. hours .. ")", getRootElement(), 255, 0, 51)
					outputChatBox("BANHAMMER: Reason: " .. reason .. ".", getRootElement(), 255, 0, 51)
				end
				showingPlayer = thePlayer
				
				local ban = addBan(nil, nil, targetSerial, thePlayer, reason, seconds)
				
				if (seconds == 0) then
					mysql:query_free("UPDATE `accounts` SET `banned`='1', `banned_reason`='" .. tostring(reason):gsub("'","''") .. "',  `banned_by`='" .. mysql:escape_string(tostring(playerName):gsub("'","''")) .. "' WHERE `id`='" .. mysql:escape_string(targetAccountID) .. "'")
				end
				
				local forumTitle = exports.mysql:escape_string("[Offline Ban] "..targetUsername .. " (" .. hours .. ")")
				local firstID = exports.mysql:forum_query_insert_free("INSERT INTO `post` SET `threadid` = '9999', `parentid` = '0', `username` = 'Maxime', `userid` = '190', `title` = '"..forumTitle.."', `dateline` = unix_timestamp(), `pagetext` = '[CENTER][uglogo]-[/uglogo][/CENTER][HR][/HR]<br>Player Name: N/A<br>Player Account Name: "..targetUsername.."<br>Banning Admin: "..adminTitle.." "..playerName.." ("..getElementData(thePlayer,"account:username")..")<br>Reason: "..reason.."<br><br> Note: Please make a reply to this post with any additional information you may have.<br>', `allowsmilie` = '1', `showsignature` = '0', `ipaddress` = '127.0.0.1', `iconid` = '0', `visible` = '1', `attach` = '0', `infraction` = '0', `reportthreadid` = '0'")
				
				local seccondID = exports.mysql:forum_query_insert_free("INSERT INTO `thread` SET `title` = '"..forumTitle.."', `firstpostid` = '"..firstID .."', `lastpostid` = '19285', `lastpost` = unix_timestamp(), `forumid` = '36', `pollid` = '0', `open` = '1', `replycount` = '0', `postercount` = '1', `hiddencount` = '0', `files112count` = '0', `postusername` = 'Maxime', `postuserid` = '190', `lastposter` = 'Maxime', `lastposterid` = '22', `dateline` = unix_timestamp(), `views` = '0', `iconid` = '0', `visible` = '1', `sticky` = '0', `votenum` = '0', `votetotal` = '0', `attach` = '0', `force_read` = '0', `force_read_order` = '10', `force_read_expire_date` = '0'")
				
				exports.mysql:forum_query_free("UPDATE `post` SET `threadid` = '"..seccondID.."' WHERE `postid` = '"..firstID.."'")
				
				exports.mysql:forum_query_free("UPDATE `user` SET `posts` = `posts` + 1 WHERE `userid` = '190'")
				
				exports.mysql:forum_query_free("UPDATE `forum` SET `replycount` = `replycount` + 1, `lastpost` = unix_timestamp(), `lastposter` = 'Maxime', `lastposterid`='190', `lastpostid`='"..firstID.."', `lastthread`='"..forumTitle.."', `lastthreadid`='"..seccondID.."', `threadcount` = `threadcount` + 1 WHERE `forumid` = 36")
				
				exports.mysql:forum_query_free("UPDATE `forum` SET `replycount` = `replycount` + 1, `lastpost` = unix_timestamp(), `lastposter` = 'Maxime', `lastposterid`='190', `lastpostid`='"..firstID.."', `lastthread`='"..forumTitle.."' , `lastthreadid`='"..seccondID.."', `threadcount` = `threadcount` + 1 WHERE `forumid` = 33")
				
				exports.mysql:forum_query_free("UPDATE `forum` SET `replycount` = `replycount` + 1, `lastpost` = unix_timestamp(), `lastposter` = 'Maxime', `lastposterid`='190', `lastpostid`='"..firstID.."', `lastthread`='"..forumTitle.."' , `lastthreadid`='"..seccondID.."', `threadcount` = `threadcount` + 1 WHERE `forumid` = 31")
				
				exports.global:sendMessageToAdmins("[MaxBan] Ban topic created: http://www.unitedgaming.org/forums/showthread.php/"..seccondID)
			elseif (hiddenAdmin==1) then
				if string.lower(commandName) == "soban" then
					exports.global:sendMessageToAdmins("BANHAMMER: A Hidden Admin silently banned " .. targetUsername .. ". (" .. hours .. ")")
					exports.global:sendMessageToAdmins("BANHAMMER: Reason: " .. reason .. ".")
				else
					outputChatBox("AdmBan: Hidden Admin banned " .. targetUsername .. ". (" .. hours .. ")", getRootElement(), 255, 0, 51)
					outputChatBox("AdmBan: Reason: " .. reason, getRootElement(), 255, 0, 51)
				end
				showingPlayer = getRootElement()
				
				local ban = addBan(nil, nil, targetSerial, thePlayer, reason, seconds)
				
				if (seconds == 0) then
					mysql:query_free("UPDATE `accounts` SET `banned`='1', `banned_reason`='" .. tostring(reason):gsub("'","''") .. "', `banned_by`='" .. mysql:escape_string(tostring(playerName):gsub("'","''")) .. "' WHERE `id`='" .. mysql:escape_string(tostring(targetAccountID)) .. "'")
				end
				
				local forumTitle = exports.mysql:escape_string("[Offline Ban] "..targetUsername .. " (" .. hours .. ")")
				local firstID = exports.mysql:forum_query_insert_free("INSERT INTO `post` SET `threadid` = '9999', `parentid` = '0', `username` = 'Maxime', `userid` = '190', `title` = '"..forumTitle.."', `dateline` = unix_timestamp(), `pagetext` = '[CENTER][uglogo]-[/uglogo][/CENTER][HR][/HR]<br>Player Name: N/A<br>Player Account Name: "..targetUsername.."<br>Banning Admin: "..adminTitle.." "..playerName.." ("..getElementData(thePlayer,"account:username")..")<br>Reason: "..reason.."<br><br> Note: Please make a reply to this post with any additional information you may have.<br>', `allowsmilie` = '1', `showsignature` = '0', `ipaddress` = '127.0.0.1', `iconid` = '0', `visible` = '1', `attach` = '0', `infraction` = '0', `reportthreadid` = '0'")
				
				local seccondID = exports.mysql:forum_query_insert_free("INSERT INTO `thread` SET `title` = '"..forumTitle.."', `firstpostid` = '"..firstID .."', `lastpostid` = '19285', `lastpost` = unix_timestamp(), `forumid` = '36', `pollid` = '0', `open` = '1', `replycount` = '0', `postercount` = '1', `hiddencount` = '0', `files112count` = '0', `postusername` = 'Maxime', `postuserid` = '190', `lastposter` = 'Maxime', `lastposterid` = '22', `dateline` = unix_timestamp(), `views` = '0', `iconid` = '0', `visible` = '1', `sticky` = '0', `votenum` = '0', `votetotal` = '0', `attach` = '0', `force_read` = '0', `force_read_order` = '10', `force_read_expire_date` = '0'")
				
				exports.mysql:forum_query_free("UPDATE `post` SET `threadid` = '"..seccondID.."' WHERE `postid` = '"..firstID.."'")
				
				exports.mysql:forum_query_free("UPDATE `user` SET `posts` = `posts` + 1 WHERE `userid` = '190'")
				
				exports.mysql:forum_query_free("UPDATE `forum` SET `replycount` = `replycount` + 1, `lastpost` = unix_timestamp(), `lastposter` = 'Maxime', `lastposterid`='190', `lastpostid`='"..firstID.."', `lastthread`='"..forumTitle.."', `lastthreadid`='"..seccondID.."', `threadcount` = `threadcount` + 1 WHERE `forumid` = 36")
				
				exports.mysql:forum_query_free("UPDATE `forum` SET `replycount` = `replycount` + 1, `lastpost` = unix_timestamp(), `lastposter` = 'Maxime', `lastposterid`='190', `lastpostid`='"..firstID.."', `lastthread`='"..forumTitle.."' , `lastthreadid`='"..seccondID.."', `threadcount` = `threadcount` + 1 WHERE `forumid` = 33")
				
				exports.mysql:forum_query_free("UPDATE `forum` SET `replycount` = `replycount` + 1, `lastpost` = unix_timestamp(), `lastposter` = 'Maxime', `lastposterid`='190', `lastpostid`='"..firstID.."', `lastthread`='"..forumTitle.."' , `lastthreadid`='"..seccondID.."', `threadcount` = `threadcount` + 1 WHERE `forumid` = 31")
				
				exports.global:sendMessageToAdmins("[MaxBan] Ban topic created: http://www.unitedgaming.org/forums/showthread.php/"..seccondID)
			end
			for key, value in ipairs(getElementsByType("player")) do
				if getPlayerSerial(value) == targetSerial then
					kickPlayer(value, showingPlayer, reason)
				end
			end
		end
	end
end
addCommandHandler("1zprooban", offlineBanAPlayer, false, false)
addCommandHandler("1zprosoban", offlineBanAPlayer, false, false)


-- /UNBAN
function unbanPlayer(thePlayer, commandName, ...)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player username/IP/Serial]", thePlayer, 255, 194, 14)
		else
			local searchString = table.concat({...}, " ")
			local searchStringM =  string.gsub(searchString, " ", "_")
			local accountID = nil
			local searchCode = "UN" 
			local localBan = nil
			
			-- Try on account name or serial or ip
			if not accountID then
				local accountSearch = mysql:query_fetch_assoc("SELECT `id` FROM `accounts` WHERE `username`='" .. mysql:escape_string(tostring(searchString)) .. "' or `mtaserial`='" .. mysql:escape_string(tostring(searchString)) .. "' or `ip`='" .. mysql:escape_string(tostring(searchString)) .. "' LIMIT 1")
				if accountSearch then
					accountID = accountSearch["id"]
					searchCode = "DA"
				end
			end
			
			-- Try on character name
			if not accountID then
				
				local characterSearch = mysql:query_fetch_assoc("SELECT `account` FROM `characters` WHERE `charactername`='" .. mysql:escape_string(tostring(searchStringM)) .. "' LIMIT 1")
				if characterSearch then
					accountID = characterSearch["account"]
					searchCode = "DC"
				end
			end
			
			-- Check local
			if not accountID then
				for _, banElement in ipairs(getBans()) do
					if (getBanSerial(banElement) == searchString) then
						accountID = -1
						searchCode = "XS"
						localBan = banElement
						break
					end
					
					if (getBanIP(banElement) == searchString) then
						accountID = -1
						searchCode = "XI"
						localBan = banElement
						break
					end
					
					if (getBanNick(banElement) == searchStringM) then
						accountID = -1
						searchCode = "XN"
						localBan = banElement
						break
					end
				end
			end
			
			if not accountID then
				outputChatBox("No ban found for '" .. searchString .. "'", thePlayer, 255, 0, 0)
				return
			end
			
			if (accountID == -1 and localBan) then
				local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
				if hiddenAdmin == 0 then
					exports.global:sendMessageToAdmins("[TamMan] "..getBanNick(localBan) .. "/"..getBanSerial(localBan).." was unbanned by " .. getPlayerName(thePlayer) .. ". (S: ".. searchCode ..")")
				else
					exports.global:sendMessageToAdmins("[TamMan] "..getBanNick(localBan) .. "/"..getBanSerial(localBan).." was unbanned by a Hidden Admin. (S: ".. searchCode ..")")
				end
				removeBan( localBan )
				return
			end
			
			-- Get ban details
			local banDetails = mysql:query_fetch_assoc("SELECT `ip`, `mtaserial`, `username`, `id`, `banned` FROM `accounts` WHERE `id`='" .. mysql:escape_string(tostring(accountID)) .. "' LIMIT 1")
			if banDetails then 
			
				-- Check local
				local unbannedSomething = false
				for _, banElement in ipairs(getBans()) do
					local unban = false
					if (getBanSerial(banElement) == banDetails["mtaserial"]) then
						searchCode = searchCode .. "-XS"
						unban = true
					end
					
					if (getBanIP(banElement) == banDetails["ip"]) then
						searchCode = searchCode .. "-IS"
						unban = true
					end
					
					if unban then
						removeBan(banElement)		
						unbannedSomething = true
					end
				end
				
				if not (unbannedSomething) and not (banDetails["banned"] == 1) then
					outputChatBox("No ban found for '" .. searchString .. "'", thePlayer, 255, 0, 0)
				else
					local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
					if hiddenAdmin == 0 then
						exports.global:sendMessageToAdmins("[BanMan] "..banDetails["username"] .. "/"..banDetails["mtaserial"].."/".. banDetails["id"] .." was unbanned by " .. getPlayerName(thePlayer) .. ". (S: ".. searchCode ..")")
					else
						exports.global:sendMessageToAdmins("[BanMan] "..banDetails["username"] .. "/"..banDetails["mtaserial"].."/".. banDetails["id"] .." was unbanned by a Hidden Admin. (S: ".. searchCode ..")")
					end
					mysql:query_free('INSERT INTO adminhistory (user_char, user, admin_char, admin, hiddenadmin, action, duration, reason) VALUES ("'..mysql:escape_string(banDetails["username"])..'",' ..accountID .. ',"' .. mysql:escape_string(tostring(getPlayerName(thePlayer)):gsub("'","''")) .. '",' .. mysql:escape_string(tostring(getElementData(thePlayer, "account:id") or 0)) .. ',0,2,0,"UNBAN")' )
					mysql:query_free("UPDATE accounts SET banned='0', banned_by=NULL, banned_reason=NULL WHERE id='" .. mysql:escape_string(banDetails["id"]) .. "'")
				end
			end
		end
	end
end
addCommandHandler("unban", unbanPlayer, false, false)

-- /UNBANIP
function unbanPlayerIP(thePlayer, commandName, ip)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (ip) then
			outputChatBox("SYNTAX: /" .. commandName .. " [IP]", thePlayer, 255, 194, 14)
		else
			ip = mysql:escape_string(ip)
			local bans = getBans()
			local found = false
				
			for key, value in ipairs(bans) do
				if (ip==getBanIP(value)) then
					local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
					if hiddenAdmin == 0 then
						exports.global:sendMessageToAdmins(tostring(ip) .. " was unbanned by " .. getPlayerName(thePlayer) .. ".")
					else
						exports.global:sendMessageToAdmins(tostring(ip) .. " was unbanned by a Hidden Admin.")
					end
					removeBan(value, thePlayer)
					mysql:query_free("UPDATE accounts SET banned='0', banned_by=NULL WHERE ip='" .. mysql:escape_string(ip) .. "'")
					found = true
					--break
				end
			end
			
			local query = mysql:query_fetch_assoc("SELECT COUNT(*) as number FROM accounts WHERE ip = '" .. mysql:escape_string(ip) .. "' AND banned = 1")
			if tonumber(query["number"]) > 0 then
				mysql:query_free("UPDATE accounts SET banned='0', banned_by=NULL WHERE ip='" .. mysql:escape_string(ip) .. "'")
				found = true
			end
			
			if found then
				outputChatBox("Unbanned ip '" .. ip .. "'", thePlayer, 255, 0, 0)
			else
				outputChatBox("No ban found for '" .. ip .. "'", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("unbanip", unbanPlayerIP, false, false)

-- /UNBANIP
function unbanPlayerSerial(thePlayer, commandName, ip)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (ip) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Serial]", thePlayer, 255, 194, 14)
		else
			ip = mysql:escape_string(ip)
			local bans = getBans()
			local found = false
				
			for key, value in ipairs(bans) do
				local bannedSerial = getBanSerial(value) or ""
				if (ip==bannedSerial) then
					local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
					if hiddenAdmin == 0 then
						exports.global:sendMessageToAdmins(tostring(ip) .. " was unbanned by " .. getPlayerName(thePlayer) .. ".")
					else
						exports.global:sendMessageToAdmins(tostring(ip) .. " was unbanned by a Hidden Admin.")
					end
					removeBan(value, thePlayer)
					mysql:query_free("UPDATE accounts SET banned='0', banned_by=NULL WHERE mtaserial='" .. mysql:escape_string(ip) .. "'")
					found = true
					--break
				end
			end
			
			local query = mysql:query_fetch_assoc("SELECT COUNT(*) as number FROM accounts WHERE mtaserial = '" .. mysql:escape_string(ip) .. "' AND banned = 1")
			if tonumber(query["number"]) > 0 then
				mysql:query_free("UPDATE accounts SET banned='0', banned_by=NULL WHERE mtaserial='" .. mysql:escape_string(ip) .. "'")
				found = true
			end
			
			if found then
				outputChatBox("Unbanned serial '" .. ip .. "'", thePlayer, 255, 0, 0)
			else
				outputChatBox("No ban found for '" .. ip .. "'", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("unbanserial", unbanPlayerSerial, false, false)


function checkForTamManBan(dummy1, dummy2, dummy3, MTAserial)
	local result = exports.mysql:query("SELECT username FROM accounts WHERE mtaserial = '" .. exports.mysql:escape_string(MTAserial) .. "' and banned=1")
	if exports.mysql:num_rows(result) > 0 then
		cancelEvent(true, "You are banned from this server.")
		local row = exports.mysql:fetch_assoc(result)
		exports.global:sendMessageToAdmins("[TamMan] Rejected connection from " .. row["username"] .. "/" .. MTAserial .." as this user currently has TamMan bans against them.")
	end
	exports.mysql:free_result(result)
end
addEventHandler("onPlayerConnect", getRootElement(), checkForTamManBan)