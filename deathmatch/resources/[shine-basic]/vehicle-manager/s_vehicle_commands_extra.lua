mysql = exports.mysql

--Toggling Vehicle Plates/VIN 
function togVehPlates(admin, command, target, status)
	if (exports.global:isPlayerAdmin(admin) and exports.donators:hasPlayerPerk(admin, 16)) then
		if not (target) or not (status) then
			outputChatBox("SYNTAX: /" .. command .. " [Veh ID] [0- Off, 1- On]", admin, 255, 194, 14)
		else
			local username = getPlayerName(admin):gsub("_"," ")
			local pv = exports.pool:getElement("vehicle", tonumber(target))
			
			if (pv) then
					local vid = getElementData(pv, "dbid")
					local stat = tonumber(status)
					if isElementAttached(pv) then
					detachElements(pv)
					end
					if (stat == 1) then
						mysql:query_free("UPDATE vehicles SET plate_hidden = '1' WHERE id='" .. mysql:escape_string(vid) .. "'")
						
						exports['anticheat-system']:changeProtectedElementDataEx(pv, "hiddenplate", 1)

						outputChatBox("You have toggled the plates to hide on vehicle #" .. vid .. ".", admin)
						exports.global:sendMessageToAdmins("Veh-Shit: Admin " .. getPlayerName(admin):gsub("_", " ") .. " toggled the plates on vehicle "..vid..".")
						
						exports.logs:dbLog(thePlayer, 6, {pv}, "TOGVEHPLATES 1" )
					elseif (stat == 0) then
						mysql:query_free("UPDATE vehicles SET plate_hidden = '0' WHERE id='" .. mysql:escape_string(vid) .. "'")
						exports['anticheat-system']:changeProtectedElementDataEx(pv, "hiddenplate", 0)

						outputChatBox("You have toggled the plates to show on vehicle #" .. vid .. ".", admin)
						exports.global:sendMessageToAdmins("Veh-Shit: Admin " .. getPlayerName(admin):gsub("_", " ") .. " toggled the plates on vehicle "..vid..".")
						exports.logs:dbLog(thePlayer, 6, {pv, targetPlayer}, "TOGVEHPLATES 0" )
					end
				else
					outputChatBox("That's not a vehicle.", admin, 255, 194, 14)
				end
			end
		end
	end
addCommandHandler("togvehicleplates", togVehPlates)

--Toggling Vehicle Plates/VIN 
function togVehReg(admin, command, target, status)
	if (exports.global:isPlayerAdmin(admin) and exports.donators:hasPlayerPerk(admin, 16)) then
		if not (target) or not (status) then
			outputChatBox("SYNTAX: /" .. command .. " [Veh ID] [0- Off, 1- On]", admin, 255, 194, 14)
		else
			local username = getPlayerName(admin):gsub("_"," ")
			local pv = exports.pool:getElement("vehicle", tonumber(target))
			
			if (pv) then
					local vid = getElementData(pv, "dbid")
					local stat = tonumber(status)
					if isElementAttached(pv) then
					detachElements(pv)
					end
					if (stat == 1) then
						mysql:query_free("UPDATE vehicles SET registered = '1' WHERE id='" .. mysql:escape_string(vid) .. "'")
						
						exports['anticheat-system']:changeProtectedElementDataEx(pv, "registered", 1)

						outputChatBox("You have toggled the registration to unregistered on vehicle #" .. vid .. ".", admin)
						exports.global:sendMessageToAdmins("Veh-Shit: Admin " .. getPlayerName(admin):gsub("_", " ") .. " toggled the registeration on vehicle "..vid..".")
						
						exports.logs:dbLog(thePlayer, 6, {pv}, "TOGVEHREG 1" )
					elseif (stat == 0) then
						mysql:query_free("UPDATE vehicles SET registered = '0' WHERE id='" .. mysql:escape_string(vid) .. "'")
						exports['anticheat-system']:changeProtectedElementDataEx(pv, "registered", 0)

						outputChatBox("You have toggled the registration to registered on vehicle #" .. vid .. ".", admin)
						exports.global:sendMessageToAdmins("Veh-Shit: Admin " .. getPlayerName(admin):gsub("_", " ") .. " toggled the registeration on vehicle "..vid..".")
						exports.logs:dbLog(thePlayer, 6, {pv, targetPlayer}, "TOGVEHREG 0" )
					end
				else
					outputChatBox("That's not a vehicle.", admin, 255, 194, 14)
				end
			end
		end
	end
addCommandHandler("togvehiclereg", togVehReg)

-- START of Vehicle Customization by Anthony

--suspensionLowerLimits
function setsuspensionLowerLimit(thePlayer, commandName, limit)
	if (exports.global:isPlayerAdmin(thePlayer) and exports.donators:hasPlayerPerk(thePlayer, 16)) then
		if (limit) then
			if tonumber(limit) <= 0.1 and tonumber(limit) >= -0.35 then
				local theVehicle = getPedOccupiedVehicle(thePlayer)
				if theVehicle then
				setVehicleHandling(theVehicle, "suspensionLowerLimit", tonumber(limit) or nil)
				outputChatBox("Vehicle suspension lower limit set to: "..tonumber(limit), thePlayer, 0, 255, 0)
				else
				outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
				end
			else
			outputChatBox("SYNTAX: /" .. commandName .. " [Limit: 0.1 to -0.35]", thePlayer, 255, 194, 14)
			end
		else
		outputChatBox("SYNTAX: /" .. commandName .. " [Limit: 0.1 to -0.35]", thePlayer, 255, 194, 14)
		end
	end
end
addCommandHandler("setlowerlimit", setsuspensionLowerLimit, false, false)

function getsuspensionLowerLimit(thePlayer)
	if (exports.global:isPlayerAdmin(thePlayer) and exports.donators:hasPlayerPerk(thePlayer, 16)) then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle then
		local currentHandling = getVehicleHandling(theVehicle)
		local suspensionHeight = currentHandling["suspensionLowerLimit"]
		outputChatBox("This vehicle's lower suspension limit is: "..tonumber(suspensionHeight), thePlayer, 0, 255, 0)
		else
		outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("getlowerlimit", getsuspensionLowerLimit, false, false)

function resetsuspensionLowerLimit(thePlayer)
	if (exports.global:isPlayerAdmin(thePlayer) and exports.donators:hasPlayerPerk(thePlayer, 16)) then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle then
		local model = getElementModel(theVehicle)
		local originalHandling = getOriginalHandling(model)
		local defaultLimit = originalHandling["suspensionLowerLimit"]
		setVehicleHandling(theVehicle, "suspensionLowerLimit", tonumber(defaultLimit) or nil)
		outputChatBox("Successfully reset the vehicle's lower suspension limit to: "..tonumber(defaultLimit), thePlayer, 0, 255, 0)
		else
		outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("resetlowerlimit", resetsuspensionLowerLimit, false, false)

--driveTypes
function setdriveType(thePlayer, commandName, driveType)
	if (exports.global:isPlayerAdmin(thePlayer) and exports.donators:hasPlayerPerk(thePlayer, 16)) then
		if (driveType) then
			if driveType == "awd" or driveType == "fwd" or driveType == "rwd" then
				local theVehicle = getPedOccupiedVehicle(thePlayer)
				if theVehicle then
				setVehicleHandling(theVehicle, "driveType", tostring(driveType) or nil)
				outputChatBox("Vehicle drive type set to: "..tostring(driveType), thePlayer, 0, 255, 0)
				else
				outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
				end
			else
			outputChatBox("SYNTAX: /" .. commandName .. " [awd/fwd/rwd]", thePlayer, 255, 194, 14)
			end
		else
		outputChatBox("SYNTAX: /" .. commandName .. " [awd/fwd/rwd]", thePlayer, 255, 194, 14)
		end
	end
end
addCommandHandler("setdrivetrain", setdriveType, false, false)

function getdriveType(thePlayer)
	if (exports.global:isPlayerAdmin(thePlayer) and exports.donators:hasPlayerPerk(thePlayer, 16)) then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle then
		local currentHandling = getVehicleHandling(theVehicle)
		local driveType = currentHandling["driveType"]
		outputChatBox("This vehicle's drive type is: "..tostring(driveType), thePlayer, 0, 255, 0)
		else
		outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("getdrivetrain", getdriveType, false, false)

function resetdriveType(thePlayer)
	if (exports.global:isPlayerAdmin(thePlayer) and exports.donators:hasPlayerPerk(thePlayer, 16)) then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle then
		local model = getElementModel(theVehicle)
		local originalHandling = getOriginalHandling(model)
		local defaultType = originalHandling["driveType"]
		setVehicleHandling(theVehicle, "driveType", tostring(defaultType) or nil)
		outputChatBox("Successfully reset the vehicle's drive type to: "..tostring(defaultType), thePlayer, 0, 255, 0)
		else
		outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("resetdrivetrain", resetdriveType, false, false)

--Suspension Bias
function setsuspensionBias(thePlayer, commandName, bias)
	if (exports.global:isPlayerAdmin(thePlayer) and exports.donators:hasPlayerPerk(thePlayer, 16)) then
		if (bias) then
			if tonumber(bias) <= 0.15 and tonumber(bias) >= 0.5 then
				local theVehicle = getPedOccupiedVehicle(thePlayer)
				if theVehicle then
				setVehicleHandling(theVehicle, "suspensionFrontRearBias", tonumber(bias) or nil)
				outputChatBox("Vehicle suspension bias set to: "..tonumber(bias), thePlayer, 0, 255, 0)
				else
				outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
				end
			else
			outputChatBox("SYNTAX: /" .. commandName .. " [Bias: 0.15 to 0.5]", thePlayer, 255, 194, 14)
			end
		else
		outputChatBox("SYNTAX: /" .. commandName .. " [Bias: 0.15 to 0.5]", thePlayer, 255, 194, 14)
		end
	end
end
addCommandHandler("setsuspensionbias", setsuspensionBias, false, false)

function getsuspensionBias(thePlayer)
	if (exports.global:isPlayerAdmin(thePlayer) and exports.donators:hasPlayerPerk(thePlayer, 16)) then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle then
		local currentHandling = getVehicleHandling(theVehicle)
		local susBias = currentHandling["suspensionFrontRearBias"]
		outputChatBox("This vehicle's drive type is: "..tostring(susBias), thePlayer, 0, 255, 0)
		else
		outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("getsuspensionbias", getsuspensionBias, false, false)

function resetsuspensionBias(thePlayer)
	if (exports.global:isPlayerAdmin(thePlayer) and exports.donators:hasPlayerPerk(thePlayer, 16)) then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if theVehicle then
		local model = getElementModel(theVehicle)
		local originalHandling = getOriginalHandling(model)
		local defaultBias = originalHandling["suspensionFrontRearBias"]
		setVehicleHandling(theVehicle, "suspensionFrontRearBias", tonumber(defaultBias) or nil)
		outputChatBox("Successfully reset the vehicle's lower suspension limit to: "..tonumber(defaultBias), thePlayer, 0, 255, 0)
		else
		outputChatBox("You are not in a vehicle!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("resetsuspensionbias", resetsuspensionBias, false, false)

-- END of Vehicle Customization by Anthony

--Adding/Removing tint
function setVehTint(admin, command, target, status)
	if exports.global:isPlayerAdmin(admin) and exports.donators:hasPlayerPerk(admin, 16) then
		if not (target) or not (status) then
			outputChatBox("SYNTAX: /" .. command .. " [player] [0- Off, 1- On]", admin, 255, 194, 14)
		else
			local username = getPlayerName(admin):gsub("_"," ")
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(admin, target)
			
			if (targetPlayer) then
				local pv = getPedOccupiedVehicle(targetPlayer)
				if (pv) then
					local vid = getElementData(pv, "dbid")
					local stat = tonumber(status)
					if (stat == 1) then
						mysql:query_free("UPDATE vehicles SET tintedwindows = '1' WHERE id='" .. mysql:escape_string(vid) .. "'")
						for i = 0, getVehicleMaxPassengers(pv) do
							local player = getVehicleOccupant(pv, i)
							if (player) then
								triggerEvent("setTintName", pv, player)
							end
						end
						
						exports['anticheat-system']:changeProtectedElementDataEx(pv, "tinted", true, true)
						triggerClientEvent("tintWindows", pv)
						outputChatBox("You have added tint to vehicle #" .. vid .. ".", admin)
						exports.global:sendMessageToAdmins("Veh-Shit: Admin " .. getPlayerName(admin):gsub("_", " ") .. " added tint to vehicle "..vid..".")
						
						exports.logs:dbLog(admin, 6, {pv, targetPlayer}, "SETVEHTINT 1" )
						
						addVehicleLogs(vid, command.." on", admin)
						
					elseif (stat == 0) then
						mysql:query_free("UPDATE vehicles SET tintedwindows = '0' WHERE id='" .. mysql:escape_string(vid) .. "'")
						for i = 0, getVehicleMaxPassengers(pv) do
							local player = getVehicleOccupant(pv, i)
							if (player) then
								triggerEvent("resetTintName", pv, player)
							end
						end
						exports['anticheat-system']:changeProtectedElementDataEx(pv, "tinted", false, true)
						triggerClientEvent("tintWindows", pv)
						outputChatBox("You have removed tint from vehicle #" .. vid .. ".", admin)
						exports.global:sendMessageToAdmins("Veh-Shit: Admin " .. getPlayerName(admin):gsub("_", " ") .. " removed tint from vehicle "..vid..".")
						exports.logs:dbLog(admin, 4, {pv, targetPlayer}, "SETVEHTINT 0" )
						addVehicleLogs(vid, command.." off", admin)
					end
				else
					outputChatBox("Player not in a vehicle.", admin, 255, 194, 14)
				end
			end
		end
	end
end
addCommandHandler("setvehicletint", setVehTint)

function setVehiclePlate(thePlayer, theCommand, vehicleID, ...)
	if exports.global:isPlayerAdmin(thePlayer) and exports.donators:hasPlayerPerk(thePlayer, 16) then
		if not (vehicleID) or not (...) then
			outputChatBox("SYNTAX: /" .. theCommand .. " [vehicleID] [Text]", thePlayer, 255, 194, 14)
		else
			local theVehicle = exports.pool:getElement("vehicle", vehicleID)
			if theVehicle then
					local plateText = table.concat({...}, " ")
					if (exports['vehicle-plate-system']:checkPlate(plateText)) then
						local cquery = mysql:query_fetch_assoc("SELECT COUNT(*) as no FROM `vehicles` WHERE `plate`='".. mysql:escape_string(plateText).."'")
						if (tonumber(cquery["no"]) == 0) then
							local insertnplate = mysql:query_free("UPDATE vehicles SET plate='" .. mysql:escape_string(plateText) .. "' WHERE id = '" .. mysql:escape_string(vehicleID) .. "'")
							local x, y, z = getElementPosition(theVehicle)
							local int = getElementInterior(theVehicle)
							local dim = getElementDimension(theVehicle)
							exports['vehicle-system']:reloadVehicle(tonumber(vehicleID))
							local newVehicleElement = exports.pool:getElement("vehicle", vehicleID)
							setElementPosition(newVehicleElement, x, y, z)
							setElementInterior(newVehicleElement, int)
							setElementDimension(newVehicleElement, dim)
							outputChatBox("Done.", thePlayer)
						else
							outputChatBox("This plate is already in use.", thePlayer, 255, 0, 0)
						end
					else
						outputChatBox("Invalid plate text specified.", thePlayer, 255, 0, 0)
					end
			else
				outputChatBox("No vehicles with that ID found.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("setvehicleplate", setVehiclePlate)