local mysql = exports.mysql

-- towing impound lot
local towSphere = createColPolygon( 2804.3544921875, -1468.08203125, 2803.5478515625, -1461.546875, 2794.9619140625, -1462.7490234375, 2794.701171875, -1468.07421875, 2804.2666015625, -1468.0869140625 )


local towImpoundSphere = createColCircle (  2799.5693359375, -1465.8740234375, 16.230501174927 )
-- pd impound lot
local towSphere2 = createColPolygon(1540.244140625, -1603.0439453125, 1590.4765625, -1603.04296875, 1583.4765625, -1617.7158203125, 1540.2451171875, -1617.138671875, 1540.2451171875, -1617.138671875, 1540.2451171875, -1603.044921875 )

-- IGS - no /park zone
local towSphere3 = createColPolygon(1951.724609375, -1761.75, 1951.724609375, -1761.75, 1902.294921875, -1823.9677734375, 1904.357421875, -1821.66113281255, 1903.7763671875, -1762.59375)

local currentReleasePos = 0

local parkingPositions = { 
						{ 2785.486328125, -1493.94921875, 23.902160644531, 0, 0, 90 },
						{ 2785.486328125, -1493.94921875, 23.902160644531, 0, 0, 90 },
						{ 2785.486328125, -1493.94921875, 23.902160644531, 0, 0, 90 },
						{ 2785.486328125, -1493.94921875, 23.902160644531, 0, 0, 90 },
						{ 2785.486328125, -1493.94921875, 23.902160644531, 0, 0, 90 },
						{ 2785.486328125, -1493.94921875, 23.902160644531, 0, 0, 90 },
						{ 2785.486328125, -1493.94921875, 23.902160644531, 0, 0, 90 },
						{ 2785.486328125, -1493.94921875, 23.902160644531, 0, 0, 90 },
						{ 2785.486328125, -1493.94921875, 23.902160644531, 0, 0, 90 },
						{ 2785.486328125, -1493.94921875, 23.902160644531, 0, 0, 90 },
						{ 2785.486328125, -1493.94921875, 23.902160644531, 0, 0, 90 }
					}


function getReleasePosition()
	currentReleasePos = currentReleasePos + 1
	if currentReleasePos > #parkingPositions then
		currentReleasePos = 1
	end
	
	return parkingPositions[ currentReleasePos ][1], parkingPositions[ currentReleasePos ][2], parkingPositions[ currentReleasePos ][3], parkingPositions[ currentReleasePos ][4], parkingPositions[ currentReleasePos ][5], parkingPositions[ currentReleasePos ][6]
end

function cannotVehpos(thePlayer, theVehicle)
	return isElementWithinColShape(thePlayer, towSphere) and getElementData(thePlayer,"faction") ~= 1 or isElementWithinColShape(thePlayer, towSphere3)
end

-- generic function to check if a guy is in the col polygon and the right team
function CanTowTruckDriverVehPos(thePlayer, commandName)
	local ret = 0
	if (isElementWithinColShape(thePlayer, towSphere) or isElementWithinColShape(thePlayer,towSphere2)) then
		if (getElementData(thePlayer,"faction") == 1) then
			ret = 2
		else
			ret = 1
		end
	end
	return ret
end

--Auto Pay for PD
function CanTowTruckDriverGetPaid(thePlayer, commandName)
	if (isElementWithinColShape(thePlayer,towSphere2)) then
		if (getElementData(thePlayer,"faction") == 1) then
			return true
		end
	end
	return false
end

function UnlockVehicle(element, matchingdimension) 
	local tempa = { }
	if (getElementType(element) == "vehicle" and getVehicleOccupant(element) and getElementData(getVehicleOccupant(element),"faction") == 1 and getElementModel(element) == 525 and getVehicleTowedByVehicle(element)) then
		while (getVehicleTowedByVehicle(element)) do
			local temp = getVehicleTowedByVehicle(element)
			tempa[1] = getVehicleTowedByVehicle(element)
			local owner = getElementData(tempa[1], "owner")
			local faction = getElementData(tempa[1], "faction")
			local dbid = getElementData(tempa[1], "dbid")
			local impounded = getElementData(tempa[1], "Impounded")
			local thePlayer = getVehicleOccupant(element)
			if (owner > 0) then
				if (faction > 3 or faction < 0) then
					if (source == towSphere2) then
						--PD make sure its not marked as impounded so it cannot be recovered and unlock/undp it
						setVehicleLocked(tempa[1], false)
						exports['anticheat-system']:changeProtectedElementDataEx(tempa[1], "Impounded", 0)
						exports['anticheat-system']:changeProtectedElementDataEx(tempa[1], "enginebroke", 0, false)
						setVehicleDamageProof(tempa[1], false)
						setVehicleEngineState(tempa[1], false)
						outputChatBox("((Please remember to /park and /handbrake your vehicle in our car park.))", thePlayer, 255, 194, 14)
					else
						if (getElementData(tempa[1], "faction") ~= 1) then
							if (impounded == 0) then
								--unlock it and impound it
								detachTrailerFromVehicle(element)
								
								exports['anticheat-system']:changeProtectedElementDataEx(tempa[1], "Impounded", getRealTime().yearday)
								setVehicleLocked(tempa[1], false)
								exports['anticheat-system']:changeProtectedElementDataEx(tempa[1], "enginebroke", 1, false)
								setVehicleEngineState(tempa[1], false)
								
								local time = getRealTime()
								-- fix trailing 0's
								local hour = tostring(time.hour)
								local mins = tostring(time.minute)
								
								if ( time.hour < 10 ) then
									hour = "0" .. hour
								end
								
								if ( time.minute < 10 ) then
									mins = "0" .. mins
								end
								local datestr = time.monthday .. "/" .. time.month .." " .. hour .. ":" .. mins
								
								local theTeam = exports.pool:getElement("team", 1)
								local factionRanks = getElementData(theTeam, "ranks")
								local factionRank = factionRanks[ getElementData(thePlayer, "factionrank") ] or ""
								
								exports.global:giveItem(tempa[1], 72, "Towing Notice: Impounded by ".. factionRank .." '".. getPlayerName(thePlayer) .."' at "..datestr)
								outputChatBox("((Please remember to /park and /handbrake your vehicle in our car park.))", thePlayer, 255, 194, 14)
								exports.global:giveMoney(thePlayer, 7500)
								setElementFrozen(tempa[1],true)
								setElementDimension(tempa[1], 65525)
								updateVehPos(tempa[1])
								local vehicleID = getElementData(tempa[1], "dbid")
								exports['vehicle-system']:reloadVehicle(tonumber(vehicleID))
								tempa[1] = nil
							end
						end
					end
				else
					outputChatBox("This Faction's vehicle cannot be impounded.", thePlayer, 255, 194, 14)
				end
			end
		end
	end
end
addEventHandler("onColShapeHit", towImpoundSphere, UnlockVehicle)
addEventHandler("onColShapeHit", towSphere2, UnlockVehicle)

-- Command to impound Bikes:
function setbikeimpound(player, matchingDimension)
	local leader = tonumber( getElementData(player, "factionleader") ) or 0
	local rank = tonumber( getElementData(player, "factionrank") ) or 0

	local veh = getPedOccupiedVehicle(player)
	if (getElementData(player,"faction")) == 1 then
		if (isPedInVehicle(player)) then
			if (getVehicleType(veh) == "Bike") or (getVehicleType(veh) == "BMX") then
				local owner = getElementData(veh, "owner")
				local faction = getElementData(veh, "faction")
				local dbid = getElementData(veh, "dbid")
				local impounded = getElementData(veh, "Impounded")
				if (owner > 0) then
					if (faction > 3 or faction < 0) then
						if (source == towSphere2) then
							--PD make sure its not marked as impounded so it cannot be recovered and unlock/undp it
							setVehicleLocked(veh, false)
							exports['anticheat-system']:changeProtectedElementDataEx(veh, "Impounded", 0)
							exports['anticheat-system']:changeProtectedElementDataEx(veh, "enginebroke", 0, false)
							setVehicleDamageProof(veh, false)
							setVehicleEngineState(veh, false)
							outputChatBox("#FF0000[!]#FFFFFFAraç Bağcılar devlet ceza otoparkına çekilmiştir, lütfen işinize devam ediniz.", player, 0, 0, 0, true)
						else
							if rank >= 5 then
								if (getElementData(veh, "faction") ~= 1) then
									if (impounded == 0) then
										exports['anticheat-system']:changeProtectedElementDataEx(veh, "Impounded", getRealTime().yearday)
										setVehicleLocked(veh, false)
										exports['anticheat-system']:changeProtectedElementDataEx(veh, "enginebroke", 1, false)
										setVehicleEngineState(veh, false)
										removePedFromVehicle(player)
										setElementFrozen(veh)
										setElementDimension(veh, 65525)
										updateVehPos(veh)
										local vehicleID = getElementData(veh, "dbid")
										exports['vehicle-system']:reloadVehicle(tonumber(vehicleID))
										outputChatBox("(( The bike has been successfully impounded. ))", player, 50, 205, 50)
										outputChatBox("((Lütfen parkı / parkı / el frenlemeyi unutmayınız.))", player, 255, 194, 14)
										exports.global:giveMoney(player, 7500)
										isin = false
										
										exports.logs:logMessage("[IMPOUNDED BIKE] " .. getPlayerName(player) .. " impounded vehicle #" .. dbid .. ", owned by " .. tostring(exports['cache']:getCharacterName(owner)) .. ", in " .. table.concat({exports.global:getElementZoneName(veh)}, ", ") .. " (pos = " .. table.concat({getElementPosition(veh)}, ", ") .. ", rot = ".. table.concat({getVehicleRotation(veh)}, ", ") .. ", health = " .. getElementHealth(veh) .. ")", 14)
									end
								end
							else
								local factionRanks = getElementData(getPlayerTeam(player), "ranks")
								local factionRank = factionRanks[ 5 ] or "awesome dudes"
								outputChatBox("Command only usable by " .. factionRank .. " and above.", player, 255, 194, 14)
							end
						end
					else
						outputChatBox("This Faction's vehicle cannot be impounded.", player, 255, 194, 14)
					end
				end
			else
				outputChatBox("You can only use this command to impound MoterBikes and BMX.", player, 255, 194, 14)
			end
		else
			outputChatBox("You are not in a vehicle.", player, 255, 0, 0)
		end
	end
end
addCommandHandler("impoundbike", setbikeimpound)

function payRelease(vehID)
	if exports.global:takeMoney(source, 7500) then
		exports.global:giveMoney(getTeamFromName("Hex Tow 'n Go"), 7525)
		setElementFrozen(vehID, false)
		local x, y, z, int, dim, rotation = getReleasePosition()
		setElementPosition(vehID, x, y, z)
		setVehicleRotation(vehID, 0, 0, rotation)
		setElementInterior(vehID, int)
		setElementDimension(vehID, dim)
		setVehicleLocked(vehID, true)
		exports['anticheat-system']:changeProtectedElementDataEx(vehID, "enginebroke", 0, false)
		setVehicleDamageProof(vehID, false)
		setVehicleEngineState(vehID, false)
		exports['anticheat-system']:changeProtectedElementDataEx(vehID, "handbrake", 0, false)
		exports['anticheat-system']:changeProtectedElementDataEx(vehID, "Impounded", 0)
		setElementHealth(vehID, 1000)

		outputChatBox("Your vehicle has been released. (( Lütfen aracınızı park etmeyi unutmayın, aksi halde park yerimizde tekrar gidebilir. ))", source, 255, 194, 14)
	else
		outputChatBox("Insufficient Funds.", source, 255, 0, 0)
	end
end
addEvent("releaseCar", true)
addEventHandler("releaseCar", getRootElement(), payRelease)

function unimpoundVeh(thePlayer, commandName, vehid)
	if thePlayer then
		if not vehid then
			outputChatBox("SYNTAX: /" .. commandName .. " [Vehicle ID]", thePlayer, 255, 194, 14)
		else
			local vehID = exports.pool:getElement("vehicle", tonumber(vehid))
			if not vehID then
				outputChatBox("Invalid Vehicle.", thePlayer, 255, 0, 0)
			else
				if getElementData(vehID, "Impounded") and getElementData(vehID, "Impounded") >= 1 then
					if commandName == "unimpound" then
						if (getElementData(thePlayer,"faction") == 1) then
							if(getElementData(thePlayer, "factionleader") == 1) then
								setElementFrozen(vehID, false)
								local x, y, z, int, dim, rotation = getReleasePosition()
								setElementPosition(vehID, x, y, z)
								setVehicleRotation(vehID, 0, 0, rotation)
								setElementInterior(vehID, int)
								setElementDimension(vehID, dim)
								setVehicleLocked(vehID, true)
								exports['anticheat-system']:changeProtectedElementDataEx(vehID, "enginebroke", 0, false)
								setVehicleDamageProof(vehID, false)
								setVehicleEngineState(vehID, false)
								exports['anticheat-system']:changeProtectedElementDataEx(vehID, "handbrake", 0, false)
								exports['anticheat-system']:changeProtectedElementDataEx(vehID, "Impounded", 0)
								updateVehPos(vehID)
								triggerEvent("parkVehicle", thePlayer, vehID)
								setElementHealth(vehID, 1000)


								outputChatBox("You have unimpounded vehicle #" .. vehid .. ".", thePlayer, 0, 255, 0)
								
								local theTeam = getTeamFromName("Hex Tow 'n Go")
								local teamPlayers = getPlayersInTeam(theTeam)
								local username = getPlayerName(thePlayer):gsub("_", " ")
								for key, value in ipairs(teamPlayers) do
									outputChatBox(username .. " has unimpounded vehicle #" .. vehid .. ".", value, 0, 255, 0)
								end
								
								exports.logs:logMessage("[BTR-UNIMPOUND] " .. username .. " has unimpounded vehicle #" .. vehid .. ".", 9)
							else
								outputChatBox("You must be the faction leader.", thePlayer, 255, 0, 0)
							end
						end
					elseif commandName == "aunimpound" then
						if exports.global:isPlayerSuperAdmin(thePlayer) then
							setElementFrozen(vehID, false)
							local x, y, z, int, dim, rotation = getReleasePosition()
							setElementPosition(vehID, x, y, z)
							setVehicleRotation(vehID, 0, 0, rotation)
							setElementInterior(vehID, int)
							setElementDimension(vehID, dim)
							setVehicleLocked(vehID, true)
							exports['anticheat-system']:changeProtectedElementDataEx(vehID, "enginebroke", 0, false)
							setVehicleDamageProof(vehID, false)
							setVehicleEngineState(vehID, false)
							exports['anticheat-system']:changeProtectedElementDataEx(vehID, "handbrake", 0, false)
							exports['anticheat-system']:changeProtectedElementDataEx(vehID, "Impounded", 0)
							updateVehPos(vehID)
							triggerEvent("parkVehicle", thePlayer, vehID)
							setElementHealth(vehID, 1000)

							
							local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
							local playerName = getPlayerName(thePlayer):gsub("_", " ")
							outputChatBox("You have unimpounded vehicle #" .. vehid .. ".", thePlayer, 0, 255, 0)
							exports.global:sendMessageToAdmins("AdmCmd: " .. adminTitle .. " " .. playerName .. " unimpounded vehicle #" .. vehid .. ".")
							
							exports.logs:logMessage("[ADMIN-UNIMPOUND] " .. playerName .. " has unimpounded vehicle #" .. vehid .. ".", 9)
						end
					end
				else
					outputChatBox("Vehicle #" .. vehid .. " is not currently impounded.", thePlayer, 255, 0, 0)
				end
			end
		end
	end
end
addCommandHandler("unimpound", unimpoundVeh)
addCommandHandler("araccikar", unimpoundVeh)

function disableEntryToTowedVehicles(thePlayer, seat, jacked, door) 
	if (getVehicleTowingVehicle(source)) then
		if seat == 0 then
			outputChatBox("You cannot enter a vehicle being towed!", thePlayer, 255, 0, 0)
			cancelEvent()
		end
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), disableEntryToTowedVehicles)

function triggerShowImpound()
	element = client
	local vehElements = {}
	local count = 1
	for key, value in ipairs(getElementsByType("vehicle")) do
		local dbid = getElementData(value, "dbid")
		if (getElementData(value, "Impounded") and getElementData(value, "Impounded") > 0 and ((dbid > 0 and exports.global:hasItem(element, 3, dbid) or (getElementData(value, "faction") == getElementData(element, "faction") and getElementData(value, "owner") == getElementData(element, "dbid"))))) then
			vehElements[count] = value
			count = count + 1
		end
	end
	triggerClientEvent( element, "ShowImpound", element, vehElements)
end
addEvent("onTowMisterTalk", true)
addEventHandler("onTowMisterTalk", getRootElement(), triggerShowImpound)

function updateVehPos(veh)
	local x, y, z = getElementPosition(veh)
	local rx, ry, rz = getVehicleRotation(veh)
		
	local interior = getElementInterior(veh)
	local dimension = getElementDimension(veh)
	local dbid = getElementData(veh, "dbid")
	mysql:query_free("UPDATE vehicles SET x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y) .."', z='" .. mysql:escape_string(z) .. "', rotx='" .. mysql:escape_string(rx) .. "', roty='" .. mysql:escape_string(ry) .. "', rotz='" .. mysql:escape_string(rz) .. "', currx='" .. mysql:escape_string(x) .. "', curry='" .. mysql:escape_string(y) .. "', currz='" .. mysql:escape_string(z) .. "', currrx='" .. mysql:escape_string(rx) .. "', currry='" .. mysql:escape_string(ry) .. "', currrz='" .. mysql:escape_string(rz) .. "', interior='" .. mysql:escape_string(interior) .. "', currinterior='" .. mysql:escape_string(interior) .. "', dimension='" .. mysql:escape_string(dimension) .. "', currdimension='" .. mysql:escape_string(dimension) .. "' WHERE id='" .. mysql:escape_string(dbid) .. "'")
	setVehicleRespawnPosition(veh, x, y, z, rx, ry, rz)
	--exports['anticheat-system']:changeProtectedElementDataEx(veh, "respawnposition", {x, y, z, rx, ry, rz}, false)
end

function updateTowingVehicle(theTruck)
	local thePlayer = getVehicleOccupant(theTruck)
	if (thePlayer) then
		if (getElementData(thePlayer,"faction") == 1) then
			local owner = getElementData(source, "owner")
			local faction = getElementData(source, "faction")
			local carName = getVehicleName(source)
			
			if owner < 0 and faction == -1 then
				outputChatBox("(( This " .. carName .. " is a civilian vehicle. ))", thePlayer, 255, 195, 14)
			elseif (faction==-1) and (owner>0) then
				local ownerName = exports["cache"]:getCharacterName(owner)
				outputChatBox("(( This " .. carName .. " belongs to " .. ownerName .. ". ))", thePlayer, 255, 195, 14)
			else
				local row = mysql:query_fetch_assoc("SELECT name FROM factions WHERE id='" .. mysql:escape_string(faction) .. "' LIMIT 1")
			
				if not (row == false) then
					local ownerName = row.name
					outputChatBox("(( This " .. carName .. " belongs to the " .. ownerName .. " faction. ))", thePlayer, 255, 195, 14)
				end
			end
			
			if (getElementData(source, "Impounded") > 0) then
				local output = getRealTime().yearday-getElementData(source, "Impounded")
				outputChatBox("(( This " .. carName .. " has been Impounded for: " .. output .. (output == 1 and " Day." or " Days.") .. " ))", thePlayer, 255, 195, 14)
			end
			
			-- fix for handbraked vehicles
			local handbrake = getElementData(source, "handbrake")
			if (handbrake == 1) then
				exports['anticheat-system']:changeProtectedElementDataEx(source, "handbrake",0,false)
				setElementFrozen(source, false)
			end
		end
		if thePlayer then
			exports.logs:logMessage("[TOW] " .. getPlayerName( thePlayer ) .. " started towing vehicle #" .. getElementData(source, "dbid") .. ", owned by " .. tostring(exports['cache']:getCharacterName(getElementData(source,"owner"))) .. ", from " .. table.concat({exports.global:getElementZoneName(source)}, ", ") .. " (pos = " .. table.concat({getElementPosition(source)}, ", ") .. ", rot = ".. table.concat({getVehicleRotation(source)}, ", ") .. ", health = " .. getElementHealth(source) .. ")", 14)
		end
	end
end

addEventHandler("onTrailerAttach", getRootElement(), updateTowingVehicle)

function updateCivilianVehicles(theTruck)
	if (isElementWithinColShape(theTruck, towSphere)) then
		local owner = getElementData(source, "owner")
		local faction = getElementData(source, "faction")
		local dbid = getElementData(source, "dbid")

		if (dbid >= 0 and faction == -1 and owner < 0) then
			exports.global:giveMoney(getTeamFromName("Hex Tow 'n Go"), 7500)
			outputChatBox("The state has un-impounded the vehicle you where towing.", getVehicleOccupant(theTruck), 255, 194, 14)
			respawnVehicle(source)
		end
	end
	setElementSyncer(source,false)
	if getVehicleOccupant(theTruck) then
		exports.logs:logMessage("[TOW STOP] " .. getPlayerName( getVehicleOccupant(theTruck) ) .. " stopped towing vehicle #" .. getElementData(source, "dbid") .. ", owned by " .. tostring(exports['cache']:getCharacterName(getElementData(source,"owner"))) .. ", in " .. table.concat({exports.global:getElementZoneName(source)}, ", ") .. " (pos = " .. table.concat({getElementPosition(source)}, ", ") .. ", rot = ".. table.concat({getVehicleRotation(source)}, ", ") .. ", health = " .. getElementHealth(source) .. ")", 14)
	end
end
addEventHandler("onTrailerDetach", getRootElement(), updateCivilianVehicles)
