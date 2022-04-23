mysql = exports.mysql

local mobese = { }
function SmallestID()
	local result = mysql:query_fetch_assoc("SELECT MIN(e1.id+1) AS nextID FROM mobese AS e1 LEFT JOIN mobese AS e2 ON e1.id +1 = e2.id WHERE e2.id IS NULL")
	if result then
		local id = tonumber(result["nextID"]) or 1
		return id
	end
	return false
end

function mobeseOlustur(thePlayer, cmd, hizlimit)
	if not hizlimit then
		exports["titan_infobox"](thePlayer, "error.", "Hız limitini giriniz.")
		return
	end
	if exports.global:isPlayerLeadAdmin(thePlayer) then
		local id = SmallestID()
		local dimension = getElementDimension(thePlayer)
		local interior = getElementInterior(thePlayer)
		local x, y, z  = getElementPosition(thePlayer)
		local rotation = getPedRotation(thePlayer)
		local olusturan = getPlayerName(thePlayer)
		local mobesekoy = mysql:query_insert_free("INSERT INTO mobese SET id ='" .. mysql:escape_string(id) .. "', x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y) .. "', z='" .. mysql:escape_string(z) .. "', dimension='" .. mysql:escape_string(dimension) .. "', interior='" .. mysql:escape_string(interior) .. "', hizlimit="..tonumber(hizlimit)..", rotation='" .. mysql:escape_string(rotation) .. "', olusturan='".. mysql:escape_string(olusturan) .."'")
		if mobesekoy then
			local mobese = createObject(893, x, y, z-1, 0, 0, rotation)
			setElementCollisionsEnabled(mobese, false)
			setElementDimension(mobese, dimension)
			setElementInterior(mobese, interior)				
			setElementData(mobese, "tip", "mobese")
			setElementData(mobese, "id", id)
			setElementData(mobese, "olusturan", olusturan)
			setElementData(mobese, "hizlimit", hizlimit)
			setElementData(mobese, "rot", rotation)
			setElementData(mobese, "x", x)
			setElementData(mobese, "y", y)
			setElementData(mobese, "z", z)			
			outputChatBox("[!] #FFFFFFMobese ekleme işlemi başarılı!(ID: #".. id ..")", thePlayer, 0, 255, 0, true)
		end
	end
end
addCommandHandler("mobeseolustur", mobeseOlustur)
function mobeseSil(thePlayer, cmd, id)
	if exports.global:isPlayerLeadAdmin(thePlayer) then
		if id then
		    local objects = getElementsByType("object", getResourceRootElement())
		    for k, theObject in ipairs(objects) do
		        if getElementData(theObject, "tip") == "mobese" then
			      	if getElementData(theObject, "id") == tonumber(id) then
  		        	    local sqlSilStr = mysql:query_free("DELETE FROM mobese WHERE id='" .. mysql:escape_string(id) .. "'")
    					if sqlSilStr then
							destroyElement(theObject)
							outputChatBox("[!] #FFFFFF#".. id .. " ID'li mobese silindi.", thePlayer, 0, 255, 0, true)
		          		end
	          		end
		        end
		    end
	    else
	    	outputChatBox("Kullanımı: #ffffff/" .. cmd .. " [MobeseID]", thePlayer, 255, 194, 14, true)
		end
    end
end
addCommandHandler("mobesesil", mobeseSil)

function mobeseYukle()
	local result = mysql:query("SELECT id, x, y, z, rotation, dimension, interior,hizlimit, olusturan,' ' FROM mobese")
	local counter = 0
	
	if (result) then
		local continue = true
		while continue do
			local row = mysql:fetch_assoc(result)
			if not row then break end
			local id = tonumber(row["id"])
			local x = tonumber(row["x"])
			local y = tonumber(row["y"])
			local z = tonumber(row["z"])

			local rotation = tonumber(row["rotation"])
			local dimension = tonumber(row["dimension"])
			local interior = tonumber(row["interior"])
			local id = tonumber(row["id"])
			local olusturan = tonumber(row["olusturan"])
			local hizlimit = tonumber(row["hizlimit"])

			
			local mobese = createObject(893, x, y, z-1, 0, 0, rotation)
			setElementCollisionsEnabled(mobese, false)
			setElementDimension(mobese, dimension)
			setElementInterior(mobese, interior)
			setElementData(mobese, "id", id)
			setElementData(mobese, "tip", "mobese")
			setElementData(mobese, "olusturan", olusturan)
			setElementData(mobese, "hizlimit", hizlimit)
			setElementData(mobese, "rot", rotation)
			setElementData(mobese, "x", x)
			setElementData(mobese, "y", y)
			setElementData(mobese, "z", z)
		end
		mysql:free_result(result)
	end
end
addEventHandler("onResourceStart", getResourceRootElement(), mobeseYukle)

--function paraKes(thePlayer)
	--if exports.global:getMoney(thePlayer) >= 2500 then
	--	exports.global:takeMoney(thePlayer, 2500)
	--	outputChatBox("[!] #FFFFFFMobese tarafından 2.500TL cezalandırıldınız!", thePlayer, 0, 255, 0, true)
	--else
	--	exports.global:takeBankMoney(thePlayer, 5000)
	--	outputChatBox("[!] #FFFFFFMobese tarafından banka hesabınızdan 5.000TL cezalandırıldınız!", thePlayer, 0, 255, 0, true)
--	end
--end
--addEvent("paraKesTRAFIK", true)
--addEventHandler("paraKesTRAFIK", getRootElement(), paraKes)

function baka_deneme(player, cmd, miktar)
	--if getElementData(player, "account:username") == "REMAJOR" then
	if not miktar then return end
	if miktar == "yuz" then
		exports.global:takeBankMoney(player, 500)
		outputChatBox("Deneme1", player)
	elseif miktar == "bin" then
		amount = 2500
		exports['anticheat-system']:changeProtectedElementDataEx(player, "bankmoney", getElementData(player, "bankmoney") + amount, false )
		outputChatBox("Deneme2", player)
	end
	-- end
end
addCommandHandler("banka", baka_deneme)