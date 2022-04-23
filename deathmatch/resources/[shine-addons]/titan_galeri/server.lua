local mysql = exports.mysql

local currentReleasePos = 0

local parkingPositions = { 
						{ 2115.193359375, -2150.1689453125, 13.613700866699 },
						{ 2115.193359375, -2155.1689453125, 13.613700866699 },
						{ 2115.193359375, -2160.1689453125, 13.613700866699 },
						{ 2115.193359375, -2165.1689453125, 13.613700866699 },
						{ 2115.193359375, -2170.1689453125, 13.613700866699 },
						{ 2115.193359375, -2175.1689453125, 13.613700866699 },
					}


function getReleasePosition()
	currentReleasePos = currentReleasePos + 1
	if currentReleasePos > #parkingPositions then
		currentReleasePos = 1
	end
	
	return parkingPositions[ currentReleasePos ][1], parkingPositions[ currentReleasePos ][2], parkingPositions[ currentReleasePos ][3], parkingPositions[ currentReleasePos ][4], parkingPositions[ currentReleasePos ][5], parkingPositions[ currentReleasePos ][6]
end

addEvent("serverSide", true)
addEventHandler("serverSide", getRootElement(), function(thePlayer, name, amount, model)
	if getElementData(thePlayer, "money") >= tonumber(amount) then
		if exports.global:canPlayerBuyVehicle(thePlayer) then
			local id = model		
			local r = 90
			local x, y, z = getReleasePosition()
			-- setElementPosition(vehID, x, y, z)
			local letter1 = string.char(math.random(65,90))
			local letter2 = string.char(math.random(65,90))
			local plate = tonumber(34).. " ".. letter1 .. letter2 .. " " .. math.random(1000, 9999)
			local factionVehicle = -1
			local dbid = getElementData(thePlayer, "dbid")
			local veh = createVehicle(id, x, y, z)
			local vehicleName = name
			destroyElement(veh)
			local dimension = getElementDimension(thePlayer)
			local interior = getElementInterior(thePlayer)
			local var1, var2 = exports['vehicle-system']:getRandomVariant(id)
			local smallestID = SmallestID()
			local insertid = mysql:query_insert_free("INSERT INTO vehicles SET id='" .. mysql:escape_string(smallestID) .. "', model='" .. mysql:escape_string(id) .. "', x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y) .. "', z='" .. mysql:escape_string(z) .. "', rotx='0', roty='0', rotz='" .. mysql:escape_string(r) .. "', color1='[ [ 255, 255, 255 ] ]', color2='[ [ 0, 0, 0 ]]', color3='[ [ 0, 0, 0 ] ] ', color4='[ [ 0, 0, 0 ] ]', faction='" .. mysql:escape_string(factionVehicle) .. "', owner='" .. mysql:escape_string(dbid) .. "', plate='" .. mysql:escape_string(plate) .. "', currx='" .. mysql:escape_string(x) .. "', curry='" .. mysql:escape_string(y) .. "', currz='" .. mysql:escape_string(z) .. "', currrx='0', currry='0', currrz='" .. mysql:escape_string(r) .. "', locked=1, interior='" .. mysql:escape_string(interior) .. "', currinterior='" .. mysql:escape_string(interior) .. "', dimension='" .. mysql:escape_string(dimension) .. "', currdimension='" .. mysql:escape_string(dimension) .. "', tintedwindows='" .. mysql:escape_string(0) .. "',variant1="..var1..",variant2="..var2..", creationDate=NOW(), fiyati="..amount..", createdBy="..getElementData(thePlayer, "account:id").."")
			if (insertid) then
				local owner = ""
				owner = getPlayerName( thePlayer )
				exports.global:giveItem(thePlayer, 3, tonumber(insertid))
				exports.logs:logMessage("[MAKEVEH DONATEGUI] " .. getPlayerName( thePlayer ) .. " created car #" .. insertid .. " (" .. vehicleName .. ") - " .. owner, 9)
				exports.logs:dbLog(thePlayer, 6, { "ve" .. insertid }, "SPAWNVEH DONATEGUI'"..vehicleName.."' $0 "..owner )
				exports['vehicle-system']:reloadVehicle(insertid)
				outputChatBox("#FF9900[+] "..name.." #FFFFFFmarka aracı #FF9900"..amount.."₺ #FFFFFFkarşılığında aldınız!", thePlayer, 255, 255, 255, true)
				exports["global"]:takeMoney(thePlayer, amount)
			end
		else
			outputChatBox("#cc0000[!]#f1f1f1 Satın almak için yeterince araç yeriniz yok.", thePlayer, 255, 194, 14, true)
		end	
	else
		outputChatBox("#FF0000[!] #FFFFFFYeterli paranız olmadığı için bu aracı alamadınız.", thePlayer, 255, 255, 255, true)
	end
end)


function SmallestID( )
	local result = mysql:query_fetch_assoc("SELECT MIN(e1.id+1) AS nextID FROM vehicles AS e1 LEFT JOIN vehicles AS e2 ON e1.id +1 = e2.id WHERE e2.id IS NULL")
	if result then
		local id = tonumber(result["nextID"]) or 1
		return id
	end
	return false
end