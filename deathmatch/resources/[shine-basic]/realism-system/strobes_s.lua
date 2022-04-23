function triggerStrobesServer(thePlayer)
	local veh = getPedOccupiedVehicle(thePlayer)
	if veh then
		if tonumber(getElementData(veh, "faction")) == 1 and getPedOccupiedVehicleSeat( thePlayer ) == 0 then
			if ( getVehicleName( veh ) == 'Police LV' ) or
		 	 ( getVehicleName( veh ) == 'Police SF' ) or
			 ( getVehicleName( veh ) == 'FBI Rancher' ) or
			 --( getVehicleName( veh ) == 'Cheetah' ) or
			 ( getVehicleName( veh ) == 'Police LS' ) or siren == 1 then
				for key, allPlayers in ipairs ( getElementsByType('player') ) do
                    triggerClientEvent( allPlayers, 'flashOn', allPlayers, veh ) -- Passing the Police cruiser client side too!
                end
			end
		end
	end
end	

-- [ Bind the key to all players server-side ]
function bindSirenKey( )
        for key, allPlayers in ipairs ( getElementsByType('player') ) do
                bindKey( allPlayers, ',', 'down', triggerStrobesServer )
        end    
end
addEventHandler('onResourceStart', resourceRoot, bindSirenKey )

function moms (player, seat)
    if player and (seat==0) then
		if ( getVehicleName( source ) == 'Police LV' ) or
		 ( getVehicleName( source ) == 'Police SF' ) or
		-- ( getVehicleName( source ) == 'Cheetah' ) or
		 ( getVehicleName( source ) == 'FBI Rancher' ) or
		 ( getVehicleName( source ) == 'Police LS' ) and tonumber(getElementData(source, "faction")) == 1 then
        addVehicleSirens(source, 8,2, false, true, true, true)
		setVehicleSirens(source, 1, 0.5, -0.3, 1, 0, 0, 255, 255, 255)
		setVehicleSirens(source, 2, 0, -0.3, 1, 255, 255, 255, 255, 255)
		setVehicleSirens(source, 3, -0.5, -0.3, 1, 255, 0, 0, 255, 255)
		setVehicleSirens(source, 4, -0.3, -1.9, 0.4, 255, 0, 0, 255, 255)
		setVehicleSirens(source, 5, 0.3, -1.9, 0.4, 0, 0, 255, 255, 255)
		setVehicleSirens(source, 6, 0.0, -2.95, -0.1, 255, 215, 0, 100, 100)
		setVehicleSirens(source, 7, -0.3, 2.7, 0.0, 255, 0, 0, 255, 255)
		setVehicleSirens(source, 8, 0.3, 2.7, 0.0, 0, 0, 255, 255, 255)
		end
		if siren == 1 then
			addVehicleSirens(source,1,1, true, true, false, true)
			setVehicleSirens(source, 1, -0.3, 1, 0.4, 0, 0, 255, 255, 255)
		end
	end
end
addEventHandler("onVehicleEnter", getRootElement(), moms)

