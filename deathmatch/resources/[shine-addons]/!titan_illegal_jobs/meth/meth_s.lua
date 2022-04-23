--written by REMAJOR

local methbolge = createColSphere (1093.8095703125, -256.53515625, 74.652481079102, 18, 3, 81)  --ToplamaYeri
local paketlemebolge = createColSphere (113.1802578125, -154.103515625, 1.578125, 6, 3, 81)  --PaketlemeYeri
local methsatbolge = createColSphere (2442.51953125, -1966.4001800625, 13.546875, 4) --SatışYeri 


function methTopla(localPlayer, cmd)
	        local uye = #getPlayersInTeam(exports["faction-system"]:getTeamFromFactionID(1))
        local aktifPolis = 0 --Polis sayısı değiştire bilirsiniz.
        if uye >= aktifPolis then
        else
        outputChatBox("[!]#FFFFFF Meth toplamak için "..aktifPolis.." aktif polis olması gerek. ( Meth )",localPlayer,255,0,0,true) return end
 
   local theVehicle = getPedOccupiedVehicle (localPlayer)
if theVehicle then
outputChatBox("[!] #FFFFFFAraçtayken bu işlemi gerçekleştiremediniz.",localPlayer,255,0,0,true)
return end


    if getElementData(localPlayer, "meth:toplaniyor") then
	    outputChatBox("[SalvoMTA]: #FFFFFFHenüz meth toplama işlemini tamamlamadınız.",localPlayer,0,128,0,true)
    return end

	if not isElementWithinColShape(localPlayer, methbolge) then
		outputChatBox("[SalvoMTA]: #FFFFFFMeth toplama bölgesinde değilsiniz.",localPlayer,0,128,0,true)
	else
		if cmd == "methtopla" then
		    setElementData(localPlayer, "meth:toplaniyor", true)
	        outputChatBox("[SalvoMTA]: #FFFFFFMeth toplamaya başladınız.",localPlayer,0,128,0,true)
	        setElementFrozen( localPlayer, true )
	        exports.global:applyAnimation(localPlayer, "bomber", "bom_plant_loop", -1, true, false, false)
            setTimer(function()
            	exports.global:removeAnimation(localPlayer)		
                outputChatBox("[SalvoMTA]:#FFFFFFBaşarı ile 1 adet meth topladınız.",localPlayer,0,128,0,true)
                setElementFrozen( localPlayer, false )
                setElementData(localPlayer, "meth:toplaniyor", nil)
                exports["item-system"]:giveItem(localPlayer,586,1)
            end, 21000, 1) 
        end
    end
end
addCommandHandler("methtopla", methTopla)

function methPaketle(localPlayer, cmd)

		        local uye = #getPlayersInTeam(exports["faction-system"]:getTeamFromFactionID(1))
        local aktifPolis = 0 --Polis sayısı değiştire bilirsiniz.
        if uye >= aktifPolis then
        else
        outputChatBox("[!]#FFFFFF Meth toplamak için "..aktifPolis.." aktif polis olması gerek. ( Meth )",localPlayer,255,0,0,true) return end
 
   local theVehicle = getPedOccupiedVehicle (localPlayer)
if theVehicle then
outputChatBox("[!] #FFFFFFAraçtayken bu işlemi gerçekleştiremediniz.",localPlayer,255,0,0,true)
return end

	    if getElementData(localPlayer, "meth:paketleme") then
	    outputChatBox("[SalvoMTA]: #FFFFFFHenüz meth paketleme işlemini tamamlamadınız.",localPlayer,0,128,0,true)
    return end

	if not exports.global:hasItem(localPlayer,586) then 
		outputChatBox("[SalvoMTA]: #FFFFFFÜzerinizde paketlenecek meth bulunmamaktadır.",localPlayer,0,128,0,true)
    return end

	if not isElementWithinColShape(localPlayer, paketlemebolge) then
		outputChatBox("[SalvoMTA]: #FFFFFFMeth paketleme bölgesinde değilsiniz.",localPlayer,0,128,0,true)
	else
	    if cmd == "methpaketle" then
		    setElementData(localPlayer, "meth:paketleme", true)
	        outputChatBox("[SalvoMTA]: #FFFFFFMeth paketlemeye başladınız.",localPlayer,0,128,0,true)
	        setElementFrozen( localPlayer, true )
	        exports.global:applyAnimation(localPlayer, "bomber", "bom_plant_loop", -1, true, false, false)
	        exports["item-system"]:takeItem(localPlayer,586,1)
            setTimer(function()
            	exports.global:removeAnimation(localPlayer)
                outputChatBox("[SalvoMTA]:#FFFFFFTebrikler, başarı ile 1 adet meth paketlediniz!",localPlayer,0,128,0,true)
                outputChatBox("[SalvoMTA]:#FFFFFFİşleme ücreti:1 adet paketlenmiş meth kazandınız!",localPlayer,0,128,0,true)
                setElementFrozen( localPlayer, false )
                setElementData(localPlayer, "meth:paketleme", nil)
				exports["item-system"]:giveItem(localPlayer,31,1)
            end, 9000, 1)
        end
    end
end
addCommandHandler("methpaketle", methPaketle)

function methsat(localPlayer, cmd)
	if getElementData(localPlayer, "meth:paketleme") then
	outputChatBox("[SalvoMTA]: #FFFFFFHenüz meth satma işlemini tamamlamadınız.",localPlayer,0,128,0,true)
return end

if not exports.global:hasItem(localPlayer,31) then 
	outputChatBox("[SalvoMTA]: #FFFFFFÜzerinizde satılacak meth bulunmamaktadır.",localPlayer,0,128,0,true)
return end

if not isElementWithinColShape(localPlayer, methsatbolge) then
	outputChatBox("[SalvoMTA]: #FFFFFFSatma bölgesinde değilsiniz.",localPlayer,0,128,0,true)
else
	if cmd == "methsat" then
		setElementData(localPlayer, "meth:paketleme", true)
		outputChatBox("[SalvoMTA]: #FFFFFFMeth satılıyor..",localPlayer,0,128,0,true)
		setElementFrozen( localPlayer, true )
		exports.global:applyAnimation(localPlayer, "casino", "cards_loop", -1, true, false, false)
		exports["item-system"]:takeItem(localPlayer,31,1)
		setTimer(function()
			exports.global:removeAnimation(localPlayer)
			outputChatBox("[SalvoMTA]:#FFFFFFTebrikler 1 adet paketlenmiş meth sattınız.",localPlayer,0,128,0,true)
			outputChatBox("[SalvoMTA]:#FFFFFFSattığın 1 adet paketlenmiş methden 5,000₺ Kazandın!",localPlayer,0,128,0,true)
			setElementFrozen( localPlayer, false )
			setElementData(localPlayer, "meth:paketleme", nil)
			exports.global:giveMoney(localPlayer,5000)
		end, 500, 1)
	end
end
end
addCommandHandler("methsat", methsat)

function methYardim(localPlayer, cmd)
	if cmd == "methyardim" then
		outputChatBox("[SalvoMTA]:#FFFFFF/methtopla --- Belirlenmiş alandan meth toplamanızı sağlar.",localPlayer,0,128,0,true)
		outputChatBox("[SalvoMTA]:#FFFFFF/methpaketle --- Belirlenmiş alandan toplanan methi paketlemenizi sağlar.",localPlayer,0,128,0,true)
		outputChatBox("[SalvoMTA]:#FFFFFF/methsat --- Belirlenmiş alandan toplanan methi satma işlemenizi sağlar.",localPlayer,0,128,0,true)
	end
end
addCommandHandler("methyardim", methYardim)


print("Basarili bir sekilde sistem aktif edildi @ REMAJOR")
