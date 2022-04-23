local mysql = exports.mysql

function getElementDataEx(theElement, theParameter)
	return getElementData(theElement, theParameter)
end

function setElementDataEx(theElement, theParameter, theValue, syncToClient, noSyncAtall)
	if syncToClient == nil then
		syncToClient = false
	end
	
	if noSyncAtall == nil then
		noSyncAtall = false
	end
	
	if tonumber(theValue) then
		theValue = tonumber(theValue)
	end
	
	exports['anticheat-system']:changeProtectedElementDataEx(theElement, theParameter, theValue, syncToClient, noSyncAtall)
	return true
end

function resourceStart(resource)
	setWaveHeight ( 0 )
	setGameType("SalvoRPG:world | 80MB indir ve oyna!")
	setMapName("İstanbul")
	setRuleValue("Script Versiyon", scriptVersion)
	setRuleValue("Website", "www.titan-roleplay.com")
	setRuleValue("Scripter", "REMAJOR")
	setRuleValue("Sunucu Sahibi", "REMAJOR")
	
	local motdresult = mysql:query_fetch_assoc("SELECT value FROM settings WHERE name='motd' LIMIT 1")
	exports['anticheat-system']:changeProtectedElementDataEx(getRootElement(), "account:motd", motdresult["value" ], false )
	local amotdresult = mysql:query_fetch_assoc("SELECT value FROM settings WHERE name='amotd' LIMIT 1")
	exports['anticheat-system']:changeProtectedElementDataEx(getRootElement(), "account:amotd", amotdresult["value" ], false )
	for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
		triggerEvent("playerJoinResourceStart", value, resource)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), resourceStart)

function onJoin()
	local skipreset = false
	local loggedIn = getElementData(source, "loggedin")
	if loggedIn == 1 then
		local accountID = getElementData(source, "account:id")
		local seamlessHash = getElementData(source, "account:seamlesshash")
		local mQuery1 = mysql:query("SELECT `id` FROM `accounts` WHERE `id`='"..mysql:escape_string(accountID).."' AND `loginhash`='".. mysql:escape_string(seamlessHash) .."'")
		if mysql:num_rows(mQuery1) == 1 then
			skipreset = true
			setElementDataEx(source, "account:seamless:validated", true, false, true)
		end
		mysql:free_result(mQuery1)
	end
	if not skipreset then 
		-- Set the user as not logged in, so they can't see chat or use commands
		exports['anticheat-system']:changeProtectedElementDataEx(source, "loggedin", 0, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "account:loggedin", false, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "account:username", "", false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "account:id", "", false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "dbid", false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "adminlevel", 0, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "hiddenadmin", 0, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "globalooc", 1, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "muted", 0, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "loginattempts", 0, false)
		exports['anticheat-system']:changeProtectedElementDataEx(source, "timeinserver", 0, false)
		setElementData(source, "chatbubbles", 0, false)
		setElementDimension(source, 9999)
		setElementInterior(source, 0)
	end
	
	exports.global:updateNametagColor(source)
end
addEventHandler("onPlayerJoin", getRootElement(), onJoin)
addEvent("playerJoinResourceStart", false)
addEventHandler("playerJoinResourceStart", getRootElement(), onJoin)

local superSalt = "Ibeforeknowno"
function changeAccountPassword(thePlayer, commandName, accountUsername, newPass, newPassConfirm)
	if exports.global:isPlayerHeadAdmin(thePlayer) then
		if not accountUsername or not newPass or not newPassConfirm then
			outputChatBox("SYNTAX : /" .. commandName .. " [Uyelik Adi] [Yeni Sifre] [Yeni Sifre Tekrar]", thePlayer, 125, 125, 125)
		else
			if (newPass ~= newPassConfirm) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Şifreler eşleşmiyor.")
			elseif (string.len(newPass)<6) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Şifre en az 6 karakter olmalı.")
			elseif (string.len(newPass)>=30) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Şifre en fazla 30 karakter olmalı.")
			elseif (string.find(newPass, ";", 0)) or (string.find(newPass, "'", 0)) or (string.find(newPass, "@", 0)) or (string.find(newPass, ",", 0)) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Şifre ;,@'. gibi karakterler içeremez.")
			else
				local accountData
				local account = exports.mysql:query("SELECT id FROM accounts WHERE username ='"..exports.mysql:escape_string(accountUsername).."' LIMIT 1")
				if (mysql:num_rows(account) > 0) then
					accountData = mysql:fetch_assoc(account)
					mysql:free_result(account)
				else
					triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "No account with that username was found.")
					return
				end
				local password = newPass
				local escapedPass = exports.mysql:escape_string(password)
				local query = exports.mysql:query_free("UPDATE accounts SET password = '" .. escapedPass .. "', passwordStyle=2 WHERE id = '" .. accountData["id"] .. "'")
				if query then
					triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, accountUsername.." adlı kullanıcının şifresi yenilendi.")
				else
					triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "MySQL hatası tekrar deneyin.")
				end
			end
		end
	end
end
addCommandHandler("setaccountpassword", changeAccountPassword, false, false)

function changePlayerPassword(thePlayer, commandName, newPass, newPassConfirm)
	if getElementData(thePlayer, "loggedin") then
		if not newPass or not newPassConfirm then
			outputChatBox("SYNTAX : /" .. commandName .. " [Yeni Sifre] [Yeni Sifre Tekrar]", thePlayer, 125, 125, 125)
		else
			if (newPass ~= newPassConfirm) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Şifreler eşleşmiyor.")
			elseif (string.len(newPass)<6) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Şifre en az 6 karakter olmalı.")
			elseif (string.len(newPass)>=30) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Şifre en fazla 30 karakter olmalı.")
			elseif (string.find(newPass, ";", 0)) or (string.find(newPass, "'", 0)) or (string.find(newPass, "@", 0)) or (string.find(newPass, ",", 0)) then
				triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Şifre ;,@'. gibi karakterler içeremez.")
			else
				local accountData
				local account = exports.mysql:query("SELECT id FROM accounts WHERE username ='"..exports.mysql:escape_string(getElementData(thePlayer, "account:username")).."' LIMIT 1")
				if (mysql:num_rows(account) > 0) then
					accountData = mysql:fetch_assoc(account)
					mysql:free_result(account)
				else
					triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "No account with that username was found.")
					return
				end
				local password = newPass
				local escapedPass = exports.mysql:escape_string(password)
				local query = exports.mysql:query_free("UPDATE accounts SET password = '" .. escapedPass .. "', passwordStyle=2 WHERE id = '" .. accountData["id"] .. "'")
				if query then
					triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "Şifreniz Yenilendi")
				else
					triggerClientEvent(thePlayer, "accounts:error:window", thePlayer, "MySQL hatası tekrar deneyin.")
				end
			end
		end
	end
end
addCommandHandler("sifreyenile", changePlayerPassword, false, false)

function karakter_tip_ayar(thePlayer, cmd, playerName, tip)
    if getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "REMAJOR" then 
      if playerName then
           if tonumber(tip) then
                local targetPlayer, targetPlayerName = exports["global"]:findPlayerByPartialNick(thePlayer, playerName)
                if isElement(targetPlayer) then
					local query = exports.mysql:query_free("UPDATE characters SET karakter_tip='"..tip.."' WHERE id='" .. exports.mysql:escape_string(getElementData(targetPlayer, "dbid")) .. "'")
					local karakter_tip = "Legal"
					if tonumber(tip) == 0 then
						karakter_tip = "Legal"
					elseif tonumber(tip) == 1 then
						karakter_tip = "İllegal"
					end
					setElementData(targetPlayer, "karakter_tip", tonumber(tip))
					outputChatBox("#00ff00[!]#ffffff Başarılı bir şekilde "..targetPlayerName.." isimli oyuncunun karakter tipini ("..karakter_tip..") yaptınız.", thePlayer, 255, 0, 0, true)
					outputChatBox("#0000ff[!]#ffffff "..getPlayerName(thePlayer).." isimli yetkili karakter tipinizi ("..karakter_tip..") yaptı.", targetPlayer, 255, 0, 0, true)
                end
           else
                 outputChatBox("SYNTAX: /tipayarla [Oyuncu Adı/ID] [0 - Legal / 1 - İllegal]", thePlayer, 255, 194, 94, true)
           end
      else
           outputChatBox("SYNTAX: /tipayarla [Oyuncu Adı/ID [0 - Legal / 1 - İllegal]", thePlayer, 255, 194, 94, true)
      end
	else
	    outputChatBox("#ff0000[!]#ffffff Bu işlemi yapmak için yetkiniz yok.", thePlayer, 255, 194, 94, true)
	end
end
addCommandHandler("tipayarla", karakter_tip_ayar)

function resetNick(oldNick, newNick)
	exports['anticheat-system']:changeProtectedElementDataEx(client, "legitnamechange", 1)
	setPlayerName(client, oldNick)
	exports['anticheat-system']:changeProtectedElementDataEx(client, "legitnamechange", 0)
	--exports.global:sendMessageToAdmins("AdmWrn: " .. tostring(oldNick) .. " tried to change their name to " .. tostring(newNick) .. ".")
end
addEvent("resetName", true )
addEventHandler("resetName", getRootElement(), resetNick)