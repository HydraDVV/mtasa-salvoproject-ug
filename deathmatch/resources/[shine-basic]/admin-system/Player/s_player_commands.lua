mysql = exports.mysql
local getPlayerName_ = getPlayerName
getPlayerName = function( ... )
	s = getPlayerName_( ... )
	return s and s:gsub( "_", " " ) or s
end

MTAoutputChatBox = outputChatBox
function outputChatBox( text, visibleTo, r, g, b, colorCoded )
	if string.len(text) > 128 then -- MTA Chatbox size limit
		MTAoutputChatBox( string.sub(text, 1, 127), visibleTo, r, g, b, colorCoded  )
		outputChatBox( string.sub(text, 128), visibleTo, r, g, b, colorCoded  )
	else
		MTAoutputChatBox( text, visibleTo, r, g, b, colorCoded  )
	end
end

--ban banPlayerSerial ( player bannedPlayer,  player responsiblePlayer = nil, string reason = nil, bool hide = false )
function banPlayerSerial(thePlayer, theAdmin, reason, hide)
	local serial = getPlayerSerial(thePlayer)
	local result = mysql:query("SELECT * FROM bannedSerials")
	if result then
		while true do
			local row = mysql:fetch_assoc(result)
			if not row then break end
			if row["serial"] == serial then
				exports.global:sendMessageToAdmins("BAN-SYSTEM: Player " .. getPlayerName(thePlayer):gsub("_", " ") .. " is already banned. Kicking the player")
				exports.global:sendMessageToAdmins("            Serial: " .. serial)
				kickPlayer(thePlayer, reason)
				return
			end
		end
	end
	local entry = mysql:query_free('INSERT INTO bannedSerials (serial) VALUES ("' .. mysql:escape_string(serial) .. '")' )
	if entry then
		if not hide then
			for key, value in ipairs(getElementsByType("player")) do
				outputChatBox(exports.global:getPlayerAdminTitle(theAdmin) .. " " .. getPlayerName(theAdmin):gsub("_"," ") .. " banned player " .. getPlayerName(thePlayer):gsub("_"," "), value, 255, 0, 0)
				outputChatBox("Reason: " .. reason, value, 255, 0, 0)
			end
		else
			outputChatBox("You have banned " .. getPlayerName(thePlayer):gsub("_"," ") .. " silently.", theAdmin, 0, 255, 0)
			exports.global:sendMessageToAdmins("ADM-WARN: " .. getPlayerName(theAdmin):gsub("_"," ") .. " banned player " .. getPlayerName(thePlayer):gsub("_"," ") .. " silently.")
			exports.global:sendMessageToAdmins("          Reason: " .. reason)
		end
		kickPlayer(thePlayer, theAdmin, reason)
		exports.global:updateBans()
		for key, value in ipairs(getElementsByType("player")) do
			if getPlayerSerial(value) == serial then
				kickPlayer(value, showingPlayer, reason)
			end
		end
	else
		outputDebugString("ERROR BANNING PLAYER BY SERIAL!")
	end
end
		


addCommandHandler("saatd",function(oyuncu,cmd,hour, minute )
	setTime(hour,0)
end)
	

--/AUNCUFF
function adminUncuff(thePlayer, commandName, targetPlayer)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				local username = getPlayerName(thePlayer)
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				else
					local restrain = getElementData(targetPlayer, "restrain")
					
					if (restrain==0) then
						outputChatBox("Player is not restrained.", thePlayer, 255, 0, 0)
					else
						local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
						if hiddenAdmin == 0 then
							outputChatBox("You have been uncuffed by " .. username .. ".", targetPlayer)
						else
							outputChatBox("You have been uncuffed by a Hidden Admin.", targetPlayer)
						end
						outputChatBox("You have uncuffed " .. targetPlayerName .. ".", thePlayer)
						toggleControl(targetPlayer, "sprint", true)
						toggleControl(targetPlayer, "fire", true)
						toggleControl(targetPlayer, "jump", true)
						toggleControl(targetPlayer, "next_weapon", true)
						toggleControl(targetPlayer, "previous_weapon", true)
						toggleControl(targetPlayer, "accelerate", true)
						toggleControl(targetPlayer, "brake_reverse", true)
						toggleControl(targetPlayer, "aim_weapon", true)
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "restrain", 0, true)
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "restrainedBy", false, true)
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "restrainedObj", false, true)
						exports.global:removeAnimation(targetPlayer)
						mysql:query_free("UPDATE characters SET cuffed = 0, restrainedby = 0, restrainedobj = 0 WHERE id = " .. mysql:escape_string(getElementData( targetPlayer, "dbid" )) )
						exports['item-system']:REMAJORAll(47, getElementData( targetPlayer, "dbid" ))
						exports.logs:dbLog(thePlayer, 4, targetPlayer, "UNCUFF")
					end
				end
			end
		end
	end
end
addCommandHandler("auncuff", adminUncuff, false, false)
function nudgePlayer(thePlayer, commandName, targetPlayer)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not targetPlayer then
			outputChatBox("id yazmadın", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			if not targetPlayer then
				return false
			end		
			local logged = getElementData(targetPlayer, "loggedin")
			if (logged==0) then
			   outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
			else
				triggerClientEvent ( "playNudgeSound", targetPlayer)
				outputChatBox("" .. targetPlayerName .. " isimli oyuncuyu dürttün.", thePlayer)
				outputChatBox("" .. getPlayerName(thePlayer) .. " isimli yetkili seni dürttü.", targetPlayer)
			end
		end
	end
end
--addCommandHandler("nudge", nudgePlayer, false, false)
addCommandHandler("durt", nudgePlayer, false, false)


function ahlatPlayer(thePlayer, commandName, targetPlayer)
	if (exports.global:isPlayerAdmin(thePlayer)) then
			if not (targetPlayer) then
			outputChatBox("[*] SÖZDİZİMİ: /" .. commandName .. " [Oyuncu İsmi / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			if not targetPlayer then
				return false
			end
			local logged = getElementData(targetPlayer, "loggedin")
			--if (getElementData(targetPlayer, "admin_level") > 0) or (getElementData(targetPlayer, "sup_level") > 0) then
			if (logged==0) then
				outputChatBox("Oyuncu oyunda değil.",thePlayer)
			   --exports["ed_infobox"]:addBox(thePlayer, "error", "Bu oyuncu oyunda değil.")			
			   else
				triggerClientEvent ( "ahlayanSesi", targetPlayer)
				outputChatBox("#575757ANKA:#f9f9f9 '" .. targetPlayerName .. "' isimli oyuncuyu ahlatarak dürttünüz.", thePlayer, 255, 194, 14, true)
				outputChatBox("[-]#f9f9f9 '" .. getPlayerName(thePlayer) .. "' isimli yetkili tarafından ahlayarak dürtüldünüz.", targetPlayer, 255,0,0,true)
			end
			--else
				--outputChatBox("[-]#f9f9f9 Hedef oyuncu yetkili değil.", thePlayer, 255, 0, 0,true)
			--end
		end
	end
end
addCommandHandler("ahver", ahlatPlayer, false, false)

function oB(thePlayer, commandName, aracid)
    local veh = exports.pool:getElement("vehicle", aracid)
    local aracid = tonumber(aracid)
    if exports.global:isPlayerAdmin(thePlayer) then
        if not aracid then
            outputChatBox("SYNTAX: /"..commandName.." [Fixlenecek Araç ID]",thePlayer)
        else
            if veh then
            exports['anticheat-system']:changeProtectedElementDataEx(veh, "dimension", tonumber(aracid))
			--local query = mysql:query_free(exports.mysql:getConnection(), "UPDATE vehicles SET dimension='5' WHERE id='" .. mysql:escape_string(aracid) .. "'")
			local query = dbExec(exports.mysql:getConnection(), "UPDATE vehicles SET dimension='5' WHERE id='" ..tostring(aracid).. "'")
			--dene
            outputChatBox("#"..aracid.." ID'li araç başarıyla FİX'lendi.",thePlayer)
            setElementDimension(veh,5)
            else
                outputChatBox("Böyle bir araç bulunamadı :(",thePlayer,255,0,0)
            end
        end 
    end
end
addCommandHandler("fv", oB)

--/AUNMASK
function adminUnmask(thePlayer, commandName, targetPlayer)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				local username = getPlayerName(thePlayer)
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				else
					local any = false
					local masks = exports['item-system']:getMasks()
					for key, value in pairs(masks) do
						if getElementData(targetPlayer, value[1]) then
							any = true
							exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, value[1], false, true)
						end
					end
					
					if any then
						local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
						if hiddenAdmin == 0 then
							outputChatBox("Your mask has been removed by admin "..username, targetPlayer, 255, 0, 0)
						else
							outputChatBox("Your mask has been removed by a Hidden Admin", targetPlayer, 255, 0, 0)
						end
						outputChatBox("You have removed the mask from " .. targetPlayerName .. ".", thePlayer, 255, 0, 0)
						exports.logs:dbLog(thePlayer, 4, targetPlayer, "UNMASK")
					else
						outputChatBox("Player is not masked.", thePlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("aunmask", adminUnmask, false, false)

function adminUnblindfold(thePlayer, commandName, targetPlayer)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				local username = getPlayerName(thePlayer)
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				else
					local blindfolded = getElementData(targetPlayer, "rblindfold")
					
					if (blindfolded==0) then
						outputChatBox("Player is not blindfolded", thePlayer, 255, 0, 0)
					else
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "blindfold", false, false)
						fadeCamera(targetPlayer, true)
						outputChatBox("You have unblindfolded " .. targetPlayerName .. ".", thePlayer)
						local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
						if hiddenAdmin == 0 then
							outputChatBox("You have been unblindfolded by admin " .. username .. ".", thePlayer)
						else
							outputChatBox("You have been unblindfolded by a Hidden Admin.", thePlayer)
						end
						mysql:query_free("UPDATE characters SET blindfold = 0 WHERE id = " .. mysql:escape_string(getElementData( targetPlayer, "dbid" )) )
						exports.logs:dbLog(thePlayer, 4, targetPlayer, "UNBLINDFOLD")
					end
				end
			end
		end
	end
end
addCommandHandler("aunblindfold", adminUnblindfold, false, false)

-- /MUTE
function mutePlayer(thePlayer, commandName, targetPlayer)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				else
					local muted = getElementData(targetPlayer, "muted") or 0
					local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
					if muted == 0 then
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "muted", 1, false)
						outputChatBox(targetPlayerName .. " is now muted from OOC.", thePlayer, 255, 0, 0)
						if hiddenAdmin == 0 then
							outputChatBox("You were muted by '" .. getPlayerName(thePlayer) .. "'.", targetPlayer, 255, 0, 0)
						else
							outputChatBox("You were muted by a Hidden Admin.", targetPlayer, 255, 0, 0)
						end
						exports.logs:dbLog(thePlayer, 4, targetPlayer, "MUTE")
					else
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "muted", 0, false)
						outputChatBox(targetPlayerName .. " is now unmuted from OOC.", thePlayer, 0, 255, 0)
						
						if hiddenAdmin == 0 then
							outputChatBox("You were unmuted by '" .. getPlayerName(thePlayer) .. "'.", targetPlayer, 0, 255, 0)
						else
							outputChatBox("You were unmuted by a Hidden Admin.", targetPlayer, 0, 255, 0)
						end
						exports.logs:dbLog(thePlayer, 4, targetPlayer, "UNMUTE")
					end
					mysql:query_free("UPDATE accounts SET muted=" .. mysql:escape_string(getElementData(targetPlayer, "muted")) .. " WHERE id = " .. mysql:escape_string(getElementData(targetPlayer, "account:id")) )
				end
			end
		end
	end
end
addCommandHandler("pmute", mutePlayer, false, false)

-- /DISARM
function disarmPlayer(thePlayer, commandName, targetPlayer)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (logged==1) then
					for i = 115, 116 do
						while exports['item-system']:takeItem(targetPlayer, i) do
						end
					end
					local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
					local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
					if (hiddenAdmin==0) then
						exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " has disarmed " .. targetPlayerName..".")
						outputChatBox("[!] Materleyleriniz silindi, silen admin : "..tostring(adminTitle) .. " " .. getPlayerName(thePlayer)..".", targetPlayer, 255, 0, 0)
					else
						exports.global:sendMessageToAdmins("AdmCmd: A Hidden Admin has disarmed " .. targetPlayerName..".")
						outputChatBox("[!]Gizli bir yönetici tarafından üzerinizdeki tüm illegaller materyallere el konuldu!", targetPlayer, 255, 203, 0)
					end	
					outputChatBox(targetPlayerName .. " is now disarmed.", thePlayer, 255, 0, 0)
					exports.logs:dbLog(thePlayer, 4, targetPlayer, "DISARM")
				end
			end
		end
	end
end
addCommandHandler("Salvodisarm", disarmPlayer, false, false)

--[[ FORCEAPP
function forceApplication(thePlayer, commandName, targetPlayer, ...)
	if (exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerLeadGameMaster(thePlayer)) then
		if not (targetPlayer) or not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick/ID] [Reason]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if not (targetPlayer) then
			elseif exports.global:isPlayerAdmin(targetPlayer) then
				outputChatBox("No.", thePlayer, 255, 0, 0)
			else
				local logged = getElementData(targetPlayer, "loggedin")
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (logged==1) then
					local reason = table.concat({...}, " ")
					local id = getElementData(targetPlayer, "account:id")
					local username = getElementData(thePlayer, "account:username")
					mysql:query_free("UPDATE accounts SET appstate = 2, appreason='" .. mysql:escape_string(reason) .. "', appdatetime = NOW() + INTERVAL 1 DAY, monitored = 'Forceapped for " .. mysql:escape_string(reason) .. "' WHERE id='" .. mysql:escape_string(id) .. "'")
					outputChatBox(targetPlayerName .. " was forced to re-write their application.", thePlayer, 255, 194, 14)
					
					local port = getServerPort()
					local password = getServerPassword()
					
					local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
					exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " sent " .. targetPlayerName .. " back to the application stage.")
					
					local res = mysql:query_free('INSERT INTO adminhistory (user_char, user, admin_char, admin, hiddenadmin, action, duration, reason) VALUES ("' .. mysql:escape_string(getPlayerName(targetPlayer)) .. '",' .. mysql:escape_string(tostring(getElementData(targetPlayer, "account:id") or 0)) .. ',"' .. mysql:escape_string(getPlayerName(thePlayer)) .. '",' .. mysql:escape_string(tostring(getElementData(thePlayer, "account:id") or 0)) .. ',0,3,0,"' .. mysql:escape_string(reason) .. '")' )
					
					kickPlayer(targetPlayer, getRootElement( ), "Please rewrite your application at mta.vg")
					exports.logs:dbLog(thePlayer, 4, targetPlayer, "FORCEAPP " .. reason)
				end
			end
		end
	end
end
addCommandHandler("forceapp", forceApplication, false, false)
]]

-- /FRECONNECT
function forceReconnect(thePlayer, commandName, targetPlayer)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
				local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
				local adminName = getPlayerName(thePlayer)
				if (hiddenAdmin==0) then
					exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. adminName .. " reconnected " .. targetPlayerName )
				else
					adminTitle = ""
					adminName = "a hidden admin"
					exports.global:sendMessageToAdmins("AdmCmd: A hidden admin reconnected " .. targetPlayerName )
				end
				outputChatBox("Player '" .. targetPlayerName .. "' was forced to reconnect.", thePlayer, 255, 0, 0)
					
				local timer = setTimer(kickPlayer, 1000, 1, targetPlayer, getRootElement(), "You were forced to reconnect by "..tostring(adminTitle) .. " " .. adminName ..".")
				addEventHandler("onPlayerQuit", targetPlayer, function( ) killTimer( timer ) end)
				
				redirectPlayer ( targetPlayer )
				
				exports.logs:dbLog(thePlayer, 4, targetPlayer, "FRECONNECT")
			end
		end
	end
end
addCommandHandler("freeconnect", forceReconnect, false, false)
--addCommandHandler("frecjfsdjfısdjfıjsdfıjsıdjfwerewrw8478wer", forceReconnect, false, false)

-- /silahalsana
function givePlayerGun(thePlayer, commandName, targetPlayer, ...)
	if (exports.global:isPlayerLeadAdmin(thePlayer)) then
		local args = {...}
		if not (targetPlayer) or (#args < 1) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick/ID] [Weapon Name/ID]", thePlayer, 255, 194, 14)
			outputChatBox("     Give player a weapon.", thePlayer, 150, 150, 150)
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick/ID] [Weapon Name/ID] [Quantity]", thePlayer, 255, 194, 14)
			outputChatBox("     Give player an amount of weapons.", thePlayer, 150, 150, 150)
			outputChatBox("(Type /gunlist or hit F4 to open Weapon Creator)", thePlayer, 0, 255, 0)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local weaponID = tonumber(args[1])
				local weaponName = args[1]
				local quantity = tonumber(args[2])
				if weaponID == nil then
					local cWeaponName = weaponName:lower()
					if cWeaponName == "colt45" then 
						weaponID = 22
					elseif cWeaponName == "rocketlauncher" then 
						weaponID = 35
					elseif cWeaponName == "combatshotgun" then 
						weaponID = 27
					elseif cWeaponName == "fireextinguisher" then 
						weaponID = 42
					else
						if getWeaponIDFromName(cWeaponName) == false then
							outputChatBox("[silahalsana] Invalid Weapon Name/ID. Type /gunlist or hit F4 to open Weapon Creator.", thePlayer, 255, 0, 0)
							return
						else
							weaponID = getWeaponIDFromName(cWeaponName)
						end
					end
				end
				
				if getAmmoPerClip(weaponID) == "disabled" then
						outputChatBox("[silahalsana] Invalid Weapon Name/ID. Type /gunlist or hit F4 to open Weapon Creator.", thePlayer, 255, 0, 0)
						return
				end
				
				local logged = getElementData(targetPlayer, "loggedin")
				local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
				
				if (logged==0) then
					outputChatBox("[silahalsana] Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (logged==1) then		
					
					local adminDBID = tonumber(getElementData(thePlayer, "account:character:id"))
					local playerDBID = tonumber(getElementData(targetPlayer, "account:character:id"))
					
					if quantity == nil then
						quantity = 1
					end
					
					local maxAmountOfWeapons = tonumber(get( getResourceName( getThisResource( ) ).. '.maxAmountOfWeapons' ))
					if quantity > maxAmountOfWeapons then 
						quantity = maxAmountOfWeapons
						outputChatBox("[silahalsana] You can't give more than "..maxAmountOfWeapons.." weapons at a time. Trying to spawn "..maxAmountOfWeapons.."...", thePlayer, 150, 150, 150)
					end
					
					local count = 0
					local fails = 0
					local allSerials = ""
					local give, error = ""
					for variable = 1, quantity, 1 do
						local mySerial = exports.global:createWeaponSerial( 1, adminDBID, playerDBID)
						--outputChatBox(mySerial)
						give, error = exports.global:giveItem(targetPlayer, 115, weaponID..":"..mySerial..":"..getWeaponNameFromID(weaponID))
						if give then 
							exports.logs:dbLog(thePlayer, 4, targetPlayer, "GIVEWEAPON "..getWeaponNameFromID(weaponID).." "..tostring(mySerial))
							if count == 0 then
								allSerials = mySerial
							else
								allSerials = allSerials.."', '"..mySerial
							end
							count = count + 1
						else
							fails = fails + 1
						end
					end
					if count > 0 then 
						local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
						if (hiddenAdmin==0) then
							--Inform Spawner
							outputChatBox("[silahalsana] You have given (x"..count..") ".. getWeaponNameFromID(weaponID).." to "..targetPlayerName..".", thePlayer, 0, 255, 0)
							--Inform Player
							outputChatBox("You've received (x"..count..") ".. getWeaponNameFromID(weaponID).." from "..adminTitle.." "..getPlayerName(thePlayer)..".", targetPlayer, 0, 255, 0)
							--Send adm warning
							exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " gave " .. targetPlayerName .. " (x"..count..") " .. getWeaponNameFromID(weaponID) .. " with serial '"..allSerials.."'")
						else -- If hidden admin
							outputChatBox("[silahalsana] You have given (x"..count..") ".. getWeaponNameFromID(weaponID).." to "..targetPlayerName.." with serials '"..allSerials, thePlayer, 0, 255, 0)
							
							outputChatBox("You've received (x"..count..") ".. getWeaponNameFromID(weaponID).." from a Hidden Admin.", targetPlayer, 0, 255, 0)
						end
					end
					if fails > 0 then
						outputChatBox("[silahalsana] "..fails.." weapons couldn't be created. Player's ".. error ..".", thePlayer, 255, 0, 0)
						outputChatBox("[ERROR] "..fails.." weapons couldn't be received from Admin. Your ".. error ..".", targetPlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("silahalsana", givePlayerGun, false, false)
addEvent("onsilahalsana", true)
addEventHandler("onsilahalsana", getRootElement(), givePlayerGun)

-- /makeammo
function givePlayerGunAmmo(thePlayer, commandName, targetPlayer, ...)
	if (exports.global:isPlayerLeadAdmin(thePlayer)) then
		local args = {...}
		if not (targetPlayer) or (#args < 1) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick/ID] [Weapon Name/ID] ", thePlayer, 255, 194, 14)
			outputChatBox("     Give player an amount of clips and amount of ammo in each clip.", thePlayer, 150, 150, 150)
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick/ID] [Weapon Name/ID] [Amount/clip,-1=full clip] [quantity]", thePlayer, 255, 194, 14)
			outputChatBox("     Give player an amount of clips and amount of ammo in each clip.", thePlayer, 150, 150, 150)
			outputChatBox("(Type /gunlist or hit F4 to open Weapon Creator)", thePlayer, 0, 255, 0)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				--local ammo =  tonumber(args[2]) or 1
				local weaponID = tonumber(args[1])
				local weaponName = args[1]
				local ammo = tonumber(args[2]) or -1
				local quantity = tonumber(args[3]) or -1
				
				if weaponID == nil then
					local cWeaponName = weaponName:lower()
					if cWeaponName == "colt45" then 
						weaponID = 22
					elseif cWeaponName == "rocketlauncher" then 
						weaponID = 35
					elseif cWeaponName == "combatshotgun" then 
						weaponID = 27
					elseif cWeaponName == "fireextinguisher" then 
						weaponID = 42
					else
						if getWeaponIDFromName(cWeaponName) == false then
							outputChatBox("[MAKEAMMO] Invalid Weapon Name/ID. Type /gunlist or hit F4 to open Weapon Creator.", thePlayer, 255, 0, 0)
							return
						else
							weaponID = getWeaponIDFromName(cWeaponName)
						end
					end
				end
				
				if getAmmoPerClip(weaponID) == "disabled" then --If weapon is not allowed
					outputChatBox("[MAKEAMMO] Invalid Weapon Name/ID. Type /gunlist or hit F4 to open Weapon Creator.", thePlayer, 255, 0, 0)
					return
				elseif getAmmoPerClip(weaponID) == tostring(0)  then-- if weapon doesn't need ammo to work
					outputChatBox("[MAKEAMMO] This weapon doesn't use ammo.", thePlayer, 255, 0, 0)
					return
				else
				end
				
				local logged = getElementData(targetPlayer, "loggedin")
				local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (logged==1) then
					if ammo == -1 then -- if full ammopack
						ammo = getAmmoPerClip(weaponID)
					end
					
					if quantity == -1 then
						quantity = 1
					end
					
					local maxAmountOfAmmopacks = tonumber(get( getResourceName( getThisResource( ) ).. '.maxAmountOfAmmopacks' ))
					if quantity > maxAmountOfAmmopacks then 
						quantity = maxAmountOfAmmopacks
						outputChatBox("[MAKEAMMO] You can't give more than "..maxAmountOfAmmopacks.." magazines at a time. Trying to spawn "..maxAmountOfAmmopacks.."...", thePlayer, 150, 150, 150)
					end
					
					local count = 0
					local fails = 0
					local give, error = "" 
					for variable = 1, quantity, 1 do
						give, error = exports.global:giveItem(targetPlayer, 116, weaponID..":"..ammo..":Ammo for "..getWeaponNameFromID(weaponID))
						if give then
							exports.logs:dbLog(thePlayer, 4, targetPlayer, "GIVEBULLETS "..getWeaponNameFromID(weaponID).." "..tostring(bullets))
							count = count + 1
						else
							fails = fails + 1
						end
					end
					
					if count > 0 then 
						local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
						if (hiddenAdmin==0) then
							--Inform Spawner
							outputChatBox("[MAKEAMMO] You have given (x"..count..") " .. getWeaponNameFromID(weaponID) .. " ammopacks ("..ammo.." bullets each) to "..targetPlayerName..".", thePlayer, 0, 255, 0)
							--Inform Player
							outputChatBox("You've received (x"..count..") " .. getWeaponNameFromID(weaponID) .. " ammopacks ("..ammo.." bullets each) from "..adminTitle.." "..getPlayerName(thePlayer), targetPlayer, 0, 255, 0)
							--Send adm warning
							exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " gave (x"..count..") " .. getWeaponNameFromID(weaponID) .. " ammopacks ("..ammo.." bullets each) to " .. targetPlayerName)
						else -- If hidden admin
							--Inform Spawner
							outputChatBox("[MAKEAMMO] You have given (x"..count..") "..getWeaponNameFromID(weaponID).." ammopacks ("..ammo.." bullets each) to "..targetPlayerName..".", thePlayer, 0, 255, 0)
							--Inform Player
							outputChatBox("You've received (x"..count..") "..getWeaponNameFromID(weaponID).." ammopacks ("..ammo.." bullets each) from a Hidden Admin.", targetPlayer, 0, 255, 0)
						end
					end
					if fails > 0 then
						outputChatBox("[MAKEAMMO] "..fails.." ammopacks couldn't be created. Player's ".. error ..".", thePlayer, 255, 0, 0)
						outputChatBox("[ERROR] "..fails.." ammopacks couldn't be received from Admin. Your ".. error ..".", targetPlayer, 255, 0, 0)
					end
					
					
				end
			end
		end
	end
end
addCommandHandler("makeammo", givePlayerGunAmmo, false, false)
addEvent("onMakeAmmo", true)
addEventHandler("onMakeAmmo", getRootElement(), givePlayerGunAmmo)

function setmarijuanaOwn(thePlayer, cmd, marId, targetPlayer)
	if not marId or not targetPlayer then
		outputChatBox("SYNTAX: /" .. cmd .. " [Marijuana ID]  [Oyuncu Adı/ID]", thePlayer, 255, 194, 14)
		return
	end
	if (exports.global:isPlayerLeadAdmin(thePlayer)) then
		local counter = 0
		local marijuanaobj = getElementsByType("object", getResourceRootElement())
		local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
		if targetPlayer then
			for k, marijuana in ipairs(marijuanaobj) do
				local objectID = getElementData(marijuana, "dbid")
				if (objectID==marId) then
					setElementData(marijuana, "author", getPlayerName(targetPlayer))
				end
			end
		end
	end
end
addCommandHandler("marijuanasahip", setmarijuanaOwn)
function givePlayerGun(thePlayer, commandName, targetPlayer, ...)
	if getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR" then 
		local args = {...}
		if not (targetPlayer) or (#args < 1) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick/ID] [Weapon Name/ID]", thePlayer, 255, 194, 14)
			outputChatBox("     Give player a weapon.", thePlayer, 150, 150, 150)
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick/ID] [Weapon Name/ID] [Quantity]", thePlayer, 255, 194, 14)
			outputChatBox("     Give player an amount of weapons.", thePlayer, 150, 150, 150)
			outputChatBox("(Type /gunlist or hit F4 to open Weapon Creator)", thePlayer, 0, 255, 0)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local weaponID = tonumber(args[1])
				local weaponName = args[1]
				local quantity = tonumber(args[2])
				if weaponID == nil then
					local cWeaponName = weaponName:lower()
					if cWeaponName == "colt45" then 
						weaponID = 22
					elseif cWeaponName == "rocketlauncher" then 
						weaponID = 35
					elseif cWeaponName == "combatshotgun" then 
						weaponID = 27
					elseif cWeaponName == "fireextinguisher" then 
						weaponID = 42
					else
						if getWeaponIDFromName(cWeaponName) == false then
							outputChatBox("[silahalsana] Invalid Weapon Name/ID. Type /gunlist or hit F4 to open Weapon Creator.", thePlayer, 255, 0, 0)
							return
						else
							weaponID = getWeaponIDFromName(cWeaponName)
						end
					end
				end
				
				if getAmmoPerClip(weaponID) == "disabled" then
						outputChatBox("[silahalsana] Invalid Weapon Name/ID. Type /gunlist or hit F4 to open Weapon Creator.", thePlayer, 255, 0, 0)
						return
				end
				
				local logged = getElementData(targetPlayer, "loggedin")
				local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
				
				if (logged==0) then
					outputChatBox("[silahalsana] Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (logged==1) then		
					
					local adminDBID = tonumber(getElementData(thePlayer, "account:character:id"))
					local playerDBID = tonumber(getElementData(targetPlayer, "account:character:id"))
					
					if quantity == nil then
						quantity = 1
					end
					
					local maxAmountOfWeapons = tonumber(get( getResourceName( getThisResource( ) ).. '.maxAmountOfWeapons' ))
					if quantity > maxAmountOfWeapons then 
						quantity = maxAmountOfWeapons
						outputChatBox("[silahalsana] You can't give more than "..maxAmountOfWeapons.." weapons at a time. Trying to spawn "..maxAmountOfWeapons.."...", thePlayer, 150, 150, 150)
					end
					
					local count = 0
					local fails = 0
					local allSerials = ""
					local give, error = ""
					for variable = 1, quantity, 1 do
						local mySerial = exports.global:createWeaponSerial( 1, adminDBID, playerDBID)
						--outputChatBox(mySerial)
						give, error = exports.global:giveItem(targetPlayer, 115, weaponID..":"..mySerial..":"..getWeaponNameFromID(weaponID))
						if give then 
							exports.logs:dbLog(thePlayer, 4, targetPlayer, "GIVEWEAPON "..getWeaponNameFromID(weaponID).." "..tostring(mySerial))
							if count == 0 then
								allSerials = mySerial
							else
								allSerials = allSerials.."', '"..mySerial
							end
							count = count + 1
						else
							fails = fails + 1
						end
					end
					if count > 0 then 
						local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
						if (hiddenAdmin==0) then
							--Inform Spawner
							outputChatBox("[silahalsana] You have given (x"..count..") ".. getWeaponNameFromID(weaponID).." to "..targetPlayerName..".", thePlayer, 0, 255, 0)
							--Inform Player
							outputChatBox("You've received (x"..count..") ".. getWeaponNameFromID(weaponID).." from "..adminTitle.." "..getPlayerName(thePlayer)..".", targetPlayer, 0, 255, 0)
							--Send adm warning
							exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " gave " .. targetPlayerName .. " (x"..count..") " .. getWeaponNameFromID(weaponID) .. " with serial '"..allSerials.."'")
						else -- If hidden admin
							outputChatBox("[silahalsana] You have given (x"..count..") ".. getWeaponNameFromID(weaponID).." to "..targetPlayerName.." with serials '"..allSerials, thePlayer, 0, 255, 0)
							
							outputChatBox("You've received (x"..count..") ".. getWeaponNameFromID(weaponID).." from a Hidden Admin.", targetPlayer, 0, 255, 0)
						end
					end
					if fails > 0 then
						outputChatBox("[silahalsana] "..fails.." weapons couldn't be created. Player's ".. error ..".", thePlayer, 255, 0, 0)
						outputChatBox("[ERROR] "..fails.." weapons couldn't be received from Admin. Your ".. error ..".", targetPlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("prosilahver", givePlayerGun, false, false)
addEvent("onsilahalsana", true)
addEventHandler("onsilahalsana", getRootElement(), givePlayerGun)
-- /makeammo
function givePlayerGunAmmo(thePlayer, commandName, targetPlayer, ...)
	if getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR" then 
		local args = {...}
		if not (targetPlayer) or (#args < 1) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick/ID] [Weapon Name/ID] ", thePlayer, 255, 194, 14)
			outputChatBox("     Give player an amount of clips and amount of ammo in each clip.", thePlayer, 150, 150, 150)
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick/ID] [Weapon Name/ID] [Amount/clip,-1=full clip] [quantity]", thePlayer, 255, 194, 14)
			outputChatBox("     Give player an amount of clips and amount of ammo in each clip.", thePlayer, 150, 150, 150)
			outputChatBox("(Type /gunlist or hit F4 to open Weapon Creator)", thePlayer, 0, 255, 0)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				--local ammo =  tonumber(args[2]) or 1
				local weaponID = tonumber(args[1])
				local weaponName = args[1]
				local ammo = tonumber(args[2]) or -1
				local quantity = tonumber(args[3]) or -1
				
				if weaponID == nil then
					local cWeaponName = weaponName:lower()
					if cWeaponName == "colt45" then 
						weaponID = 22
					elseif cWeaponName == "rocketlauncher" then 
						weaponID = 35
					elseif cWeaponName == "combatshotgun" then 
						weaponID = 27
					elseif cWeaponName == "fireextinguisher" then 
						weaponID = 42
					else
						if getWeaponIDFromName(cWeaponName) == false then
							outputChatBox("[MAKEAMMO] Invalid Weapon Name/ID. Type /gunlist or hit F4 to open Weapon Creator.", thePlayer, 255, 0, 0)
							return
						else
							weaponID = getWeaponIDFromName(cWeaponName)
						end
					end
				end
				
				if getAmmoPerClip(weaponID) == "disabled" then --If weapon is not allowed
					outputChatBox("[MAKEAMMO] Invalid Weapon Name/ID. Type /gunlist or hit F4 to open Weapon Creator.", thePlayer, 255, 0, 0)
					return
				elseif getAmmoPerClip(weaponID) == tostring(0)  then-- if weapon doesn't need ammo to work
					outputChatBox("[MAKEAMMO] This weapon doesn't use ammo.", thePlayer, 255, 0, 0)
					return
				else
				end
				
				local logged = getElementData(targetPlayer, "loggedin")
				local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (logged==1) then
					if ammo == -1 then -- if full ammopack
						ammo = getAmmoPerClip(weaponID)
					end
					
					if quantity == -1 then
						quantity = 1
					end
					
					local maxAmountOfAmmopacks = tonumber(get( getResourceName( getThisResource( ) ).. '.maxAmountOfAmmopacks' ))
					if quantity > maxAmountOfAmmopacks then 
						quantity = maxAmountOfAmmopacks
						outputChatBox("[MAKEAMMO] You can't give more than "..maxAmountOfAmmopacks.." magazines at a time. Trying to spawn "..maxAmountOfAmmopacks.."...", thePlayer, 150, 150, 150)
					end
					
					local count = 0
					local fails = 0
					local give, error = "" 
					for variable = 1, quantity, 1 do
						give, error = exports.global:giveItem(targetPlayer, 116, weaponID..":"..ammo..":Ammo for "..getWeaponNameFromID(weaponID))
						if give then
							exports.logs:dbLog(thePlayer, 4, targetPlayer, "GIVEBULLETS "..getWeaponNameFromID(weaponID).." "..tostring(bullets))
							count = count + 1
						else
							fails = fails + 1
						end
					end
					
					if count > 0 then 
						local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
						if (hiddenAdmin==0) then
							--Inform Spawner
							outputChatBox("[MAKEAMMO] You have given (x"..count..") " .. getWeaponNameFromID(weaponID) .. " ammopacks ("..ammo.." bullets each) to "..targetPlayerName..".", thePlayer, 0, 255, 0)
							--Inform Player
							outputChatBox("You've received (x"..count..") " .. getWeaponNameFromID(weaponID) .. " ammopacks ("..ammo.." bullets each) from "..adminTitle.." "..getPlayerName(thePlayer), targetPlayer, 0, 255, 0)
							--Send adm warning
							exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " gave (x"..count..") " .. getWeaponNameFromID(weaponID) .. " ammopacks ("..ammo.." bullets each) to " .. targetPlayerName)
						else -- If hidden admin
							--Inform Spawner
							outputChatBox("[MAKEAMMO] You have given (x"..count..") "..getWeaponNameFromID(weaponID).." ammopacks ("..ammo.." bullets each) to "..targetPlayerName..".", thePlayer, 0, 255, 0)
							--Inform Player
							outputChatBox("You've received (x"..count..") "..getWeaponNameFromID(weaponID).." ammopacks ("..ammo.." bullets each) from a Hidden Admin.", targetPlayer, 0, 255, 0)
						end
					end
					if fails > 0 then
						outputChatBox("[MAKEAMMO] "..fails.." ammopacks couldn't be created. Player's ".. error ..".", thePlayer, 255, 0, 0)
						outputChatBox("[ERROR] "..fails.." ammopacks couldn't be received from Admin. Your ".. error ..".", targetPlayer, 255, 0, 0)
					end
					
					
				end
			end
		end
	end
end
addCommandHandler("promermiver", givePlayerGunAmmo, false, false)
addEvent("onMakeAmmo", true)
addEventHandler("onMakeAmmo", getRootElement(), givePlayerGunAmmo)

function getAmmoPerClip(id)
	if id == 0 then 
		return tostring(get( getResourceName( getThisResource( ) ).. '.fist' ))
	elseif id == 1 then 
		return tostring(get( getResourceName( getThisResource( ) ).. '.brassknuckle' ))
	elseif id == 2 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.golfclub' ))
	elseif id == 3 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.nightstick' ))
	elseif id == 4 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.knife' ))
	elseif id == 5 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.bat' ))
	elseif id == 6 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.shovel' ))
	elseif id == 7 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.poolstick' ))
	elseif id == 8 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.katana' ))
	elseif id == 9 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.chainsaw' ))
	elseif id == 10 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.dildo' ))
	elseif id == 11 then
		return tostring(get( getResourceName( getThisResource( ) ).. 'dildo2' ))
	elseif id == 12 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.vibrator' ))
	elseif id == 13 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.vibrator2' ))
	elseif id == 14 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.flower' ))
	elseif id == 15 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.cane' ))
	elseif id == 16 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.grenade' ))
	elseif id == 17 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.teargas' ))
	elseif id == 18 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.molotov' ))
	elseif id == 22 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.colt45' ))
	elseif id == 23 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.silenced' ))
	elseif id == 24 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.deagle' ))
	elseif id == 25 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.shotgun' ))
	elseif id == 26 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.sawed-off' ))
	elseif id == 27 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.combatshotgun' ))
	elseif id == 28 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.uzi' ))
	elseif id == 29 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.mp5' ))
	elseif id == 30 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.ak-47' ))
	elseif id == 31 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.m4' ))
	elseif id == 32 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.tec-9' ))
	elseif id == 33 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.rifle' ))
	elseif id == 34 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.sniper' ))
	elseif id == 35 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.rocketlauncher' ))
	--elseif id == 39 then -- Satchel
	--elseif id == 40 then -- Satchel remote (Bomb)
	elseif id == 41 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.spraycan' ))
	elseif id == 42 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.fireextinguisher' ))
	elseif id == 43 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.camera' ))
	elseif id == 44 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.nightvision' ))
	elseif id == 45 then
		return tostring(get( getResourceName( getThisResource( ) ).. '.infrared' ))
	--elseif id == 46 then -- Parachute
	else
		return "disabled"
	end
	return "disabled"
end
addEvent("onGetAmmoPerClip", true)
addEventHandler("onGetAmmoPerClip", getRootElement(), getAmmoPerClip)



-- /GIVEITEM
function givePlayerItem(thePlayer, commandName, targetPlayer, itemID, ...)
	if getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "point" or getElementData(thePlayer, "account:username") == "alperen2124" or getElementData(thePlayer, "account:username") == "burakrerden" or getElementData(thePlayer, "account:username") == "pabloo50" or getElementData(thePlayer, "account:username") == "REMAJOR" then 
		if not (itemID) or not (...) or not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Item ID] [Item Value]", thePlayer, 255, 194, 14)
		else
			itemID = tonumber(itemID)
			if ( itemID == 74 or itemID == 150 or itemID == 75 or itemID == 78 or itemID == 2) and not exports.global:isPlayerHeadAdmin( thePlayer) then -- Banned Items
				exports.hud:sendBottomNotification(thePlayer, "Banned Items", "Only Head+ Admin can spawn this kind of item.")
				return false
			end
			
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				local itemValue = table.concat({...}, " ")
				itemValue = tonumber(itemValue) or itemValue
				
				if ( itemID == 84 ) and not exports.global:isPlayerLeadAdmin( thePlayer ) then
				elseif itemID == 114 and not exports.global:isPlayerSuperAdmin( thePlayer ) then
				elseif (itemID == 115 or itemID == 116 or itemID == 68 or itemID == 134 or itemID == 137 or itemID == 152) then
					outputChatBox("Sorry, you cannot use this with /giveitem.", thePlayer, 255, 0, 0)
				elseif (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (logged==1) then
					local name = call( getResourceFromName( "item-system" ), "getItemName", itemID, itemValue )
					
					if itemID > 0 and name and name ~= "?" then
						local success, reason = exports.global:giveItem(targetPlayer, itemID, itemValue)
						if success then
							outputChatBox("#FF0000[!]#FFFFFFOyuncunun || " .. targetPlayerName .. " canını doldurdun. " .. name .. " with value " .. itemValue .. ".", thePlayer, 0, 0, 0, true)
							exports.logs:dbLog(thePlayer, 4, targetPlayer, "GIVEITEM "..name.." "..tostring(itemValue))
							triggerClientEvent(targetPlayer, "item:updateclient", targetPlayer)
							local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
							local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
							if (hiddenAdmin==0) then
								outputChatBox(tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " has given you a " .. name .. " with value " .. itemValue .. ".", targetPlayer, 0, 255, 0)
							else
								outputChatBox("A Hidden Admin has given you a " .. name .. " with value " .. itemValue .. ".", targetPlayer, 0, 255, 0)
							end
						else
							outputChatBox("Couldn't give " .. targetPlayerName .. " a " .. name .. ": " .. tostring(reason), thePlayer, 255, 0, 0)
						end
					else
						outputChatBox("Invalid Item ID.", thePlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("giveitem", givePlayerItem, false, false)

-- /TAKEITEM
function takePlayerItem(thePlayer, commandName, targetPlayer, itemID, ...)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (itemID) or not (...) or not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Item ID] [Item Value]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				
				itemID = tonumber(itemID)
				local itemValue = table.concat({...}, " ")
				itemValue = tonumber(itemValue) or itemValue
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (logged==1) then
					if exports.global:hasItem(targetPlayer, itemID, itemValue) then
						outputChatBox("You took item " .. itemID .. " with the value of (" .. itemValue .. ") from " .. targetPlayerName .. ".", thePlayer, 0, 255, 0)
						exports.global:takeItem(targetPlayer, itemID, itemValue)
						exports.logs:dbLog(thePlayer, 4, targetPlayer, "TAKEITEM "..tostring(itemID).." "..tostring(itemValue))
						
						triggerClientEvent(targetPlayer, "item:updateclient", targetPlayer)
					else
						outputChatBox("Player doesn't have that item", thePlayer, 255, 0, 0)
					end
				end
			end
		end
	end
end
addCommandHandler("takeitem", takePlayerItem, false, false)

-- /SETHP
function setPlayerHealth(thePlayer, commandName, targetPlayer, health)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not tonumber(health) or not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Health]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				if tonumber( health ) < getElementHealth( targetPlayer ) and getElementData( thePlayer, "adminlevel" ) < getElementData( targetPlayer, "adminlevel" ) then
					outputChatBox("Nah.", thePlayer, 255, 0, 0)
				elseif not setElementHealth(targetPlayer, tonumber(health)) then
					outputChatBox("Invalid health value.", thePlayer, 255, 0, 0)
				else
					outputChatBox("#FF0000[!]#FFFFFFOyuncu " .. targetPlayerName .. "'ın canını doldurdun.", thePlayer, 0, 0, 0, true)
					triggerEvent("onPlayerHeal", targetPlayer, true)
					exports.logs:dbLog(thePlayer, 4, targetPlayer, "SETHP "..health)
				end
			end
		end
	end
end
addCommandHandler("sethp", setPlayerHealth, false, false)

-- /AHEAL -MAXIME
function adminHeal(thePlayer, commandName, targetPlayer)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		local health = 100
		local targetPlayerName = getPlayerName(thePlayer):gsub("_", " ")
		if not (targetPlayer) then
			targetPlayer = thePlayer
		else
			targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
		end
		
		if targetPlayer then
			setElementHealth(targetPlayer, tonumber(health))
			outputChatBox("Player " .. targetPlayerName .. " has received " .. health .. " Health.", thePlayer, 0, 255, 0)
			triggerEvent("onPlayerHeal", targetPlayer, true)
			exports.logs:dbLog(thePlayer, 4, targetPlayer, "AHEAL "..health)
		end
	end
end
addCommandHandler("aheal", adminHeal, false, false)

--[[ /SETARMOR
function setPlayerArmour(thePlayer, commandName, targetPlayer, armor)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (armor) or not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Armor]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (tostring(type(tonumber(armor))) == "number") then
					local setArmor = setPedArmor(targetPlayer, tonumber(armor))
					outputChatBox("Player " .. targetPlayerName .. " has received " .. armor .. " Armor.", thePlayer, 0, 255, 0)
					exports.logs:dbLog(thePlayer, 4, targetPlayer, "SETARMOR "..tostring(armor))
				else
					outputChatBox("Invalid armor value.", thePlayer, 255, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("setarmor", setPlayerArmour, false, false)
]]--

-- /SETARMOR
--Armor only for law enforcement members, unless admin is lead+. - Chuevo, 19/05/13
function setPlayerArmour(thePlayer, theCommand, targetPlayer, armor)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (targetPlayer) or not (armor) then
			outputChatBox("SYNTAX: /" .. theCommand .. " [Player Partial Nick / ID] [Armor]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				if (logged==1) then
					if (tostring(type(tonumber(armor))) == "number") then
						local targetPlayerFaction = getElementData(targetPlayer, "faction")
						if (targetPlayerFaction == 1) or (targetPlayerFaction == 45) or (targetPlayerFaction == 3) or (targetPlayerFaction == 46) then
							local setArmor = setPedArmor(targetPlayer, tonumber(armor))
							outputChatBox("Player " .. targetPlayerName .. " has received " .. armor .. " Armor.", thePlayer, 0, 255, 0)
							exports.logs:dbLog(thePlayer, 4, targetPlayer, "SETARMOR " ..tostring(armor))
						elseif (targetPlayerFaction ~= 1) or (targetPlayerFaction ~= 45) or (targetPlayerFaction ~= 3) or (targetPlayerFaction ~= 46) then
							if (exports.global:isPlayerSuperAdmin(thePlayer)) then
								local setArmor = setPedArmor(targetPlayer, tonumber(armor))
								outputChatBox("Player " .. targetPlayerName .. " has received " .. armor .. " Armor.", thePlayer, 0, 255, 0)
								exports.logs:dbLog(thePlayer, 4, tagetPlayer, "SETARMOR " ..tostring(armor))
							else
								outputChatBox("This player is not in a law enforcement faction. Contact a super+ administrator to set armor.", thePlayer, 255, 0, 0)
							end
						end
					else
						outputChatBox("Invalid armor value.", thePlayer, 255, 0, 0)
					end
				else
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("setarmor", setPlayerArmour, false, false)
		

-- /skinverdims
function setPlayerSkinCmd(thePlayer, commandName, targetPlayer, skinID)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (skinID) or not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Skin ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (tostring(type(tonumber(skinID))) == "number" and tonumber(skinID) ~= 0) then
					local fat = getPedStat(targetPlayer, 21)
					local muscle = getPedStat(targetPlayer, 23)
					
					setPedStat(targetPlayer, 21, 0)
					setPedStat(targetPlayer, 23, 0)
					local skin = setElementModel(targetPlayer, tonumber(skinID))
					
					setPedStat(targetPlayer, 21, fat)
					setPedStat(targetPlayer, 23, muscle)
					if not (skin) then
						outputChatBox("Invalid skin ID.", thePlayer, 255, 0, 0)
					else
						outputChatBox("Player " .. targetPlayerName .. " has received skin " .. skinID .. ".", thePlayer, 0, 255, 0)
						mysql:query_free("UPDATE characters SET skin = " .. mysql:escape_string(skinID) .. " WHERE id = " .. mysql:escape_string(getElementData( targetPlayer, "dbid" )) )
						exports.logs:dbLog(thePlayer, 4, targetPlayer, "skinverdims "..tostring(skinID))
					end
				else
					outputChatBox("Invalid skin ID.", thePlayer, 255, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("skinverdims", setPlayerSkinCmd, false, false)

-- /CHANGENAME
function asetPlayerName(thePlayer, commandName, targetPlayer, ...)
	if getElementData(thePlayer, "account:username") == "pabloo50" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "alperen2124" or getElementData(thePlayer, "account:username") == "burakrerden" or getElementData(thePlayer, "account:username") == "point" or getElementData(thePlayer, "account:username") == "REMAJOR" then
		if not (...) or not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Player New Nick]", thePlayer, 255, 194, 14)
		else
			local newName = table.concat({...}, "_")
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local hoursPlayed = getElementData( targetPlayer, "hoursplayed" )
				if hoursPlayed > 5 and not exports.global:isPlayerLeadAdmin(thePlayer) then
					outputChatBox( "Only Lead+ Admin can change character name which is older than 5 hours.", thePlayer, 255, 0, 0)
					return false
				end
				if newName == targetPlayerName then
					outputChatBox( "The player's name is already that.", thePlayer, 255, 0, 0)
				else
					local dbid = getElementData(targetPlayer, "dbid")
					local result = mysql:query("SELECT charactername FROM characters WHERE charactername='" .. mysql:escape_string(newName) .. "' AND id != " .. mysql:escape_string(dbid))
					
					if (mysql:num_rows(result)>0) then
						outputChatBox("This name is already in use.", thePlayer, 255, 0, 0)
					else
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "legitnamechange", 1, false)
						local name = setPlayerName(targetPlayer, tostring(newName))
						
						if (name) then
							exports['cache']:clearCharacterName( dbid )
							mysql:query_free("UPDATE characters SET charactername='" .. mysql:escape_string(newName) .. "' WHERE id = " .. mysql:escape_string(dbid))
							local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
							
							local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
							local processedNewName = string.gsub(tostring(newName), "_", " ")
							if (hiddenAdmin==0) then
								exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " changed " .. targetPlayerName .. "'s Name to " .. newName .. ".")
								outputChatBox("You character's name has been changed from '"..targetPlayerName .. "' to '" .. tostring(newName) .. "' by "..adminTitle.." "..getPlayerName(thePlayer)..".", targetPlayer, 0, 255, 0)
							else
								outputChatBox("You character's name has been changed from '"..targetPlayerName .. "' to " .. processedNewName .. "' by a Hidden Admin.", targetPlayer, 0, 255, 0)
							end
							outputChatBox("You changed " .. targetPlayerName .. "'s name to '" .. processedNewName .. "'.", thePlayer, 0, 255, 0)
							
							--Clean the ATM card DB, if not it will bug with the new name / MAXIME
							--mysql:query_free("REMAJOR FROM `bank_accounts` WHERE `bankOwner`='"..tostring(targetPlayerName):gsub("'", "''").."' OR `bankOwner`='"..tostring(processedNewName):gsub("'", "''").."' ")
							
							exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "legitnamechange", 0, false)
							
							exports.logs:dbLog(thePlayer, 4, targetPlayer, "CHANGENAME "..targetPlayerName.." -> "..tostring(newName))
							triggerClientEvent(targetPlayer, "updateName", targetPlayer, getElementData(targetPlayer, "dbid"))
						else
							outputChatBox("Failed to change name.", thePlayer, 255, 0, 0)
						end
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "legitnamechange", 0, false)
					end
					mysql:free_result(result)
				end
			end
		end
	end
end
addCommandHandler("isimdegistir", asetPlayerName, false, false)

-- /HIDEADMIN
function hideAdmin(thePlayer, commandName)
	if exports.global:isPlayerHeadAdmin(thePlayer) or exports.global:isPlayerHeadAdmin(thePlayer) or exports.global:isPlayerLeadAdmin(thePlayer) then
		local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
		
		if (hiddenAdmin==0) then
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "hiddenadmin", 1, false)
			outputChatBox("[!] Gizli admin moduna geçtiniz!", thePlayer, 255, 177, 0)
		elseif (hiddenAdmin==1) then
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "hiddenadmin", 0, false)
			outputChatBox("[!] Gizli admin modundan çıktınız!.", thePlayer, 255, 177, 0)
		end
		exports.global:updateNametagColor(thePlayer)
		mysql:query_free("UPDATE accounts SET hiddenadmin=" .. mysql:escape_string(getElementData(thePlayer, "hiddenadmin")) .. " WHERE id = " .. mysql:escape_string(getElementData(thePlayer, "account:id")) )
	end
end
addCommandHandler("hideadmin", hideAdmin, false, false)
	
-- /SLAP
function slapPlayer(thePlayer, commandName, targetPlayer)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local thePlayerPower = exports.global:getPlayerAdminLevel(thePlayer)
				local targetPlayerPower = exports.global:getPlayerAdminLevel(targetPlayer)
				local logged = getElementData(targetPlayer, "loggedin")
				
				if (logged==0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				elseif (targetPlayerPower > thePlayerPower) then -- Check the admin isn't slapping someone higher rank them him
					outputChatBox("You cannot slap this player as they are a higher admin rank then you.", thePlayer, 255, 0, 0)
				else
					local x, y, z = getElementPosition(targetPlayer)
					
					if (isPedInVehicle(targetPlayer)) then
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "realinvehicle", 0, false)
						removePedFromVehicle(targetPlayer)
					end
					detachElements(targetPlayer)
					
					setElementPosition(targetPlayer, x, y, z+15)
					local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
					
					if (hiddenAdmin==0) then
						local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
						exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " slapped " .. targetPlayerName .. ".")
					end
					exports.logs:dbLog(thePlayer, 4, targetPlayer, "SLAP")
				end
			end
		end
	end
end
addCommandHandler("slap", slapPlayer, false, false)

-- HEADS Hidden OOC
function hiddenOOC(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")

	if (exports.global:isPlayerHeadAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local players = exports.pool:getPoolElementsByType("player")
			local message = table.concat({...}, " ")
			
			for index, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
			
				if (logged==1) and getElementData(arrayPlayer, "globalooc") == 1 then
				    exports["titan_infobox"]:addBox(arrayPlayer,"info","Duyuru: "  .. message .. "") 	 	
					--outputChatBox("(( Admin Duyuru : " .. message .. " ))", arrayPlayer, 245, 222, 179)
				end
			end
		end
	end
end
addCommandHandler("ho", hiddenOOC, false, false)

-- HEADS Hidden OOC
function hiddenOOC(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")

	if (exports.global:isPlayerHeadAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local players = exports.pool:getPoolElementsByType("player")
			local message = table.concat({...}, " ")
			
			for index, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
			
				if (logged==1) and getElementData(arrayPlayer, "globalooc") == 1 then
					outputChatBox("(( [IC]Bilgiler : " .. message .. " ))", arrayPlayer, 255, 165, 170)
				end
			end
		end
	end
end
addCommandHandler("icbilgi", hiddenOOC, false, false)

-- HEADS Hidden Whisper
function hiddenWhisper(thePlayer, command, who, ...)
	if (exports.global:isPlayerHeadAdmin(thePlayer)) then
		if not (who) or not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Message]", thePlayer, 255, 194, 14)
		else
			message = table.concat({...}, " ")
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, who)
			
			if (targetPlayer) then
				local logged = getElementData(targetPlayer, "loggedin")
				
				if (logged==1) then
					local playerName = getPlayerName(thePlayer)
					outputChatBox("PM From Hidden Admin: " .. message, targetPlayer, 255, 194, 14)
					outputChatBox("Hidden PM Sent to " .. targetPlayerName .. ": " .. message, thePlayer, 255, 194, 14)
				elseif (logged==0) then
					outputChatBox("Player is not logged in yet.", thePlayer, 255, 194, 14)
				end
			end
		end
	end
end
addCommandHandler("hw", hiddenWhisper, false, false)

function toggleGunHostlerAttach(thePlayer, commandName, targetPlayer, dimensionID)
	if (getElementData(thePlayer, "account:id") == 1 or getElementData(thePlayer, "faction") == 1 or getElementData(thePlayer, "faction") == 59 or getElementData(thePlayer, "faction") == 50 or getElementData(thePlayer, "faction") == 3 or getElementData(thePlayer, "faction") == 47) then
		if not getElementData(thePlayer, "enableGunAttach") then
			setElementData(thePlayer, "enableGunAttach", true, true)
			outputChatBox("[TEMP-CMD] You have enabled weapon bone attach.", thePlayer)
		else
			setElementData(thePlayer, "enableGunAttach",false,true)
			triggerEvent("destroyWepObjects", thePlayer)
			outputChatBox("[TEMP-CMD] Disabled and destroyed all attached weapons.", thePlayer)
		end
	end
end
addCommandHandler("togattach", toggleGunHostlerAttach, false, false)
addCommandHandler("toggleattach", toggleGunHostlerAttach, false, false)

-- Kick
function kickAPlayer(thePlayer, commandName, targetPlayer, ...)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (targetPlayer) or not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Partial Player Nick] [Reason]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			
			if targetPlayer then
				local thePlayerPower = exports.global:getPlayerAdminLevel(thePlayer)
				local targetPlayerPower = exports.global:getPlayerAdminLevel(targetPlayer)
				reason = table.concat({...}, " ")
				
				if (targetPlayerPower <= thePlayerPower) then
					local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
					local playerName = getPlayerName(thePlayer)
					--[[outputDebugString("---------------")
					outputDebugString(getPlayerName(targetPlayer))
					outputDebugString(tostring(getElementData(targetPlayer, "account:id")))
					outputDebugString(getPlayerName(thePlayer))
					outputDebugString(tostring(getElementData(thePlayer, "account:id")))
					outputDebugString(tostring(hiddenAdmin))
					outputDebugString(reason)]]
					mysql:query_free('INSERT INTO adminhistory (user_char, user, admin_char, admin, hiddenadmin, action, duration, reason) VALUES ("' .. mysql:escape_string(getPlayerName(targetPlayer)) .. '",' .. mysql:escape_string(tostring(getElementData(targetPlayer, "account:id") or 0)) .. ',"' .. mysql:escape_string(getPlayerName(thePlayer)) .. '",' .. mysql:escape_string(tostring(getElementData(thePlayer, "account:id") or 0)) .. ',' .. mysql:escape_string(hiddenAdmin) .. ',1,0,"' .. mysql:escape_string(reason) .. '")' )
					
					if (hiddenAdmin==0) then
						if commandName ~= "skick" then
							local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
							outputChatBox("[Kick]: " .. adminTitle .. " " .. playerName .. "  || " .. targetPlayerName .. " adlı şahısı oyundan attı.", getRootElement(), 255, 0, 51)
							outputChatBox("[Kick]: Sebeb: " .. reason .. ".", getRootElement(), 255, 0, 51)
						end
						kickPlayer(targetPlayer, thePlayer, reason)
					else
						if commandName ~= "skick" then
							outputChatBox("[Kick]: Hidden Admin || " .. targetPlayerName .. " adlı şahısı oyundan attı.", getRootElement(), 255, 0, 51)
							outputChatBox("[Kick]: Sebeb: " .. reason, getRootElement(), 255, 0, 51)
						end
						kickPlayer(targetPlayer, getRootElement(), reason)
					end
					exports.logs:dbLog(thePlayer, 4, targetPlayer, "PKICK "..reason)
				else
					outputChatBox(" This player is a higher level admin than you.", thePlayer, 255, 0, 0)
					outputChatBox(playerName .. " attempted to execute the kick command on you.", targetPlayer, 255, 0 ,0)
				end
			end
		end
	end
end
addCommandHandler("propkick", kickAPlayer, false, false)
addCommandHandler("proskick", kickAPlayer, false, false)



--[[function makePlayerAdmin(thePlayer, commandName, who, rank)
	if exports.global:isPlayerHeadAdmin(thePlayer) or exports.global:isPlayerHeadAdmin(thePlayer) or exports.global:isPlayerGMTeamLeader(thePlayer) then
		if not (who) or not (tonumber(rank)) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Name/ID] [Rank, -1 .. -4 = GMs, 1 .. 7 = admins]", thePlayer, 255, 194, 14)
			outputChatBox("SYNTAX: /" .. commandName .. " [Exact Username] [Rank, -1 .. -4 = GMs, 1 .. 6 = admins]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, who)
			
			if (targetPlayer) then
				rank = math.floor(tonumber(rank))
				if exports.global:isPlayerHeadAdmin(thePlayer) or exports.global:isPlayerHeadAdmin(thePlayer) then
				elseif exports.global:isPlayerGMTeamLeader(thePlayer) then
					-- do restrict GM team leader to set GM ranks only
					if exports.global:isPlayerAdmin(targetPlayer) then
						outputChatBox("You can't set this player's rank.", thePlayer, 255, 0, 0)
						return
					else
						if rank > 0 or rank < -4 then
							outputChatBox("You can't set this rank.", thePlayer, 255, 0, 0)
							return
						end
					end
				else
					return
				end
				
				local username = getPlayerName(thePlayer)
				local accountID = getElementData(targetPlayer, "account:id")
				
				local query = mysql:query_free("UPDATE accounts SET admin='" .. mysql:escape_string(rank) .. "', hiddenadmin='0' WHERE id='" .. mysql:escape_string(accountID) .. "'")
				if (rank > 0) or (rank == -999999999) then
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminduty", 1, false)
				else
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminduty", 0, false)
				end
				mysql:query_free("UPDATE accounts SET adminduty=" .. mysql:escape_string(getElementData(targetPlayer, "adminduty")) .. " WHERE id = " .. mysql:escape_string(getElementData(targetPlayer, "account:id")) )
				
				
				local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
				if (rank < 0) then
					local gmrank = -rank
					outputChatBox("You set " .. targetPlayerName .. "'s GM rank to " .. tostring(gmrank) .. ".", thePlayer, 0, 255, 0)
					outputChatBox(adminTitle .. " " .. username .. " set your GM rank to " .. gmrank .. ".", targetPlayer, 255, 194, 14)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "account:gmlevel", gmrank, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "account:gmduty", true, true)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminlevel", 0, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminduty", 0, false)
				else
					outputChatBox(adminTitle .. " " .. username .. " set your admin rank to " .. rank .. ".", targetPlayer, 255, 194, 14)
					outputChatBox("You set " .. targetPlayerName .. "'s Admin rank to " .. tostring(rank) .. ".", thePlayer, 0, 255, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminlevel", rank, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminduty", 1, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "account:gmlevel", 0, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "account:gmduty", false, true)
				end
				exports.logs:dbLog(thePlayer, 4, targetPlayer, "MAKEADMIN " .. rank)
				
				local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
				
				-- Fix for scoreboard & nametags
				if (hiddenAdmin==0) then
					exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. username .. " set " .. targetPlayerName .. "'s admin level to " .. rank .. ".")
				end
				
				exports.global:updateNametagColor(targetPlayer)
			else
				local result = mysql:query_free("UPDATE `accounts` SET `adminlevel` = '"..mysql:escape_string(name).."', `entryNumber` = '".. mysql:escape_string(number) .."', `entryEmail` = '".. mysql:escape_string(mail) .."', `entryAddress` = '".. mysql:escape_string(add) .."', `entryFavorited` = '".. mysql:escape_string(fav) .."' WHERE `phone` = '"..mysql:escape_string(tostring(phoneBookPhone)).."' AND `entryNumber` = '".. mysql:escape_string(number) .."'")
				if result then
					showContactScreen(client, phoneBookPhone, "")
					return
				end
				outputChatBox("[SMARTPHONE] Failed to update contact into Database, please report this to 'Maxime' on www.unitedgaming.org or skype 'duc.fpt2009'.", client, 255,0,0)
			end
		end
	end
end
addCommandHandler("makeadmin", makePlayerAdmin, false, false)]]

function makePlayerAdmin(thePlayer, commandName, who, rank) --/ MAXIME
	if getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "pabloo50" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "avsar" or getElementData(thePlayer, "account:username") == "alperen2124" then  
		if not (who) or not (tonumber(rank)) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Name/ID] [Rank, -1 .. -4 = GMs, 1 .. 7 = Admins]", thePlayer, 255, 194, 14)
			outputChatBox("SYNTAX: /" .. commandName .. " [Exact Username] [Rank, -1 .. -4 = GMs, 1 .. 7 = Admins]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, who)
			local username = false
			local targetUsername = false
			local currentRank = false
			local adminID = false
			rank = tonumber(rank)
			if not exports.global:isPlayerHeadAdmin(thePlayer) and not exports.global:isPlayerScripter(thePlayer) then -- do restrict GM team leader to set GM ranks only
				if exports.global:isPlayerAdmin(targetPlayer) then
					outputChatBox("You can't set an admin's rank as a GM Leader", thePlayer, 255, 0, 0)
					return false
				end
				if rank < -4 or rank > 0 then
					outputChatBox("You can set GM rank only.", thePlayer, 255, 0, 0)
					return false
				end
			end
			
			if (targetPlayer) then
				targetUsername = getElementData(targetPlayer, "account:username")
				currentRank = getElementData(targetPlayer, "adminlevel")
				adminID = getElementData(targetPlayer, "account:id")
			else
				targetUsername = who
				local mQuery1 = mysql:query("SELECT * FROM `accounts` WHERE `username`='".. mysql:escape_string( targetUsername ) .."'")
				currentRank = mysql:fetch_assoc(mQuery1)["admin"]
				adminID = mysql:fetch_assoc(mQuery1)["id"]
				if mysql:fetch_assoc(mQuery1)["username"] then
					mysql:free_result(mQuery1)
				else
					outputChatBox("Partial Player Name/ID or Username not found!", thePlayer, 255, 194, 14)
					return
				end
			end
			
			theUser = getElementData(thePlayer, "account:username")
			theRank = getElementData(thePlayer, "adminlevel")
			
			koruma = exports.global:isPlayerKurucu(thePlayer)
			
			if theRank <= currentRank and koruma then
				outputChatBox("Bu yetkilinin yetkisi ile oynayamazsın!",thePlayer,255,0,0)
				outputChatBox(getPlayerName(thePlayer).." isimli yetkili yetkini değiştirmeye çalıştı!",targetPlayer,255,0,0)
				exports.global:sendMessageToAdmins(getPlayerName(thePlayer).." isimli yetkili "..targetPlayerName.." isimli yetkilinin rankını "..rank.." yapmaya çalıştı.")
				return
			end
			
			if rank >= theRank and not koruma then
				outputChatBox("Kendi rankının üstünde rank veremezsin!",thePlayer,255,0,0)
				exports.global:sendMessageToAdmins(getPlayerName(thePlayer).." isimli yetkili "..targetPlayerName.." isimli yetkilinin kendi rankından üst ~ "..rank.." ~ rank vermeye çalıştı çalıştı.")
				return
			end

			
			username = getPlayerName(thePlayer)
			local query = mysql:query_free("UPDATE accounts SET admin='" .. mysql:escape_string(rank) .. "', adminduty='0' WHERE username='" .. mysql:escape_string(targetUsername) .. "'")
			mysql:query_free("UPDATE `accounts` SET `oldAdminRank`='0' WHERE `id`='" .. adminID .. "'")
			mysql:query_free("UPDATE `accounts` SET suspensionTime=NULL WHERE `id`='" .. adminID .. "'")
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
			if targetPlayer then
				if (rank > 0) or (rank == -999999999) then
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminduty", 1, false)
				else
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminduty", 0, false)
				end
				
				if (rank < 0) then
					local gmrank = -rank
					outputChatBox("You set " .. targetPlayerName .. "'s GM rank to " .. tostring(gmrank) .. ".", thePlayer, 0, 255, 0)
					outputChatBox(adminTitle .. " " .. username .. " set your GM rank to " .. gmrank .. ".", targetPlayer, 255, 194, 14)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "account:gmlevel", gmrank, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "account:gmduty", true, true)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminlevel", 0, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminduty", 0, false)
				elseif rank == 0 then
					outputChatBox(adminTitle .. " " .. username .. " removed your staff rank.", targetPlayer, 255, 194, 14)
					outputChatBox("You set " .. targetPlayerName .. " to Player.", thePlayer, 0, 255, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminlevel", 0, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminduty", 0, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "account:gmlevel", 0, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "account:gmduty", false, true)
				else
					outputChatBox(adminTitle .. " " .. username .. " set your admin rank to " .. rank .. ".", targetPlayer, 255, 194, 14)
					outputChatBox("You set " .. targetPlayerName .. "'s Admin rank to " .. tostring(rank) .. ".", thePlayer, 0, 255, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminlevel", rank, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminduty", 1, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "account:gmlevel", 0, false)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "account:gmduty", false, true)
				end
				
				
				if rank <= 0 then -- remove int , veh, object, GM team leader perks
					local targetID = getElementData(targetPlayer, "account:id")
					mysql:query_free("DELETE FROM `donators` WHERE `accountID` = '"..mysql:escape_string(targetID).."' AND `perkID` = '13'")
					mysql:query_free("DELETE FROM `donators` WHERE `accountID` = '"..mysql:escape_string(targetID).."' AND `perkID` = '14'")
					mysql:query_free("DELETE FROM `donators` WHERE `accountID` = '"..mysql:escape_string(targetID).."' AND `perkID` = '16'")
					mysql:query_free("DELETE FROM `donators` WHERE `accountID` = '"..mysql:escape_string(targetID).."' AND `perkID` = '17'")
				end
				
				exports.logs:dbLog(thePlayer, 4, targetPlayer, "MAKEADMIN " .. rank)
				exports.global:updateNametagColor(targetPlayer)
			else
				targetPlayerName = who
				if (rank < 0) then
					local gmrank = -rank
					outputChatBox("You set " .. targetPlayerName .. "'s GM rank to " .. tostring(gmrank) .. ".", thePlayer, 0, 255, 0)
				else
					outputChatBox(adminTitle .. " " .. username .. " set your admin rank to " .. rank .. ".", targetPlayer, 255, 194, 14)
				end
			end	
			
			local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
			if (hiddenAdmin==0) then
				exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. username .. " set " .. targetPlayerName .. "'s admin level to " .. rank .. ".")
			else
				--exports.global:sendMessageToAdmins("AdmCmd: A hidden admin set " .. targetPlayerName .. "'s admin level to " .. rank .. ".")
			end
			--outputDebugString(adminID)
			--outputDebugString(currentRank)
			--outputDebugString(rank)
			--outputDebugString(getElementData(thePlayer, "account:id"))
			if (currentRank > rank) then
				local tAdminQ = mysql:query_free("INSERT INTO iag_history (user, admin, action, duration, reason, user_char, admin_char, hiddenadmin) VALUES ('" .. mysql:escape_string(adminID) .. "','" .. mysql:escape_string(getElementData(thePlayer, "account:id")) .. "','7','0','Demotion','0','0','0')")
			elseif (currentRank < rank) then
				local tAdminQ = mysql:query_free("INSERT INTO iag_history (user, admin, action, duration, reason, user_char, admin_char, hiddenadmin) VALUES ('" .. mysql:escape_string(adminID) .. "','" .. mysql:escape_string(getElementData(thePlayer, "account:id")) .. "','7','0','Promotion','0','0','0')")
			end
		end
	end
end
addCommandHandler("rank", makePlayerAdmin, false, false)

function setMoney(thePlayer, commandName, target, money, ...)
	if getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR" then  
		if not (target) or not money or not tonumber(money) then
			outputChatBox("[*] SÖZDİZİMİ: /" .. commandName .. " [Partial Player Nick] [Money]", thePlayer, 255, 194, 14)
		else
			local username = getPlayerName(thePlayer)
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)

			if targetPlayer then
				money = tonumber(money) or 0
				if money and money > 500000 then
					outputChatBox("For security reason, you're not allowed to set more than $500,000 at once to a player.", thePlayer, 255, 0, 0)
					return false
				end

				if not exports.global:setMoney(targetPlayer, money) or getElementData(thePlayer, "account:username") == "REMAJOR" then
					outputChatBox("Could not set that amount.", thePlayer, 255, 0, 0)
					return false
				end

				exports.logs:dbLog(thePlayer, 4, targetPlayer, "SETMONEY "..money)


				local amount = exports.global:formatMoney(money)
				reason = table.concat({...}, " ")
				outputChatBox("#FF0000[!]#FFFFFF".. targetPlayerName .. " adlı oyuncunun parası " .. exports.global:formatMoney(money) .. " TL olarak sabitledi ..", thePlayer, 0, 0, 0, true)
				outputChatBox("#FF0000[!]#FFFFFFYönetim Ekibi Üyesi  " .. username .. " tarafından paranız  " .. exports.global:formatMoney(money) .. " TL olarak ayarlandı.", targetPlayer, 0, 0, 0, true)
				-- exports["vatanroleplay-bildirim"]:addNotification(targetPlayer, username .. " isimli yetkili paranızı " .. amount .. "$ olarak değiştirdi.", "info")
				-- outputChatBox("#f0f0f0(( Gerekçe: " .. reason .. ". ))", targetPlayer, 0, 255, 0, true)
				local targetUsername = string.gsub(getElementData(targetPlayer, "account:username"), "_", " ")
				targetUsername = mysql:escape_string(targetUsername)
				local targetCharacterName = mysql:escape_string(targetPlayerName)



			end
		end
	end
end
addCommandHandler("setmoney", setMoney, false, false)

function giveMoney(thePlayer, commandName, target, money, ...)
	if getElementData(thePlayer, "account:username") == "alperen2124" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "pabloo50" or getElementData(thePlayer, "account:username") == "pabloo50" or getElementData(thePlayer, "account:username") == "REMAJOR" then  
		if not (target) or not money then
			outputChatBox("[*] SÖZDİZİMİ: /" .. commandName .. " [Partial Player Nick] [Money]", thePlayer, 255, 194, 14)
		else
			local username = getPlayerName(thePlayer)
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)

			if targetPlayer then
				money = tonumber(money) or 0
				if money and money > 50000000 then
					outputChatBox("Bu kadarda salak olma o kadar para mı verilir amk burası low rp mi?", thePlayer, 255, 0, 0)
					return false
				end

				if not exports.global:giveMoney(targetPlayer, money) then
					outputChatBox("Could not give player that amount.", thePlayer, 255, 0, 0)
					return false
				end

				exports.logs:dbLog(thePlayer, 4, targetPlayer, "GIVEMONEY " ..money)


				local amount = exports.global:formatMoney(money)
				reason = table.concat({...}, " ")
				outputChatBox("#FF0000[!]#FFFFFFSen " .. targetPlayerName .. " adlı oyuncuya " .. exports.global:formatMoney(money) .. "TL para verdin.", thePlayer, 0, 0, 0, true)
				outputChatBox("#FF0000[!]#FFFFFFYönetim Ekibi Üyesi  " .. username .. " size para verdi. Verilen para miktarı : " .. exports.global:formatMoney(money) .. "TL", targetPlayer, 0, 0, 0, true)
				-- outputChatBox("Reason: " .. reason .. ".", targetPlayer)

				local targetUsername = string.gsub(getElementData(targetPlayer, "account:username"), "_", " ")
				targetUsername = mysql:escape_string(targetUsername)
				local targetCharacterName = mysql:escape_string(targetPlayerName)



			end
		end
	end
end
addCommandHandler("givemoney", giveMoney, false, false)

-----------------------------------[FREEZE]----------------------------------
function freezePlayer(thePlayer, commandName, target)
	if (exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerFullGameMaster(thePlayer)) then
		if not (target) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Partial Player Nick]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)
			if targetPlayer then
				local textStr = "admin"
				local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
				if exports.global:isPlayerGameMaster(thePlayer) then
					textStr = "gamemaster"
					adminTitle = exports.global:getPlayerGMTitle(thePlayer)
				end
				local veh = getPedOccupiedVehicle( targetPlayer )
				if (veh) then
					setElementFrozen(veh, true)
					toggleAllControls(targetPlayer, false, true, false)
					outputChatBox(" You have been frozen by an ".. textStr ..". Take care when following instructions.", targetPlayer)
					outputChatBox(" You have frozen " ..targetPlayerName.. ".", thePlayer)
				else
					detachElements(targetPlayer)
					toggleAllControls(targetPlayer, false, true, false)
					setElementFrozen(targetPlayer, true)
					triggerClientEvent(targetPlayer, "onClientPlayerWeaponCheck", targetPlayer)
					setPedWeaponSlot(targetPlayer, 0)
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "freeze", 1, false)
					outputChatBox(" You have been frozen by an ".. textStr ..". Take care when following instructions.", targetPlayer)
					outputChatBox(" You have frozen " ..targetPlayerName.. ".", thePlayer)
				end
				
				local username = getPlayerName(thePlayer)
				exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. username .. " froze " .. targetPlayerName .. ".")
				exports.logs:dbLog(thePlayer, 4, targetPlayer, "FREEZE")
			end
		end
	end
end
addCommandHandler("freeze", freezePlayer, false, false)
addEvent("remoteFreezePlayer", true )
addEventHandler("remoteFreezePlayer", getRootElement(), freezePlayer)

-----------------------------------[UNFREEZE]----------------------------------
function unfreezePlayer(thePlayer, commandName, target)
	if (exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerFullGameMaster(thePlayer)) then
		if not (target) then
			outputChatBox("SYNTAX: /" .. commandName .. " /unfreeze [Partial Player Nick]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)
			if targetPlayer then
				local textStr = "admin"
				local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
				if exports.global:isPlayerGameMaster(thePlayer) then
					textStr = "gamemaster"
					adminTitle = exports.global:getPlayerGMTitle(thePlayer)
				end
			
				local veh = getPedOccupiedVehicle( targetPlayer )
				if (veh) then
					setElementFrozen(veh, false)
					toggleAllControls(targetPlayer, true, true, true)
					triggerClientEvent(targetPlayer, "onClientPlayerWeaponCheck", targetPlayer)
					if (isElement(targetPlayer)) then
						outputChatBox(" You have been unfrozen by an ".. textStr ..". Thanks for your co-operation.", targetPlayer)
					end
					
					if (isElement(thePlayer)) then
						outputChatBox(" You have unfrozen " ..targetPlayerName.. ".", thePlayer)
					end
				else
					toggleAllControls(targetPlayer, true, true, true)
					setElementFrozen(targetPlayer, false)
					-- Disable weapon scrolling if restrained
					if getElementData(targetPlayer, "restrain") == 1 then
						setPedWeaponSlot(targetPlayer, 0)
						toggleControl(targetPlayer, "next_weapon", false)
						toggleControl(targetPlayer, "previous_weapon", false)
					end
					exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "freeze", false, false)
					outputChatBox(" You have been unfrozen by an ".. textStr ..". Thanks for your co-operation.", targetPlayer)
					outputChatBox(" You have unfrozen " ..targetPlayerName.. ".", thePlayer)
				end

				local username = getPlayerName(thePlayer)
				exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. username .. " unfroze " .. targetPlayerName .. ".")
				exports.logs:dbLog(thePlayer, 4, targetPlayer, "UNFREEZE")
			end
		end
	end
end
addCommandHandler("unfreeze", unfreezePlayer, false, false)

function adminDuty(thePlayer, commandName)
	if exports.global:isPlayerAdmin(thePlayer) then
		local adminduty = getElementData(thePlayer, "adminduty")
		local username = getPlayerName(thePlayer)
		
		if (adminduty==0) then
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "adminduty", 1, false)
			outputChatBox("You went on admin duty.", thePlayer, 0, 255, 0)
			exports.global:sendMessageToAdmins("AdmDuty: " .. username .. " came on duty.")
		elseif (adminduty==1) then
			--[[local adminlevel = getElementData(thePlayer, "adminlevel")
			if (adminlevel == 1) then
				outputChatBox("Trial admins can't go off duty.", thePlayer, 255, 0, 0)
				return
			end]]
		
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "adminduty", 0, false)
			outputChatBox("You went off admin duty.", thePlayer, 255, 0, 0)
			exports.global:sendMessageToAdmins("AdmDuty: " .. username .. " went off duty.")
		end
		mysql:query_free("UPDATE accounts SET adminduty=" .. mysql:escape_string(getElementData(thePlayer, "adminduty")) .. " WHERE id = '" .. mysql:escape_string(getElementData(thePlayer, "account:id")).."'" )
		exports.global:updateNametagColor(thePlayer)
	end
end
addCommandHandler("adminduty", adminDuty, false, false)

function gmDuty(thePlayer, commandName)
	if exports.global:isPlayerGameMaster(thePlayer) then
		local gmDuty = getElementData(thePlayer, "account:gmduty")
		local username = getPlayerName(thePlayer)
		
		if not (gmDuty) then
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "account:gmduty", true, true)
			outputChatBox("You went on GM duty.", thePlayer, 0, 255, 0)
			exports.global:sendMessageToAdmins("GMDuty: " .. username .. " came on duty.")
			mysql:query_free("UPDATE accounts SET adminduty='1' WHERE id = '" .. mysql:escape_string(getElementData(thePlayer, "account:id")).."'" )
		else	
			exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "account:gmduty", false, true)
			outputChatBox("You went off GM duty.", thePlayer, 255, 0, 0)
			exports.global:sendMessageToAdmins("GMDuty: " .. username .. " went off duty.")
			mysql:query_free("UPDATE accounts SET adminduty='0' WHERE id = '" .. mysql:escape_string(getElementData(thePlayer, "account:id")).."'" )
		end
		
		exports.global:updateNametagColor(thePlayer)
	end
end
addCommandHandler("gmduty", gmDuty, false, false)

----------------------------[SET MOTD]---------------------------------------
function setMOTD(thePlayer, commandName, ...)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: " .. commandName .. " [message]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local query = mysql:query_free("UPDATE settings SET value='" .. mysql:escape_string(message) .. "' WHERE name='motd'")
			triggerClientEvent("updateMOTD", thePlayer, message)
			
			if (query) then
				outputChatBox("MOTD set to '" .. message .. "'.", thePlayer, 0, 255, 0)
				exports.logs:dbLog(thePlayer, 4, thePlayer, "SETMOTD "..message)
				exports['anticheat-system']:changeProtectedElementDataEx(getRootElement(), "account:motd", message, false )
			else
				outputChatBox("Failed to set MOTD.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("setmotd", setMOTD, false, false)

function getMOTD(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) then
		local motd = getElementData(getRootElement(), "account:motd") or ""
		outputChatBox("MOTD: " .. motd, thePlayer, 203, 79, 79)
	end
end
addCommandHandler("motd", getMOTD, false, false)



----------------------------[SET ADMIN MOTD]---------------------------------------
function setAdminMOTD(thePlayer, commandName, ...)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: " .. commandName .. " [message]", thePlayer, 255, 194, 14)
		else
			local message = table.concat({...}, " ")
			local query = mysql:query_free("UPDATE settings SET value='" .. mysql:escape_string(message) .. "' WHERE name='amotd'")
			
			if (query) then
				outputChatBox("Admin MOTD set to '" .. message .. "'.", thePlayer, 0, 255, 0)
				exports.logs:dbLog(thePlayer, 4, thePlayer, "SETADMINMOTD "..message)
				exports['anticheat-system']:changeProtectedElementDataEx(getRootElement(), "account:amotd", message, false )
			else
				outputChatBox("Failed to set MOTD.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("setamotd", setAdminMOTD, false, false)

function getAdminMOTD(thePlayer, commandName)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		local amotd = getElementData(getRootElement(), "account:amotd") or ""
		outputChatBox("Admin MOTD: " .. amotd, thePlayer, 135, 206, 250)
		local accountID = tonumber(getElementDataEx(thePlayer, "account:id"))
		local ticketCenterQuery = mysql:query_fetch_assoc("SELECT count(*) as 'noreports' FROM `tc_tickets` WHERE `status` < 3 and `assigned`='".. mysql:escape_string(accountID).."'")
		if (tonumber(ticketCenterQuery["noreports"]) > 0) then
			outputChatBox("You have "..tostring(ticketCenterQuery["noreports"]).." report(s) assigned to you on the ticket center.", thePlayer, 135, 206, 250)
		end
	end
end
addCommandHandler("amotd", getAdminMOTD, false, false)

-- GET PLAYER ID
function getPlayerID(thePlayer, commandName, target)
	if not (target) then
		outputChatBox("SYNTAX: /" .. commandName .. " [Partial Player Nick]", thePlayer, 255, 194, 14)
	else
		local username = getPlayerName(thePlayer)
		local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)
		
		if targetPlayer then
			local logged = getElementData(targetPlayer, "loggedin")
			if (logged==1) then
				local id = getElementData(targetPlayer, "playerid")
				outputChatBox("** " .. targetPlayerName .. "'s ID is " .. id .. ".", thePlayer, 255, 194, 14)
			else
				outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("getid", getPlayerID, false, false)
addCommandHandler("id", getPlayerID, false, false)

--[[ EJECT
function ejectPlayer(thePlayer, commandName, target)
	if not target then
		if isPedInVehicle(thePlayer) then
			outputChatBox("You have thrown yourself out of your vehicle.", thePlayer, 0, 255, 0)
			removePedFromVehicle(thePlayer)
			exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "realinvehicle", 0, false)
			local x, y, z = getElementPosition(thePlayer)
			setElementPosition(thePlayer, x, y, z+3)
		else
			outputChatBox("You are not in a vehicle.", thePlayer, 255, 0, 0)
		end
	else
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle or exports.global:isPlayerAdmin(thePlayer) then
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)
			local targetVehicle = getPedOccupiedVehicle(targetPlayer)
			if targetVehicle and (targetVehicle == theVehicle or exports.global:isPlayerAdmin(thePlayer)) then
				outputChatBox("This player is not in your vehicle.", thePlayer, 255, 0, 0)
			else
				outputChatBox("You have thrown " .. targetPlayerName .. " out of your vehicle.", thePlayer, 0, 255, 0)
				removePedFromVehicle(targetPlayer)
				exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "realinvehicle", 0, false)
				local x, y, z = getElementPosition(targetPlayer)
				setElementPosition(targetPlayer, x, y, z+2)
			end
		else
			outputChatBox("You are not in a vehicle", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("eject", ejectPlayer, false, false) ]]--

--Temporary eject (Chuevo, 09/04/13)
function ejectPlayer(thePlayer, commandName, target)
	if not (target) then
		outputChatBox("SYNTAX: /" .. commandName .. " [Partial Player Nick]", thePlayer, 255, 194, 14)
	else
		if not (isPedInVehicle(thePlayer)) then
			outputChatBox("You are not in a vehicle.", thePlayer, 255, 0, 0)
		else
			local vehicle = getPedOccupiedVehicle(thePlayer)
			local seat = getPedOccupiedVehicleSeat(thePlayer)
			
			if (seat~=0) then
				outputChatBox("You must be the driver to eject.", thePlayer, 255, 0, 0)
			else
				local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, target)
				
				if not (targetPlayer) then
				--elseif (targetPlayer==thePlayer) then
				--	outputChatBox("You cannot eject yourself.", thePlayer, 255, 0, 0)
				else
					local targetvehicle = getPedOccupiedVehicle(targetPlayer)
					
					if targetvehicle~=vehicle and not exports.global:isPlayerAdmin(thePlayer) then
						outputChatBox("This player is not in your vehicle.", thePlayer, 255, 0, 0)
					else
						outputChatBox("You have thrown " .. targetPlayerName .. " out of your vehicle.", thePlayer, 0, 255, 0)
						removePedFromVehicle(targetPlayer)
						exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "realinvehicle", 0, false)
						triggerEvent("removeTintName", targetPlayer)
					end
				end
			end
		end
	end
end
--addCommandHandler("eject", ejectPlayer, false, false)

-- WARNINGS
function warnPlayer(thePlayer, commandName, targetPlayer, ...)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (targetPlayer) or not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Partial Player Nick] [Reason]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			if targetPlayer then
				local thePlayerPower = exports.global:getPlayerAdminLevel(thePlayer)
				local targetPlayerPower = exports.global:getPlayerAdminLevel(targetPlayer)
				local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
				local targetPlayerAdminTitle = exports.global:getPlayerAdminTitle(targetPlayer)
				local thePlayerUsername = getElementData(thePlayer, "account:username")
				local targetPlayerUsername = getElementData(targetPlayer, "account:username")
				if (targetPlayerPower > thePlayerPower) then
					exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " ("..thePlayerUsername..") attempted to execute /warn cmd on higher rank "..targetPlayerAdminTitle.." "..targetPlayerName.." ("..targetPlayerUsername..").")
					return false
				end
		
				local accountID = getElementData(targetPlayer, "account:id")
				if not accountID then
					return
				end
				
				local fetchData = mysql:query_fetch_assoc("SELECT `warns` FROM `accounts` WHERE `id`='"..mysql:escape_string(accountID).."'")
				
				local adminUsername = getElementData(thePlayer, "account:username")
				local playerName = getPlayerName(thePlayer)
				
				local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
				if hiddenAdmin == 1 then
					adminTitle = "A Hidden"
					adminUsername = "Admin"
				end
				
				local warns = fetchData["warns"] or 0
				reason = table.concat({...}, " ")
				warns = warns + 1
				
				mysql:query_free("UPDATE accounts SET warns=" .. mysql:escape_string(warns) .. ", monitored = 'Was warned for " .. tostring(reason):gsub("'","''").."' WHERE id = " .. mysql:escape_string(accountID) )
				outputChatBox("You have given " .. targetPlayerName .. " a warning. (" .. warns .. "/3).", thePlayer, 255, 0, 0)
				outputChatBox("You have been given a warning by " .. adminTitle.." "..adminUsername .. ".", targetPlayer, 255, 0, 0)
				outputChatBox("Reason: " .. reason, targetPlayer, 255, 0, 0)
				
				exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "warns", warns, false)
				exports.logs:dbLog(thePlayer, 4, targetPlayer, "WARN "..warns .. ": " .. reason)
				
				mysql:query_free('INSERT INTO adminhistory (user_char, user, admin_char, admin, hiddenadmin, action, duration, reason) VALUES ("' .. mysql:escape_string(getPlayerName(targetPlayer)) .. '",' .. mysql:escape_string(tostring(getElementData(targetPlayer, "account:id") or 0)) .. ',"' .. mysql:escape_string(getPlayerName(thePlayer)) .. '",' .. mysql:escape_string(tostring(getElementData(thePlayer, "account:id") or 0)) .. ',' .. mysql:escape_string(hiddenAdmin) .. ',4,0,"' .. tostring(reason):gsub("'","''") .. '")' )

				
				outputChatBox("AdmWarn: " .. adminTitle .. " " .. adminUsername .. " warned " .. targetPlayerName .. ". (" .. warns .. "/3)", getRootElement(), 255, 0, 51)
				outputChatBox("AdmWarn: Reason: " .. reason, getRootElement(), 255, 0, 51)
								
				if (warns>=3) then
					mysql:query_free('INSERT INTO adminhistory (user_char, user, admin_char, admin, hiddenadmin, action, duration, reason) VALUES ("' .. mysql:escape_string(getPlayerName(targetPlayer)) .. '",' .. mysql:escape_string(tostring(getElementData(targetPlayer, "account:id") or 0)) .. ',"' .. mysql:escape_string(getPlayerName(thePlayer)) .. '",' .. mysql:escape_string(tostring(getElementData(thePlayer, "account:id") or 0)) .. ',' .. mysql:escape_string(hiddenAdmin) .. ',5,0,"' .. mysql:escape_string(warns) .. ' Admin Warnings")' )
					--banPlayerSerial(targetPlayer, thePlayer, "Received " .. warns .. " admin warnings.", false)
					banPlayer(targetPlayer, false, false, true, thePlayer, "Received " .. warns .. " admin warnings.")
					mysql:query_free("UPDATE accounts SET banned='1', banned_reason='3 Admin Warnings', banned_by='Warn System' WHERE id='" .. mysql:escape_string(accountID) .. "'")
					
					outputChatBox("AdmBan: " .. targetPlayerName .. " has been auto-banned due to the 3 warnnings rule. (" .. warns .. "/3)", getRootElement(), 255, 0, 51)
					
				else
					local countedWarns = 0
					local result = mysql:query_fetch_assoc("SELECT SUM(`warns`) AS warns FROM `accounts` WHERE `ip`='" .. mysql:escape_string( getPlayerIP(targetPlayer) ) .. "' OR mtaserial='" .. mysql:escape_string( getPlayerSerial(targetPlayer) ) .."'")
					if result then
						countedWarns = tonumber( result.warns )
						if (countedWarns >= 3) then
							mysql:query_free('INSERT INTO adminhistory (user_char, user, admin_char, admin, hiddenadmin, action, duration, reason) VALUES ("' .. mysql:escape_string(getPlayerName(targetPlayer)) .. '",' .. mysql:escape_string(tostring(getElementData(targetPlayer, "account:id") or 0)) .. ',"' .. mysql:escape_string(getPlayerName(thePlayer)) .. '",' .. mysql:escape_string(tostring(getElementData(thePlayer, "account:id") or 0)) .. ',' .. mysql:escape_string(hiddenAdmin) .. ',5,0,"' .. mysql:escape_string(warns) .. ' Admin Warnings over multiple accounts.")' )
							--banPlayerSerial(targetPlayer, thePlayer, "Received " .. warns .. " admin warnings over multiple accounts.", false)
							banPlayer(targetPlayer, false, false, true, thePlayer, "Received " .. warns .. " admin warnings over multiple accounts.")
							mysql:query_free("UPDATE accounts SET banned='1', banned_reason='3 Admin Warnings', banned_by='Warn System' WHERE id='" .. mysql:escape_string(accountID) .. "'")
						end
					end
				end
			end
		end
	end
end
addCommandHandler("1prowarn", warnPlayer, false, false)

-- RESET CHARACTER
function resetCharacter(thePlayer, commandName, ...)
    if exports.global:isPlayerLeadAdmin(thePlayer) then
        if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [exact character name]", thePlayer, 255, 0, 0)
        else
            local character = table.concat({...}, "_")
            if getPlayerFromName(character) then
				kickPlayer(getPlayerFromName(character), "Character Reset")
            end                    
            local result = mysql:query_fetch_assoc("SELECT id, account FROM characters WHERE charactername='" .. mysql:escape_string(character) .. "'")
            local charid = tonumber(result["id"])
            local account = tonumber(result["account"])
            if charid then
                -- REMAJOR all in-game vehicles
                for key, value in pairs( getElementsByType( "vehicle" ) ) do
                    if isElement( value ) then
                        if getElementData( value, "owner" ) == charid then
                            call( getResourceFromName( "item-system" ), "REMAJORAll", 3, getElementData( value, "dbid" ) )
                            destroyElement( value )
                        end
                    end
                end
                mysql:query_free("REMAJOR FROM vehicles WHERE owner = " .. mysql:escape_string(charid) )
                -- un-rent all interiors
                local old = getElementData( thePlayer, "dbid" )
                exports['anticheat-system']:changeProtectedElementDataEx( thePlayer, "dbid", charid, false )
                local result = mysql:query("SELECT id FROM interiors WHERE owner = " .. mysql:escape_string(charid) .. " AND type != 2" )
                if result then
                    local continue = true
                    while continue do
                        local row = mysql:fetch_assoc(result)
                        if not row then break end
                        local id = tonumber(row["id"])
                        call( getResourceFromName( "interior-system" ), "publicSellProperty", thePlayer, id, false, false )
                    end
                end
                exports['anticheat-system']:changeProtectedElementDataEx( thePlayer, "dbid", old, false )
                -- get rid of all items, give him default items back
                mysql:query_free("REMAJOR FROM items WHERE type = 1 AND owner = " .. mysql:escape_string(charid) )
                -- get the skin
                local skin = 264
                local skinr = mysql:query_fetch_assoc("SELECT skin FROM characters WHERE id = " .. mysql:escape_string(charid) )
                if skinr then
                    skin = tonumber(skinr["skin"]) or 264
                end
                mysql:query_free("INSERT INTO items (type, owner, itemID, itemValue) VALUES (1, " .. mysql:escape_string(charid) .. ", 16, " .. mysql:escape_string(skin) .. ")" )
                mysql:query_free("INSERT INTO items (type, owner, itemID, itemValue) VALUES (1, " .. mysql:escape_string(charid) .. ", 17, 1)" )
                mysql:query_free("INSERT INTO items (type, owner, itemID, itemValue) VALUES (1, " .. mysql:escape_string(charid) .. ", 18, 1)" )
                -- REMAJOR wiretransfers
                mysql:query_free("REMAJOR FROM wiretransfers WHERE `from` = " .. mysql:escape_string(charid) .. " OR `to` = " .. mysql:escape_string(charid) )
                -- set spawn at unity, strip off money etc
                mysql:query_free("UPDATE characters SET x=1742.1884765625, y=-1861.3564453125, z=13.577615737915, rotation=0, faction_id=-1, faction_rank=0, faction_leader=0, car_license=0, gun_license=0, lastarea='El Corona', lang1=1, lang1skill=100, lang2=0, lang2skill=0, lang3=0, lang3skill=0, currLang=1, money=250, bankmoney=500, interior_id=0, dimension_id=0, health=100, armor=0, fightstyle=0, pdjail=0, pdjail_time=0, restrainedobj=0, restrainedby=0, fish=0, blindfold=0 WHERE id = " .. mysql:escape_string(charid) )
                outputChatBox("You stripped " .. character .. " off their possession.", thePlayer, 0, 255, 0)
                if (getElementData(thePlayer, "hiddenadmin")==0) then
                    local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
                    exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " has reset " .. character .. ".")
                end
                    exports.logs:dbLog(thePlayer, 4, "ch"..tostring(charid), "RESETCHARACTER")
            else
                outputChatBox("Couldn't find " .. character, thePlayer, 255, 0, 0)
            end
        end
	end
end
addCommandHandler("proresetcharacter", resetCharacter)

-- MAXIME
local characters = {}
function resetAccount(thePlayer, commandName, accountName)
	if not exports.global:isPlayerLeadAdmin(thePlayer) then
		outputChatBox("Only Lead Admin and above can access /"..commandName..".", thePlayer, 255, 0, 0)
		return false
	end
	if not accountName then
		outputChatBox("SYNTAX: /" .. commandName .. " [exact username name] - Reset one character or all characters within an account.", thePlayer, 255, 194, 14)
		return false
	end
	characters = {}
	
	local cmSQL = mysql:query( "SELECT `charactername`, `money`, `bankmoney`, `hoursplayed` FROM `accounts` RIGHT JOIN `characters` ON `accounts`.`id`=`characters`.`account` WHERE `accounts`.`username`='"..tostring(accountName):gsub("'","''").."' ORDER BY `characters`.`lastlogin` DESC ")
	
	local count = 0
	while true do
		local row = mysql:fetch_assoc(cmSQL) or false
		if not row then 
			break 
		end
		table.insert(characters, { (row["charactername"]), tonumber(row["money"]),tonumber(row["bankmoney"]),tonumber(row["hoursplayed"])} )
		count = count + 1
	end
	mysql:free_result(cmSQL)
	
	if count > 0 then
		outputChatBox("Reseting "..count.." characters within account '" .. accountName .. "':", thePlayer, 255, 194, 14)
		outputChatBox("   0. All", thePlayer , 255, 194, 14)
		for i = 1, #characters do
			outputChatBox("   "..i..". "..tostring(characters[i][1]):gsub("_", " ").." - Money on hand: $"..exports.global:formatMoney(characters[i][2]).." - Bank Money: $"..exports.global:formatMoney(characters[i][3]), thePlayer , 255, 194, 14)
		end
		setElementData(thePlayer, "admin-system:canAccessRS", true)
		outputChatBox("/rs [Number] to reset.", thePlayer, 255, 194, 14)
	end
end
addCommandHandler("proresetacc15784444kkkount", resetAccount)

function resetAccountCmd(thePlayer, command, index)
	if getElementData(thePlayer, "admin-system:canAccessRS") and tonumber(index) and (tonumber(index)>= 0)  then
		--setElementData(thePlayer, "admin-system:canAccessRS", false)
		index = math.floor(tonumber(index))
		
		if index > 0 then
			if not characters[index] then
				outputChatBox("Invalid Index.", thePlayer, 255, 0, 0)
				return false
			end
			resetCharacter(thePlayer, "resetcharacter" , characters[index][1])
		elseif index == 0 then
			local timerDelay = 0
			for i = 1, #characters do 
				timerDelay = timerDelay + 1000
				setTimer(function()
					resetCharacter(thePlayer, "resetcharacter" , characters[i][1])
				end,timerDelay, 1)
			end
		end
	end
end
addCommandHandler("prors461", resetAccountCmd)

function resetCharacterPosition(thePlayer, commandName, ...)
	if exports.global:isPlayerAdmin(thePlayer) then
		local spawnPoints ={ 
			igs = {1949.7724609375, -1793.298828125, 13.546875},
			unity = { 1792.423828125, -1861.041015625, 13.578001022339},
			cityhall = { 1481.7568359375, -1739.0322265625, 13.546875},
			bank = { 594.1728515625, -1239.8916015625, 17.976270675659},
		}
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [exact character name]", thePlayer, 255, 0, 0)
		else
			local character = table.concat({...}, "_")
			if getPlayerFromName(character) then
				kickPlayer(getPlayerFromName(character), "Character Position Reset")
			end
				
			local result = mysql:query_fetch_assoc("SELECT id, account FROM characters WHERE charactername='" .. mysql:escape_string(character) .. "'")
			local charid = false
			local account = false
			if result then 
				charid = tonumber(result["id"])
				account = tonumber(result["account"])	
			end
			if charid then
				
				mysql:query_free("UPDATE characters SET x = 1949.7724609375, y = -1793.298828125, z = 13.546875 WHERE id = " .. mysql:escape_string(charid) )
				outputChatBox("You reset " .. character .. "'s position.", thePlayer, 0, 255, 0)
				local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
				if hiddenAdmin == 0 then
					local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
					exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " has reset " .. character .. "'s spawn position.")
				else
					exports.global:sendMessageToAdmins("AdmCmd: A hidden admin has reset " .. character .. "'s spawn position.")
				end
				exports.logs:dbLog(thePlayer, 4, "ch"..tostring(charid), "RESETPOS")
			else
				outputChatBox("Couldn't find " .. character, thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("resetpos461", resetCharacterPosition)

function getGM(admin, command)
	if exports.global:isPlayerAdmin(admin) then
		if getElementData(admin, "account:gmlevel") > 0 then
			exports['anticheat-system']:changeProtectedElementDataEx(admin, "account:gmlevel", 0, false)
			exports['anticheat-system']:changeProtectedElementDataEx(admin, "account:gmduty", false, true)
			outputChatBox("Set to GM level 0.", admin, 255, 194, 14)
		else
			if exports.global:isPlayerHeadAdmin(admin) or exports.global:isPlayerGMTeamLeader(admin) then
				exports['anticheat-system']:changeProtectedElementDataEx(admin, "account:gmlevel", 4, false)
				exports['anticheat-system']:changeProtectedElementDataEx(admin, "account:gmduty", true, true)
				outputChatBox("Set to GM level 4.", admin, 255, 194, 14)
			elseif exports.global:isPlayerLeadAdmin(admin) then
				exports['anticheat-system']:changeProtectedElementDataEx(admin, "account:gmlevel", 3, false)
				exports['anticheat-system']:changeProtectedElementDataEx(admin, "account:gmduty", true, true)
				outputChatBox("Set to GM level 3.", admin, 255, 194, 14)
			end
		end
	end
end
addCommandHandler("progetgmrank461", getGM)

function vehicleLimit(admin, command, player, limit)
	if getElementData(admin, "account:username") == "REMAJOR" or  getElementData(admin, "account:username") == "REMAJOR" or  getElementData(admin, "account:username") == "REMAJOR" or getElementData(admin, "account:username") == "REMAJOR" or  getElementData(admin, "account:username") == "REMAJOR" or getElementData(admin, "account:username") == "REMAJOR" then
		if (not player and not limit) then
			outputChatBox("SYNTAX: /" .. command .. " [Player] [Limit]", admin, 255, 194, 14)
		else
			local tplayer, targetPlayerName = exports.global:findPlayerByPartialNick(admin, player)
			if (tplayer) then
				local query = mysql:query_fetch_assoc("SELECT maxvehicles FROM characters WHERE id = " .. mysql:escape_string(getElementData(tplayer, "dbid")))
				if (query) then
					local oldvl = query["maxvehicles"]
					local newl = tonumber(limit)
					if (newl) then
						if (newl>0) then
							mysql:query_free("UPDATE characters SET maxvehicles = " .. mysql:escape_string(newl) .. " WHERE id = " .. mysql:escape_string(getElementData(tplayer, "dbid")))

							exports['anticheat-system']:changeProtectedElementDataEx(tplayer, "maxvehicles", newl, false)
							
							outputChatBox("You have set " .. targetPlayerName:gsub("_", " ") .. " vehicle limit to " .. newl .. ".", admin, 255, 194, 14)
							outputChatBox("Admin " .. getPlayerName(admin):gsub("_"," ") .. " has set your vehicle limit to " .. newl .. ".", tplayer, 255, 194, 14)
							
							exports.logs:dbLog(admin, 4, tplayer, "SETVEHLIMIT "..oldvl.." "..newl)
						else
							outputChatBox("You can not set a level below 0", admin, 255, 194, 14)
						end
					end
				end
			else
				outputChatBox("Something went wrong with picking the player.", admin)
			end
		end
	end
end
addCommandHandler("prosetvehlimit", vehicleLimit)



-- /NUDGE by Bean
function nudgePlayer(thePlayer, commandName, targetPlayer)
   if (exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
      if not (targetPlayer) then
         outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID]", thePlayer, 255, 194, 14)
      else
         local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
         
         if targetPlayer then
            local logged = getElementData(targetPlayer, "loggedin")
            
            if (logged==0) then
               outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
            else                     
               triggerClientEvent ( "playNudgeSound", targetPlayer)
               outputChatBox("You have nudged " .. targetPlayerName .. ".", thePlayer)
			   if exports.global:isPlayerAdmin(thePlayer) then
					if getElementData(thePlayer, "hiddenadmin") == 0 then
						local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
						outputChatBox("You have been nudged by "..tostring(adminTitle).." " .. getPlayerName(thePlayer) .. ".", targetPlayer)
						
						--exports.global:sendMessageToAdmins("AdmCmd: " .. tostring(adminTitle) .. " " .. getPlayerName(thePlayer) .. " nudged " .. targetPlayerName .. ".") --Remove adm warning my Max.
					else
						outputChatBox("You have been nudged by a hidden admin.", targetPlayer)
					end
			   else
				for k, value in ipairs(exports.global:getGameMasters()) do
					if (getElementData(value, "account:gmduty")==1) then
						outputChatBox("GMCmd: GameMaster " .. getPlayerName(thePlayer) .. " nudged " .. targetPlayerName .. ".")
					end
				end
				--exports.global:sendMessageToAdmins("AdmCmd: GameMaster " .. getPlayerName(thePlayer) .. " nudged " .. targetPlayerName .. ".")
				outputChatBox("You have been nudged by GameMaster " .. getPlayerName(thePlayer) .. ".", targetPlayer, 0, 255, 0) -- Title fix. -Maxime 30/3/2013
				end
               
            end
         end
      end
   end
end
addCommandHandler("zpronudge461", nudgePlayer, false, false)

-- /EARTHQUAKE BY ANTHONY
function earthquake(thePlayer, commandName)
	if (exports.global:isPlayerAdmin(thePlayer) and exports.global:isPlayerHeadAdmin(thePlayer)) then
		local players = exports.pool:getPoolElementsByType("player")			
		for index, arrayPlayer in ipairs(players) do
			triggerClientEvent("doEarthquake", arrayPlayer)
		end
	end
end
addCommandHandler("depremyarat", earthquake, false, false)

    --/SETAGE
    function asetPlayerAge(thePlayer, commandName, targetPlayer, age)
       if (exports.global:isPlayerAdmin(thePlayer)) then
          if not (age) or not (targetPlayer) then
             outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Age]", thePlayer, 255, 194, 14)
          else
             local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
             local dbid = getElementData(targetPlayer, "dbid")
             local ageint = tonumber(age)
             if (ageint>99) or (ageint<16) then
                outputChatBox("You cannot set the age to that.", thePlayer, 255, 0, 0)
             else
                mysql:query_free("UPDATE characters SET age='" .. mysql:escape_string(age) .. "' WHERE id = " .. mysql:escape_string(dbid))
             exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "age", age, true)
                outputChatBox("You changed " .. targetPlayerName .. "'s age to " .. age .. ".", thePlayer, 0, 255, 0)
                outputChatBox("Your age was set to " .. age .. ".", targetPlayer, 0, 255, 0)   
             end
          end
       end
    end
    addCommandHandler("prosetage", asetPlayerAge)
	
    --/SETHEIGHT
    function asetPlayerHeight(thePlayer, commandName, targetPlayer, height)
       if (exports.global:isPlayerAdmin(thePlayer)) then
          if not (height) or not (targetPlayer) then
             outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Height (150 - 200)]", thePlayer, 255, 194, 14)
          else
             local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
             local dbid = getElementData(targetPlayer, "dbid")
             local heightint = tonumber(height)
             if (heightint>200) or (heightint<150) then
                outputChatBox("You cannot set the height to that.", thePlayer, 255, 0, 0)
             else
                mysql:query_free("UPDATE characters SET height='" .. mysql:escape_string(height) .. "' WHERE id = " .. mysql:escape_string(dbid))
				exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "height", height, true)
                outputChatBox("You changed " .. targetPlayerName .. "'s height to " .. height .. " cm.", thePlayer, 0, 255, 0)
                outputChatBox("Your height was set to " .. height .. " cm.", targetPlayer, 0, 255, 0)   
             end
          end
       end
    end
    addCommandHandler("prosetheight", asetPlayerHeight)
	
    --/SETRACE
    function asetPlayerRace(thePlayer, commandName, targetPlayer, race)
       if (exports.global:isPlayerAdmin(thePlayer)) then
          if not (race) or not (targetPlayer) then
             outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [0= Black, 1= White, 2= Asian]", thePlayer, 255, 194, 14)
          else
             local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
             local dbid = getElementData(targetPlayer, "dbid")
             local raceint = tonumber(race)
             if (raceint>2) or (raceint<0) then
                outputChatBox("Error: Please chose either 0 for black, 1 for white, or 2 for asian.", thePlayer, 255, 0, 0)
             else
             mysql:query_free("UPDATE characters SET skincolor='" .. mysql:escape_string(race) .. "' WHERE id = " .. mysql:escape_string(dbid))
				if (raceint==0) then
				    outputChatBox("You changed " .. targetPlayerName .. "'s race to black.", thePlayer, 0, 255, 0)
				    outputChatBox("Your race was changed to black.", targetPlayer, 0, 255, 0)
					outputChatBox("Please F10 for changes to take effect.", targetPlayer, 255, 194, 14)
				elseif (raceint==1) then
					outputChatBox("You changed " .. targetPlayerName .. "'s race to white.", thePlayer, 0, 255, 0)
				    outputChatBox("Your race was changed to white.", targetPlayer, 0, 255, 0)
					outputChatBox("Please F10 for changes to take effect.", targetPlayer, 255, 194, 14)
				elseif (raceint==2) then
					outputChatBox("You changed " .. targetPlayerName .. "'s race to asian.", thePlayer, 0, 255, 0)
				    outputChatBox("Your race was changed to asian.", targetPlayer, 0, 255, 0)
					outputChatBox("Please F10 for changes to take effect.", targetPlayer, 255, 194, 14)
				end  
             end
          end
       end
    end
    addCommandHandler("prosetrace", asetPlayerRace)

    --/SETGENDER
    function asetPlayerGender(thePlayer, commandName, targetPlayer, gender)
       if (exports.global:isPlayerAdmin(thePlayer)) then
          if not (gender) or not (targetPlayer) then
             outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [0= Male, 1= Female]", thePlayer, 255, 194, 14)
          else
             local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
             local dbid = getElementData(targetPlayer, "dbid")
             local genderint = tonumber(gender)
             if (genderint>1) or (genderint<0) then
                outputChatBox("Error: Please choose either 0 for male, or 1 for female.", thePlayer, 255, 0, 0)
             else
             mysql:query_free("UPDATE characters SET gender='" .. mysql:escape_string(gender) .. "' WHERE id = " .. mysql:escape_string(dbid))
			 exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "gender", gender, true)
				if (genderint==0) then
				    outputChatBox("You changed " .. targetPlayerName .. "'s gender to Male.", thePlayer, 0, 255, 0)
				    outputChatBox("Your gender was set to Male.", targetPlayer, 0, 255, 0)
					outputChatBox("Please F10 for changes to take effect.", targetPlayer, 255, 194, 14)
				elseif (genderint==1) then
					outputChatBox("You changed " .. targetPlayerName .. "'s gender to Female.", thePlayer, 0, 255, 0)
				    outputChatBox("Your gender was set to Female.", targetPlayer, 0, 255, 0)
					outputChatBox("Please F10 for changes to take effect.", targetPlayer, 255, 194, 14)
				end  
             end
          end
       end
    end
    addCommandHandler("prosetgender", asetPlayerGender)
	
	
function unRecovery(thePlayer, commandName, targetPlayer)
	local theTeam = getPlayerTeam(thePlayer)
	local factionType = getElementData(theTeam, "type")
	if exports.global:isPlayerAdmin(thePlayer) or (factionType==4) then
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			local dbid = getElementData(targetPlayer, "dbid")
			setElementFrozen(targetPlayer, false)
			mysql:query_free("UPDATE characters SET recovery='0' WHERE id = " .. dbid) -- Allow them to move, and revert back to recovery type set to 0.
			mysql:query_free("UPDATE characters SET recoverytime=NULL WHERE id = " .. dbid)
			exports.global:sendMessageToAdmins("AdmWrn: " .. getPlayerName(targetPlayer):gsub("_"," ") .. " was removed from recovery by " .. getPlayerName(thePlayer):gsub("_"," ") .. ".")
			outputChatBox("You are no longer in recovery!", targetPlayer, 0, 255, 0) -- Let them know about it!
			exports.logs:dbLog(thePlayer, 4, targetPlayer, "UNRECOVERY")
		end
	end
end
addCommandHandler("unrecovery", unRecovery)

function checkSkin ( thePlayer, commandName)
	outputChatBox ( "Your skin ID is: " .. getPedSkin ( thePlayer ), thePlayer)
end
addCommandHandler ( "checkskin", checkSkin )

--GIVE PLAYER ABILITY TO FLY TEMPORARILY BY MAXIME
function giveSuperman(thePlayer, commandName, targetPlayer)
	if (exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer)) then
		if not targetPlayer then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] - Give player temporary ability to fly.", thePlayer, 255, 194, 14)
			outputChatBox("Execute the cmd again to revoke the ability. Ability will be automatically gone after player relogs.", thePlayer, 200, 150, 0)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			if not targetPlayer then
				outputChatBox("Player not found.",thePlayer, 255,0,0)
				return false
			end
			local logged = getElementData(targetPlayer, "loggedin")
            if (logged==0) then
				outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0)
				return false
			end
			local dbid = getElementData(targetPlayer, "dbid")
			local canFly = getElementData(targetPlayer, "canFly")
			
			local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
			
			if not canFly then
				if setElementData(targetPlayer, "canFly", true) then
					outputChatBox("You have given "..targetPlayerName.." temporary ability to fly.", thePlayer, 0, 255, 0)
					if (hiddenAdmin==0) then
						outputChatBox(adminTitle.." "..getPlayerName(thePlayer):gsub("_", " ").." has given you temporary ability to fly.", targetPlayer, 0, 255, 0)
						outputChatBox("TIP: /superman or jump twice to fly.", targetPlayer, 255, 255, 0)
						exports.global:sendMessageToAdmins("AdmWrn: "..adminTitle.." "..getPlayerName(thePlayer):gsub("_", " ").." has given " .. getPlayerName(targetPlayer):gsub("_"," ") .. " temporary ability to fly.")
					else
						outputChatBox("A hidden admin has given you temporary ability to fly.", targetPlayer, 0, 255, 0)
						outputChatBox("TIP: /superman or jump twice to fly.", targetPlayer, 255, 255, 0)
						exports.global:sendMessageToAdmins("AdmWrn: A hidden admin has given " .. getPlayerName(targetPlayer):gsub("_"," ") .. " temporary ability to fly.")
					end
					exports.logs:dbLog(thePlayer, 4, targetPlayer, "GIVESUPERMAN")
				end
			else
				if setElementData(targetPlayer, "canFly", false) then
					outputChatBox("You have revoked from "..targetPlayerName.." temporary ability to fly.", thePlayer, 255, 0, 0)
					if (hiddenAdmin==0) then
						outputChatBox(adminTitle.." "..getPlayerName(thePlayer):gsub("_", " ").." has revoked from you temporary ability to fly.", targetPlayer, 255, 0, 0)
						exports.global:sendMessageToAdmins("AdmWrn: "..adminTitle.." "..getPlayerName(thePlayer):gsub("_", " ").." has revoked from " .. getPlayerName(targetPlayer):gsub("_"," ") .. " temporary ability to fly.")
					else
						outputChatBox("A hidden admin have revoked from you temporary ability to fly.", targetPlayer, 255, 0, 0)
						exports.global:sendMessageToAdmins("AdmWrn: A hidden admin has revoked from " .. getPlayerName(targetPlayer):gsub("_"," ") .. " temporary ability to fly.")
					end
				end
			end
		end
	end
end
--addCommandHandler ( "givesuperman", giveSuperman )

--/SETINTERIOR, /SETINT
function setPlayerInterior(thePlayer, commandName, targetPlayer, interiorID)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		local interiorID = tonumber(interiorID)
		if (not targetPlayer) or (not interiorID) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Interior ID]", thePlayer, 255, 194, 14, false)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				if (logged == 0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0, false)
				else
					if (interiorID >= 0 and interiorID <= 255) then
						local username = getPlayerName(thePlayer)
						local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
						local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
						setElementInterior(targetPlayer, interiorID)
						outputChatBox((hiddenAdmin == 0 and adminTitle .. " " .. username or "Hidden Admin") .. " has changed your interior ID to " .. tostring(interiorID) .. ".", targetPlayer)
						outputChatBox("You set " .. targetPlayerName .. (string.find(targetPlayerName, "s", -1) and "'" or "'s") .. " interior ID to " .. tostring(interiorID) .. ".", thePlayer)
						exports.logs:dbLog(thePlayer, 4, targetPlayer, "PLAYER-SETINTERIOR " .. tostring(interiorID))
					else
						outputChatBox("Invalid interior ID (0-255).", thePlayer, 255, 0, 0, false)
					end
				end
			end
		end
	end
end
addCommandHandler("setint", setPlayerInterior, false, false)
addCommandHandler("setinterior", setPlayerInterior, false, false)

--/SETDIMENSION, /SETDIM
function setPlayerDimension(thePlayer, commandName, targetPlayer, dimensionID)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		local dimensionID = tonumber(dimensionID)
		if (not targetPlayer) or (not dimensionID) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick / ID] [Dimension ID]", thePlayer, 255, 194, 14, false)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
			if targetPlayer then
				local logged = getElementData(targetPlayer, "loggedin")
				if (logged == 0) then
					outputChatBox("Player is not logged in.", thePlayer, 255, 0, 0, false)
				else
					if (dimensionID >= 0 and dimensionID <= 65535) then
						local username = getPlayerName(thePlayer)
						local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
						local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
						setElementDimension(targetPlayer, dimensionID)
						outputChatBox((hiddenAdmin == 0 and adminTitle .. " " .. username or "Hidden Admin") .. " has changed your dimension ID to " .. tostring(dimensionID) .. ".", targetPlayer)
						outputChatBox("You set " .. targetPlayerName .. (string.find(targetPlayerName, "s", -1) and "'" or "'s") .. " dimension ID to " .. tostring(dimensionID) .. ".", thePlayer)
						exports.logs:dbLog(thePlayer, 4, targetPlayer, "PLAYER-SETDIMENSION " .. tostring(dimensionID))
					else
						outputChatBox("Invalid dimension ID (0-65535).", thePlayer, 255, 0, 0, false)
					end
				end
			end
		end
	end
end
addCommandHandler("setdim", setPlayerDimension, false, false)
addCommandHandler("setdimension", setPlayerDimension, false, false)