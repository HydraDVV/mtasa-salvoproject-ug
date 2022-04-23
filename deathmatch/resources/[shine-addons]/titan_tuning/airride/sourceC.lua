addEvent("playAirRideSound", true)
addEventHandler("playAirRideSound", root, function(vehicle)
	if isElement(vehicle) then
		if isElementStreamedIn(vehicle) then
			local vehicleX, vehicleY, vehicleZ = getElementPosition(vehicle)
			local vehicleInterior, vehicleDimension = getElementInterior(vehicle), getElementDimension(vehicle)
			local airRideSoundEffect = playSound3D("files/sounds/airride.mp3", vehicleX, vehicleY, vehicleZ, false)
			
			if isElement(airRideSoundEffect) then
				setSoundVolume(airRideSoundEffect, 0.5)
				setElementDimension(airRideSoundEffect, vehicleDimension)
				setElementInterior(airRideSoundEffect, vehicleInterior)
				attachElements(airRideSoundEffect, vehicle)
			end
		end
	end
end)

function removeAirRide(vehicle)
	if vehicle then
		triggerServerEvent("tuning->PerformanceUpgrade", localPlayer, vehicle, {"suspensionLowerLimit"}) -- set suspension to default
	end
end