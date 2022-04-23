local function sortTable( a, b )
	if b[2] < a[2] then
		return true
	end
	
	if b[2] == a[2] and b[4] > a[4] then
		return true
	end
	
	return false
end

function showAdmins(thePlayer, commandName)
	local logged = getElementData(thePlayer, "loggedin")
	local info = {}
	local isOverlayDisabled = getElementData(thePlayer, "hud:isOverlayDisabled")
	if(logged==1) then
		local players = exports.global:getAdmins()
		local counter = 0
		
		admins = {}
		if isOverlayDisabled then
			outputChatBox("ADMINISTRATORS:", thePlayer, 255, 194, 14)
		else
			table.insert(info,{"Adminler", 255, 194, 14, 255, 1,})
			table.insert(info, {""})
		end
		for k, arrayPlayer in ipairs(players) do
			local hiddenAdmin = getElementData(arrayPlayer, "hiddenadmin")
			local logged = getElementData(arrayPlayer, "loggedin")
			
			if logged == 1 then
				if hiddenAdmin == 0 or exports.global:isPlayerSuspendedAdmin(thePlayer) or exports.global:isPlayerScripter(thePlayer) then
					admins[ #admins + 1 ] = { arrayPlayer, getElementData( arrayPlayer, "adminlevel" ), getElementData( arrayPlayer, "adminduty" ), getPlayerName( arrayPlayer ) }
				end
			end
		end
		
		table.sort( admins, sortTable )
		
		for k, v in ipairs(admins) do
			arrayPlayer = v[1]
			local adminTitle = exports.global:getPlayerAdminTitle(arrayPlayer)
			local hiddenAdmin = getElementData(arrayPlayer, "hiddenadmin")
			if hiddenAdmin == 0 or exports.global:isPlayerLeadAdmin(thePlayer) then -- Maxime (1/4/2013) hide hidden admin on /admins from Super and below
				--if exports.global:isPlayerSuspendedAdmin(thePlayer) or exports.global:isPlayerScripter(thePlayer) then
					v[4] = v[4] .. " (" .. tostring(getElementData(arrayPlayer, "account:username")) .. ")"
				--end
				
				if(v[3]==1)then
					if isOverlayDisabled then
						outputChatBox("-    " .. tostring(adminTitle) .. " " .. tostring(v[4]):gsub("_"," ").." - Görevde", thePlayer, 0, 200, 10)
					else
						table.insert(info, {"-    " .. tostring(adminTitle) .. " " .. tostring(v[4]):gsub("_"," ").." - Görevde", 0, 255, 0, 255, 1, "default-bold"})
					end
				else
					if isOverlayDisabled then
						outputChatBox("-    " .. tostring(adminTitle) .. " " .. tostring(v[4]):gsub("_"," ").." - Rolde / Meşgul", thePlayer, 100, 100, 100)
					else
						table.insert(info, {"-    " .. tostring(adminTitle) .. " " .. tostring(v[4]):gsub("_"," ").." - Rolde / Meşgul", 200, 200, 200, 255, 1, "default-bold"})
					end
				end
			end
			
		end
		
		if #admins == 0 then
			if isOverlayDisabled then
				outputChatBox("-    Currently no administrators online.", thePlayer)
			else
				table.insert(info, {"-    Online Admin yok.", 255, 255, 255, 255, 0.87, "default-bold"})
			end
		end
		--outputChatBox("Use /gms to see a list of gamemasters.", thePlayer)
	end
	
	if not isOverlayDisabled then
		table.insert(info, {"", 100, 100, 100, 255, 0.35, "default"})
	end
	
	if(logged==1) then
		local players = exports.global:getGameMasters()
		local counter = 0
		
		admins = {}
		if isOverlayDisabled then
			outputChatBox("GAMEMASTERS:", thePlayer, 255, 194, 14)
		else
			table.insert(info, {"Rehberler:", 10, 230, 10, 255, 1,})
			table.insert(info, {""})
		end
		for k, arrayPlayer in ipairs(players) do
			local logged = getElementData(arrayPlayer, "loggedin")
			if logged == 1 then
				if exports.global:isPlayerGameMaster(arrayPlayer) then
					admins[ #admins + 1 ] = { arrayPlayer, getElementData( arrayPlayer, "account:gmlevel" ), getElementData( arrayPlayer, "account:gmduty" ), getPlayerName( arrayPlayer ) }
				end
			end
		end
		
		table.sort( admins, sortTable )
		
		for k, v in ipairs(admins) do
			arrayPlayer = v[1]
			local adminTitle = exports.global:getPlayerGMTitle(arrayPlayer)
			
			if exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerScripter(thePlayer) then
				v[4] = v[4] .. " (" .. tostring(getElementData(arrayPlayer, "account:username")) .. ")"
			end
			
			if(v[3] == true)then
				if isOverlayDisabled then
					outputChatBox("-    " .. tostring(adminTitle) .. " " .. tostring(v[4]):gsub("_"," ").." - Görevde", thePlayer, 0, 200, 10)
				else
					table.insert(info, {"-    " .. tostring(adminTitle) .. " " .. tostring(v[4]):gsub("_"," ").." - Görevde", 0, 255, 0, 255, 0.87, "default-bold"})
				end
			else
				if isOverlayDisabled then
					outputChatBox("-    " .. tostring(adminTitle) .. " " .. tostring(v[4]):gsub("_"," ").." - Rolde / Meşgul", thePlayer, 100, 100, 100)
				else
					table.insert(info, {"-    " .. tostring(adminTitle) .. " " .. tostring(v[4]):gsub("_"," ").." - Rolde / Meşgul", 200, 200, 200, 255, 0.87, "default-bold"})
				end
			end
		end
		
		if #admins == 0 then
			if isOverlayDisabled then
				outputChatBox("-    Currently no game masters online.", thePlayer)
			else
				table.insert(info, {"-    Online Rehberimiz Yok", 255, 255, 255, 255, 0.87, "default-bold"})
			end
		end
		--outputChatBox("Use /admins to see a list of administrators.", thePlayer)
		if not isOverlayDisabled then
			exports.hud:sendTopRightNotification(thePlayer, info, 350)
		end
	end
end
addCommandHandler("admins", showAdmins, false, false)
addCommandHandler("gms", showAdmins, false, false)

function toggleOverlay(thePlayer, commandName)
	if getElementData(thePlayer, "hud:isOverlayDisabled") then
		setElementData(thePlayer, "hud:isOverlayDisabled", false)
		setElementData(thePlayer, "report-system:isAdminPanelEnabled", false)
		outputChatBox("You enabled overlay menus.",thePlayer)
	else
		setElementData(thePlayer, "hud:isOverlayDisabled", true)
		setElementData(thePlayer, "report-system:isAdminPanelEnabled", false)
		outputChatBox("You disabled overlay menus.", thePlayer)
	end
end
addCommandHandler("toggleOverlay", toggleOverlay, false, false)
addCommandHandler("togOverlay", toggleOverlay, false, false)