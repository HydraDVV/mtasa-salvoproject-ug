mysql = exports.mysql
addEventHandler( "onResourceStart", getResourceRootElement( ),
	function( )
		local result = mysql:query("SELECT id, x, y, z, rotation, interior, dimension, author FROM marijuanas" )
		local continue = true
		while continue do
			local row = mysql:fetch_assoc(result)
			if not row then break end
			
			local id = tonumber( row["id"] )
			local x = tonumber( row["x"] )
			local y = tonumber( row["y"] )
			local z = tonumber( row["z"] )
			local rotation = tonumber( row["rotation"] )
			local interior = tonumber( row["interior"] )
			local dimension = tonumber( row["dimension"] )
			local author = tostring( row["author"] )
			
			saksi = createObject( 2203, x, y, z, rotation )
			exports['anticheat']:changeProtectedElementDataEx( saksi, "dbid", id, false )
			exports['anticheat']:changeProtectedElementDataEx( saksi, "position", { x, y, z, rotation }, false )
			setElementInterior( saksi, interior )
			setElementDimension( saksi, dimension )
			setElementData(saksi, "type", "marijuana")
			setElementData(saksi, "hasat", 0)
			setElementData(saksi, "dbid", id)
			setElementData(saksi, "author", author)
			setElementData(saksi, "tip", "saksi")
			setElementData(saksi, "text", "Marijuana Ekili Saksı(ID:#".. id ..")\nHasat: %".. getElementData(saksi, "hasat") .."\nSahip: ".. author .."")
			setObjectScale(saksi, 1)
		end
		mysql:free_result( result )
		
	end
)

addCommandHandler( "saksikoy", 
	function( thePlayer, commandName )
		if  exports.global:takeItem(thePlayer, 347) then
			local x, y, z = getElementPosition( thePlayer )
			local rotation = getElementRotation( thePlayer )
			local interior = getElementInterior( thePlayer )
			local dimension = getElementDimension( thePlayer )
			
			local query = mysql:query_fetch_assoc("SELECT COUNT(*) as number FROM marijuanas WHERE dimension = " .. mysql:escape_string(dimension) )
			if query then
				local num = tonumber( query["number"] ) or 5
				if dimension == 0 or exports.global:isPlayerScripter( thePlayer ) then
					local marijuana = createObject( 2203, x, y, z-0.8, rotation )
					if marijuana then
						local id = mysql:query_insert_free("INSERT INTO marijuanas (x,y,z,rotation,interior,dimension,author) VALUES (" .. mysql:escape_string(x) .. "," .. mysql:escape_string(y) .. "," .. mysql:escape_string(z-0.8) .. "," .. mysql:escape_string(rotation) .. "," .. mysql:escape_string(interior) .. "," .. mysql:escape_string(dimension) .. ",'" .. getPlayerName(thePlayer) .. "')" )
						if id then
							exports['anticheat-system']:changeProtectedElementDataEx( marijuana, "dbid", id, false )
							exports['anticheat-system']:changeProtectedElementDataEx( marijuana, "position", { x, y, z, rotation }, false )
							setPedRotation( marijuana, rotation )
							setElementInterior( marijuana, interior )
							setElementDimension( marijuana, dimension )
							pz = z + 2
							setElementPosition(thePlayer, x, y, pz)
							setObjectScale(marijuana, 1)
							setElementData(marijuana, "type", "marijuana")
							setElementData(marijuana, "hasat", 0)
							setElementData(marijuana, "dbid", id)
							setElementData(marijuana, "author", getPlayerName(thePlayer))
							setElementData(marijuana, "tip", "saksi")
							setElementData(marijuana, "text", "Marijuana Ekili Saksı(ID:#".. id ..")\nHasat: %".. getElementData(marijuana, "hasat") .."\nSahip: ".. getElementData(marijuana, "author") .."")
							outputChatBox("#3AA658[!]#ffffffSaksı başarıyla koyuldu(ID: #" .. id .. ").", thePlayer, 255, 0, 0, true)
						else
							destroyElement( marijuana )
							outputDebugString( "" )
							outputChatBox( "SQL Hatası.", thePlayer, 255, 0, 0 )
						end
					else
						outputChatBox( "Obje oluşturulurken hata oluştu.", thePlayer, 255, 0, 0 )
					end
				end
			else
				outputDebugString( "" )
				outputChatBox( "SQL Hatası.", thePlayer, 255, 0, 0 )
			end
		else
			outputChatBox("#A63A3A[!]#ffffffBu işlem için marijuana tohumuna ihtiyacın var.", thePlayer, 255, 0, 0, true)
		end
	end
)

function deletemarijuana(thePlayer, commandName, id)
		if not (id) then
			outputChatBox("SYNTAX: /" .. commandName .. " [ID]", thePlayer, 255, 194, 14)
		else
			id = tonumber(id)
				
			local counter = 0
			local marijuanaobj = getElementsByType("object", getResourceRootElement())
			for k, marijuana in ipairs(marijuanaobj) do
				local objectID = getElementData(marijuana, "dbid")
				if (objectID==id) then
					local sahip = getElementData(marijuana, "author")
					if sahip == getPlayerName(thePlayer) or (exports.global:isPlayerAdmin(thePlayer)) then
						destroyElement(marijuana)
						counter = counter + 1
					end
				end
			end
			
			if (counter>0) then
				local query = mysql:query_free("DELETE FROM marijuanas WHERE id='" .. mysql:escape_string(id) .. "'")
				outputChatBox("#3AA658[!]#ffffffSaksı başarıyla silindi(ID: #" .. id .. ").", thePlayer, 255, 0, 0, true)
			end
		end

end
addCommandHandler("saksisil", deletemarijuana, false, false)

function getNearbymarijuanas(thePlayer, commandName)
		local posX, posY, posZ = getElementPosition(thePlayer)
		outputChatBox("Yakındaki saksılar:", thePlayer, 255, 126, 0)
		local count = 0
		
		for k, marijuana in ipairs(getElementsByType("object", getResourceRootElement())) do
			local x, y, z = getElementPosition(marijuana)
			local distance = getDistanceBetweenPoints3D(posX, posY, posZ, x, y, z)
			if (distance<=10) then
				local dbid = getElementData(marijuana, "dbid")
				outputChatBox("   Yakinlardaki Saksi ID " .. tostring(dbid) .. ".", thePlayer)
				count = count + 1
			end
		end
		
		if (count==0) then
			outputChatBox("   None.", thePlayer, 255, 126, 0)
		end
end
addCommandHandler("yakindakisaksilar", getNearbymarijuanas, false, false)

addEvent( "saksi:Check", true )
function petMilk (ped)
	if (isElement(source)) and (isElement(ped)) then
		if getElementData(ped, "hasat") == 100 then
			setElementData(ped, "hasat", 0)
			setElementData(ped, "text", "Marijuana Ekili Saksı(ID:#".. getElementData(ped, "dbid") ..")\nHasat: %".. getElementData(ped,"hasat") .."\nSahip: ".. getElementData(ped,"author") .."")
			exports.global:giveItem(source, 38, 1)
			--if getPlayerName(source) == "Furkan_Parlak" then
				exports.global:giveItem(source, 347, 1)
			--end
			exports.global:applyAnimation( source, "BOMBER", "BOM_Plant_Loop", -1, true, false, false)
			exports.global:sendLocalMeAction(source, "dizlerini kırarak eğilir ve marijuanaları toplamaya başlar.")
			outputChatBox("#3AA658[!]#ffffffHasat vakti gelmiş tüm hasat toplandı.", source, 255, 0, 0, true)
			mysql:query_free("DELETE FROM marijuanas WHERE id='" .. mysql:escape_string(getElementData(ped, "dbid")) .. "'")
			destroyElement(ped)
			

		else
			outputChatBox("#A63A3A[!]#ffffffBu saksıda hasat henüz yetişmedi.", source, 255, 0, 0, true)
		end
	end
end
addEventHandler( "saksi:Check", getRootElement(), petMilk)

setTimer(function ()
	for i, v in ipairs (getElementsByType("object")) do
		if (getElementData(v,"type") == "marijuana") then
			local hasat = getElementData(v,"hasat")
			if hasat < 100 then
				setElementData(v, "hasat", hasat+1)
				setElementData(v, "text", "Marijuana Ekili Saksı(ID:#".. getElementData(v, "dbid") ..")\nHasat: %".. hasat+1 .."\nSahip: ".. getElementData(v, "author") .."")
			end
		end
	end
end, 120000*2, 0, source)

function tohum_satinal(thePlayer, tohum_fiyat)
	exports.global:takeMoney(thePlayer, tohum_fiyat)
	exports.global:giveItem(thePlayer, 347, 1)
	outputChatBox("#3AA658[!]#ffffff "..tohum_fiyat.."TL karşılığında marijuana tohumu aldın.", thePlayer, 255, 0, 0, true)
end
addEvent("tohum:satinal", true)
addEventHandler("tohum:satinal", getRootElement(), tohum_satinal)