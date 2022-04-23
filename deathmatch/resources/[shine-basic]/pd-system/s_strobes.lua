function triggerStrobesServer(thePlayer)
	if getPedOccupiedVehicleSeat( thePlayer )== 0 then
		if ( getVehicleName( getPedOccupiedVehicle( thePlayer ) ) == 'Police LV' ) or
			( getVehicleName( getPedOccupiedVehicle( thePlayer ) ) == 'Police SF' ) or
			( getVehicleName( getPedOccupiedVehicle( thePlayer ) ) == 'FBI rancher' ) or
			( getVehicleName( getPedOccupiedVehicle( thePlayer ) ) == 'Police LS' ) or siren == 1 then
		    for key, allPlayers in ipairs ( getElementsByType('player') ) do
                        triggerClientEvent( allPlayers, 'flashOn', allPlayers, getPedOccupiedVehicle( thePlayer ) ) -- Passing the Police cruiser client side too!
                end
end
end
end

-- [ Bind the key to all players server-side ]
function bindSirenKey( )
        for key, allPlayers in ipairs ( getElementsByType('player') ) do
                bindKey( allPlayers, 'u', 'down', triggerStrobesServer )
        end    
end
addEventHandler('onResourceStart', resourceRoot, bindSirenKey )

function moms (player, seat)
    if player and (seat==0) then
		if ( getVehicleName( source ) == 'Police LV' ) or
		 ( getVehicleName( source ) == 'Police SF' ) or
		 ( getVehicleName( source ) == 'FBI rancher' ) or
		 ( getVehicleName( source ) == 'Police LS' ) then
        	addVehicleSirens(source,8,2, false, true, true, true)
		--vehicle, sirenPoint, x, y, z, r, g, b, alpha, minAlpha
		setVehicleSirens(source, 1, 0.5, -0.3, 1, 0, 0, 255, 255, 255)
		setVehicleSirens(source, 2, 0, -0.3, 1, 255, 255, 255, 255, 255)
		setVehicleSirens(source, 3, -0.5, -0.3, 1, 255, 0, 0, 255, 255)
		setVehicleSirens(source, 4, -0.3, -1.9, 0.4, 255, 0, 0, 255, 255)
		setVehicleSirens(source, 5, 0.3, -1.9, 0.4, 0, 0, 255, 255, 255)
		setVehicleSirens(source, 6, 0.0, -2.95, -0.1, 255, 215, 0, 100, 100)
		setVehicleSirens(source, 7, -0.3, 2.7, 0.0, 255, 0, 0, 255, 255)
		setVehicleSirens(source, 8, 0.3, 2.7, 0.0, 0, 0, 255, 255, 255)
		elseif(getVehicleName( source ) == 'Ambulance') then
			addVehicleSirens(source,7,2, false, true, true, true)
			--vehicle, sirenPoint, x, y, z, r, g, b, alpha, minAlpha
			--lightbar
			setVehicleSirens(source, 1, 0.5, 0.9, 1.3, 255, 0, 0, 255, 255)
			setVehicleSirens(source, 2, 0, 0.9, 1.3, 255, 255, 255, 255, 255)
			setVehicleSirens(source, 3, -0.5, 0.9, 1.3, 255, 0, 0, 255, 255)
			--right side
			setVehicleSirens(source, 4, 1.3, 0.2, 1.5, 255, 0, 0, 255, 255)
			setVehicleSirens(source, 5, 1.3, -3.3, 1.5, 255, 0, 0, 255, 255)
			--left side
			setVehicleSirens(source, 6, -1.3, 0.2, 1.5, 255, 0, 0, 255, 255)
			setVehicleSirens(source, 7, -1.3, -3.3, 1.5, 255, 0, 0, 255, 255)
		elseif(getVehicleName( source ) == 'Fire Truck') then
			addVehicleSirens(source,7,2, false, true, true, true)
			--lightbar
			setVehicleSirens(source, 1, 0.6, 3.2, 1.4, 255, 0, 0, 255, 255)
			setVehicleSirens(source, 2, 0, 3.2, 1.4, 255, 255, 255, 255, 255)
			setVehicleSirens(source, 3, -0.6, 3.2, 1.4, 255, 0, 0, 255, 255)
			--rear
			setVehicleSirens(source, 4, 0.4, -3.7, 0.4, 255, 0, 0, 255, 255)
			setVehicleSirens(source, 5, -0.4, -3.7, 0.4, 255, 0, 0, 255, 255)
			--grill
			setVehicleSirens(source, 6, 0.6, 4.2, 0.1, 255, 0, 0, 255, 255)
			setVehicleSirens(source, 7, -0.6, 4.2, 0.1, 255, 0, 0, 255, 255)
		elseif(getVehicleName( source ) == 'Fire Truck Ladder') then	
			--not working (vehicle is probably one of the few models that does not support sirens)		
		elseif(getVehicleName( source ) == 'Towtruck') then
			addVehicleSirens(source, 3, 4, true, true, true, true)
			setVehicleSirens(source, 1, -0.7, -0.35, 1.5250904560089, 255, 0, 0, 255, 0)
			setVehicleSirens(source, 2, 0, -0.35, 1.5250904560089, 255, 198, 10, 255, 0)
			setVehicleSirens(source, 3, 0.7, -0.35, 1.5250904560089, 255, 0, 0, 255, 0)
		elseif(exports.global:hasItem(source, 144)) then --Yellow Roof Strobe
			addVehicleSirens(source, 1, 2, true, true, false, true)
			setVehicleSirens(source, 1, 0, 0, 0, 255, 198, 10, 255, 0)
			triggerClientEvent(player, "strobes:getmaxz", source, source)
		end
		if siren == 1 then
			addVehicleSirens(source,1,1, true, true, false, true)
			--vehicle, sirenPoint, x, y, z, r, g, b, alpha, minAlpha
			setVehicleSirens(source, 1, -0.3, 1, 0.4, 0, 0, 255, 255, 255)
		end
	end
end
addEventHandler("onVehicleEnter", getRootElement(), moms)
--addCommandHandler("togglestrobes", triggerStrobesServer)

function setRoofStrobe(maxZ)
	local offsetZ = maxZ - 0.2
	setVehicleSirens(source, 1, 0, 0, offsetZ, 255, 198, 10, 255, 0)
end
addEvent("strobes:setroofstrobe", true)
addEventHandler("strobes:setroofstrobe", getRootElement(), setRoofStrobe)