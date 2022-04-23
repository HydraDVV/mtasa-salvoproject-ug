local mysql = exports.mysql
local salt = "wedorp"

function clientReady()
	local thePlayer = source
	local resources = getResources()
	local missingResources = false
	for key, value in ipairs(resources) do
		local resourceName = getResourceName(value)
		if resourceName == "global" or resourceName == "mysql" or resourceNmae == "pool" then
			if getResourceState(value) == "loaded" or getResourceState(value) == "stopping" or getResourceState(value) == "failed to load" then
				missingResources = true
				outputChatBox("Server'de bir problem bulundu '"..getResourceName(value).."'.", thePlayer, 255, 0, 0)
				outputChatBox("Lütfen Girmeyi Tekrar Deneyiniz", thePlayer, 255, 0, 0)
				outputChatBox("       - Titan Roleplay Developer Kadrosu", thePlayer, 255, 0, 0)
				break
			end
		end
	end
	if missingResources then return end
	local willPlayerBeBanned = false
	local bannedIPs = exports.global:fetchIPs()
	local playerIP = getPlayerIP(thePlayer)
	for key, value in ipairs(bannedIPs) do
		if playerIP == value then
			outputChatBox("Kullanıcı Ip Adresiniz Yasaklanmıştır", thePlayer, 255, 0, 0)
			setTimer(outputChatBox, 1000, 1, "10 Saniyeliğine Serverden Atıldınız.", thePlayer, 255, 0, 0)
			setTimer(kickPlayer, 10000, 1, "You are blacklisted from this server.")
			willPlayerBeBanned = true
			break
		end
	end
	if not willPlayerBeBanned then
		local bannedSerials = exports.global:fetchSerials()
		local playerSerial = getPlayerSerial(thePlayer)
		for key, value in ipairs(bannedSerials) do
			if playerSerial == value then
				outputChatBox("Sizi Yönetici Serial'IP ' den Engelledi", thePlayer, 255, 0, 0)
				setTimer(outputChatBox, 1000, 1, "Serverden 10 saniyeliğine Atıldınız.", thePlayer, 255, 0, 0)
				setTimer(kickPlayer, 10000, 1, "Sen Kara Listedesin.")
				willPlayerBeBanned = true
				break
			end
		end
	end
	if not willPlayerBeBanned then
		triggerClientEvent(thePlayer, "beginLogin", thePlayer)
	else
		triggerClientEvent(thePlayer, "beginLogin", thePlayer, "Banned.")
	end
end
addEvent("onJoin", true)
addEventHandler("onJoin", getRootElement(), clientReady)

addEventHandler("accounts:login:request", getRootElement(), 
	function ()
		local seamless = getElementData(client, "account:seamless:validated")
		if seamless == true then
			
			-- outputChatBox("-- Migrated your session after a system restart", client, 0, 200, 0)
			setElementData(client, "account:seamless:validated", false, false, true)
			triggerClientEvent(client, "accounts:options", client)
			triggerClientEvent(client, "item:updateclient", client)
			return
		end
		triggerClientEvent(client, "accounts:login:request", client)
	end
);

addEventHandler("accounts:register:attempt", getRootElement(),
	function (username, password)
		local safeusername = mysql:escape_string(username)
		local password =  md5(salt .. password)
		local result = mysql:query("SELECT username FROM accounts WHERE username='" .. safeusername .. "'")
		if (mysql:num_rows(result)>0) then -- Name is already taken
			triggerClientEvent(source, "accounts:error:window", source, "Kullanıcı adı kullanılıyor.")
			return 
		end
		local mtaSerial = getPlayerSerial(source)
		local preparedQuery2 = "SELECT `mtaserial`, `username`, `id` FROM `accounts` WHERE `mtaserial`='".. toSQL(mtaSerial) .."' LIMIT 1"
		local Q2 = mysql:query(preparedQuery2)
		local usernameExisted = mysql:fetch_assoc(Q2)
		if (mysql:num_rows(Q2) > 0) and usernameExisted["id"] ~= "1" then
			triggerClientEvent(source,"accounts:error:window",source,"Birden Fazla Hesabı izin verilmez (Zaten Hesabınız Bulunmakta: "..tostring(usernameExisted["username"])..")")
			return false
		end
		mysql:free_result(Q2)
		local safepassword = mysql:escape_string(password)
		-- Old Scripts Had This
		--triggerClientEvent(source,"loginChange",source)
		--triggerClientEvent(source,"inforeg",source)
		local id = mysql:query_insert_free("INSERT INTO accounts SET username='" .. safeusername .. "', loginhash='" .. safepassword .. "',password='".. safepassword.."' ,appstate='3'")
		if id then 
			triggerClientEvent(source, "accounts:error:window", source, "Account Registered Successfully")
			--exports.notifications:addNotification(source, 'Hesap başarıyla oluşturuldu.', 'success')
		else
			triggerClientEvent(source, "accounts:error:window", source, "Account Registration Failed! \n Please report on the forrums \n Account-0125 \n Sorry For the Inconvenience")
			--exports.notifications:addNotification(source, 'Hesap bilinmeyen bir nedenle oluşturulamıyor. Lütfen yetkiliden yardım isteyin!', 'error')
		end
	end
);
 	
addEventHandler("accounts:login:attempt", getRootElement(), 
	function (username, password, wantsLoginHash)
		local accountCheckQueryStr, accountData,newAccountHash,safeusername,safepassword = nil
		local cpypassword = password
		if (string.len(cpypassword) ~= 64) then
			password = md5(salt .. password)
			safeusername = mysql:escape_string(username)
			safepassword = mysql:escape_string(password)
			accountCheckQueryStr = "SELECT `id`, `username`, `banned`, `appstate`, `admin`,  `warn_style`, `adminduty`, `adminreports`, `hiddenadmin`, `adminjail`, `adminjail_time`, `adminjail_by`, `adminjail_reason`, `monitored`, `email`, `karakterlimit`, `bakiye`, `rol_durum`, `mail` FROM `accounts` WHERE `username`='" .. safeusername .. "' AND `password`='" .. safepassword .. "'"
		else
			safeusername = mysql:escape_string(username)
			safepassword = mysql:escape_string(password)
			accountCheckQueryStr = "SELECT `id`, `username`, `banned`, `appstate`, `admin`, `warn_style`, `adminduty`, `adminreports`, `hiddenadmin`, `adminjail`, `adminjail_time`, `adminjail_by`, `adminjail_reason`, `monitored`, `email`, `karakterlimit`, `bakiye`, `rol_durum`, `mail` FROM `accounts` WHERE `username`='" .. safeusername .. "' AND `loginhash`='" .. safepassword .. "'"
		end
		
		local accountCheckQuery = mysql:query(accountCheckQueryStr)
		if (mysql:num_rows(accountCheckQuery) > 0) then
			accountData = mysql:fetch_assoc(accountCheckQuery)
			mysql:free_result(accountCheckQuery)
		
			-- Create a new safety hash, also used for autologin
			local newAccountHash = Login_calculateAutoLoginHash(safeusername)
			setElementDataEx(client, "account:seamlesshash", newAccountHash, false, true)
			if not (wantsLoginHash) then
				newAccountHash = ""
			end
			
			-- Check the account isn't already logged in
			local found = false
			for _, thePlayer in ipairs(exports.pool:getPoolElementsByType("player")) do
				local playerAccountID = tonumber(getElementData(thePlayer, "account:id"))
				if (playerAccountID) then
					if (playerAccountID == tonumber(accountData["id"])) and (thePlayer ~= client) then
						kickPlayer(thePlayer, getRootElement(), "Someone else has logged into your account.") -- To prevent the 0 ping / MAXIME
						-- triggerClientEvent(client, "accounts:login:attempt", client, 1, "Account is already logged in." ) 
						-- return false
						break
					end
				end
			end
			for _, thePlayer in ipairs(exports.pool:getPoolElementsByType("player")) do
				local playerAccountID = tonumber(getElementData(thePlayer, "account:id"))
				if (playerAccountID) then
					if (playerAccountID == tonumber(accountData["id"])) and (thePlayer ~= client) then
						kickPlayer(thePlayer, thePlayer, "Başka biri hesabınıza oturum açtı.")
						--triggerClientEvent(client,"set_authen_text",client,"Login","Hesap şu anda çevrimiçi . Diğer kullanıcı bağlantısının kesilmesi Lazım. .")
						--addNotification(client, "Hesap şu anda çevrimiçi. Diğer kullanıcı bağlantısının kesilmesi lazım..", "warning")
						break
					end
				end
			end
			-- Check if the account ain't banned
			if (tonumber(accountData["banned"]) == 1) then
				triggerClientEvent(client, "accounts:login:attempt", client, 2, "Account is disabled." )
				--exports.notifications:addNotification(source, 'Hesap aktif değil!', 'warning')
				return
			end
			
			-- Check the application state
			if (tonumber(accountData["appstate"]) == 0) then
				triggerClientEvent(client, "accounts:login:attempt", client, 5, "You need to send in an application to play on this server." ) 
				return
			elseif (tonumber(accountData["appstate"]) == 1) then
				triggerClientEvent(client, "accounts:login:attempt", client, 4, "Your application is still pending." ) 
				return
			elseif (tonumber(accountData["appstate"]) == 2) then
				triggerClientEvent(client, "accounts:login:attempt", client, 3, "Your application has been denied." ) 
				return
			end
			local forceAppCheckQuery = mysql:query("SELECT `username`,`appstate` FROM `accounts` WHERE `ip`='" .. mysql:escape_string(getPlayerIP(client)) .. "' OR `mtaserial`='" .. mysql:escape_string(getPlayerSerial(client)) .. "'")
			if forceAppCheckQuery then
				while true do
					local forceAppRow = mysql:fetch_assoc(forceAppQuery)
					if not forceAppRow then break end
					if (tonumber(forceAppRow["appstate"]) == 1) then
						triggerClientEvent(client, "accounts:login:attempt", client, 4, "Your application is still pending on account "..forceAppRow["username"].."." ) 
						mysql:free_result(forceAppCheckQuery)
						return
					elseif (tonumber(forceAppRow["appstate"]) == 2) then
						triggerClientEvent(client, "accounts:login:attempt", client, 3, "Your application has been denied on account "..forceAppRow["username"]..", you can remake one at http://mta.vg." ) 
						mysql:free_result(forceAppCheckQuery)
						return
					end
					
				end
			end
			mysql:free_result(forceAppCheckQuery)
			-- Start the magic
			setElementDataEx(client, "account:loggedin", true, true)
			setElementDataEx(client, "account:id", tonumber(accountData["id"]), true) 
			setElementDataEx(client, "account:username", accountData["username"], true)
			
			setElementDataEx(client, "adminreports", accountData["adminreports"], false)
			setElementDataEx(client, "hiddenadmin", accountData["hiddenadmin"], false)
			
			setElementDataEx(client, "autopark", tonumber(accountData["autopark"]), true)
			setElementDataEx(client, "email", accountData["email"], true)
			
			if (tonumber(accountData["admin"]) >= 0) then
				setElementDataEx(client, "adminlevel", tonumber(accountData["admin"]), false)
				setElementDataEx(client, "account:gmlevel", 0, false)
				setElementDataEx(client, "adminduty", accountData["adminduty"], false)
				setElementDataEx(client, "account:gmduty", false, true)
				setElementDataEx(client, "wrn:style", tonumber(accountData["warn_style"]), true)
			else
				setElementDataEx(client, "adminlevel", 0, false)
				local GMlevel = -tonumber(accountData["admin"])
				setElementDataEx(client, "account:gmlevel", GMlevel, false)
				if (tonumber(accountData["adminduty"]) == 1) then
					setElementDataEx(client, "account:gmduty", true, true)
				else
					setElementDataEx(client, "account:gmduty", false, true)
				end
			end
			
			--PLAYER SECURITY EMAIL REQUEST BY MAXIME
			if not (tostring(accountData["email"]):find("@"))  then
				triggerClientEvent(client, "requestEmail:onPlayerLogin", client, tonumber(accountData["id"]))
			end
			
			if  tonumber(accountData["adminjail"]) == 1 then
				setElementDataEx(client, "adminjailed", true, false)
			else
				setElementDataEx(client, "adminjailed", false, false)
			end
			setElementDataEx(client, "jailtime", tonumber(accountData["adminjail_time"]), false)
			setElementDataEx(client, "jailadmin", accountData["adminjail_by"], false)
			setElementDataEx(client, "jailreason", accountData["adminjail_reason"], false)
			setElementDataEx(client, "karakterlimit", accountData["karakterlimit"], true)
			setElementDataEx(client, "account:bakiye", accountData["bakiye"], true)
			setElementDataEx(client, "rol_durum", accountData["rol_durum"], true)
			setElementDataEx(client, "mail", tostring(accountData["mail"]), true)
			
			if accountData["monitored"] ~= "" then
				setElementDataEx(client, "admin:monitor", accountData["monitored"], false)
			end

			local dataTable = { }
			
			table.insert(dataTable, { "account:newAccountHash", newAccountHash } )
			table.insert(dataTable, { "account:characters", characterList( client ) } )
			triggerClientEvent(client, "accounts:login:attempt", client, 0, dataTable  ) 
			local loginmethodstr = "manually"
			if (string.len(cpypassword) == 64) then
				loginmethodstr = "Autologin - "..cpypassword 
			end
			
			exports.logs:dbLog("ac"..tostring(accountData["id"]), 27, "ac"..tostring(accountData["id"]), "Connected from "..getPlayerIP(client) .. " - "..getPlayerSerial(client) .. " (".. loginmethodstr ..")" )
			mysql:query_free("UPDATE `accounts` SET `ip`='" .. mysql:escape_string(getPlayerIP(client)) .. "', `mtaserial`='" .. mysql:escape_string(getPlayerSerial(client)) .. "' WHERE `id`='".. mysql:escape_string(tostring(accountData["id"])) .."'")	
			triggerEvent( "social:account", client, tonumber( accountData.id ) )
		else
			mysql:free_result(accountCheckQuery)
			triggerClientEvent(client, "accounts:login:attempt", client, 1, "Girilen kullanıcı adı / şifre kombinasyonu bulunamadı." )
			--exports.notifications:addNotification(source, 'Girilen kullanıcı adı / şifre kombinasyonu bulunamadı.', 'warning')
		end
	end
);

function Login_calculateAutoLoginHash(username)
	local finalhash = ""
	local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	for i = 1, 64 do
		local rand = math.random(#chars)
		finalhash = finalhash .. chars:sub(rand, rand)
	end
	mysql:query_free("UPDATE `accounts` SET `loginhash`='".. finalhash .."' WHERE `username`='".. mysql:escape_string(username) .."'")
	return finalhash
end

function quitPlayer(quitReason, reason)
	local accountID = tonumber(getElementData(source, "account:id"))
	if accountID then
		local affected = { "ac"..tostring(accountID) } 
		local dbID = getElementData(source,"dbid")
		if dbID then
			table.insert(affected, "ch"..tostring(dbID))
		end
		exports.logs:dbLog("ac"..tostring(accountID), 27, affected, "Disconnected ("..quitReason or "Unknown reason"..") (Name: "..getPlayerName(source)..")" )
	end
end
addEventHandler("onPlayerQuit",getRootElement(), quitPlayer)

function toSQL(stuff)
	return mysql:escape_string(stuff)
end

function site_gir(mail, kod)
	callRemote("http://185.126.177.222/sifre/mail_gonder.php", returns, mail, kod) 
end
addEvent("account:mail_call",true)
addEventHandler("account:mail_call",getRootElement(),site_gir)

function returns(msg, num)
	if msg == "ERROR" or (not msg) then
		outputDebugString("Web sayfasi hatalari nedeniyle e-posta gonderilmedi, saglanan betigi ve / veya sayfayi kontrol edin.")
	else
		outputDebugString(msg, num or 3)
	end
end

function sifre_guncelle(mail, sifre)
	outputDebugString(mail.."")
	outputDebugString(sifre.."")
	local query = mysql:query_free("UPDATE accounts SET password = '" .. mysql:escape_string(sifre) .. "' WHERE mail = '" .. mysql:escape_string(mail) .. "'")
end
addEvent("account:sifre_guncelle",true)
addEventHandler("account:sifre_guncelle",getRootElement(),sifre_guncelle)

function mail_guncelle(thePlayer, mail)	
	local id = getElementData(thePlayer, "account:id")
	local query = mysql:query_free("UPDATE accounts SET mail = '" .. mysql:escape_string(mail) .. "' WHERE id = '" .. mysql:escape_string(id) .. "'")
	if(query) then
		setElementData(thePlayer, "mail", tostring(mail))
		outputChatBox("#58C579[!] #ffffffMail adresiniz güncellendi(".. mail ..").", thePlayer, 255, 255, 255, true)
	else
		outputChatBox("#C55858[!] #ffffffBilinmeyen bir hata oluştur.", thePlayer, 255, 255, 255, true)
	end
end
addEvent("account:mail_guncelle",true)
addEventHandler("account:mail_guncelle", getRootElement(), mail_guncelle)