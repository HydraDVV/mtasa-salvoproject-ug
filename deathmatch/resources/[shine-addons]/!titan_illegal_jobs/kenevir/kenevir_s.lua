local kenevirbolge = createColSphere (-18.7841796875, -30.2978515625, 3.1171875, 15, 3, 81)  --ToplamaYeri
local paketlemebolge = createColSphere (95.3154296875, -164.658203125, 2.59375, 6, 3, 81) --PaketlemeYeri
local kenevirsatbolge = createColSphere (2457.7734375, -1968.1416015625, 13.510054588318, 4) --Satışyeri


function kenevirTopla(localPlayer, cmd)

   local theVehicle = getPedOccupiedVehicle (localPlayer)
   if theVehicle then
   outputChatBox("[!] #FFFFFFAraçtayken bu işlemi yapamazsınız.",localPlayer,255,0,0,true)
   return end -- burada bitti


    if getElementData(localPlayer, "kenevir:toplaniyor") then
	    outputChatBox("[SalvoMTA]: #FFFFFFHenüz kenevir toplama işlemini tamamlamadınız.",localPlayer,255,0,0,true)
    return end

	if not isElementWithinColShape(localPlayer, kenevirbolge) then
		outputChatBox("[SalvoMTA]: #FFFFFFKenevir toplama bölgesinde değilsiniz.",localPlayer,255,0,0,true)
	else
		if cmd == "kenevirtopla" then
		    setElementData(localPlayer, "kenevir:toplaniyor", true)
	        outputChatBox("[SalvoMTA]: #FFFFFFKenevir toplamaya başladınız.",localPlayer,255,0,0,true)
	        setElementFrozen( localPlayer, true )
	        exports.global:applyAnimation(localPlayer, "bomber", "bom_plant_loop", -1, true, false, false)
            setTimer(function()
            	exports.global:removeAnimation(localPlayer)		
                outputChatBox("[SalvoMTA]:#FFFFFFBaşarı ile 1 adet kenevir topladınız.",localPlayer,255,0,0,true)
                setElementFrozen( localPlayer, false )
                setElementData(localPlayer, "kenevir:toplaniyor", nil)
                exports["item-system"]:giveItem(localPlayer,38,1)
            end, 15000, 1)
        end
    end
end
addCommandHandler("kenevirtopla", kenevirTopla)

function kenevirPaketle(localPlayer, cmd)
	    if getElementData(localPlayer, "kenevir:paketleme") then
	    outputChatBox("[SalvoMTA]: #FFFFFFHenüz kenevir paketleme işlemini tamamlamadınız.",localPlayer,255,0,0,true)
    return end

	if not exports.global:hasItem(localPlayer,38) then 
		outputChatBox("[SalvoMTA]: #FFFFFFÜzerinizde paketlenecek kenevir bulunmamaktadır.",localPlayer,255,0,0,true)
    return end

	if not isElementWithinColShape(localPlayer, paketlemebolge) then
		outputChatBox("[SalvoMTA]: #FFFFFFKenevir paketleme bölgesinde değilsiniz.",localPlayer,255,0,0,true)
	else
        local theVehicle = getPedOccupiedVehicle (localPlayer)
        if theVehicle then
      outputChatBox("[!] #FFFFFFAraçtayken bu işlemi gerçekleştiremediniz.",localPlayer,255,0,0,true)
     return end

		    setElementData(localPlayer, "kenevir:paketleme", true)
	        outputChatBox("[SalvoMTA]: #FFFFFFKenevir paketlemeye başladınız.",localPlayer,255,0,0,true)
	        setElementFrozen( localPlayer, true )
	        exports.global:applyAnimation(localPlayer, "bomber", "bom_plant_loop", -1, true, false, false)
	        exports["item-system"]:takeItem(localPlayer,38,1)
            setTimer(function()
            	exports.global:removeAnimation(localPlayer)
                outputChatBox("[SalvoMTA]:#FFFFFFTebrikler başarılı bir şekilde 1 adet kenevir paketlediniz!",localPlayer,255,0,0,true)
                --outputChatBox("[SalvoMTA]:#FFFFFFPaketleme ücreti:1 adet paketlenmiş kenevir kazandınız!",localPlayer,255,0,0,true)
                setElementFrozen( localPlayer, false )
                setElementData(localPlayer, "kenevir:paketleme", nil)
				exports["item-system"]:giveItem(localPlayer,182,1)
            end, 3000, 1)
        end
    end
addCommandHandler("kenevirpaketle", kenevirPaketle)

function kenevirsat(localPlayer, cmd)
	if getElementData(localPlayer, "kenevir:paketleme") then
	outputChatBox("[SalvoMTA]: #FFFFFFHenüz kenevir satma işlemini tamamlamadınız.",localPlayer,255,0,0,true)
return end

if not exports.global:hasItem(localPlayer,182) then 
	outputChatBox("[SalvoMTA]: #FFFFFFÜzerinizde satılacak paketlenmiş kenevir bulunmamaktadır.",localPlayer,255,0,0,true)
return end

if not isElementWithinColShape(localPlayer, kenevirsatbolge) then
	outputChatBox("[SalvoMTA]: #FFFFFFSatma bölgesinde değilsiniz.",localPlayer,255,0,0,true)
else
	if cmd == "kenevirsat" then
		setElementData(localPlayer, "kenevir:paketleme", true)
		outputChatBox("[SalvoMTA]: #FFFFFFKenevir satılıyor..",localPlayer,255,0,0,true)
		setElementFrozen( localPlayer, true )
		exports.global:applyAnimation(localPlayer, "casino", "cards_loop", -1, true, false, false)
		exports["item-system"]:takeItem(localPlayer,182,1)
		setTimer(function()
			exports.global:removeAnimation(localPlayer)
			outputChatBox("[SalvoMTA]:#FFFFFFTebrikler 1 adet paketlenmiş kenevir Sattınız.",localPlayer,255,0,0,true)
			outputChatBox("[SalvoMTA]:#FFFFFFSattığın 1 adet paketlenmiş kenevirden 3,000TL Kazandın!",localPlayer,255,0,0,true)
			setElementFrozen( localPlayer, false )
			setElementData(localPlayer, "kenevir:paketleme", nil)
			exports.global:giveMoney(localPlayer,3000)
		end, 500, 1)
	end
end
end
addCommandHandler("kenevirsat", kenevirsat)

function kenevirYardim(localPlayer, cmd)
	if cmd == "keneviryardim" then
		outputChatBox("[SalvoMTA]:#FFFFFF/kenevirtopla --- Belirlenmiş alandan kenevir toplamanızı sağlar.",localPlayer,255,0,0,true)
		outputChatBox("[SalvoMTA]:#FFFFFF/kenevirpaketle --- Belirlenmiş alandan toplanan keneviri paketlemenizi sağlar.",localPlayer,255,0,0,true)
		outputChatBox("[SalvoMTA]:#FFFFFF/kenevirsat --- Belirlenmiş alandan toplanan keneviri satma işlemenizi sağlar.",localPlayer,255,0,0,true)
	end
end
addCommandHandler("keneviryardim", kenevirYardim)


print("Basarili bir sekilde sistem aktif edildi @ REMAJOR")
