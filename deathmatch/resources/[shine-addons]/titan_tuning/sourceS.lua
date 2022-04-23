local enteredMarkerData = {}

addEvent("tuning->ResetMarker", true)
addEvent("tuning->OpticalUpgrade", true)
addEvent("tuning->Performances", true)
addEvent("tuning->PerformanceUpgrade", true)
addEvent("tuning->HandlingUpdate", true)
addEvent("tuning->WheelWidth", true)
addEvent("tuning->OffroadAbility", true)
addEvent("tuning->Color", true)
addEvent("tuning->LicensePlate", true)

addEventHandler("onResourceStart", resourceRoot, function()
	for i = 1, #availableTuningMarkers do
		local currentTuning = availableTuningMarkers[i]
		
		if currentTuning then
			local tuningMarker = createMarker(currentTuning[1], currentTuning[2], currentTuning[3] - 1, "cylinder", 2.5, 104, 183, 186, 50)
			
			setElementData(tuningMarker, "tuningMarkerSettings", {true, currentTuning[4]})
			
			addEventHandler("onMarkerHit", tuningMarker, hitTuningMarker)
		end
	end
end)

addEventHandler("onPlayerQuit", root, function()
	resetTuningMarker(source)
end)

addEventHandler("tuning->ResetMarker", root, function(player)
	resetTuningMarker(player)
end)

addEventHandler("tuning->OpticalUpgrade", root, function(vehicle, type, upgrade)
	if vehicle then
		if upgrade then
			if type == "add" then
				addVehicleUpgrade(vehicle, upgrade)
			elseif type == "remove" then
				removeVehicleUpgrade(vehicle, upgrade)
			end
		end
	end
end)

addEventHandler("tuning->PerformanceUpgrade", root, function(vehicle, data)
	if vehicle then
		if data then
			local vehicleModel = getElementModel(vehicle)
			
			if not data[1][2] then -- Default upgrade
				for _, property in ipairs(data) do
					setVehicleHandling(vehicle, property[1], nil, false)
				end
			else
				for _, property in ipairs(data) do
					local defaultHandling = getOriginalHandling(vehicleModel)[property[1]]
					
					setVehicleHandling(vehicle, property[1], defaultHandling, false)
					setVehicleHandling(vehicle, property[1], defaultHandling + property[2], false)
				end
			end
		end
	end
end)

addEventHandler("tuning->HandlingUpdate", root, function(vehicle, property, value)
	if vehicle then
		if property then
			if value then
				setVehicleHandling(vehicle, property, value, false)
			else
				setVehicleHandling(vehicle, property, getOriginalHandling(getElementModel(vehicle))[property], false)
			end
		end
	end
end)

addEventHandler("tuning->WheelWidth", root, function(vehicle, side, type)
	if vehicle then
		if type then
			if type == "verynarrow" then type = 1
				elseif type == "narrow" then type = 2
				elseif type == "wide" then type = 4
				elseif type == "verywide" then type = 8
				elseif type == "default" then type = 0
			end
		
			if side then
				if side == "front" then
					setVehicleHandlingFlags(vehicle, 3, type)
				elseif side == "rear" then
					setVehicleHandlingFlags(vehicle, 4, type)
				else
					setVehicleHandlingFlags(vehicle, {3, 4}, type)
				end
			else
				setVehicleHandlingFlags(vehicle, {3, 4}, type)
			end
		else
			setVehicleHandlingFlags(vehicle, {3, 4}, 0)
		end
	end
end)

addEventHandler("tuning->OffroadAbility", root, function(vehicle, type)
	if vehicle then
		if type then
			if type == "dirt" then type = 1
				elseif type == "sand" then type = 2
				elseif type == "default" then type = 0
			end
			
			setVehicleHandlingFlags(vehicle, 6, type)
		else
			setVehicleHandlingFlags(vehicle, 6, 0)
		end
	end
end)

addEventHandler("tuning->Color", root, function(vehicle, color, headlightColor)
	if vehicle then
		setVehicleColor(vehicle, color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9])
		setVehicleHeadLightColor(vehicle, headlightColor[1], headlightColor[2], headlightColor[3])
	end
end)

addEventHandler("tuning->LicensePlate", root, function(vehicle, text)
	if vehicle and text then
		setVehiclePlateText(vehicle, text)
	end
end)

function setVehicleHandlingFlags(vehicle, byte, value)
	if vehicle then
		local handlingFlags = string.format("%X", getVehicleHandling(vehicle)["handlingFlags"])
		local reversedFlags = string.reverse(handlingFlags) .. string.rep("0", 8 - string.len(handlingFlags))
		local currentByte, flags = 1, ""
		
		for values in string.gmatch(reversedFlags, ".") do
			if type(byte) == "table" then
				for _, v in ipairs(byte) do
					if currentByte == v then
						values = string.format("%X", tonumber(value))
					end
				end
			else
				if currentByte == byte then
					values = string.format("%X", tonumber(value))
				end
			end
			
			flags = flags .. values
			currentByte = currentByte + 1
		end
		
		setVehicleHandling(vehicle, "handlingFlags", tonumber("0x" .. string.reverse(flags)), false)
	end
end

function hitTuningMarker(element)
	if isElement(element) then
		if getElementType(element) == "vehicle" then
			if getVehicleController(element) then
				local vehicleController = getVehicleController(element)
			--	if getElementData(vehicleController, 'job') ~= 5 then outputChatBox('[!]#D6D6D6 Bu panele erişebilmek için modifiyeci olmalısın', vehicleController, 255, 0 ,0, true) return end
				local markerX, markerY, markerZ = getElementPosition(source)
				local markerRotation = getElementData(source, "tuningMarkerSettings")[2] or 0
				
				enteredMarkerData[vehicleController] = {source, element}
				
				setElementFrozen(element, true)
				setVehicleDamageProof(element, true)
				setElementPosition(element, markerX, markerY, markerZ + 1)
				setElementRotation(element, 0, 0, markerRotation)
				
				setElementDimension(source, 65535)
				
				triggerClientEvent(vehicleController, "tuning->ShowMenu", vehicleController, element)
			end
		end
	end
end

function resetTuningMarker(player)
	if player then
		if enteredMarkerData[player] then
			setElementDimension(enteredMarkerData[player][1], 0)
			
			setElementFrozen(enteredMarkerData[player][2], false)
			setVehicleDamageProof(enteredMarkerData[player][2], false)
		
			enteredMarkerData[player] = nil
		end
	end
end

addEvent("paraKes", true)
addEventHandler("paraKes", root, function(amount)
    exports.global:takeMoney(source,amount)
end)