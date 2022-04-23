mysql = exports.mysql
function add_bakiye(thePlayer, cmd, playerName, miktar)
    if getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "point" or getElementData(thePlayer, "account:username") == "REMAJOR" or getElementData(thePlayer, "account:username") == "pabloo50" or getElementData(thePlayer, "account:username") == "hypermc" or getElementData(thePlayer, "account:username") == "alperen2124" or getElementData(thePlayer, "account:username") == "Leteral" or getElementData(thePlayer, "account:username") == "alptosun" or getElementData(thePlayer, "account:username") == "REMAJOR" then
      if playerName then
           if tonumber(miktar) then
                local targetPlayer, targetPlayerName = exports["global"]:findPlayerByPartialNick(thePlayer, playerName)
				local bakiye_cek = getElementData(targetPlayer, "account:bakiye") or 0
                if isElement(targetPlayer) then
					  local query = mysql:query_free("UPDATE accounts SET bakiye='"..bakiye_cek+miktar.."' WHERE id='" .. mysql:escape_string(getElementData(targetPlayer, "account:id")) .. "'")
                      setElementData(targetPlayer, "account:bakiye", tonumber(bakiye_cek+miktar))
					  outputChatBox("#00ff00[!]#ffffff Başarılı bir şekilde "..targetPlayerName.." isimli oyuncuya "..miktar.."TL bakiye eklediniz.", thePlayer, 255, 0, 0, true)
					  outputChatBox("#0000ff[!]#ffffff "..getPlayerName(thePlayer).." isimli yetkili size "..miktar.."TL bakiye ekledi.", targetPlayer, 255, 0, 0, true)
                end
           else
                 outputChatBox("SYNTAX: /"..cmd.." [Oyuncu Adı/ID] [Miktar]", thePlayer, 255, 194, 94, true)
           end
      else
           outputChatBox("SYNTAX: /"..cmd.." [Oyuncu Adı/ID] [Miktar]", thePlayer, 255, 194, 94, true)
      end
	
	else
	    outputChatBox("#ff0000[!]#ffffff Bu işlemi yapmak için yetkiniz yok.", thePlayer, 255, 194, 94, true)
	end
end
addCommandHandler("bakiyeekle", add_bakiye)
function bakiye_guncelle(thePlayer, mik)
	local bakiye_cek = getElementData(thePlayer, "account:bakiye") or 0
	local query = mysql:query_free("UPDATE accounts SET bakiye='"..tonumber(bakiye_cek-mik).."' WHERE id='" .. mysql:escape_string(getElementData(thePlayer, "account:id")) .. "'")
	setElementData(thePlayer, "account:bakiye", tonumber(bakiye_cek-mik))
	outputChatBox("#626EB9[!]#ffffff Güncel Bakiyeniz: " .. tonumber(bakiye_cek-mik) .. "TL", thePlayer, 255, 0, 0, true)
	setElementData(thePlayer, "donate:durum", true)
end
function isim_degistir(thePlayer, isim)	
	oyuncu_isim = isim
	local getrow = mysql:query("SELECT * FROM characters WHERE charactername='" .. oyuncu_isim:gsub(" ", "_") .. "'")
	local numrows = mysql:num_rows(getrow)
	if numrows > 0 then
		outputChatBox("#cc0000[!] #FFFFFFMaalesef, girilen isim başkası tarafından kullanılmakta.", thePlayer, 0, 255, 0, true)
		return false
	end
	exports.anticheat:changeProtectedElementDataEx(thePlayer, "legitnamechange", 1, false)
	local eski_isim = getPlayerName(thePlayer)
	local isim_ayarla = setPlayerName(thePlayer, oyuncu_isim:gsub(" ", "_"))		
	if (isim_ayarla) then
		exports.global:sendMessageToAdmins("AdmCmd (Oyuncu NPC'den isim değiştirdi): "..eski_isim.." olan ismini "..oyuncu_isim:gsub(" ", "_").." yaptı.")
		local dbid = getElementData(thePlayer, "dbid")
		mysql:query_free("UPDATE characters SET charactername='" .. mysql:escape_string(oyuncu_isim:gsub(" ", "_")) .. "' WHERE id = " .. mysql:escape_string(dbid))
		mysql:free_result(getrow)
		bakiye_guncelle(thePlayer, 5)
		outputChatBox("[!] #FFFFFFİsminiz 5TL karşılığında "..oyuncu_isim.." olarak değiştirilmiştir.", thePlayer, 0, 255, 0, true)
	end
	exports.anticheat:changeProtectedElementDataEx(thePlayer, "legitnamechange", 0, false)
end
addEvent("donate:isimDegistir", true)
addEventHandler("donate:isimDegistir", getRootElement(), isim_degistir)

function kullanici_adi_degister(thePlayer, kullanici_adi)
	local kullanici_adi_sql = mysql:escape_string(kullanici_adi)
	local result = mysql:query("SELECT username FROM accounts WHERE username='" .. kullanici_adi_sql .. "'")
	if (mysql:num_rows(result)>0) then
		outputChatBox("#cc0000[!] #FFFFFFMaalesef, girilen kullanıcı adı başkası tarafından kullanılmakta.", thePlayer, 0, 255, 0, true)
		return 
	end
	local dbid = getElementData(thePlayer, "account:id")
	local escapedID = mysql:escape_string(dbid)
	local query = exports.mysql:query_free("UPDATE accounts SET username = '" .. kullanici_adi_sql .. "' WHERE id = '" .. escapedID .. "'")
	if query then
		outputChatBox("#00ff00[!]#ffffff Başarılı bir şekilde kullanıcı adınızı #00ff00"..kullanici_adi.."#ffffff olarak güncellediniz.", thePlayer, 255, 0, 0, true)
		setElementData(thePlayer, "account:username", kullanici_adi)
		bakiye_guncelle(thePlayer, 5)
	else
		outputChatBox("#cc0000Veritabanı hatası.", thePlayer, 0, 255, 0, true)
	end
end
addEvent("donate:kullaniciAdiGuncelle", true)
addEventHandler("donate:kullaniciAdiGuncelle", getRootElement(), kullanici_adi_degister)

function karakter_limit_ekle(thePlayer)
	local limit = getElementData(thePlayer, "karakterlimit") or 3
	mysql:query_free("UPDATE accounts SET karakterlimit=karakterlimit+1 WHERE id='" .. getElementData(thePlayer, "account:id") .. "'")						
	setElementData(thePlayer, "karakterlimit", tonumber(limit)+1)
	outputChatBox("#00ff00[!]#ffffff Karakter limitinize 1 ekleme yaptınız. Yeni limitiniz: " .. tonumber(limit)+1, thePlayer, 255, 0, 0, true)
	bakiye_guncelle(thePlayer, 20)
end
addEvent("donate:karakterLimitiEkle", true)
addEventHandler("donate:karakterLimitiEkle", getRootElement(), karakter_limit_ekle)

function arac_limit_ekle(thePlayer)
	local query = mysql:query_fetch_assoc("SELECT maxvehicles FROM characters WHERE id = " .. mysql:escape_string(getElementData(thePlayer, "dbid")))
	if (query) then
		local oldvl = query["maxvehicles"]
		local ekle = 1
		mysql:query_free("UPDATE characters SET maxvehicles = " .. mysql:escape_string(tonumber(oldvl)+ekle) .. " WHERE id = " .. mysql:escape_string(getElementData(thePlayer, "dbid")))
		exports['anticheat-system']:changeProtectedElementDataEx(thePlayer, "maxvehicles", tonumber(oldvl)+ekle, false)
		outputChatBox("#00ff00[!]#ffffff Araç limitinize 1 ekleme yaptınız. Yeni limitiniz: " .. tonumber(oldvl)+ekle, thePlayer, 255, 194, 14, true)
		exports.logs:dbLog(thePlayer, 4, thePlayer, "SETVEHLIMIT DONATEGUI"..oldvl.." "..tonumber(oldvl)+ekle)
		bakiye_guncelle(thePlayer, 5)
	end
end
addEvent("donate:aracLimitiEkle", true)
addEventHandler("donate:aracLimitiEkle", getRootElement(), arac_limit_ekle)

function vip_ekle(thePlayer, vip, ucret)
	local query = mysql:query_free("UPDATE characters SET vipver='"..vip.."' WHERE id='" .. mysql:escape_string(getElementData(thePlayer, "dbid")) .. "'")
	setElementData(thePlayer, "vipver", tonumber(vip))
	outputChatBox("#00ff00[!]#ffffff Başarılı bir şekilde vip ["..vip.."] satın aldınız.", thePlayer, 255, 0, 0, true)
	bakiye_guncelle(thePlayer, tonumber(ucret))
end
addEvent("donate:vipEkle", true)
addEventHandler("donate:vipEkle", getRootElement(), vip_ekle)

function SmallestID( )
	local result = mysql:query_fetch_assoc("SELECT MIN(e1.id+1) AS nextID FROM vehicles AS e1 LEFT JOIN vehicles AS e2 ON e1.id +1 = e2.id WHERE e2.id IS NULL")
	if result then
		local id = tonumber(result["nextID"]) or 1
		return id
	end
	return false
end

function arac_al(thePlayer, arac_id, ucret, aracadi, vergi)
	if exports.global:canPlayerBuyVehicle(thePlayer) then
		local id = arac_id
		local r = getPedRotation(thePlayer)
		local x, y, z = getElementPosition(thePlayer)
		x = x + ( ( math.cos ( math.rad ( r ) ) ) * 5 )
		y = y + ( ( math.sin ( math.rad ( r ) ) ) * 5 )
		local letter1 = string.char(math.random(65,90))
		local letter2 = string.char(math.random(65,90))
		local plate = tonumber(34).. " ".. letter1 .. letter2 .. " " .. math.random(1000, 9999)
		local factionVehicle = -1
		local dbid = getElementData(thePlayer, "dbid")
		local veh = createVehicle(id, x, y, z, 0, 0, r, plate)
		local vehicleName = getVehicleName(veh)
		destroyElement(veh)
		local dimension = getElementDimension(thePlayer)
		local interior = getElementInterior(thePlayer)
		local var1, var2 = exports['vehicle-system']:getRandomVariant(id)
		local smallestID = SmallestID()
		local insertid = mysql:query_insert_free("INSERT INTO vehicles SET id='" .. mysql:escape_string(smallestID) .. "', model='" .. mysql:escape_string(id) .. "', x='" .. mysql:escape_string(x) .. "', y='" .. mysql:escape_string(y) .. "', z='" .. mysql:escape_string(z) .. "', rotx='0', roty='0', rotz='" .. mysql:escape_string(r) .. "', color1='[ [ 0, 0, 0 ] ]', color2='[ [ 0, 0, 0 ]]', color3='[ [ 0, 0, 0 ] ] ', color4='[ [ 0, 0, 0 ] ]', faction='" .. mysql:escape_string(factionVehicle) .. "', owner='" .. mysql:escape_string(dbid) .. "', plate='" .. mysql:escape_string(plate) .. "', currx='" .. mysql:escape_string(x) .. "', curry='" .. mysql:escape_string(y) .. "', currz='" .. mysql:escape_string(z) .. "', currrx='0', currry='0', currrz='" .. mysql:escape_string(r) .. "', locked=1, interior='" .. mysql:escape_string(interior) .. "', currinterior='" .. mysql:escape_string(interior) .. "', dimension='" .. mysql:escape_string(dimension) .. "', currdimension='" .. mysql:escape_string(dimension) .. "', tintedwindows='" .. mysql:escape_string(0) .. "',variant1="..var1..",variant2="..var2..", marka='"..aracadi.."', tax="..vergi..", fiyati=1000000, creationDate=NOW(), createdBy="..getElementData(thePlayer, "account:id").."")
		if (insertid) then
			local owner = ""
			owner = getPlayerName( thePlayer )
			exports.global:giveItem(thePlayer, 3, tonumber(insertid))
			exports.logs:logMessage("[MAKEVEH DONATEGUI] " .. getPlayerName( thePlayer ) .. " created car #" .. insertid .. " (" .. vehicleName .. ") - " .. owner, 9)
			exports.logs:dbLog(thePlayer, 6, { "ve" .. insertid }, "SPAWNVEH DONATEGUI'"..vehicleName.."' $0 "..owner )
			exports['vehicle-system']:reloadVehicle(insertid)
			local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
			local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
			local adminUsername = getElementData(thePlayer, "account:username")
			local adminID = getElementData(thePlayer, "account:id")
			
			local addLog = mysql:query_free("INSERT INTO `vehicle_logs` (`vehID`, `action`, `actor`) VALUES ('"..tostring(insertid).."', 'DONATEGUI "..vehicleName.." ($0 - to "..owner..")', '"..adminID.."')") or false
			if not addLog then
				outputDebugString("Araç logu oluşurken hata oluştu")
			end
			bakiye_guncelle(thePlayer, tonumber(ucret))
		end
	else
		outputChatBox("#cc0000[!]#f1f1f1 Satın almak için yeterince araç yeriniz yok.", thePlayer, 255, 194, 14, true)
	end
end
addEvent("donate:aracAl", true)
addEventHandler("donate:aracAl", getRootElement(), arac_al)

function kiyafet_Al(thePlayer, model, ucret)
	exports.global:giveItem(thePlayer, 16, model)
	outputChatBox("#00ff00[!]#ffffff Başarılı bir şekilde "..model.." model kıyafet satın aldınız.", thePlayer, 255, 0, 0, true)
	bakiye_guncelle(thePlayer, tonumber(ucret))
end
addEvent("donate:kiyafetAl", true)
addEventHandler("donate:kiyafetAl", getRootElement(), kiyafet_Al)

local silah_mermiler = {
	[22] = {2, 17},
	[28] = {2, 25},
	[25] = {2, 10},
	[33] = {2, 25},
	[30] = {2, 25},
	[29] = {2, 25},
	[23] = {2, 17},
	[32] = {2, 25},
}
function silah_Al(thePlayer, silah, silah_adi, ucret)
	outputChatBox(silah, thePlayer)
	outputChatBox(silah_adi, thePlayer)
	outputChatBox(ucret, thePlayer)
	if not exports["item-system"]:hasSpaceForItem(thePlayer, 115, silah) or not exports["item-system"]:hasSpaceForItem(thePlayer, 116, silah..":"..silah_mermiler[silah][2]..":Ammo for "..getWeaponNameFromID(silah)) then outputChatBox("#cc0000[!] #FFFFFFEnvanterin dolu.", thePlayer, 0, 255, 0, true) return end
	local dbid = tonumber(getElementData(thePlayer, "account:character:id"))
	local g_serial = exports.global:createWeaponSerial( 1, dbid, dbid)
	local give, error = "" 
	give, error = exports.global:giveItem(thePlayer, 115, silah..":"..g_serial..":"..getWeaponNameFromID(silah))
	for i = 1, silah_mermiler[silah][1] do
		give, error = exports.global:giveItem(thePlayer, 116, silah..":"..silah_mermiler[silah][2]..":Ammo for "..getWeaponNameFromID(silah))
	end
	outputChatBox( "#169D0A[!]#89BC84 "..ucret.."TL karşılığında '"..silah_adi.."' satın aldınız.", thePlayer, 255, 0, 0, true)
	bakiye_guncelle(thePlayer, tonumber(ucret))
end
addEvent("donate:silahAl", true)
addEventHandler("donate:silahAl", getRootElement(), silah_Al)

function telno_al(thePlayer, telno, ucret)
	local result = mysql:query("SELECT `phonenumber` FROM `phones` WHERE `phonenumber` = '" .. mysql:escape_string(tostring(telno))  .. "'")
	if (mysql:num_rows(result)>0) then
		outputChatBox("#cc0000[!] #FFFFFFMaalesef, girilen telefon numarası başkası tarafından kullanılmakta.", thePlayer, 0, 255, 0, true)
		return 
	end
	if exports.global:giveItem( client, 2, telno ) then
		mysql:query_free("INSERT INTO `phones` (`phonenumber`, `boughtby`) VALUES ('"..mysql:escape_string(tostring(telno)).."', '"..mysql:escape_string(tostring(getElementData(thePlayer, "account:character:id") or 0)).."')")
	end
	outputChatBox( "#169D0A[!]#89BC84 "..ucret.."TL karşılığında '"..telno.."' numarasını satın aldınız.", thePlayer, 255, 0, 0, true)
	bakiye_guncelle(thePlayer, tonumber(ucret))
end
addEvent("donate:telNoAl", true)
addEventHandler("donate:telNoAl", getRootElement(), telno_al)

local sayiGeT = {"1", "2", "3", "4", "5", "6", "7", "8", "9"}

function table.random ( theTable )
    return theTable[math.random ( #theTable )]
end

function maske_no(thePlayer)
	local maskenosu = table.random(sayiGeT) .. "" .. table.random(sayiGeT) .. "" .. table.random(sayiGeT) .. "" .. table.random(sayiGeT) .. "" .. table.random(sayiGeT) .. ""	
	local query = mysql:query_free("UPDATE characters SET maskeno='"..maskenosu.."', maskehak='1' WHERE id='" .. mysql:escape_string(getElementData(thePlayer, "dbid")) .. "'")
	setElementData(thePlayer, "maskeno", tonumber(maskenosu))
	setElementData(thePlayer, "maskehak", 1)
	outputChatBox("#00ff00[!]#ffffff Başarılı bir şekilde maske hakkı satın aldınız. Maske Numaranız: ("..maskenosu..")", thePlayer, 255, 0, 0, true)
	bakiye_guncelle(thePlayer, 10)
	exports["item-system"]:giveItem(thePlayer, 56,1)
end
addEvent("donate:maskehak", true)
addEventHandler("donate:maskehak", getRootElement(), maske_no)