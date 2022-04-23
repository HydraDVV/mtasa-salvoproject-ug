local nametag = "Bilinmeyen Kisi (Tint)"
function startTint(player)
	if getElementType(source) == "player" then
		local pv = getPedOccupiedVehicle(source)
		if getElementData(pv, "tinted") then
			setPlayerNametagText(source, nametag)
			return
		end
	end
	if getElementData(source, "tinted") then
		if (getElementData(source, "vehicle:windowstat") == 0) then
			if getPlayerNametagText(player) ~= nametag then
				setPlayerNametagText(player, nametag)
			end
		end
	end
end
addEventHandler("onVehicleEnter", getRootElement(), startTint)
addEvent("setTintName", true)
addEventHandler("setTintName", getRootElement(), startTint)

function stopTint(p)
	if getElementType(source) == "vehicle" then
		if getPlayerNametagText(p) == nametag then
			setPlayerNametagText(p, getPlayerName(p):gsub("_", " "))
		end
		return
	end
	if getPlayerNametagText(source) == nametag then
		setPlayerNametagText(source, getPlayerName(source):gsub("_", " "))
	end
end
addEventHandler("onPlayerVehicleExit", getRootElement(), stopTint)
addEventHandler("onPlayerWasted", getRootElement(), stopTint)
addEvent("resetTintName", true)
addEventHandler("resetTintName", getRootElement(), stopTint)