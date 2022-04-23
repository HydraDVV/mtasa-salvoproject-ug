local sX, sY = guiGetScreenSize ()
local deathTimer = 0

function playerDeath(oldDuration)
	if getElementData(localPlayer, "paintball.state") == 2 or getElementData(localPlayer, "paintball.state") == 3 then
		deathTimer = 999
	else
		if exports.global:hasItem(localPlayer, 115) or exports.global:hasItem(localPlayer, 116) then
			deathTimer = 200
		else
			deathTimer = 50
		end
	end

	local oldDuration = tonumber(oldDuration)
	if oldDuration then
		deathTimer = oldDuration
	end
	if isTimer(lowerTime) then killTimer(lowerTime) end
	lowerTime = setTimer(lowerTimer, 1000, deathTimer)
	
	isTextShowing = true
	outputChatBox("[!] #ffffffBayıldınız, "..deathTimer.." saniye sonra tekrar ayılacaksınız.", 0, 0, 255, true)

	toggleControls(false)
end
addEvent("playerdeath", true)
addEventHandler("playerdeath", localPlayer, playerDeath)

function renderDeath()
	if not isTextShowing then return false end

	local text = " "..deathTimer

	if deathTimer < 2 then
		text = "Ayılıyorsunuz."
	end
	if getElementData(localPlayer, "dead") or 0 == 1 then
		if isElementFrozen(localPlayer) ~= true then
			setElementFrozen(localPlayer, true)
		end
	end
	if deathTimer <= 0 then
		isTextShowing = false
		if isElementFrozen(localPlayer) ~= false then
			setElementFrozen(localPlayer, false)
		end
		triggerServerEvent("es-system:ready", localPlayer, localPlayer)
	end
	local font = exports.titan_fonts:getFont("FontAwesome",25)
	local scale = 1
	
	local width = dxGetTextWidth( text, scale, font )
	local height = dxGetFontHeight( scale, font )
	dxDrawText(text, (sX - width) / 2, sY - height * 3 + 3, 0, 0, tocolor( 0, 0, 0, 200 ), scale, font)
	dxDrawText(text, (sX - width) / 2, sY - height * 3, 0, 0, tocolor( 255, 255, 255, 200 ), scale, font)
--	dxDrawText("/canlan yazarak canlanabilirsin ama üstündeki her şey silinir.", (sX - width) / 2.2, sY - height * 0.5, 0, 0, tocolor( 255, 255, 255, 200 ), 1.2, font)

end
addEventHandler("onClientRender", root, renderDeath)

addEventHandler("onClientResourceStop", resourceRoot, function()
	toggleControls(true)
end)

function lowerTimer()
	deathTimer = deathTimer - 1

	if deathTimer <= 0 then
		triggerServerEvent("es-system:acceptDeath", localPlayer, localPlayer, victimDropItem)
		playerRespawn()
	end
end

function playerRespawn()
	if isTimer(lowerTime) then
		killTimer(lowerTime)
	end
	deathTimer = 0
	toggleControls(true)
	setElementData(getLocalPlayer(), "knockout", false)
	setElementData(getLocalPlayer(), "knockout_moving", false)
end
addEvent("bayilmaRevive", true)
addEventHandler("bayilmaRevive", root, playerRespawn)

function toggleControls(bool)
	if (bool == true) then
		removeEventHandler("onClientKey", root, disableMouse)
	elseif (bool == false) then
		addEventHandler("onClientKey", root, disableMouse)
	end
end
function disableMouse(key, press)
	if (key == "mouse1") and press then
		if getElementData(localPlayer, "dead") == 1 then
			cancelEvent()
		else
			removeEventHandler("onClientKey", root, disableMouse)
		end
	end
end


addEvent("fadeCameraOnSpawn", true)
addEventHandler("fadeCameraOnSpawn", localPlayer,
	function()
		--start = getTickCount()
	end
)



function closeRespawnButton()
	if bRespawn then
		destroyElement(bRespawn)
		bRespawn = nil
		showCursor(false)
		guiSetInputEnabled(false)
	end
	deathTimer = 0
end
addEvent("es-system:closeRespawnButton", true)
addEventHandler("es-system:closeRespawnButton", localPlayer,closeRespawnButton)

function noDamageOnDeath ( attacker, weapon, bodypart )
	if ( getElementData(source, "dead") == 1 ) then
		cancelEvent()
	end
end
addEventHandler ( "onClientPlayerDamage", localPlayer, noDamageOnDeath )

function playerDeath(totalAmmo, killer, killerWeapon)
	if ( getElementData(getLocalPlayer(), "dead") == 1 ) then cancelEvent() return end
	if getElementData(getLocalPlayer(), "dbid") then
		if getElementData(getLocalPlayer(), "adminjailed") then
			local team = getPlayerTeam(getLocalPlayer())
			spawnPlayer(getLocalPlayer(), 232.3212890625, 160.5693359375, 1003.0234375, 270)
			
			setElementModel(getLocalPlayer(),getElementModel(getLocalPlayer()))
			setPlayerTeam(getLocalPlayer(), team)
			setElementInterior(getLocalPlayer(), 9)
			setElementDimension(getLocalPlayer(), 3)
			
			setCameraInterior(getLocalPlayer(), 9)
			setCameraTarget(getLocalPlayer())
			fadeCamera(getLocalPlayer(), true)
		elseif getElementData(getLocalPlayer(), "jailed") then
			exports["prison"]:checkForRelease(getLocalPlayer())
		else
			if getElementData(getLocalPlayer(), "dead") == 1 then
				return false
			end
		
			if getElementData(getLocalPlayer(), "seatbelt") then
				setElementData(getLocalPlayer(), "seatbelt", false)
			end

			setElementData(getLocalPlayer(), "dead", 1)
			setElementData(getLocalPlayer(), "yaralisinArtik", 1)
			local x,y,z = getElementPosition(getLocalPlayer())
			local int = getElementInterior(getLocalPlayer())
			local dim = getElementDimension(getLocalPlayer())
			local team = getPlayerTeam(getLocalPlayer())
			local rotx, roty, rotz = getElementRotation(getLocalPlayer())
			local skin = getElementModel(getLocalPlayer())
			
			spawnPlayer(getLocalPlayer(), x, y, z, rotz, skin, int, dim, team)
			
			setPedHeadless(getLocalPlayer(), false)
			setCameraInterior(getLocalPlayer(), int)
			setCameraTarget(getLocalPlayer(), source) 

			setPlayerTeam(getLocalPlayer(), team)
			setElementInterior(getLocalPlayer(), int)
			setElementDimension(getLocalPlayer(), dim)
			setTimer(setPedAnimation, 1000, 1, getLocalPlayer(), "CRACK", "crckidle1", -1, true, false, false)
		
			setElementHealth(getLocalPlayer(), 10)
			
			triggerClientEvent(getLocalPlayer(), "playerdeath", getLocalPlayer())
		end
	end
end
addEventHandler("onPlayerWasted", getLocalPlayer(), playerDeath)
