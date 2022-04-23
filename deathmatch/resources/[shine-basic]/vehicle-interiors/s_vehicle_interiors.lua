--MODIFIED! by Exciter

local vehicles = { }
local vehicleInteriorGates = { }

local customVehInteriors = {
		--model,x,y,z,rx,ry,rz,interior
		
		--1: Andromada
		{
			{14548,-445.39999,87.3,1226.80005,13,0,0,1},
			{3069,-445.39999,111.2,1224.69995,0,0,0,1}
		},
		--2: Shamal
		{
			{2924,2.4000000953674,34.400001525879,1202.0999755859,0,0,0,1}
		},
		--3: AT-400
		{
			{14548,-388.89999, 86.6, 1226.80005,13,0,0,1},
			{7191,-391.10001, 110.2, 1226.69995,0,0,270,1},
			{7191,-391.10001, 110.2, 1230.19995,0,0,270,1},
			{7191,-411.79999,62.6,1226.69995,0,0,270,1},
			{7191,-365.89999,62.6,1226.69995,0,0,90,1},
			{7191,-373.89999,62.6,1229.40002,0,0,90,1},
		}
}

-- check all existing vehicles for interiors
addEventHandler( "onResourceStart", getResourceRootElement( ),
	function( )
		for key, value in ipairs( getElementsByType( "vehicle" ) ) do
			add( value )
		end
	end
)

-- cleanup code
addEventHandler( "onElementDestroy", getRootElement( ),
	function( )
		if vehicles[ source ] then
			destroyElement( vehicles[ source ] )
			vehicles[ source ] = nil
		end
	end
)

addEventHandler( "onResourceStop", getResourceRootElement( ),
	function( )
		for key, value in ipairs( getElementsByType( "vehicle" ) ) do
			if getElementData( value, "entrance" ) then
				exports['anticheat-system']:changeProtectedElementDataEx( value, "entrance" )
			end
		end
		for key, value in ipairs(vehicleInteriorGates) do
			exports['gate-manager']:removeGate(value)
		end
	end
)

-- code to create the pickup and set properties
local function addInterior( vehicle, targetx, targety, targetz, targetinterior )
	local intpickup = createPickup( targetx, targety, targetz, 3, 1318 )
	setElementDimension( intpickup, getElementData( vehicle, "dbid" ) + 20000 )
	setElementInterior( intpickup, targetinterior )
	
	vehicles[ vehicle ] = intpickup
	exports['anticheat-system']:changeProtectedElementDataEx( vehicle, "entrance", true )
end

-- exported, called when a vehicle is created
function add( vehicle )
	--[[
	if getElementData(vehicle, "dbid") == 8726 then -- vehicle is shamal and vehid is 8726
		addInterior( vehicle, 1429, 1463, 11, 33) -- add the interior
		return true, 33 -- this is teh interior the shit was createObject'd in.
	--]]
	if getElementModel( vehicle ) == 519 then -- Shamal
		local dbid = tonumber(getElementData(vehicle, "dbid"))
		local dim = dbid+20000

		--create custom objects
		for k,v in ipairs(customVehInteriors[2]) do
			local object = createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
			setElementInterior(object, v[8])
			setElementDimension(object, dim)
		end

		--add cockpit door		
		local gate = exports['gate-manager']:createGate(2924,1,34.5,1199.8000488281,0,0,180,-0.30000001192093,34.5,1199.8000488281,0,0,180,1,dim,0,30,9,tostring(dbid),2)
		table.insert(vehicleInteriorGates, gate)

		addInterior( vehicle,  2.609375, 33.212890625, 1199.6, 1 )
		--addInterior( vehicle, 3.8, 23.1, 1199.6, 1 )
		local x,y,z = getElementPosition(vehicle)
		local marker = createColSphere(x, y, z, 2)
		attachElements(marker, vehicle, -2, 3.5, -2)
		addEventHandler("onColShapeHit", marker, hitVehicleEntrance)
		addEventHandler("onColShapeLeave", marker, leaveVehicleEntrance)
		
		local shape = createColSphere(1.7294921875, 35.7333984375, 1200.3044433594, 1.5)
		setElementInterior(shape, 1)
		setElementDimension(shape, dim)
		addEventHandler("onColShapeHit", shape, hitCockpitShape)
		addEventHandler("onColShapeLeave", shape, leaveCockpitShape)
		
		return true, 1 -- interior id
	elseif getElementModel( vehicle ) == 577 then -- AT-400
		local dbid = tonumber(getElementData(vehicle, "dbid"))
		local dim = dbid+20000

		--create custom objects
		local addY = 0
		for i = 1,14 do
			table.insert(customVehInteriors[3], {1562, -384.60001, 65.1+addY, 1225.5, 0, 0, 0,1})
			table.insert(customVehInteriors[3], {1562, -385.39999, 65.1+addY, 1225.5, 0, 0, 0,1})
			table.insert(customVehInteriors[3], {1562, -386.20001, 65.1+addY, 1225.5, 0, 0, 0,1})
			table.insert(customVehInteriors[3], {1562, -393.29999, 65.1+addY, 1225.5, 0, 0, 0,1})
			table.insert(customVehInteriors[3], {1562, -392.5, 65.1+addY, 1225.5, 0, 0, 0,1})
			table.insert(customVehInteriors[3], {1562, -391.70001, 65.1+addY, 1225.5, 0, 0, 0,1})
			table.insert(customVehInteriors[3], {1562, -389.79999, 65.1+addY, 1225.5, 0, 0, 0,1})
			table.insert(customVehInteriors[3], {1562, -389, 65.1+addY, 1225.5, 0, 0, 0,1})
			table.insert(customVehInteriors[3], {1562, -388.20001, 65.1+addY, 1225.5, 0, 0, 0,1})			
			addY = addY + 2.8
		end
			
		for k,v in ipairs(customVehInteriors[3]) do
			local object = createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
			setElementInterior(object, v[8])
			setElementDimension(object, dim)
			if(v[1] == 1562) then --add pillows to jet seats
				local object2 = createObject(1563,v[2],v[3],v[4],v[5],v[6],v[7])
				setElementInterior(object2, v[8])
				setElementDimension(object2, dim)
				attachElements(object2, object, 0, 0.35, 0.54)
			end
		end
	
		addInterior( vehicle, -391.79999, 58, 1225.80005, 1 )
		
		local x,y,z = getElementPosition(vehicle)
		local marker = createColSphere(x, y, z, 2)
		attachElements(marker, vehicle, -4.5, 19, 2.7)
		addEventHandler("onColShapeHit", marker, hitVehicleEntrance)
		addEventHandler("onColShapeLeave", marker, leaveVehicleEntrance)
		
		local shape = createColSphere(-388.79999, 53.9, 1225.80005, 1.5)
		setElementInterior(shape, 1)
		setElementDimension(shape, dim)
		addEventHandler("onColShapeHit", shape, hitCockpitShape)
		addEventHandler("onColShapeLeave", shape, leaveCockpitShape)
		
		return true, 1
	elseif getElementModel(vehicle) == 592 then --Andromada
		--create the andromada interior
		local dim = tonumber(getElementData(vehicle, "dbid")) + 20000
		for k,v in ipairs(customVehInteriors[1]) do
			local object = createObject(v[1],v[2],v[3],v[4],v[5],v[6],v[7])
			setElementInterior(object, v[8])
			setElementDimension(object, dim)
		end
		addInterior(vehicle,  -445.29999, 113.1, 1226.19995, 1)
		
		local x,y,z = getElementPosition(vehicle)
		local marker = createColSphere(x, y, z, 5)
		attachElements(marker, vehicle, 0, -23, -2.2)
		addEventHandler("onColShapeHit", marker, hitVehicleEntrance)
		addEventHandler("onColShapeLeave", marker, leaveVehicleEntrance)

		return true, 1

	elseif getElementModel( vehicle ) == 508 then --Journey
		local x,y,z = getElementPosition(vehicle)
		local marker = createColSphere(x, y, z, 1)
		attachElements(marker, vehicle, 2, 0, 0)
		addEventHandler("onColShapeHit", marker, hitVehicleEntrance)
		addEventHandler("onColShapeLeave", marker, leaveVehicleEntrance)		
		addInterior( vehicle, 1.9, -3.2, 999.4, 2 )
		return true, 2
	elseif getElementModel( vehicle ) == 484 then
		addInterior( vehicle, 1.9, -3.2, 999.4, 2 )
		return true, 2
	--[[elseif getElementModel( vehicle ) == 435 then -- Trailer / MAXIME
		addInterior( vehicle, 1448.4056396484, 1465.1271972656, 16994.09765625, 0 )
		return true, 0 -- int]]
	else
		return false
	end
end

function hitCockpitShape(hitElement, matchingDimension)
	--outputDebugString("hitCockpitShape()")
	if matchingDimension and getElementType(hitElement) == "player" then
		bindKey(hitElement, "enter_exit", "down", enterCockpitByKey)
		bindKey(hitElement, "enter_passenger", "down", enterCockpitByKey)
	end
end
function leaveCockpitShape(hitElement, matchingDimension)
	--outputDebugString("leaveCockpitShape()")
	if matchingDimension and getElementType(hitElement) == "player" then
		unbindKey(hitElement, "enter_exit", "down", enterCockpitByKey)
		unbindKey(hitElement, "enter_passenger", "down", enterCockpitByKey)
	end
end
function enterCockpitByKey(thePlayer, key, keyState)
	unbindKey(thePlayer, "enter_exit", "down", enterCockpitByKey)
	unbindKey(thePlayer, "enter_passenger", "down", enterCockpitByKey)
	fadeCamera(thePlayer, false)
	local dbid = getElementDimension(thePlayer) - 20000
	local vehicle
	for value in pairs( vehicles ) do
		if getElementData( value, "dbid" ) == dbid then
			vehicle = value
			break
		end
	end
	if vehicle then
		local allowed = false
		local model = getElementModel(vehicle)
		if(model == 577 or model == 519) then --AT-400 & Shamal
			if(getElementData(thePlayer, "adminduty") == 1 or exports.global:hasItem(thePlayer, 3, tonumber(dbid)) or (getElementData(thePlayer, "faction") > 0 and getElementData(thePlayer, "faction") == getElementData(vehicle, "faction"))) then
				allowed = true
			end
		end
		if allowed then
			local seat
			if(key == "enter_exit") then
				seat = 0
			elseif(key == "enter_passenger") then
				seat = 1
			end
			if seat then
				local result = warpPedIntoVehicle(thePlayer, vehicle, seat)
				if result then
					setElementInterior(thePlayer, getElementInterior(vehicle))
					setElementDimension(thePlayer, getElementDimension(vehicle))
					triggerEvent("texture-system:loadCustomTextures", thePlayer)
					fadeCamera(thePlayer, true)
				end
			else
				--outputDebugString("no seat")
			end
		end
	end
end

function hitVehicleEntrance(hitElement, matchingDimension)
	--outputDebugString("hitVehicleEntrance()")
	if matchingDimension and getElementType(hitElement) == "player" then
		--outputDebugString("matching")
		local vehicle = getElementAttachedTo(source)
		if vehicles[ vehicle ] then
			--outputDebugString("found veh")
			if not isVehicleLocked( vehicle ) then
				--outputDebugString("not locked")
				--[[
				local owner = getElementData(vehicle, "owner")
				local faction = getElementData(vehicle, "faction")
				local ownerName = "None."
				if owner < 0 and faction == -1 then
					--ownerName = "None."
				elseif (faction==-1) and (owner>0) then
					ownerName = exports['cache']:getCharacterName(owner)
				elseif(faction > 0) then
					local factionName
					for key, value in ipairs(exports.pool:getPoolElementsByType("team")) do
						local id = tonumber(getElementData(value, "id"))
						if (id==faction) then
							factionName = getTeamName(value)
							break
						end
					end
					if factionName then
						ownerName = factionName
					end
				end
				--]]
				triggerClientEvent(hitElement, "vehicle-interiors:showInteriorGUI", vehicle)
			end
		end
	end
end
function leaveVehicleEntrance(hitElement, matchingDimension)
	--outputDebugString("leaveVehicleEntrance()")
	if matchingDimension and getElementType(hitElement) == "player" then
		triggerClientEvent(hitElement, "vehicle-interiors:hideInteriorGUI", hitElement)
	end
end

-- enter over right click menu
function teleportTo( player, x, y, z, dimension, interior, freeze )
	fadeCamera( player, false, 1 )
	
	setTimer(
		function( player )
			setElementDimension( player, dimension )
			setElementInterior( player, interior )
			setCameraInterior( player, interior )
			setElementPosition( player, x, y, z )
			
			triggerEvent( "onPlayerInteriorChange", player )
			
			setTimer( fadeCamera, 1000, 1, player, true, 2 )
			
			if freeze then 
				triggerClientEvent( player, "usedElevator", player ) -- DISABLED because the event was buggged for an unknown reason on client side / MAXIME
				setElementFrozen( player, true )
				setPedGravity( player, 0 )
			end
		end, 1000, 1, player
	)
end

addEvent( "enterVehicleInterior", true )
addEventHandler( "enterVehicleInterior", getRootElement( ),
	function( vehicle )
		if vehicles[ vehicle ] then
			if isVehicleLocked( vehicle ) then
				outputChatBox( "You try the door handle, but it seems to be locked.", source, 255, 0, 0 )
			else
				local model = getElementModel(vehicle)
				if(model == 577 or model == 592) then --texture change
					triggerClientEvent(source, "vehicle-interiors:changeTextures", vehicle, model)
				end
				
				if(model == 592) then --Andromada (for vehicles)
					if(isPedInVehicle(source)) then
						if(getPedOccupiedVehicleSeat(source) == 0) then
							local pedVehicle = getPedOccupiedVehicle(source)
							exports['anticheat-system']:changeProtectedElementDataEx(pedVehicle, "health", getElementHealth(pedVehicle), false)
							for i = 0, getVehicleMaxPassengers( pedVehicle ) do
								local p = getVehicleOccupant( pedVehicle, i )
								if p then
									triggerClientEvent( p, "CantFallOffBike", p )
								end
							end
							local exit = vehicles[ vehicle ]
							local x, y, z = getElementPosition(exit)
							setTimer(warpVehicleIntoInteriorfunction, 500, 1, pedVehicle, getElementInterior(exit), getElementDimension(exit), x, y, z)	
						end
						return
					end
				end

				local exit = vehicles[ vehicle ]
				local x, y, z = getElementPosition(exit)
				local teleportArr = { x, y, z, getElementInterior(exit), getElementDimension(exit), 0, 0 }
				triggerClientEvent(source, "setPlayerInsideInterior", vehicle, teleportArr, 0)
			end
		end
	end
)

function warpVehicleIntoInteriorfunction(vehicle, interior, dimension, x, y, z, rz)
	if isElement(vehicle) then
		local offset = getElementData(vehicle, "groundoffset") or 2
		
		setElementPosition(vehicle, x, y, z  - 1 + offset)
		setElementInterior(vehicle, interior)
		setElementDimension(vehicle, dimension)
		setElementVelocity(vehicle, 0, 0, 0)
		setVehicleTurnVelocity(vehicle, 0, 0, 0)
		setVehicleRotation(vehicle, 0, 0, 0)
		--setElementRotation(vehicle, rz or 0, 0, 0, "ZYX")
		setTimer(setVehicleTurnVelocity, 50, 2, vehicle, 0, 0, 0)			
		setElementHealth(vehicle, getElementData(vehicle, "health") or 1000)
		exports['anticheat-system']:changeProtectedElementDataEx(vehicle, "health")
		setElementFrozen(vehicle, true)
					
		setTimer(setElementFrozen, 1000, 1, vehicle, false)
			
		for i = 0, getVehicleMaxPassengers( vehicle ) do
			local player = getVehicleOccupant( vehicle, i )
			if player then
				setElementInterior(player, interior)
				setCameraInterior(player, interior)
				setElementDimension(player, dimension)
				setCameraTarget(player)
				
				triggerEvent("onPlayerInteriorChange", player)
				exports['anticheat-system']:changeProtectedElementDataEx(player, "realinvehicle", 1, false)
			end
		end
	end
end


function enterVehicleInteriorByMarker(hitElement, matchingDimension)
	if(matchingDimension and getElementType(hitElement) == "player") then
		if not isPedInVehicle(hitElement) then
			local exiting = getElementData(hitElement, "vehint.exiting")
			if not exiting then
				local vehicle = getElementAttachedTo(source)
				if vehicles[ vehicle ] then
					if not isVehicleLocked( vehicle ) then
						local model = getElementModel(vehicle)
						if(model == 577 or model == 592) then --texture change
							triggerClientEvent(hitElement, "vehicle-interiors:changeTextures", vehicle, model)
						end
						
						local exit = vehicles[ vehicle ]
						local x, y, z = getElementPosition(exit)
						local teleportArr = { x, y, z, getElementInterior(exit), getElementDimension(exit), 0, 0 }
						triggerClientEvent(hitElement, "setPlayerInsideInterior", vehicle, teleportArr, 0)
					end
				end
			else
				--outputDebugString("exiting")
			end
		end
	end
end

function leaveVehIntMarker(hitElement, matchingDimension)
	if(getElementType(hitElement) == "player") then
		setElementData(hitElement, "vehint.exiting", false, false)
	end
end

function leaveInterior( player )
	local dim = getElementDimension( player ) - 20000
	for value in pairs( vehicles ) do
		if getElementData( value, "dbid" ) == dim then
			if isVehicleLocked( value ) then
				outputChatBox( "You try the door handle, but it seems to be locked.", player, 255, 0, 0 )
			else
				if(getElementData(value, "airport.gate.connected")) then
					local gateID = tonumber(getElementData(value, "airport.gate.connected"))
					local teleportArr = exports["sfia"]:getDataForExitingConnectedPlane(gateID, value)
					if teleportArr then
						triggerClientEvent(player, "setPlayerInsideInterior", player, teleportArr, 0)
						return
					end
				end
				
				local x, y, z = getElementPosition( value )
				local xadd, yadd, zadd = 0, 0, 2
				
				if (getElementModel(value) == 454) then -- Tropic
					xadd, yadd, zadd = 0, 0, 4
				elseif (getElementModel(value) == 508) then -- Journey
					local attached = getAttachedElements(value)
					for k,v in ipairs(attached) do
						if(getElementType(v) == "colshape") then
							x,y,z = getElementPosition(v)
							xadd,yadd,zadd = 0,0,0.5
							break
						end
					end
				elseif (getElementModel(value) == 519) then -- Shamal
					local attached = getAttachedElements(value)
					for k,v in ipairs(attached) do
						if(getElementType(v) == "colshape") then
							x,y,z = getElementPosition(v)
							xadd,yadd,zadd = 0,0,1.5
							break
						end
					end
				elseif (getElementModel(value) == 577) then -- AT-400
					local attached = getAttachedElements(value)
					for k,v in ipairs(attached) do
						if(getElementType(v) == "colshape") then
							x,y,z = getElementPosition(v)
							xadd,yadd,zadd = 0,0,1.5
							break
						end
					end
				elseif (getElementModel(value) == 592) then -- Andromada
					local attached = getAttachedElements(value)
					for k,v in ipairs(attached) do
						if(getElementType(v) == "colshape") then
							x,y,z = getElementPosition(v)
							xadd,yadd,zadd = 0,0,2
							break
						end
					end
					if(isPedInVehicle(player)) then
						if(getPedOccupiedVehicleSeat(player) == 0) then
							local pedVehicle = getPedOccupiedVehicle(player)
							exports['anticheat-system']:changeProtectedElementDataEx(pedVehicle, "health", getElementHealth(pedVehicle), false)
							for i = 0, getVehicleMaxPassengers( pedVehicle ) do
								local p = getVehicleOccupant( pedVehicle, i )
								if p then
									triggerClientEvent( p, "CantFallOffBike", p )
								end
							end
							local rz,ry,rx = getElementRotation(value, "ZYX")
							local rot = 0
							if(rz >= 180) then
								rot = rz - 180
							else
								rot = rz + 180
							end
							
							setTimer(warpVehicleIntoInteriorfunction, 500, 1, pedVehicle, getElementInterior(value), getElementDimension(value), x+xadd, y+yadd, z+zadd, rot)	
						end
						return
					end

				end			
				--setElementData(player, "vehint.exiting", true, false)
				local teleportArr = { x + xadd, y + yadd, z + zadd, getElementInterior(value), getElementDimension(value) }
				triggerClientEvent(player, "setPlayerInsideInterior", player, teleportArr, 0)
				return
			end
		end
	end
end

-- cancel picking up our pickups
function isInPickup( thePlayer, thePickup, distance )
	if not isElement(thePickup) then return false end
	
	local ax, ay, az = getElementPosition(thePlayer)
	local bx, by, bz = getElementPosition(thePickup)
	
	return getDistanceBetweenPoints3D(ax, ay, az, bx, by, bz) < ( distance or 2 ) and getElementInterior(thePlayer) == getElementInterior(thePickup) and getElementDimension(thePlayer) == getElementDimension(thePickup)
end

function isNearExit( thePlayer, theVehicle )
	return isInPickup( thePlayer, vehicles[ theVehicle ] )
end

function checkLeavePickup( player, pickup )
	if isElement( player ) then
		if isInPickup( player, pickup ) then
			setTimer( checkLeavePickup, 500, 1, player, pickup )
		else
			unbindKey( player, "f", "down", leaveInterior )
		end
	end
end

addEventHandler( "onPickupHit", getResourceRootElement( ), 
	function( player )
		bindKey( player, "f", "down", leaveInterior )
		
		setTimer( checkLeavePickup, 500, 1, player, source )
		
		cancelEvent( )
	end
)

-- make sure we blow
addEventHandler( "onVehicleRespawn", getRootElement( ),
	function( blown )
		if blown and vehicles[ source ] then
			local dim = getElementData( source ) + 20000
			for k, v in ipairs( getElementsByType( "player" ) ) do
				if getElementDimension( v ) == dim then
					killPed( v, 0 )
				end
			end
		end
	end
)

function vehicleKnock(veh)
	local player = source
	if (player) then
		local tpd = getElementDimension(player)
		if (tpd > 20000) then
			local vid = tpd - 20000
			for key, value in ipairs( getElementsByType( "vehicle" ) ) do
				if getElementData( value, "dbid" ) == vid then
					exports.global:sendLocalText(player, " *" .. getPlayerName(player):gsub("_"," ") .. " begins to knock on the vehicle.", 255, 51, 102)
					exports.global:sendLocalText(value, " * Knocks can be heard coming from inside the vehicle. *      ((" .. getPlayerName(player):gsub("_"," ") .. "))", 255, 51, 102)
				end
			end
		else
			if vehicles[veh] then
				local exit = vehicles[veh]

				if (exit) then
					exports.global:sendLocalText(player, " *" .. getPlayerName(player):gsub("_"," ") .. " begins to knock on the vehicle.", 255, 51, 102)
					exports.global:sendLocalText(exit, " * Knocks can be heard coming from the outside. *      ((" .. getPlayerName(player):gsub("_"," ") .. "))", 255, 51, 102)
				end
			end
		end
	end
end
addEvent("onVehicleKnocking", true)
addEventHandler("onVehicleKnocking", getRootElement(), vehicleKnock)

function enterVehicle(thePlayer, seat, jacked)
	local model = getElementModel(source)
	if(model == 519 or model == 577) then --Shamal & AT-400
		if vehicles[source] then
			--[[local x,y,z = getElementPosition(source)
			local px,py,pz = getElementPosition(thePlayer)
			if(getDistanceBetweenPoints3D(x,y,z,px,py,pz) < 3) then
				if not isVehicleLocked(source) then
					--outputDebugString("not locked")
					local exit = vehicles[source]
					local x, y, z = getElementPosition(exit)
					local teleportArr = { x, y, z, getElementInterior(exit), getElementDimension(exit), 0, 0 }
					triggerClientEvent(thePlayer, "setPlayerInsideInterior", source, teleportArr, 0)
				end
			else
				outputDebugString("too far away: "..tostring(getDistanceBetweenPoints3D(x,y,z,px,py,pz)))
			end--]]
			cancelEvent()
		end	
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), enterVehicle)
function exitVehicle(thePlayer, seat, jacked, door)
	--outputDebugString("onVehicleStartExit")
	if(getElementModel(source) == 519) then --Shamal
		if vehicles[source] then
			removePedFromVehicle(thePlayer)
			local teleportArr = { 1.7294921875, 35.7333984375, 1200.3044433594, 1, tonumber(getElementData(source, "dbid"))+20000, 0, 0 }
			fadeCamera(thePlayer, false)
			triggerClientEvent(thePlayer, "setPlayerInsideInterior", source, teleportArr, 0)
			fadeCamera(thePlayer, true)
			cancelEvent()
		end
	elseif(getElementModel(source) == 577) then --AT-400
		if vehicles[source] then
			removePedFromVehicle(thePlayer)
			local teleportArr = { -388.79999, 53.9, 1225.80005, 1, tonumber(getElementData(source, "dbid"))+20000, 0, 0 }
			fadeCamera(thePlayer, false)
			triggerClientEvent(thePlayer, "setPlayerInsideInterior", source, teleportArr, 0)
			fadeCamera(thePlayer, true)
			cancelEvent()
		end
	end
end
addEventHandler("onVehicleStartExit", getRootElement(), exitVehicle)
