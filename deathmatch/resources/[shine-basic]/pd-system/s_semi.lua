function updateFireMode(mode)
	if ( tonumber(mode) and (tonumber(mode) >= 0 and tonumber(mode) <= 1) ) then
		exports['anticheat-system']:changeProtectedElementDataEx(client, "firemode", mode, true)
	end
end
addEvent("firemode", true)
addEventHandler("firemode", getRootElement(), updateFireMode)