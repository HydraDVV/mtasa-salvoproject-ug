addCommandHandler("airride", function(player, command, level)
	if getPedOccupiedVehicle(player) then
		local vehicle = getPedOccupiedVehicle(player)
		
		if getVehicleOccupant(vehicle) == player then
			if getElementData(vehicle, "tuning.airRide") then
				if tonumber(level) >= 0 and tonumber(level) <= 5 then
					if isTimer(airRideActive) then
						return
					end
					
					triggerClientEvent(player, "playAirRideSound", player, vehicle)
					setElementFrozen(vehicle, true)
					
					airRideActive = setTimer(function()
						if tonumber(level) == 0 then
							setVehicleHandling(vehicle, "suspensionLowerLimit", getOriginalHandling(getElementModel(vehicle))["suspensionLowerLimit"])
						elseif tonumber(level) == 1 then
							setVehicleHandling(vehicle, "suspensionLowerLimit", 0.01)
						elseif tonumber(level) == 2 then
							setVehicleHandling(vehicle, "suspensionLowerLimit", -0.1)
						elseif tonumber(level) == 3 then
							setVehicleHandling(vehicle, "suspensionLowerLimit", -0.2)
						elseif tonumber(level) == 4 then
							setVehicleHandling(vehicle, "suspensionLowerLimit", -0.3)
						elseif tonumber(level) == 5 then
							setVehicleHandling(vehicle, "suspensionLowerLimit", -0.45)
						end
						
						setElementFrozen(vehicle, false)
					end, 3000, 1)
				else
					outputChatBox("#FF4646[Air-Ride]: #FFFF99" .. getLocalizedText("message.airride.error"), player, 255, 255, 255, true)
				end
			end
		end
	end
end)