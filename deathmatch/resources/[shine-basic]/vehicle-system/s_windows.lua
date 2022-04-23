function toggleWindow(source)
	local thePlayer = source
	local theVehicle = getPedOccupiedVehicle(thePlayer)
	if theVehicle then
		if hasVehicleWindows(theVehicle) then
			if (getVehicleOccupant(theVehicle) == thePlayer) or (getVehicleOccupant(theVehicle, 1) == thePlayer) then
				if not (isVehicleWindowUp(theVehicle)) then
					exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, "vehicle:windowstat", 0, true)
					triggerEvent('sendAme', source, "düğmeye bir süre basık tutarak camı geri kapatır*")
					triggerClientEvent("removeWindow", getRootElement())
					for i = 0, getVehicleMaxPassengers(theVehicle) do
						local player = getVehicleOccupant(theVehicle, i)
						if (player) then
							triggerEvent("setTintName", player)
						end
					end
				else
					exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, "vehicle:windowstat", 1, true)
					triggerEvent('sendAme', source, "pencereleri tuşa basarak açar*")
					triggerClientEvent("addWindow", getRootElement())
					for i = 0, getVehicleMaxPassengers(theVehicle) do
						local player = getVehicleOccupant(theVehicle, i)
						if (player) then
							triggerEvent("resetTintName", theVehicle, player)
						end
					end
				end
			end
		end
	end
end
addCommandHandler("cam", toggleWindow)

function cam_kontrol(veh, durum)
	if durum == 1 then
		
		exports['anticheat-system']:changeProtectedElementDataEx(veh, "vehicle:windowstat", 1, true)
		triggerEvent('sendAme', source, "pencereleri telefon uygulamasından açar*")
		triggerClientEvent("addWindow", getRootElement())
		for i = 0, getVehicleMaxPassengers(veh) do
			local player = getVehicleOccupant(veh, i)
			if (player) then
				triggerEvent("resetTintName", veh, player)
			end
		end
	elseif durum == 0 then
		exports['anticheat-system']:changeProtectedElementDataEx(veh, "vehicle:windowstat", 0, true)
		--exports.global:sendLocalMeAction(source, "düğmeye bir süre basık tutarak camı geri kapatır*")
		triggerEvent('sendAme', source, "telefon uygulamasından açık olan camları geri kapatır*")
		triggerClientEvent("removeWindow", getRootElement())
		for i = 0, getVehicleMaxPassengers(veh) do
			local player = getVehicleOccupant(veh, i)
			if (player) then
				triggerEvent("setTintName", player)
			end
		end
	end
end
addEvent("vehicle:togWindow", true)
addEventHandler("vehicle:togWindow", getRootElement(), cam_kontrol)

function addIcon()
	if (getElementData(source, "vehicle:windowstat") == 0) then
		triggerClientEvent("addWindow", getRootElement())
	end
end
addEventHandler("onVehicleEnter", getRootElement(), addIcon)