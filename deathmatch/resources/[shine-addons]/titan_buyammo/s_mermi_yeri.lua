local mermiYerleri = {}
local radius = 10

function mermiYerleriniYukle()
	local result = exports.mysql:query("SELECT * FROM mermiyerleri ORDER BY id ASC")
	if result then
		while true do
			local row = exports.mysql:fetch_assoc(result)
			if not row then break end
			local mermiYeri = createColSphere(row.x, row.y, row.z, radius)
			setElementData(mermiYeri, "mermiYeri", true)
			setElementData(mermiYeri, "id", tonumber(row.id))
			mermiYerleri[tonumber(row.id)] = mermiYeri
			exports.pool:allocateElement(mermiYeri, tonumber(row.id))
		end
	end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), mermiYerleriniYukle)

function mermiYeriEkle(thePlayer, cmd)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		return false
	end
	
	local playerX, playerY, playerZ = getElementPosition(thePlayer)
	local mermiYeri = createColSphere(playerX, playerY, playerZ, radius)
	local mermiQuery = exports.mysql:query_insert_free("INSERT INTO mermiyerleri (x, y, z) VALUES ('" .. playerX .. "', '" .. playerY .. "', '" .. playerZ .. "')")
	mermiYerleri[mermiQuery] = mermiYeri
	setElementData(mermiYeri, "mermiYeri", true)
	setElementData(mermiYeri, "id", mermiQuery)
	exports.pool:allocateElement(mermiYeri, mermiQuery)
	if mermiYeri and mermiQuery then
		outputChatBox("Mermi yeri başarıyla eklenmiştir.", thePlayer, 0, 255, 0)
	end
end

function mermiYeriSil(thePlayer, cmd, id)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		return false
	end

	if mermiYerleri[tonumber(id)] then
		local mermiDeleteQ = exports.mysql:query_free("DELETE FROM mermiyerleri WHERE id='" .. id .. "'")
		if mermiDeleteQ then
		destroyElement(mermiYerleri[tonumber(id)])
		outputChatBox("Mermi başarıyla silindi.", thePlayer, 0, 255, 0)
		else
		outputChatBox("Veritabanı hatası.", thePlayer, 255, 0, 0)
		end
	else
		outputChatBox("Mermi yeri bulunamadı.", thePlayer, 255, 0, 0)
	end
end
addCommandHandler("mermiyerisil", mermiYeriSil)

function yakinMermiYerleri(thePlayer)
	local posX, posY, posZ = getElementPosition(thePlayer)
	outputChatBox("Yakınlardaki Mermi Yerleri:", thePlayer, 255, 126, 0)
	local count = 0
	
	local dimension = getElementDimension(thePlayer)
	
	for k, theColShape in ipairs(exports.pool:getPoolElementsByType("colshape")) do
		if getElementData(theColShape, "mermiYeri") then
			local x, y = getElementPosition(theColShape)
			local distance = getDistanceBetweenPoints2D(posX, posY, x, y)
			local cdimension = getElementDimension(theColShape)
			if (distance<=10) and (dimension==cdimension) then
				local dbid = getElementData(theColShape, "id")
				outputChatBox("   Mermi Yeri ID " .. dbid .. ".", thePlayer, 255, 126, 0)
				count = count + 1
			end
		end
	end

	if (count==0) then
		outputChatBox("   Bulunamadı.", thePlayer, 255, 126, 0)
	end
end
addCommandHandler("yakinmermiyerleri", yakinMermiYerleri)