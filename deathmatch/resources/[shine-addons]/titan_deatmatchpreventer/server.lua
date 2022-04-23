mysql = exports.mysql
connection = mysql:getConnection()

pvp = {}

addEventHandler("onPlayerWeaponFire" , root , function(weapon , x , y , z , element)
	element = getPedTarget(source)
    if element and getElementType(element) == "player" and getElementType(source) == "player" then
        pvp[source] = 60
    end
end)

setTimer(function()
    for k , v in ipairs(getElementsByType("player")) do 
        if pvp[v] and v:getData("loggedin") == 1 then
        	if pvp[v] <= 0 then
        		pvp[v] = nil
        	else
	            pvp[v] = pvp[v] - 1
	        end
	        triggerClientEvent(v  , "pvpTable" , v , pvp[v])
        end
    end
end,1000,0)


addEventHandler("onPlayerQuit" , root , function()

    if pvp[source] then

		jaille(source , 220)
		pvp[source] = nil

    end
end)

function jaille(targetPlayer , checkpoint)

    local accountID = getElementData(targetPlayer, "account:id")
    
	local playerName = "pvp"
	local reason = "Aktif GUN-RP Sırasında /q Atma"
							
	dbExec(connection,"UPDATE accounts SET adminjail='1', adminjail_time='" .. (tonumber(checkpoint)) .. "', adminjail_permanent='0', adminjail_by='" .. (playerName) .. "', adminjail_reason='" .. (reason) .. "' WHERE id='" .. (tonumber(accountID)) .. "'")
	exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "jailserved", 0, false)
				
	exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "adminjailed", true, false)
	exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "jailreason", reason, false)
	exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "jailcp", checkpoint, false)
	exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "jailadmin", "pvp", false)

	adminTitle = "PVP-System"
				
	setElementDimension(targetPlayer, 65400+getElementData(targetPlayer, "playerid"))
	setElementInterior(targetPlayer, 49)
	setCameraInterior(targetPlayer, 49)
    setElementData(targetPlayer, "hapiste", 1)				
	toggleControl(targetPlayer,'next_weapon',false)
	toggleControl(targetPlayer,'previous_weapon',false)
	toggleControl(targetPlayer,'fire',false)
	toggleControl(targetPlayer,'aim_weapon',false)
	setPedWeaponSlot(targetPlayer,0)
	triggerClientEvent(targetPlayer , "hapis" , targetPlayer)

end