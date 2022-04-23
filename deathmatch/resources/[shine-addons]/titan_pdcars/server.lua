local araclar = {
--["isim"] = {modelid,vehlibid}
["suv"] = {598,1119},  ---1 araç 598 idsi,2. taraftaki numarayı elleme
["patrol"] = {599,1117},  ---2 araç 599 idsi,2. taraftaki numarayı elleme
['maverick'] = {601,1120},  ---3 araç 601 idsi,2. taraftaki numarayı elleme
['boxville'] = {490,1122}, ---4 araç 490 idsi,2. taraftaki numarayı elleme
['HPV1000'] = {523,11322}, ---5 araç 523 idsi,2. taraftaki numarayı elleme
['police'] = {497,11322},  ---6 araç 497 idsi,2. taraftaki numarayı elleme






}
local pdAlan = createColSphere(1595.6396484375, -1712.1455078125, 5.890625,4)
local pdAlan2 = createColSphere(1564.8037109375, -1712.1455078125, 5.890625,4)
local pdAlan3 = createColSphere(1564.6669921875, -1654.259765625, 28.395606994629,9)
local pedvehs = {}

function pdaraccikart(p, i)
if isElement(pedvehs[p]) then
outputChatBox("Zaten çıkartılmış bir aracın var! /aracteslim yazmadan yeni araç çıkartamazsın",p, 255, 0, 0,true)
return end
local x,y,z = 1591.2490234375, -1710.9140625, 5.890625
local deger = math.random(1,5)
if deger == 1 then
    x,y,z = 1591.2490234375, -1710.9140625, 5.890625
elseif deger == 2 then
    x,y,z = 1587.2490234375, -1710.9140625, 5.890625
elseif deger == 3 then
    x,y,z = 1583.2490234375, -1710.9140625, 5.890625
elseif deger == 4 then
    x,y,z = 1578.2490234375, -1710.9140625, 5.890625
elseif deger == 5 then
    x,y,z =  1574.2490234375, -1710.9140625, 5.890625
elseif deger == 6 then
    x,y,z =  1574.2490234375, -1710.9140625, 5.890625
end
if not i then
    outputChatBox("Kullanım : #FFFFFF/"..c.." [ suv / ]",p,255,0,0,true)
return end
if not getElementData(p,"faction") == 1 then
outputChatBox("Bu komutu kullanmak için kolluk kuvvetlerinde olmanız gerekmektedir",p,255,255,0,true)
return end

if i == "suv" then

local rx,ry,rz = 0, 0, 358.92056274414
pedvehs[p] = createVehicle(araclar["suv"][1],x-4,y,z+1,rx,ry,rz,"Polis #"..getElementData(p,"playerid"))
local vehShopData = araclar["suv"][1]
exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "dbid", getElementData(p, "dbid"), true)
exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "fuel", 100)
exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "plate", "İEM", true)
exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "Impounded", 0)
exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "engine", 0, false)
setElementData(pedvehs[p], "pdaraci",true)
setElementData(p, "arac:cikartti", true)
exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldx", x, false)
exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldy", y, false)
exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldz", z, false)
exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "faction", 1)
exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "owner", getElementData(p, "dbid"), false)
exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "job", 0, false)
exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "handbrake", 0, true)
exports.global:giveItem(p, 3, getElementData(p, "dbid"))
warpPedIntoVehicle(p, pedvehs[p], 0)
outputChatBox("Bir adet SUV araç çıkarttın , devriyen bittikten sonra /aracteslim yazarak aracı bırakabilirsin",p,0,255,0,true)
elseif i == "patrol" then

    local rx,ry,rz = 0, 0, 358.92056274414
    pedvehs[p] = createVehicle(araclar["patrol"][1],x-4,y,z+1,rx,ry,rz,"Polis #"..getElementData(p,"playerid"))
    local vehShopData = araclar["patrol"][1]
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "dbid", getElementData(p, "dbid"), true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "fuel",100)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "plate", "İEM", true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "Impounded", 0)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "engine", 0, false)
    setElementData(pedvehs[p], "pdaraci",true)
    setElementData(p, "arac:cikartti", true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldx", x, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldy", y, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldz", z, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "faction", 1)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "owner", getElementData(p, "dbid"), false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "job", 0, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "handbrake", 0, true)
    exports.global:giveItem(p, 3, getElementData(p, "dbid"))
    warpPedIntoVehicle(p, pedvehs[p], 0)

    outputChatBox("Bir adet Patrol araç çıkarttın , devriyen bittikten sonra /aracteslim yazarak aracı bırakabilirsin",p,0,255,0,true)


elseif i == "maverick" then

    local rx,ry,rz = 0, 0, 358.92056274414
    pedvehs[p] = createVehicle(araclar["maverick"][1],1601.8974609375, -1683.36328125, 5.890625+1,0, 0, 85.779815673828,"Polis #"..getElementData(p,"playerid"))
    local vehShopData = araclar["maverick"][1]
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "dbid", getElementData(p, "dbid"), true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "fuel",100)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "plate", "İEM", true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "Impounded", 0)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "engine", 0, false)
    setElementData(pedvehs[p], "pdaraci",true)
    setElementData(p, "arac:cikartti", true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldx", x, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldy", y, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldz", z, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "faction", 1)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "owner", getElementData(p, "dbid"), false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "job", 0, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "handbrake", 0, true)
    exports.global:giveItem(p, 3, getElementData(p, "dbid"))
    warpPedIntoVehicle(p, pedvehs[p], 0)
    outputChatBox("Bir adet Maverick araç çıkarttın , devriyen bittikten sonra /aracteslim yazarak aracı bırakabilirsin",p,0,255,0,true)
	
	
	elseif i == "boxville" then

    local rx,ry,rz = 0, 0, 358.92056274414
    pedvehs[p] = createVehicle(araclar["boxville"][1],1601.8974609375, -1683.36328125, 5.890625+1,0, 0, 85.779815673828,"Polis #"..getElementData(p,"playerid"))
    local vehShopData = araclar["boxville"][1]
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "dbid", getElementData(p, "dbid"), true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "fuel",100)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "plate", "İEM", true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "Impounded", 0)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "engine", 0, false)
    setElementData(pedvehs[p], "pdaraci",true)
    setElementData(p, "arac:cikartti", true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldx", x, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldy", y, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldz", z, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "faction", 1)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "owner", getElementData(p, "dbid"), false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "job", 0, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "handbrake", 0, true)
    exports.global:giveItem(p, 3, getElementData(p, "dbid"))
    warpPedIntoVehicle(p, pedvehs[p], 0)
    outputChatBox("Bir adet boxville araç çıkarttın , devriyen bittikten sonra /aracteslim yazarak aracı bırakabilirsin",p,0,255,0,true)

	elseif i == "HPV1000" then

    local rx,ry,rz = 0, 0, 358.92056274414
    pedvehs[p] = createVehicle(araclar["HPV1000"][1],x-4,y,z+1,rx,ry,rz,"Polis #"..getElementData(p,"playerid"))
    local vehShopData = araclar["HPV1000"][1]
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "dbid", getElementData(p, "dbid"), true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "fuel",100)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "plate", "İEM", true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "Impounded", 0)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "engine", 0, false)
    setElementData(pedvehs[p], "pdaraci",true)
    setElementData(p, "arac:cikartti", true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldx", x, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldy", y, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldz", z, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "faction", 1)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "owner", getElementData(p, "dbid"), false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "job", 0, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "handbrake", 0, true)
    exports.global:giveItem(p, 3, getElementData(p, "dbid"))
    warpPedIntoVehicle(p, pedvehs[p], 0)

    outputChatBox("Bir adet HPV1000 araç çıkarttın , devriyen bittikten sonra /aracteslim yazarak aracı bırakabilirsin",p,0,255,0,true)



    elseif i == "police" then

    local rx,ry,rz = 0, 0, 358.92056274414
    pedvehs[p] = createVehicle(araclar["police"][1],1563.185546875, -1657.123046875, 28.395606994629+1,0, 0, 85.779815673828,"Polis #"..getElementData(p,"playerid"))
    local vehShopData = araclar["police"][1]
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "dbid", getElementData(p, "dbid"), true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "fuel",100)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "plate", "İEM", true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "Impounded", 0)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "engine", 0, false)
    setElementData(pedvehs[p], "pdaraci",true)
    setElementData(p, "arac:cikartti", true)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldx", x, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldy", y, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "oldz", z, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "faction", 1)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "owner", getElementData(p, "dbid"), false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "job", 0, false)
    exports.anticheat:changeProtectedElementDataEx(pedvehs[p], "handbrake", 0, true)
    exports.global:giveItem(p, 3, getElementData(p, "dbid"))
    warpPedIntoVehicle(p, pedvehs[p], 0)
    outputChatBox("Bir adet police araç çıkarttın , devriyen bittikten sonra /aracteslim yazarak aracı bırakabilirsin",p,0,255,0,true)
	
    

end





   
end
addEvent("pdaraccikart", true)
addEventHandler("pdaraccikart", root, pdaraccikart)


	

addCommandHandler("aracteslim",function(hypnos,hypnoskomut)

if not getElementData(hypnos,"faction") == 1 then
outputChatBox("Bu komutu kullanmak için kolluk kuvvetlerinde olmanız gerekmektedir",p,255,255,0,true)
return end

if isElement(pedvehs[hypnos]) then
    destroyElement(pedvehs[hypnos])
    exports["item-system"]:deleteAll(3, getElementData(hypnos, "dbid"))
    setElementData(hypnos,"arac:cikartti",nil)
    outputChatBox("Devriye için aldığın aracı teslim ettin",hypnos,0,255,0,true)
else
    outputChatBox("Teslim edecek bir aracın yok sen nasıl memursun ?",p,255,255,0,true)

end
end)

addEventHandler("onPlayerQuit",root, 
function() 
if isElement(pedvehs[source]) then
setElementData(source, "arac:cikartti", false) 
exports["item-system"]:deleteAll(3, getElementData(source, "dbid")) 
destroyElement(pedvehs[source])
end
end)

addCommandHandler("resetdata",function(p,c)
    setElementData(p, "arac:cikartti", false) 
end)


addCommandHandler("faracyolla",
    function(player, cmd)
        if exports.vh_integration:isPlayerLeadAdmin(player) then
            local count = 0
            for index, vehicle in ipairs(exports.vh_global:getNearbyElements(player, "vehicle")) do
                if vehicle:getData("faction") ~= -1 and vehicle:getData("job") == 0 then
                    vehicle:setDimension(333)
                    count = count + 1
                end
            end
            outputChatBox("[-]#ffffff Toplamda "..count.." faction aracı gönderildi.", player, 30, 255, 10, true)
        end
    end
)
