mysql = exports.mysql

local informationicons = { }

function SmallestID()
	local result = dbQuery(mysql:getConnection(), "SELECT MIN(e1.id+1) AS nextID FROM informationicons AS e1 LEFT JOIN informationicons AS e2 ON e1.id +1 = e2.id WHERE e2.id IS NULL")
	local result2 = dbPoll(result, -1)
	if result2 then
		local id = tonumber(result2[1]["nextID"]) or 1
		return id
	end
	return false
end

function makeInformationIcon(thePlayer, commandName, ...)
	if exports.global:isPlayerAdmin(thePlayer) then
	if ... then
		local arg = {...}
		local information = table.concat( arg, " " )
		local x, y, z = getElementPosition(thePlayer)
		local rx, ry, rz = getElementRotation(thePlayer)
		local interior = getElementInterior(thePlayer)
		local dimension = getElementDimension(thePlayer)
		local id = SmallestID()
		local createdby = getPlayerName(thePlayer):gsub("_", " ")
		local query = dbExec(mysql:getConnection(),"INSERT INTO informationicons SET id="..(id)..",createdby='"..(createdby).."',x='"..(x).."', y='"..(y).."', z='"..(z).."', rx='"..(rx).."', ry='"..(ry).."', rz='"..(rz).."', interior='"..(interior).."', dimension='"..(dimension).."', information='"..(information).."'")
		if query then
			informationicons[id] = createMarker(x, y, z, "cylinder", 1.5, 255, 255, 0, 0)--createObject(1239, x, y, z, rx, ry, rz)
			setElementInterior(informationicons[id], interior)
			setElementDimension(informationicons[id], dimension)
			setElementData(informationicons[id], "informationicon:id", id)
			setElementData(informationicons[id], "informationicon:createdby", createdby)
			setElementData(informationicons[id], "informationicon:x", x)
			setElementData(informationicons[id], "informationicon:y", y)
			setElementData(informationicons[id], "informationicon:z", z)
			setElementData(informationicons[id], "informationicon:rx", rx)
			setElementData(informationicons[id], "informationicon:ry", ry)
			setElementData(informationicons[id], "informationicon:rz", rz)
			setElementData(informationicons[id], "informationicon:interior", interior)
			setElementData(informationicons[id], "informationicon:dimension", dimension)
			setElementData(informationicons[id], "informationicon:information", information)
			exports["titan_infobox"]:addBox(thePlayer, "success", "Ba??ar??yla "..id.." ID'li infoyu olu??turdunuz.")
		else
			outputChatBox("MySQL hatas?? olu??tu, REMAJOR'a bildiriniz.", thePlayer, 255, 0, 0)
		end
		else
			outputChatBox("Kullan??m:#f9f9f9 /infoekle [????erik]", thePlayer, 255, 194, 14, true)
		end
	end
end
addCommandHandler("infoekle", makeInformationIcon, false, false)

function saveAllInformationIcons()
	for key, value in ipairs (informationicons) do
		local id = getElementData(informationicons[key], "informationicon:id")
		local createdby = getElementData(informationicons[key], "informationicon:createdby")
		local x = getElementData(informationicons[key], "informationicon:x")
		local y = getElementData(informationicons[key], "informationicon:y")
		local z = getElementData(informationicons[key], "informationicon:z")
		local rx = getElementData(informationicons[key], "informationicon:rx")
		local ry = getElementData(informationicons[key], "informationicon:ry")
		local rz = getElementData(informationicons[key], "informationicon:rz")
		local interior = getElementData(informationicons[key], "informationicon:interior")
		local dimension = getElementData(informationicons[key], "informationicon:dimension")
		local information = getElementData(informationicons[key], "informationicon:information")
		dbExec(mysql:getConnection(),"UPDATE informationicons SET createdby = '" .. (createdby) .. "', x = '" .. (x) .. "', y = '" .. (y) .. "', z = '" .. (z) .. "', rx = '" .. (rx) .. "', ry = '" .. (ry) .. "', rz = '" .. (rz) .. "', interior = '" .. (interior) .. "', dimension = '" .. (dimension) .. "', information = '" .. (information) .. "' WHERE id='" .. (id) .. "'")
	end
end
addEventHandler("onResourceStop", getResourceRootElement(), saveAllInformationIcons)


function loadAllInformationIcons()
	dbQuery(
		function(qh)
			local res, rows, err = dbPoll(qh, 0)
			if rows > 0 then
				for index, row in ipairs(res) do
					local id = tonumber(row["id"])
					local createdby = tostring(row["createdby"])
					local x = tonumber(row["x"])
					local y = tonumber(row["y"])
					local z = tonumber(row["z"])
					local rx = tonumber(row["rx"])
					local ry = tonumber(row["ry"])
					local rz = tonumber(row["rz"])
					local interior = tonumber(row["interior"])
					local dimension = tonumber(row["dimension"])
					local information = tostring(row["information"])
					--informationicons[id] = createPickup(x, y, z, 3, 14609, 0)--createObject(1239, x, y, z, rx, ry, rz)
					informationicons[id] = createMarker(x, y, z, "cylinder", 1.5, 255, 255, 0, 0)--createObject(1239, x, y, z, rx, ry, rz)
					setElementInterior(informationicons[id], interior)
					setElementDimension(informationicons[id], dimension)
					setElementData(informationicons[id], "informationicon:id", id)
					setElementData(informationicons[id], "informationicon:createdby", createdby)
					setElementData(informationicons[id], "informationicon:x", x)
					setElementData(informationicons[id], "informationicon:y", y)
					setElementData(informationicons[id], "informationicon:z", z)
					setElementData(informationicons[id], "informationicon:rx", rx)
					setElementData(informationicons[id], "informationicon:ry", ry)
					setElementData(informationicons[id], "informationicon:rz", rz)
					setElementData(informationicons[id], "informationicon:interior", interior)
					setElementData(informationicons[id], "informationicon:dimension", dimension)
					setElementData(informationicons[id], "informationicon:information", information)
				end
			end
		end,
	mysql:getConnection(), "SELECT * FROM `informationicons`")
	
end
addEventHandler("onResourceStart", getResourceRootElement(), loadAllInformationIcons)

function getNearbyInformationIcons(thePlayer, commandName)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		local posX, posY, posZ = getElementPosition(thePlayer)
		outputChatBox("??evrende Bulunan Yaz??lar:", thePlayer, 255, 126, 0)
		local count = 0
		for key, value in ipairs (informationicons) do
			local dbid = getElementData(informationicons[key], "informationicon:id")
			if dbid then
				local x, y, z = getElementPosition(informationicons[key])
				local distance = getDistanceBetweenPoints3D(posX, posY, posZ, x, y, z)
				if distance <= 10 and getElementDimension(informationicons[key]) == getElementDimension(thePlayer) and getElementInterior(informationicons[key]) == getElementInterior(thePlayer) then
					local createdby = getElementData(informationicons[key], "informationicon:createdby")
					local information = getElementData(informationicons[key], "informationicon:information")
					outputChatBox("   #" .. dbid .. " ID | " .. createdby .. " taraf??ndan | ????erik: " .. information, thePlayer, 255, 126, 0)
					count = count + 1
				end
			end
		end		
		if (count==0) then
			outputChatBox("   Yok.", thePlayer, 255, 126, 0)
		end
	end
end
addCommandHandler("infolar", getNearbyInformationIcons, false, false)

function deleteInformationIcon(thePlayer, commandName, ID)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if tonumber(ID) then
			local ID = tonumber(ID)
			if informationicons[ID] then
				for k,v in pairs(getAllElementData(informationicons[ID])) do
					removeElementData(informationicons[ID],k)
				end
				destroyElement(informationicons[ID])
				local query = dbExec(mysql:getConnection(),"DELETE FROM informationicons WHERE id='"..(ID).."'")
				if query then
					informationicons[ID] = nil
					exports["titan_infobox"]:addBox(thePlayer, "success", "Ba??ar??yla "..id.." ID'li infoyu sildiniz.")					
				else
					outputChatBox("MySQL hatas?? olu??tu, REMAJOR'a bildiriniz.", thePlayer, 255, 0, 0)
				end
			else
				outputChatBox("B??yle bir info ID'si bulunamad??.", thePlayer, 255, 0, 0)
			end
		else
			outputChatBox("Kullan??m:#f9f9f9 /infosil [ID]", thePlayer, 255, 194, 14, true)
		end
	end
end
addCommandHandler("infosil", deleteInformationIcon, false, false)