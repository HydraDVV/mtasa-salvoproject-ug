local vehiculars = { }
local descriptionLines = { }

function bindVD()
  bindKey ( "lalt", "down", showNearbyVehicleDescriptions )
  bindKey ( "lalt", "up", removeVD )
end
addEventHandler ( "onClientResourceStart", resourceRoot, bindVD )

function removeVD ( key, keyState )
	removeEventHandler ( "onClientRender", getRootElement(), showText )
end

function showNearbyVehicleDescriptions()
	for index, nearbyVehicle in ipairs( exports.global:getNearbyElements(getLocalPlayer(), "vehicle") ) do
		if isElement(nearbyVehicle) then
			vehiculars[index] = nearbyVehicle
		end
	end
	addEventHandler("onClientRender", getRootElement(), showText)
end

function showText()
	for i = 1, #vehiculars, 1 do
		if isElement(vehiculars[i]) then
		if getElementModel(vehiculars[i]) == 481 or getElementModel(vehiculars[i]) == 509 or getElementModel(vehiculars[i]) == 510 then
		local descriptions = {}
		for j = 1, 5 do
			descriptions[j] = getElementData(vehiculars[i], "description:"..j)
		end
		local x,y,z = getElementPosition(vehiculars[i])			
        local cx,cy,cz = getCameraMatrix()
		if descriptions[1] and descriptions[2] and descriptions[3] and descriptions[4] and descriptions[5] then
			if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 40 then
				local px,py,pz = getScreenFromWorldPosition(x,y,z+1,0.05)
				if px and isLineOfSightClear(cx, cy, cz, x, y, z, true, false, false, true, true, false, false) then
					dxDrawText(descriptions[1].."\n"..descriptions[2].."\n"..descriptions[3].."\n"..descriptions[4].."\n"..descriptions[5], px, py, px, py, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false)
				end
			end
		end
		elseif isElement(vehiculars[i]) then
		local plate
		local vin = getElementData(vehiculars[i], "dbid")
		if vin < 0 then
			plate = getVehiclePlateText(vehiculars[i])
		else
			plate = getElementData(vehiculars[i], "plate")
		end
		local descriptions = {}
		for j = 1, 5 do
			descriptions[j] = getElementData(vehiculars[i], "description:"..j)
		end
		local x,y,z = getElementPosition(vehiculars[i])			
        local cx,cy,cz = getCameraMatrix()
		if descriptions[1] and descriptions[2] and descriptions[3] and descriptions[4] and descriptions[5] then
			if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 40 then
				local px,py,pz = getScreenFromWorldPosition(x,y,z+1,0.05)
				if px and isLineOfSightClear(cx, cy, cz, x, y, z, true, false, false, true, true, false, false) then
					--dxDrawText("(Plaka: "..plate..")\n(İd: "..vin..")\n"..descriptions[1].."\n"..descriptions[2].."\n"..descriptions[3].."\n"..descriptions[4].."\n"..descriptions[5], px, py, px, py, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false)
				end
			end
		else
			if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 40 then
				local px,py,pz = getScreenFromWorldPosition(x,y,z+1,0.05)
				if px and isLineOfSightClear(cx, cy, cz, x, y, z, true, false, false, true, true, false, false) then
					if getElementData(vehiculars[i],'carshop >> data') then
						dxDrawText(" \n Plaka: "..plate.."\n Arac ID: "..vin.."\n\n\n\n\n\n#008C00 Satılık:"..getElementData(vehiculars[i],'carshop >> data')[1].."\n İletişim:"..getElementData(vehiculars[i],'carshop >> data')[2], px, py, px+20, py, tocolor(220, 220, 220, 255), 1, exports['titan_fonts']:getFont("FontAwesome", 8), "center", "center", false, false, true, true)
					else
						dxDrawText(" \n Plaka: "..plate.."\n Arac ID: "..vin.."\n", px, py, px+20, py, tocolor(255, 255, 255, 175), 1, exports['titan_fonts']:getFont("FontAwesome", 8), "center", "center", false, false)
					end
				end
			end
		end
		end
		end
	end
end


