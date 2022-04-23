--
-- people with blips
--
local blips = { }
local runwayBlips_Oceana_1 = {}
local runwayBlips_Oceana_2 = {}

addEvent( "sfia:airtrack:on", true )
addEventHandler( "sfia:airtrack:on", root,
	function( )
		if getElementType( source ) == "vehicle" then
			triggerClientEvent( client, "sfia:airtrack:blips", client, blips )
			
			blips[ client ] = source
			for player in pairs( blips ) do
				triggerClientEvent( player, "sfia:airtrack:on", source )
			end
		end
	end
)

addEvent( "sfia:airtrack:onTower", true )
addEventHandler( "sfia:airtrack:onTower", root,
	function( )
		--blipsTwr[ client ] = source
		blips[ client ] = source
		triggerClientEvent(client, "sfia:airtrack:blips", client, blips)
	end
)

function off( player )
	local vehicle = blips[ player ]
	blips[ player ] = nil
	
	for player in pairs( blips ) do
		if vehicle then
			triggerClientEvent( player, "sfia:airtrack:off", vehicle )
		end
	end
end

addEvent( "sfia:airtrack:off", true )
addEventHandler( "sfia:airtrack:off", root,
	function( )
		off( client )
	end
)
addEventHandler( "onPlayerQuit", root,
	function( )
		off( source )
	end
)

function enterVehicle(thePlayer, seat, jacked) --show radar when entering an aircraft (as aircrafts would have this in cockpit)
	local vehType = getVehicleType(source)
	if(vehType == "Plane" or vehType == "Helicopter") then
		if(seat == 0 or seat == 1) then
			showPlayerHudComponent(thePlayer, "radar", true)
			--runwayBlips_Oceana_1[thePlayer] = createBlip(-3900.5629882813, 2533.1791992188, 4.6859374046326, 57, 2, 255, 0, 0, 255, 0, 1000, thePlayer)
			--setElementRotation(runwayBlips_Oceana_1[thePlayer], 90, 90, 90)
			runwayBlips_Oceana_1[thePlayer] = createBlip(-3900.5629882813, 2533.1791992188, 4.6859374046326, 56, 1, 255, 0, 0, 255, 0, 1000, thePlayer)
			runwayBlips_Oceana_2[thePlayer] = createBlip(-4474.134765625, 2534.046875, 4.6875, 56, 1, 255, 0, 0, 255, 0, 1000, thePlayer)
		end
	end
end
addEventHandler("onVehicleEnter", getRootElement(), enterVehicle)
function exitVehicle(thePlayer, seat, jacked)
	local vehType = getVehicleType(source)
	if(vehType == "Plane" or vehType == "Helicopter") then
		if not exports.global:hasItem(thePlayer, 111) then --hide radar if player dont have the gps item
			showPlayerHudComponent(thePlayer, "radar", false)
			if runwayBlips_Oceana_1[thePlayer] then
				destroyElement(runwayBlips_Oceana_1[thePlayer])
			end
			if runwayBlips_Oceana_2[thePlayer] then
				destroyElement(runwayBlips_Oceana_2[thePlayer])
			end
		end
	end
end
addEventHandler("onVehicleStartExit", getRootElement(), exitVehicle)

--
-- exported for chat-system
--
function getPlayersInAircraft( )
	local t = {}
	for k, v in ipairs( getElementsByType( "player" ) ) do
		local vehicle = getPedOccupiedVehicle( v )
		if vehicle then
			if trackingMinHeight[ getElementModel( vehicle ) ] then
				table.insert( t, v )
			end
		end
	end
	return t
end

function disableHunter(theVehicle, seat, jacked)
    if (getElementModel (theVehicle) == 425) and (getElementData(theVehicle, "dbid") == 1360) then
	 toggleControl(source, "vehicle_secondary_fire", false)
	 toggleControl(source, "vehicle_fire", false)
    end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), disableHunter )

function enableHunter(theVehicle, seat, jacked)
    if ( getElementModel(theVehicle) == 425) and (getElementData(theVehicle, "dbid") == 1360) then
	toggleControl(source, "vehicle_secondary_fire", true)
	toggleControl(source, "vehicle_fire", true)
    end
end
addEventHandler ( "onPlayerVehicleExit", getRootElement(), enableHunter )

