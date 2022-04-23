--
local thePed = createPed(240, 1631.67578125, -1145.865234375, 24.1484375, 180)
setElementDimension(thePed, 0)
setElementInterior(thePed, 0)
setElementRotation(thePed,  0, 0, 270)
setElementFrozen(thePed, true)
setElementData(thePed, "talk", 1)
setElementData(thePed, "name", "Albert Henry")

local yersira = 0
local cikisSira = 0
dolarlar = {}
pickuplar = {}
icerde = {}
aracsira = {}

local aracuzakik = 30 -- oyuncu aracını satılığa çıkartırken arasındaki uzaklık sınırı(10 dan büyükse çıkarmaz)

local mysql = exports.mysql

satisYerler = {--satiliğa çıkartınca ışınlancak yerler
-- 1.Sıra
{1619.064453125, -1107.4130859375, 23.53861618042, 90, true},
{1619.064453125, -1102.4130859375, 23.53861618042, 90, true},
{1619.064453125, -1097.4130859375, 23.53861618042, 90, true},
{1619.064453125, -1092.4130859375, 23.53861618042, 90, true},
{1619.064453125, -1087.4130859375, 23.53861618042, 90, true},
{1619.064453125, -1082.4130859375, 23.53861618042, 90, true},
{1619.064453125, -1077.4130859375, 23.53861618042, 90, true},
-- 2. Sıra
{1630.8818359375, -1077.294921875, 23.53861618042, 270, true},
{1630.8818359375, -1082.294921875, 23.53861618042, 270, true},
{1630.8818359375, -1087.294921875, 23.53861618042, 270, true},
{1630.8818359375, -1092.294921875, 23.53861618042, 270, true},
{1630.8818359375, -1097.294921875, 23.53861618042, 270, true},
{1630.8818359375, -1102.294921875, 23.53861618042, 270, true},
{1630.8818359375, -1107.294921875, 23.53861618042, 270, true},
-- 3. Sıra
{1647.9599609375, -1112.6171875, 23.53861618042, 90, true},
{1647.9599609375, -1107.6171875, 23.53861618042, 90, true},
{1647.9599609375, -1102.5703125, 23.53861618042, 90, true},
{1647.9599609375, -1097.5859375, 23.53861618042, 90, true},
{1647.9599609375, -1092.5703125, 23.53861618042, 90, true},
{1647.9599609375, -1087.5703125, 23.53861618042, 90, true},
{1647.9599609375, -1082.5703125, 23.53861618042, 90, true},
{1647.9599609375, -1077.5703125, 23.53861618042, 90, true},
-- 4. Sıra 
{1659.412109375, -1077.7080078125, 23.53861618042, 270, true},
{1659.412109375, -1082.7080078125, 23.53861618042, 270, true},
{1659.412109375, -1087.7080078125, 23.53861618042, 270, true},
{1659.412109375, -1092.7080078125, 23.53861618042, 270, true},
{1659.412109375, -1097.7080078125, 23.53861618042, 270, true},
{1659.412109375, -1102.7080078125, 23.53861618042, 270, true},
{1659.412109375, -1107.7080078125, 23.53861618042, 270, true},
{1659.412109375, -1112.7080078125, 23.53861618042, 270, true},
-- 5. Sıra
{1673.9482421875, -1116.8818359375, 23.53861618042, 90, true},
{1673.9482421875, -1111.8818359375, 23.53861618042, 90, true},
{1673.9482421875, -1106.8818359375, 23.53861618042, 90, true},
{1673.9482421875, -1101.8818359375, 23.53861618042, 90, true},
{1673.9482421875, -1096.8818359375, 23.53861618042, 90, true},
{1673.9482421875, -1091.8818359375, 23.53861618042, 90, true},
-- 6. Sıra
{1687.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1692.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1697.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1702.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1707.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1712.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1722.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1727.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1732.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1737.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1742.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1747.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1752.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1757.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1762.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1767.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1772.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1777.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1782.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1787.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1792.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1797.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1802.3876953125, -1084.716796875, 23.532939910889, 0, true},
{1807.3876953125, -1084.716796875, 23.532939910889, 0, true},
-- 7. Sıra
{1795.1328125, -1070.201171875, 23.595947265625, 180, true},
{1790.1328125, -1070.201171875, 23.595947265625, 180, true},
{1785.1328125, -1070.201171875, 23.595947265625, 180, true},
{1780.1328125, -1070.201171875, 23.595947265625, 180, true},
{1775.1328125, -1070.201171875, 23.595947265625, 180, true},
{1770.1328125, -1070.201171875, 23.595947265625, 180, true},
{1765.1328125, -1070.201171875, 23.595947265625, 180, true},
{1760.1328125, -1070.201171875, 23.595947265625, 180, true},
-- 8. Sıra 
{1790.1328125, -1060.36328125, 23.595947265625, 0, true},
{1785.1328125, -1060.36328125, 23.595947265625, 0, true},
{1780.1328125, -1060.36328125, 23.595947265625, 0, true},
{1775.1328125, -1060.36328125, 23.595947265625, 0, true},
{1770.1328125, -1060.36328125, 23.595947265625, 0, true},
{1765.1328125, -1060.36328125, 23.595947265625, 0, true},
{1760.1328125, -1060.36328125, 23.595947265625, 0, true},
-- 9. Sıra
{1723.162109375, -1070.201171875, 23.595947265625, 180, true},
{1718.162109375, -1070.201171875, 23.595947265625, 180, true},
{1713.162109375, -1070.201171875, 23.595947265625, 180, true},
{1708.162109375, -1070.201171875, 23.595947265625, 180, true},
{1703.162109375, -1070.201171875, 23.595947265625, 180, true},
{1698.162109375, -1070.201171875, 23.595947265625, 180, true},
{1693.162109375, -1070.201171875, 23.595947265625, 180, true},
{1688.162109375, -1070.201171875, 23.595947265625, 180, true},
-- 10. Sıra
{1723.162109375, -1060.36328125, 23.595947265625, 0, true},
{1718.162109375, -1060.36328125, 23.595947265625, 0, true},
{1713.162109375, -1060.36328125, 23.595947265625, 0, true},
{1708.162109375, -1060.36328125, 23.595947265625, 0, true},
{1703.162109375, -1060.36328125, 23.595947265625, 0, true},
{1798.162109375, -1060.36328125, 23.595947265625, 0, true},
{1793.162109375, -1060.36328125, 23.595947265625, 0, true},
{1788.162109375, -1060.36328125, 23.595947265625, 0, true},
-- 11. Sıra
{1765, -1047.43359375, 23.588541030884, 180, true},
{1760, -1047.43359375, 23.588541030884, 180, true},
{1755, -1047.43359375, 23.588541030884, 180, true},
{1750, -1047.43359375, 23.588541030884, 180, true},
{1745, -1047.43359375, 23.588541030884, 180, true},
{1740, -1047.43359375, 23.588541030884, 180, true},
-- 12. Sıra 
{1765, -1036.1865234375, 23.588541030884, 0, true},
{1760, -1036.1865234375, 23.588541030884, 0, true},
{1755, -1036.1865234375, 23.588541030884, 0, true},
{1750, -1036.1865234375, 23.588541030884, 0, true},
{1745, -1036.1865234375, 23.588541030884, 0, true},
{1740, -1036.1865234375, 23.588541030884, 0, true},
-- 13. Sıra 
{1713.591796875, -1045.177734375, 23.588541030884, 180, true},
{1708.591796875, -1045.177734375, 23.588541030884, 180, true},
{1703.591796875, -1045.177734375, 23.588541030884, 180, true},
{1698.591796875, -1045.177734375, 23.588541030884, 180, true},
{1693.591796875, -1045.177734375, 23.588541030884, 180, true},
{1688.591796875, -1045.177734375, 23.588541030884, 180, true},
{1683.591796875, -1045.177734375, 23.588541030884, 180, true},
{1678.591796875, -1045.177734375, 23.588541030884, 180, true},
-- 14. Sıra
{1713.591796875, -1034.2890625, 23.588541030884, 0, true},
{1708.591796875, -1034.2890625, 23.588541030884, 0, true},
{1703.591796875, -1034.2890625, 23.588541030884, 0, true},
{1698.591796875, -1034.2890625, 23.588541030884, 0, true},
{1693.591796875, -1034.2890625, 23.588541030884, 0, true},
{1688.591796875, -1034.2890625, 23.588541030884, 0, true},
{1683.591796875, -1034.2890625, 23.588541030884, 0, true},
{1678.591796875, -1034.2890625, 23.588541030884, 0, true},
-- 15. Sıra
{1660, -1047.48046875, 23.588541030884, 180, true},
{1655, -1047.48046875, 23.588541030884, 180, true},
{1650, -1047.48046875, 23.588541030884, 180, true},
{1645, -1047.48046875, 23.588541030884, 180, true},
{1640, -1047.48046875, 23.588541030884, 180, true},
{1635, -1047.48046875, 23.588541030884, 180, true},
{1630, -1047.48046875, 23.588541030884, 180, true},
{1625, -1047.48046875, 23.588541030884, 180, true},
-- 16. Sıra
{1660, -1036.7919921875, 23.588541030884, 0, true},
{1655, -1036.7919921875, 23.588541030884, 0, true},
{1650, -1036.7919921875, 23.588541030884, 0, true},
{1645, -1036.7919921875, 23.588541030884, 0, true},
{1640, -1036.7919921875, 23.588541030884, 0, true},
{1635, -1036.7919921875, 23.588541030884, 0, true},
{1630, -1036.7919921875, 23.588541030884, 0, true},
{1625, -1036.7919921875, 23.588541030884, 0, true},
}

cikisYerler = { -- satılıktan çıkartıncan ışınlanıcak yerler
{1652.4873046875, -1124.74609375, 23.533197402954, 180},
{1655.416015625, -1124.74609375, 23.533197402954, 180},
{1658.44140625, -1124.74609375, 23.533197402954, 180},
{1661.4013671875, -1124.74609375, 23.533197402954, 180},
{1664.3212890625, -1124.74609375, 23.533197402954, 180}, 
{1667.2734375, -1124.74609375, 23.533197402954, 180},
{1670.2958984375, -1124.74609375, 23.533197402954, 180},
{1673.1416015625, -1124.74609375, 23.533197402954, 180},
{1676.1484375, -1124.74609375, 23.533197402954, 180},   
{1679.0390625, -1124.74609375, 23.533197402954, 180},
-- 2. Sıra
{1667.853515625, -1136.1953125, 23.531644821167, 0},
{1665.0595703125, -1136.1953125, 23.531644821167, 0},
{1662.064453125, -1136.1953125, 23.531644821167, 0},
{1659.095703125, -1136.1953125, 23.531644821167, 0},
{1656.0458984375, -1136.1953125, 23.531644821167, 0},
{1653.2138671875, -1136.1953125, 23.531644821167, 0},

}	

addEvent("AracSatma:AraclariCekServer", true)
addEventHandler("AracSatma:AraclariCekServer", root, function()
	aracListeYenile(source)
end)

function aracListeYenile(oyuncu)
	local playerID = getElementData(oyuncu, "dbid")
	local sorgu = mysql:query("SELECT * FROM vehicles WHERE owner = '"..mysql:escape_string(playerID).."' AND deleted=0")
	local araclar = {}
	while true do
		local row = mysql:fetch_assoc(sorgu)
		if not row then break end
		local vehicle = exports.pool:getElement("vehicle", row.id)
		if isElement(vehicle) then
			local model = getVehicleName(vehicle)
			local km = tonumber(math.floor(row.odometer)) or 0
			setElementData(vehicle, "odometer", km)
			local satilikmi = row.satilikmi or 0
			table.insert(araclar, {id=row.id, model=model, satilikmi=tonumber(satilikmi),arac=vehicle})
		end	
	end
	--if araclar and #araclar > 0 then
		triggerClientEvent(oyuncu, "AracSatma:AraclariGonderClient", oyuncu, araclar)
	--end
end

addEventHandler("onResourceStart", resourceRoot, function()
	local sorgu = exports.mysql:query("SELECT * FROM vehicles WHERE deleted=0")
	while true do
		local row = mysql:fetch_assoc(sorgu)
		if not row then break end
		local vehicle = exports.pool:getElement("vehicle", row.id)
		if tonumber(row.satilikmi) == 1 then
			local fiyat = row.fiyat or 500
			satiligaCikar(tonumber(row.id),fiyat)
		end
	end
end)


					
function satiligaCikar(aracId,fiyat,oyuncuDeger)
	local arac = exports.pool:getElement("vehicle", aracId)
	if isElement(arac) then
		
		if isElement(pickuplar[aracId]) then destroyElement(pickuplar[aracId]) end	
		if aracsira[arac] then satisYerler[sira][5] = true end
		if oyuncuDeger and tonumber(getElementData(arac, "owner")) ~= tonumber(getElementData(source, "dbid")) then outputChatBox("#ee0000[!]#f1f1f1 Sana ait olmayan aracı satılığa çıkartamazsın.", source, 255,0,0, true) return end
		if oyuncuDeger and getVehicleController(arac) then outputChatBox("#ee0000[!]#f1f1f1 Araç içinde birileri var iken satılığa çıkartamazsın.", source, 255,0,0, true) return end
		if oyuncuDeger and #getVehicleOccupants(arac) > 0 then outputChatBox("#ee0000[!]#f1f1f1 Araç içinde birileri var iken satılığa çıkartamazsın.", source, 255,0,0, true) return end
		if oyuncuDeger and not getElementData(arac, "faction") == "-1" then outputChatBox("#ee0000[!]#f1f1f1 Bu araç bir birliğe ait satılamaz.",source,255,0,0,true) return end
		if oyuncuDeger and getElementData(arac, "Satilik") then outputChatBox("#ee0000[!]#f1f1f1 Bu araç zaten satılık.",source,255,0,0,true) return end
		local model = getElementModel(arac)
		if oyuncuDeger and (model == 434 or model == 494 or model == 502 or model == 503 or model == 504 or model == 522 or model == 555 or model == 605) then outputChatBox("#ee0000[!]#f1f1f1 Bu aracı 2. el galeride satamazsınız.",source,255,0,0,true) return end
		
		if oyuncuDeger then
			local px,py,pz = getElementPosition(source)
			local vx,vy,vz = getElementPosition(arac)
			if getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz) > aracuzakik then
				outputChatBox("#ee0000[!]#f1f1f1 Aracınızı satılığa çıkartmak için aracınızdan uzaktasınız.", source, 255,0,0, true)
				return
			end
		end	
		
		yersira = bosSira()
		
		--if yersira > #satisYerler then yersira = 1 end	
		
		local x,y,z,r = unpack(satisYerler[yersira])
		satisYerler[yersira][5] = false
		setElementPosition(arac,x,y,z)
		setElementRotation(arac,0,0,r)
		setVehicleLocked(arac, true)
		setElementFrozen(arac, true)
		setElementData(arac, "Satilik", fiyat)
		setVehicleDamageProof(arac, true)
		setElementDimension(arac, 0)
		setElementInterior(arac,0)
		
		local x2 = x - ( ( math.cos ( math.rad (  r ) ) ) * 1.5 )
		local y2 = y - ( ( math.sin ( math.rad (  r ) ) ) * 1.5 )
		local pickup = createPickup(x2,y2,z,3,1274)
		dolarlar[pickup] = aracId
		pickuplar[aracId] = pickup
		aracsira[arac] = yersira
		addEventHandler("onPickupHit", pickup, dolaraGirince)
		addEventHandler("onPickupLeave", pickup, dolardanCikinca)
		if oyuncuDeger then
			outputChatBox("#12ec00[!]#f1f1f1 Aracınızı satılığa çıkarttınız!", source, 255, 194, 14, true)
		end
		mysql:query_free("UPDATE vehicles SET fiyat="..mysql:escape_string((tonumber(fiyat) or 0)).." WHERE id="..mysql:escape_string(aracId))
		mysql:query_free("UPDATE vehicles SET satilikmi= '1' WHERE id="..mysql:escape_string(aracId))
		mysql:query_free("UPDATE vehicles SET x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y) .."', z='" .. mysql:escape_string(z) .. "', rotx='" .. mysql:escape_string(0) .. "', roty='" .. mysql:escape_string(0) .. "', rotz='" .. mysql:escape_string(r) .. "', currx='" .. mysql:escape_string(x) .. "', curry='" .. mysql:escape_string(y) .. "', currz='" .. mysql:escape_string(z) .. "', currrx='" .. mysql:escape_string(0) .. "', currry='" .. mysql:escape_string(0) .. "', currrz='" .. mysql:escape_string(r) .. "', interior='" .. mysql:escape_string(0) .. "', currinterior='" .. mysql:escape_string(0) .. "', dimension='" .. mysql:escape_string(0) .. "', currdimension='" .. mysql:escape_string(0) .. "' WHERE id='" .. mysql:escape_string(aracId) .. "'")
		setVehicleRespawnPosition(arac, x, y, z, 0, 0, r)
		exports['anticheat-system']:changeProtectedElementDataEx(arac, "respawnposition", {x, y, z, 0, 0, r}, false)
		exports['anticheat-system']:changeProtectedElementDataEx(arac, "interior", 0)
		exports['anticheat-system']:changeProtectedElementDataEx(arac, "dimension", 0)
	end
end
addEvent("AracSat:SatiligaCikar", true)
addEventHandler("AracSat:SatiligaCikar", root, satiligaCikar)

function bosSira()
	for i,v in pairs(satisYerler) do
		local x,y,z,r,durum = unpack(v)
		if durum then
			return i
		end
	end
	return false
end	

addEvent("AracSat:SatiligtanCikar", true)
addEventHandler("AracSat:SatiligtanCikar", root, function(aracId)
	local arac = exports.pool:getElement("vehicle", aracId)
	if isElement(arac) then
		if not getElementData(arac, "Satilik") then outputChatBox("#ee0000[!]#f1f1f1 Bu araç zaten satılık değil.",source,255,0,0,true) return end
	
		cikisSira = cikisSira + 1
		--yersira = yersira -1
		 
		--if yersira < 0 then yersira = 0 end	
		if cikisSira > #cikisYerler then cikisSira = 1 end	
		
		local x,y,z,r = unpack(cikisYerler[cikisSira])
		
		setElementPosition(arac,x,y,z)
		setElementRotation(arac,0,0,r)
		setVehicleLocked(arac, false)
		setElementFrozen(arac, false)
		setElementData(arac, "Satilik", nil)
		setVehicleDamageProof(arac, false)
		if isElement(pickuplar[aracId]) then destroyElement(pickuplar[aracId]) end
		
		local sira = aracsira[arac]
		if sira then
			satisYerler[sira][5] = true
			aracsira[arac] = nil
		end
		pickuplar[aracId] = nil
		
		outputChatBox("#12ec00[!]#f1f1f1 Aracınızı satılıktan çıkarttınız!", source, 255, 194, 14, true)
		mysql:query_free("UPDATE vehicles SET fiyat= '0' WHERE id="..mysql:escape_string(aracId))
		mysql:query_free("UPDATE vehicles SET satilikmi= '0' WHERE id="..mysql:escape_string(aracId))
	end
end)

function dolaraGirince(giren)
	if getElementType(giren) == "player" and not getPedOccupiedVehicle(giren) then
		local aracId = dolarlar[source]
		local arac = exports.pool:getElement("vehicle", aracId)
		local fiyat = getElementData(arac, "Satilik")
		triggerClientEvent(giren, "AracSatma:BilgiGöster",giren, arac,fiyat)
		icerde[giren] = aracId
		cancelEvent()
	end
end

function dolardanCikinca(cikan)
	icerde[cikan] = nil
end

addEventHandler("onPlayerQuit", root, function() if icerde[source] then icerde[source] = nil end end)

function aracSatinAl()
	if icerde[source] then
		local aracId = icerde[source]
		local arac = exports.pool:getElement("vehicle", aracId)
		local fiyat = tonumber(getElementData(arac, "Satilik"))
		local oyuncuId = getElementData(source, "dbid") -- SATIN ALAN
		local sahipID = getElementData(arac, "owner")
		local sahip = getPlayerFromDbID(sahipID)
		if exports.global:canPlayerBuyVehicle(source) then
			if fiyat then
				local oyuncuPara = exports.global:getMoney(source)
				
				if not getElementData(arac, "Satilik") then outputChatBox("#ee0000[!]#f1f1f1 Bu araç zaten satılık değil.",source,255,0,0,true) return end
				if not exports.global:hasMoney(source, fiyat)  then outputChatBox("Yeterli Paran Yok",source,255,0,0) return end
				if oyuncuId == sahipID then outputChatBox("#ee0000[!]#f1f1f1 Sana ait olan aracı satın alamazsın!", source, 255,0,0, true)  return end
				--yersira = yersira -1
			 
			--	if yersira < 0 then yersira = 0 end	
				cikisSira = cikisSira + 1
				
				if cikisSira > #cikisYerler then cikisSira = 1 end	
				
				local sira = aracsira[arac]
				if sira then
					satisYerler[sira][5] = true
				end	
			
				local x,y,z,r = unpack(cikisYerler[cikisSira])

				setElementPosition(arac,x,y,z)
				setElementRotation(arac,0,0,r)
				
				if isElement(sahip) then			
					outputChatBox("#12ec00[!]#f1f1f1 " ..aracId .. " numaralı aracı satın aldınız.", source, 255, 194, 14, true)
					outputChatBox("#12ec00[!]#f1f1f1 " ..aracId .. " numaralı aracınız satın alındı. ", sahip, 255, 194, 14, true)
					exports.global:giveMoney(sahip,fiyat)
					aracListeYenile(sahip)
				else
					outputChatBox("#12ec00[!] #f1f1f1 " ..aracId .. " numaralı aracı satın aldınız.", source, 255, 194, 14, true)
					
					mysql:query_free("UPDATE `characters` SET `money`=`money`+'"..mysql:escape_string(fiyat).."' WHERE `id`='"..sahipID.."' ") 
					
					
					local hesapVerileri = mysql:query_fetch_assoc( "SELECT * FROM `characters` WHERE `id`=" .. mysql:escape_string(sahipID))
					if hesapVerileri then
						local caraclar = hesapVerileri["ek"]
						if type(fromJSON(caraclar)) ~= "table" then caraclar = toJSON ( { } ) end
						local satilikAraclar = fromJSON(caraclar or toJSON ( { } ))
						
						table.insert(satilikAraclar, aracId..","..fiyat)
					
						mysql:query_free("UPDATE `characters` SET `ek`='"..mysql:escape_string(toJSON(satilikAraclar)).."' WHERE `id`='"..sahipID.."' ") 
					end
					
				end	
			

				
				icerde[source] = nil
				exports['item-system']:deleteAll(3,aracId)
				setElementData(arac,"owner",oyuncuId)
				setVehicleLocked(arac, false)
				setElementFrozen(arac, false)
				setElementData(arac, "Satilik", nil)
				setVehicleDamageProof(arac, false)
				exports['item-system']:deleteAll(3,aracId)
				exports.global:takeMoney(source,fiyat)
				exports.global:giveItem(source, 3, aracId)
				destroyElement(pickuplar[aracId])		
				mysql:query_free("UPDATE vehicles SET fiyat= '0' WHERE id="..mysql:escape_string(aracId))
				mysql:query_free("UPDATE vehicles SET satilikmi= '0' WHERE id="..mysql:escape_string(aracId))
				mysql:query_free("UPDATE vehicles SET owner="..oyuncuId.." WHERE id="..mysql:escape_string(aracId))
				aracsira[arac] = nil
				
				triggerClientEvent(source, "AracSatma:BilgiKapat", source)
			end
		else
			outputChatBox("#cc0000[!]#f1f1f1 Satın almak için yeterince araç yeriniz yok.", source, 255, 194, 14, true)
		end
	end
end
addEvent("AracSatma:AracSatinAl", true)
addEventHandler("AracSatma:AracSatinAl", root, aracSatinAl)

addEvent("accounts:characters:spawn",true)
addEventHandler("accounts:characters:spawn", root, function(karakterId)
	setTimer(function(karakterId)
		local oyuncu = getPlayerFromDbID(karakterId)
		local hesapVerileri = mysql:query_fetch_assoc( "SELECT * FROM `characters` WHERE `id`=" .. mysql:escape_string(karakterId))
		local caraclar = hesapVerileri["ek"]
		if type(fromJSON(caraclar)) ~= "table" then caraclar = toJSON ( { } ) end
		local satilikAraclar = fromJSON(caraclar or toJSON ( { } ))
		--if #satilikAraclar > 0 then
			for i,v in pairs(satilikAraclar) do
				local virgul = split(v, ",")
				local aracId,fiyat = virgul[1],virgul[2]
				outputChatBox("#12ec00[!]#f1f1f1 " ..aracId .. " numaralı aracın "..convertNumber ( fiyat ).."TL'ye satın alındı. ", oyuncu, 255, 194, 14, true)		
			end
			mysql:query_free("UPDATE `characters` SET `ek`='"..mysql:escape_string(toJSON({})).."' WHERE `id`='"..karakterId.."' ") 
		--end	
	end, 1000,1,karakterId)	
end)

function getPlayerFromDbID(dbid)
	local dbid = tonumber(dbid)
	if dbid then
		for i,oyuncular in pairs(getElementsByType("player")) do
			if tonumber(getElementData(oyuncular, "dbid")) == dbid then
				return oyuncular
			end	
		end
	end	
	return false
end

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

function aracbinme(thePlayer, seat, jacked)
	if getElementData(source, "Satilik") then
		cancelEvent()
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), aracbinme)