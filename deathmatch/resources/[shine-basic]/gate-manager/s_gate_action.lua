local affectedByGate = {}

addEvent("gate:trigger", true)
function triggerGate(password)
	if not source or not client then
		return
	end
	
	local isGate = getElementData(source, "gate")
	if not isGate then
		return
	end
	local playerX, playerY, playerZ = getElementPosition(client)		
	local gateX, gateY, gateZ = getElementPosition(source)		
	local reachedit = false
	if ( getDistanceBetweenPoints3D(playerX, playerY, playerZ, gateX, gateY, gateZ) <= 5 ) then
		reachedit = true
	end
	if ( isPedInVehicle (client) and getDistanceBetweenPoints3D(playerX, playerY, playerZ, gateX, gateY, gateZ) <= 25 ) then
		reachedit = true
	end
	if reachedit then
		local isGateBusy = getElementData(source, "gate:busy")
		if not (isGateBusy) then
			--[[local gateType = getProtectionType(source)
			if (gateType == 1 or gateType == 3 or gateType == 4 or gateType == 5 or gateType == 7) then
				-- Doesn't need players input]]
				if (canPlayerControlGate(source, client, password)) then
					moveGate(source)
				else
					outputChatBox("You're unable to open this door, it seems to be locked.", client, 255, 0, 0)
				end
			--end
		end
	end
end
addEventHandler("gate:trigger", getRootElement(), triggerGate)

function moveGate(theGate, secondtime)
	if not secondtime then
		secondtime = false
	end
	local isGateBusy = getElementData(theGate, "gate:busy")
	if not (isGateBusy) or (secondtime) then
		exports['anticheat-system']:changeProtectedElementDataEx(theGate, "gate:busy", true, false)
		local gateParameters = getElementData(theGate, "gate:parameters")
		
		local newX, newY, newZ, offsetRX, offsetRY, offsetRZ, movementTime, autocloseTime
		
		local startPosition = gateParameters["startPosition"]
		local endPosition = gateParameters["endPosition"]
		
		if gateParameters["state"] then -- its opened, close it
			newX = startPosition[1]
			newY = startPosition[2]
			newZ = startPosition[3]
			offsetRX = endPosition[4] - startPosition[4] 
			offsetRY = endPosition[5] - startPosition[5] 
			offsetRZ = endPosition[6] - startPosition[6] 
			gateParameters["state"] = false1
			gateParameters["state"] = false
		else -- its closed, open it
			newX = endPosition[1]
			newY = endPosition[2]
			newZ = endPosition[3]
			offsetRX = startPosition[4] - endPosition[4] 
			offsetRY = startPosition[5] - endPosition[5] 
			offsetRZ = startPosition[6] - endPosition[6] 
			gateParameters["state"] = true
		end

		movementTime = gateParameters["movementTime"] * 100
		
		local gateSound = getElementData(theGate, "gate.sound")
		if gateSound then gateSound = tostring(gateSound) end
		if(gateSound == "alarmbell") then
			local sphere = createColSphere(startPosition[1], startPosition[2], startPosition[3], 100)
			local affectedPlayers = getElementsWithinColShape(sphere, "player")
			affectedByGate[theGate] = affectedPlayers
			for k,v in ipairs(affectedPlayers) do
				triggerClientEvent(v, "gate:playsound", getRootElement(), theGate, gateSound, startPosition[1], startPosition[2], startPosition[3])
			end
		end

		offsetRX = fixRotation(offsetRX)
		offsetRY = fixRotation(offsetRY)
		offsetRZ = fixRotation(offsetRZ)
		
		moveObject ( theGate, movementTime, newX, newY, newZ, offsetRX, offsetRY, offsetRZ )
		
		
		if (not secondtime) and (gateParameters["autocloseTime"] ~= 0) then
			autocloseTime = tonumber(gateParameters["autocloseTime"])*100
			gateParameters["timer"] = setTimer(moveGate, movementTime+autocloseTime, 1, theGate, true)
		else
			setTimer(resetBusyState, movementTime, 1, theGate)
		end
		exports['anticheat-system']:changeProtectedElementDataEx(theGate, "gate:parameters", gateParameters, false)
	end
end

function fixRotation(value)
	local invert = false
	if value < 0 then
		--invert = true
		--value = value - value - value
		while value < -360 do
			value = value + 360
		end
		if value < -180 then
			value = value + 180
			value = value - value - value
		end
	else
		while value > 360 do
			value = value - 360
		end
		if value > 180 then
			value = value - 180
			value = value - value - value
		end
	end
	
	--[[if invert then
		value = 360 - value
	end--]]
	return value
end

function resetBusyState(theGate)
	local isGateBusy = getElementData(theGate, "gate:busy")
	if (isGateBusy) then
		exports['anticheat-system']:changeProtectedElementDataEx(theGate, "gate:busy", false, false)
	end
	if affectedByGate[theGate] then
		for k,v in ipairs(affectedByGate[theGate]) do
			triggerClientEvent(v, "gate:stopsound", getRootElement(), theGate)
		end
		affectedByGate[theGate] = nil
	end
end

function getProtectionType(theGate)
	local gateParameters = getElementData(theGate, "gate:parameters")
	return tonumber(gateParameters["type"]) or -1
end

function canPlayerControlGate(theGate, thePlayer, password)
	if not password then
		password = ""
	end
	local gateParameters = getElementData(theGate, "gate:parameters")
	local gateProtection = getProtectionType(theGate)
	if gateProtection == 1 then
		return true
	elseif gateProtection == 2 then
		if password == gateParameters["gateSecurityParameters"] then
			return true
		end
	elseif gateProtection == 3 then
		local tempAccess = split(gateParameters["gateSecurityParameters"], " ")
		for _, itemID in ipairs(tempAccess) do
			if (exports.global:hasItem(thePlayer, tonumber(itemID))) then
				return true
			end
		end
		outputDebugString("Found none, returning false.")
		return false
	elseif gateProtection == 4 then
		local tempAccess = split(gateParameters["gateSecurityParameters"], " ")
		local hasItem, slotID, itemValue, databaseID = exports.global:hasItem(thePlayer, tonumber(tempAccess[1]))
		if (hasItem) then
			if string.find(itemValue, tempAccess[2]) then
				return true
			end
		end
	elseif gateProtection == 5 then
		if password == gateParameters["gateSecurityParameters"] then
			return true
		end
	elseif gateProtection == 7 then
		if string.find(getElementData(thePlayer, "faction"), gateParameters["gateSecurityParameters"]) then
			return true
		end
	elseif gateProtection == 8 then --Query string
		local tempAccess = split(gateParameters["gateSecurityParameters"], " AND ")
		--local badges = exports["item-system"]:getBadges()
		--outputDebugString("badges:"..tostring(badges).." ("..tostring(#badges)..")")
		local count = 0
		for _, itemID in ipairs(tempAccess) do
			local orString = split(itemID, " OR ")
			if(#orString > 1) then
				--outputDebugString("or alternatives found")
				local countOr = 0
				for k, v in ipairs(orString) do
					local theItem = split(orString[k], "=")
					local hasItem, key, value2, value3 = exports.global:hasItem(thePlayer, tonumber(theItem[1]))
					if hasItem then
						--outputDebugString("has item")
						if theItem[2] then
							--outputDebugString("value match requested")
							--outputDebugString(tostring(value2).." == "..tostring(theItem[2]))
							--if(tostring(value2) == tostring(theItem[2])) then
							if(isNumeric(theItem[2])) then theItem[2] = tonumber(theItem[2]) else theItem[2] = tostring(theItem[2]) end
							--outputDebugString(tostring(exports['item-system']:countItems(thePlayer, tonumber(theItem[1]), theItem[2])))
							if(tonumber(exports['item-system']:countItems(thePlayer, tonumber(theItem[1]), theItem[2])) > 0) then
								countOr = countOr + 1
								--outputDebugString("has value, +1")
							end
						else
							--outputDebugString("badges["..tostring(theItem[1]).."] = "..tostring(badges[theItem[1]]))
							--if badges[theItem[1]] then
							if exports["item-system"]:isBadge(theItem[1]) then
								--if(getElementData(thePlayer, badges[theItem[1]][1])) then
								if exports["item-system"]:isWearingBadge(thePlayer, theItem[1]) then
									countOr = countOr + 1
									--outputDebugString("badge on, +1")
								end
							else
								countOr = countOr + 1
								--outputDebugString("has item, +1")
							end
						end						
					end
				end
				if(countOr > 0) then
					count = count + 1
				end
			else
				local theItem = split(orString[1], "=")
				local hasItem, key, value2, value3 = exports.global:hasItem(thePlayer, tonumber(theItem[1]))
				if hasItem then
					if theItem[2] then
						if(isNumeric(theItem[2])) then theItem[2] = tonumber(theItem[2]) else theItem[2] = tostring(theItem[2]) end
						--outputDebugString(tostring(exports['item-system']:countItems(thePlayer, tonumber(theItem[1]), theItem[2])))
						if(tonumber(exports['item-system']:countItems(thePlayer, tonumber(theItem[1]), theItem[2])) > 0) then
							count = count + 1
						end
						--if(tonumber(value2) == tonumber(theItem[2])) then
						--	count = count + 1
						--end
					else
						if badges[itemID] then
							if(getElementData(thePlayer, badges[itemID][1])) then
								count = count + 1
							end
						else
							count = count + 1
						end
					end
				end
			end
		end
		--outputDebugString("#tempAccess:"..tostring(#tempAccess).." count:"..tostring(count))
		if(#tempAccess == count) then
			return true
		end
		
		return false
	elseif gateProtection == 9 then --If player has access to the given vehicle
		local tempAccess = split(gateParameters["gateSecurityParameters"], " ")
		for _, vehID in ipairs(tempAccess) do
			local veh
			for k,v in ipairs(exports.pool:getPoolElementsByType("vehicle")) do
				if(getElementData(v, "dbid") == tonumber(vehID)) then
					veh = v
					break
				end
			end
			if veh then
				if(getElementData(thePlayer, "adminduty") == 1 or exports.global:hasItem(thePlayer, 3, tonumber(vehID)) or (getElementData(thePlayer, "faction") > 0 and getElementData(thePlayer, "faction") == getElementData(veh, "faction"))) then
					return true
				end
			end
		end		
		return false
	else
		--outputDebugString("nothing matched :( "..type(gateProtection) .. " "..tostring(gateProtection))
	end
	
	return false
end

function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function isNumeric(a)
	if tonumber(a) ~= nil then return true else return false end
end

--[[
Gate types:
1. /gate for everyone
2. /gate for everyone with password
3. /gate with item
4. /gate with item and itemvalue ending on *
5. open with /gate and keypad
6. colsphere trigger
7. /gate for person in faction
8. /gate depending on query string
9. /gate for person with access to given vehicle ID
]]