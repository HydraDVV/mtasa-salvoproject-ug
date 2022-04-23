--MAXIME
function playSoundHandbrake(state)
	if state == "off" then
		local sound = playSound("hb_off.mp3")
		if sound then
			setSoundVolume(sound , 1)
		end
	else
		local sound = playSound("hb_on.mp3")
		if sound then
			setSoundVolume(sound , 0.3)
		end
	end
end
addEvent( "playSoundHandbrake", true )
addEventHandler( "playSoundHandbrake", root,  playSoundHandbrake)
function farSesi(durum)
	local sound = playSound(":resources/far.mp3")
	if sound then
		setSoundVolume(sound , 1)
		setElementInterior( sound, getElementInterior(source) )
		setElementDimension( sound, getElementDimension(source) )
	end
end
addEvent( "far:ses", true )
addEventHandler( "far:ses", root,  farSesi)

function calismaSesi(x,y,z)
	local calismasesi = playSound3D( 'arabacalistirma.mp3', x,y,z ) 
	setSoundMaxDistance( calismasesi, 100 )
end
addEvent( "calisma:ses", true )
addEventHandler( "calisma:ses", root,  calismaSesi)

local function checkVelocity(veh)
	local x, y, z = getElementVelocity(veh)
	return math.abs(x) < 0.05 and math.abs(y) < 0.05 and math.abs(z) < 0.05
end

-- exported
-- commandName is optional
function doHandbrake(commandName)
	if isPedInVehicle ( localPlayer ) then
		local playerVehicle = getPedOccupiedVehicle ( localPlayer )
		if (getVehicleOccupant(playerVehicle, 0) == localPlayer) then
			-- vehicle doesn't move and its in a custom interior; custom (officially mapped) interiors would otherwise suffer from no-handbrake and vehicles falling through
			local override = getElementDimension(playerVehicle) > 0 and checkVelocity(playerVehicle)

			triggerServerEvent("vehicle:handbrake", playerVehicle, override, commandName)
		end
	end
end
addCommandHandler('kickstand', doHandbrake)
addCommandHandler('handbrake', doHandbrake)
addCommandHandler('anchor', doHandbrake)

--Cancel everything else but handbrake when player hit G. /maxime
function playerPressedKey(button, press)
	if button == "g" and (press) then -- Only output when they press it down
		doHandbrake()
		cancelEvent()
	end
end

function resourceStartBindG()
	bindKey("g", "down", playerPressedKey)
end
addEventHandler("onClientResourceStart", resourceRoot, resourceStartBindG)

addEventHandler('onClientVehicleStartExit', root,
	function(player)
		if player == localPlayer and not isVehicleLocked(source) and getControlState('handbrake') then
			setControlState('handbrake', false)
		end
	end)
	
