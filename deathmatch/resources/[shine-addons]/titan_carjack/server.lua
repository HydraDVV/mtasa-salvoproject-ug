function aracCek(thePlayer, commandName, id)
	if getElementData(thePlayer, "loggedin") == 1 and not getElementData(thePlayer, "adminjailed") and not getElementData(thePlayer, "pd.jailstation") then
		local playerID = getElementData(thePlayer, "dbid")
		if not (id) then
			outputChatBox("Salvo:#f9f9f9/" .. commandName .. " [ARAC ID]", thePlayer, 255, 194, 14,true)
		else
		local vehicle = exports.pool:getElement("vehicle", id)
			if vehicle then
				if getElementData(vehicle, "Satilik") then
					outputChatBox("Salvo:#f9f9f9Araç şuan 2. el galeride satışta.", thePlayer, 255, 194, 14,true)
					return
				end
				local vehicleOwner = getElementData(vehicle, "owner")
				if vehicleOwner == playerID then
					if exports.global:takeMoney(thePlayer, 10000) then
						local r = getPedRotation(thePlayer)
						local x, y, z = getElementPosition(thePlayer)
						x = x + ( ( math.cos ( math.rad ( r ) ) ) * 5 )
						y = y + ( ( math.sin ( math.rad ( r ) ) ) * 5 )

						if	(getElementHealth(vehicle)==0) then
							spawnVehicle(vehicle, x, y, z, 0, 0, r)
						else
							setElementPosition(vehicle, x, y, z)
							setVehicleRotation(vehicle, 0, 0, r)
						end


						outputChatBox("Salvo:#f9f9f9Arabanı 10.000₺ ile Yanına Çektin.", thePlayer, 255, 194, 14,true)
					else
						outputChatBox("Salvo:#f9f9f9Yeterli Miktarda Paran Yok.", thePlayer, 255, 0, 0,true)
					end
				end
			else
				outputChatBox("Salvo:#f9f9f9Arac Size Ait Değildir.", thePlayer, 255, 0, 0,true)
			end
		end
	end
end
addCommandHandler("aracgetir", aracCek, false, false)
