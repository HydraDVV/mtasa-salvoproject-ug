local handbrakeTimer = {}
local someExceptions = {
	[573] = true,
	[556] = true,
	[444] = true, --Monster Truck
}
function toggleHandbrake( player, vehicle, forceOnGround, commandName )
	local handbrake = getElementData(vehicle, "handbrake")
	local kickstand = false
	if commandName == nil then
		kickstand = getVehicleType(vehicle) == 'BMX' or getVehicleType(vehicle) == 'Bike'
	else
		kickstand = commandName == 'kickstand'
	end
	--outputDebugString(tostring(kickstand) .. " " .. tostring(commandName) .. " " .. tostring(forceOnGround))
	if (handbrake == 0) then
		if getVehicleType(vehicle) == 'BMX' or getVehicleType(vehicle) == 'Bike' then
			if not kickstand then
				outputChatBox('Bu araçta bir el freni yok.', player, 255, 0, 0)
			elseif not isVehicleOnGround(vehicle) and not forceOnGround then
				outputChatBox('Bu özelliğin çalışması için zeminde olmanız gerekmektedir.', player, 255, 0, 0)
			elseif math.floor(exports.global:getVehicleVelocity(vehicle)) > 2 then
				outputChatBox("Hareket halinde el frenini çekemezsiniz.", player, 255, 0, 0)
			else
				exports.anticheat:changeProtectedElementDataEx(vehicle, "handbrake", 1, true)
				setElementFrozen(vehicle, true)
			end
		elseif (isVehicleOnGround(vehicle) or forceOnGround) or getVehicleType(vehicle) == "Boat" or getVehicleType(vehicle) == "Helicopter" or someExceptions[getVehicleType(vehicle)] then
			if kickstand then
				outputChatBox('Bu araçta kickstand yoktur.', player, 255, 0, 0)
				return false
			end
			setControlState ( player, "handbrake", true )
			playSoundHandbrake(vehicle, "on")
			exports.anticheat:changeProtectedElementDataEx(vehicle, "handbrake", 1, true)
			handbrakeTimer[vehicle] = setTimer(function ()
				setElementFrozen(vehicle, true)
				--outputChatBox("Handbrake has been applied.", player, 0, 255, 0)
				setControlState ( player, "handbrake", false )
			end, 3000, 1)
		end
	else
		if getVehicleType(vehicle) == 'BMX' or getVehicleType(vehicle) == 'Bike' then
			if not kickstand then
				outputChatBox('Bu araçta El Freni mevcut değildir.', player, 255, 0, 0)
				return
			end
		else
			if kickstand then
				outputChatBox('Bu araçta kickstand mevcut değildir.', player, 255, 0, 0)
				return
			end
		end

		if isTimer(handbrakeTimer[vehicle]) then
			killTimer(handbrakeTimer[vehicle])
			setControlState ( player, "handbrake", false )
		end
		exports.anticheat:changeProtectedElementDataEx(vehicle, "handbrake", 0, true)
		setElementFrozen(vehicle, false) 
		--outputChatBox("Handbrake has been released.", player, 0, 255, 0)
		triggerEvent("vehicle:handbrake:lifted", vehicle, player)
		playSoundHandbrake(vehicle, "off")
	end	
end

addEvent("vehicle:handbrake:lifted", true)

addEvent("vehicle:handbrake", true)
addEventHandler( "vehicle:handbrake", root, function(forceOnGround, commandName) toggleHandbrake( client, source, forceOnGround, commandName ) end )


function playSoundHandbrake(veh, state)
	for i = 0, getVehicleMaxPassengers( veh ) do
		local player = getVehicleOccupant( veh, i )
		if player then
			triggerClientEvent(player, "playSoundHandbrake", player, state)
		end
	end
end
