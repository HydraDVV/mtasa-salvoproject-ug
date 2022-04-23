MunitorC, MunitorL = guiGetScreenSize()
abx, aby = (MunitorC/1366), (MunitorL/768)
fuel = 0
local hfont = exports.titan_fonts:getFont("fvfont",20)
function syncFuel(ifuel)
	if not (ifuel) then
		fuel = 100
	else
		fuel = ifuel
	end
end
addEvent("syncFuel", true)
addEventHandler("syncFuel", getRootElement(), syncFuel)

function Velocimetro()
	if exports.hud:isActive() then 
		theVehicle = localPlayer.vehicle
		actualspeed = getVehicleSpeed()
		kmh = math.floor(actualspeed)
		if not theVehicle or getVehicleOccupant(theVehicle) ~= localPlayer then return true end
		fuelSAMP = math.floor((fuel/exports["fuel-system"]:getMaxFuel(theVehicle))*100)
		if fuel == 0 or fuelSAMP > 100 then 
			fuelSAMP = 100
		end
        dxDrawText("KM/H", abx*635, aby*700, abx*710, aby*700, tocolor(255, 255, 255, 125), 1, hfont, "center", "center", false, false, false, false, false)
		dxDrawImage(abx*723, aby*700, abx*15, aby*15, "REMAJOR/fuelicon.png", 0, 0, 0, tocolor(255, 255, 255, 155), false)
        if kmh < 405 then
        	dxDrawText(kmh, abx*629, aby*670, abx*710, aby*680, tocolor(255, 255, 255, 125), 1, hfont, "center", "center", false, false, false, false, false)
        	hou_circle(abx*670, aby*685, abx*80, aby*80, tocolor(0, 0, 0, 100), 215, 230, 5)
			hou_circle(abx*670, aby*685, abx*80, aby*80, tocolor(155, 155, 155, 180), 215, kmh*0.7, 5)
			hou_circle(abx*730, aby*710, abx*50, aby*50, tocolor(0, 0, 0, 100), 230, 230, 5)
			hou_circle(abx*730, aby*710, abx*50, aby*50, tocolor(155, 155, 155, 180), 230, fuelSAMP/0.43, 5)
        end
	end
end
addEventHandler("onClientRender", getRootElement(), Velocimetro)

function getVehicleSpeed()
    if isPedInVehicle(getLocalPlayer()) then
		local theVehicle = getPedOccupiedVehicle (getLocalPlayer())
		if theVehicle then 
			local vx, vy, vz = getElementVelocity (theVehicle)
			if vx then 
				return math.sqrt(vx^2 + vy^2 + vz^2) * 165
			else
				return 0
			end
		else
			return 0
		end
    end
    return 0
end
