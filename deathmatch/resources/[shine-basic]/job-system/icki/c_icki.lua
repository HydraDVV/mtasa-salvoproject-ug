local ickiPed = createPed(16, 2224.0966796875, -2214.55078125, 13.546875)
setPedRotation( ickiPed, 220)
setElementDimension(ickiPed, 0)
setElementInterior(ickiPed, 0)
setElementData(ickiPed, "talk", 1)
setElementData(ickiPed, "name", "Muzaffer Sarı")
setElementFrozen(ickiPed, true)
local levelEksikMsg = {
	"Şu sıralar pek iş yok, adamım.",
	"İşler biraz kötü, sonra gel."
}

local kabulEtMsg = {
	"Bana uyar, ahbap.",
	"Huh, güzel teklif.",
	"Ne zaman başlıyorum?",
}

local kabulEtmeMsg = {
	"İşim olmaz, adamım.",
	"Daha önemli işlerim var.",
	"Meşgulüm, ahbap.",
}

function ickiGUI(thePlayer)
	local oyuncuBirlik = getPlayerTeam(thePlayer)
	local birlikTip = getElementData(oyuncuBirlik, "type")

	if (birlikTip == 0) or (birlikTip == 1) then
		triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[English] Muzaffer Sarı fısıldar: Hey, elimde bir içki kaçakçılığı işi var. Ne dersin, ha?", 255, 255, 255, 3, {}, true)
		ickiKabulGUI(thePlayer)
		return
	else
        triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[English] Muzaffer Sarı diyor ki: Seninle bir işim yok. Derhal toz ol buradan.", 255, 255, 255, 10, {}, true)
		return	
	end
end
addEvent("ickiGUI", true)
addEventHandler("ickiGUI", getRootElement(), ickiGUI)

function ickiKabulGUI(thePlayer)
	local screenW, screenH = guiGetScreenSize()
	local kacakcilikWindow = guiCreateWindow((screenW - 308) / 2, (screenH - 102) / 2, 308, 102, "SalvoMTA - İçki Kaçakçılığı © REMAJOR", false)
	guiWindowSetSizable(kacakcilikWindow, false)

	local isLbl = guiCreateLabel(9, 26, 289, 19, "İşi kabul ediyor musun?", false, kacakcilikWindow)
	guiLabelSetHorizontalAlign(isLbl, "center", false)
	guiLabelSetVerticalAlign(isLbl, "center")
	
	local ickiKabulBtn = guiCreateButton(9, 55, 142, 33, "Kabul Et", false, kacakcilikWindow)
	addEventHandler("onClientGUIClick", ickiKabulBtn, 
		function()
			destroyElement(kacakcilikWindow)
			triggerServerEvent("acceptJob", getLocalPlayer(), 19)
			triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[English] " .. getPlayerName(thePlayer):gsub("_", " ") .. " diyor ki: " .. kabulEtMsg[math.random(#kabulEtMsg)], 255, 255, 255, 3, {}, true)
			triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[English] Muzaffer Sarı diyor ki: Yandaki kamyonlardan birini alarak işe başla, kamyonlar yüklü ve yola çıkmaya hazır. Bol şanslar, ahbap.", 255, 255, 255, 3, {}, true)
			setTimer(function() outputChatBox("[!] #FFFFFFYandaki beyaz kamyonlardan birini alıp, /ickibasla yazarak işe başlayabilirsiniz!", 0, 0, 255, true) end, 500, 1)
			return	
		end
	)
	
	local line = guiCreateLabel(9, 32, 289, 19, "____________________________________________________", false, kacakcilikWindow)
	guiLabelSetHorizontalAlign(line, "center", false)
	guiLabelSetVerticalAlign(line, "center")
	local ickiIptalBtn = guiCreateButton(159, 55, 139, 33, "İptal Et", false, kacakcilikWindow)
	addEventHandler("onClientGUIClick", ickiIptalBtn, 
		function()
			destroyElement(kacakcilikWindow)
			triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[English] " .. getPlayerName(thePlayer):gsub("_", " ") .. " diyor ki: " .. kabulEtmeMsg[math.random(#kabulEtmeMsg)], 255, 255, 255, 3, {}, true)
			return	
		end
	)
end

-- ROTA --
local ickiMarker = 0
local ickiCreatedMarkers = {}
local ickiRota = {
{ 2233.84375, -2219.2919921875, 13.481475830078, false },
{ 2252.5009765625, -2222.228515625, 13.25538444519, false },
{ 2283.783203125, -2254.0654296875, 13.289608001709, false },
{ 2263.8359375, -2286.7900390625, 13.310048103333, false },
{ 2197.1669921875, -2353.4072265625, 13.309619903564, false },
{ 2161.1640625, -2423.8291015625, 13.309334754944, false },
{ 2157.5966796875, -2533.98828125, 13.310211181641, false },
{ 2149.462890625, -2608.8486328125, 13.317129135132, false },
{ 2079.3251953125, -2665.3759765625, 13.31316280365, false },
{ 1925.5107421875, -2667.7197265625, 5.884955406189, false },
{ 1614.544921875, -2667.3564453125, 5.8138194084167, false },
{ 1436.806640625, -2667.109375, 13.308588027954, false },
{ 1364.53515625, -2622.4521484375, 13.310445785522, false },
{ 1349.3056640625, -2509.712890625, 13.310178756714, false },
{ 1348.37109375, -2404.1865234375, 13.310532569885, false },
{ 1349.099609375, -2269.970703125, 13.321577072144, false },
{ 1357.8876953125, -2192.3154296875, 13.318091392517, false },
{ 1403.7314453125, -2144.603515625, 13.318054199219, false },
{ 1499.1787109375, -2134.6337890625, 13.704850196838, false },
{ 1611.6083984375, -2098.466796875, 18.874130249023, false },
{ 1670.8837890625, -1998.7392578125, 23.449100494385, false },
{ 1648.728515625, -1884.6708984375, 24.957847595215, false },
{ 1622.2626953125, -1765.720703125, 27.396520614624, false },
{ 1614.1337890625, -1641.2158203125, 28.522010803223, false },
{ 1613.8369140625, -1539.11328125, 28.52134513855, false },
{ 1613.24609375, -1426.8837890625, 28.520751953125, false },
{ 1621.12109375, -1326, 32.768089294434, false },
{ 1634.9033203125, -1234.28515625, 49.936637878418, false },
{ 1650.140625, -1122.45703125, 58.802181243896, false },
{ 1665.7900390625, -1017.626953125, 62.379333496094, false },
{ 1685.8857421875, -889.3671875, 60.939167022705, false },
{ 1704.6796875, -764.34375, 52.726043701172, false },
{ 1720.2568359375, -630.939453125, 40.441230773926, false },
{ 1720.037109375, -547.1064453125, 35.397590637207, false },
{ 1688.7958984375, -376.23046875, 40.807144165039, false },
{ 1680.1123046875, -224.8037109375, 41.694137573242, false },
{ 1667.1298828125, -58.5146484375, 36.052764892578, false },
{ 1621.9189453125, 54.6904296875, 37.099632263184, false },
{ 1637.041015625, 169.869140625, 34.024036407471, false },
{ 1665.1787109375, 278.84375, 29.98858833313, false },
{ 1706.734375, 395.640625, 30.311624526978, false },
{ 1748.9541015625, 516.412109375, 28.028085708618, false },
{ 1786.08203125, 638.4912109375, 19.313724517822, false },
{ 1804.7978515625, 743.619140625, 12.919249534607, false },
{ 1809.8662109375, 821.9521484375, 10.637502670288, false },
{ 1825.74609375, 831.337890625, 10.336122512817, false },
{ 1925.185546875, 831.380859375, 7.0738263130188, false },
{ 2008.74609375, 831.056640625, 6.6693434715271, false },
{ 2129.4326171875, 831.2490234375, 6.6688313484192, false },
{ 2172.451171875, 816.2646484375, 6.6161375045776, false },
{ 2224.462890625, 781.1044921875, 9.5233669281006, false },
{ 2274.1201171875, 760.3525390625, 10.574910163879, false },
{ 2285.388671875, 750.736328125, 10.599341392517, false },
{ 2284.6474609375, 725.3583984375, 10.607054710388, false },
{ 2298.78125, 709.947265625, 10.607236862183, false },
{ 2414.38671875, 711.0380859375, 10.606852531433, false },
{ 2429.5810546875, 724.1552734375, 10.617017745972, false },
{ 2432.451171875, 767.705078125, 10.607353210449, false },
{ 2504.8037109375, 771.048828125, 10.767023086548, false },
{ 2608.83203125, 770.767578125, 10.607217788696, false },
{ 2685.4228515625, 770.765625, 10.7807264328, false },
{ 2725.2890625, 774.6396484375, 10.685346603394, false },
{ 2729.2861328125, 831.8203125, 10.685959815979, false },
{ 2733.416015625, 909.37109375, 10.684990882874, false },
{ 2766.599609375, 911.3798828125, 11.028532028198, false },
{ 2811.728515625, 910.892578125, 10.684874534607, false },
{ 2839.3974609375, 896.6728515625, 10.690228462219, true, false },
{ 2826.1572265625, 917.3505859375, 10.686092376709, false },
{ 2767.7529296875, 915.6640625, 11.029197692871, false },
{ 2730.1416015625, 913.0810546875, 10.688311576843, false },
{ 2725.1123046875, 866.314453125, 10.6858959198, false },
{ 2722.794921875, 778.75390625, 10.684096336365, false },
{ 2628.677734375, 775.896484375, 10.605595588684, false },
{ 2538.4453125, 775.6259765625, 10.638253211975, false },
{ 2431.25390625, 773.705078125, 10.613028526306, false },
{ 2425.046875, 725.6083984375, 10.614416122437, false },
{ 2414.6171875, 716.1923828125, 10.611204147339, false },
{ 2301.044921875, 715.9267578125, 10.606689453125, false },
{ 2289.447265625, 725.2919921875, 10.610293388367, false },
{ 2289.693359375, 750.1181640625, 10.605278015137, false },
{ 2289.7158203125, 775.0810546875, 10.601188659668, false },
{ 2289.810546875, 830.2705078125, 13.572403907776, false },
{ 2290.0087890625, 909.970703125, 10.594088554382, false },
{ 2274.505859375, 926.62109375, 10.571757316589, false },
{ 2197.7353515625, 885.6162109375, 7.7489829063416, false },
{ 2145.279296875, 860.19140625, 6.6695189476013, false },
{ 2089.429687, 855.4638671875, 6.6697950363159, false },
{ 2013.80859375, 854.7421875, 6.6699495315552, false },
{ 1950.6083984375, 854.658203125, 6.668637752533, false },
{ 1821.423828125, 854.48046875, 10.478105545044, false },
{ 1786.9404296875, 844.0947265625, 10.574596405029, false },
{ 1785.3779296875, 820.72265625, 10.642092704773, false },
{ 1775.9150390625, 706.4599609375, 14.998017311096, false },
{ 1748.2294921875, 589.9453125, 23.500032424927, false },
{ 1700.048828125, 447.689453125, 30.866390228271, false },
{ 1651.8642578125, 303.474609375, 30.212326049805, false },
{ 1629.7939453125, 225.2216796875, 30.733856201172, false },
{ 1599.7587890625, 97.0068359375, 37.595638275146, false },
{ 1611.20703125, 20.2236328125, 36.836585998535, false },
{ 1653.3203125, -93.3564453125, 35.443061828613, false },
{ 1655.794921875, -192.212890625, 35.75366973877, false },
{ 1659.6416015625, -322.17578125, 40.234672546387, false },
{ 1676.4501953125, -415.5546875, 33.755424499512, false },
{ 1701.4228515625, -590.5830078125, 37.739517211914, false },
{ 1692.953125, -696.4794921875, 46.404933929443, false },
{ 1660.955078125, -901.5966796875, 61.395984649658, false },
{ 1628.845703125, -1110.3818359375, 59.093097686768, false },
{ 1612.8232421875, -1228.4287109375, 50.40096282959, false },
{ 1592.92578125, -1350.486328125, 29.508104324341, false },
{ 1590.74609375, -1442.771484375, 28.512287139893, false },
{ 1590.47265625, -1638.1533203125, 28.520833969116, false },
{ 1594.85546875, -1727.697265625, 27.945085525513, false },
{ 1631.3974609375, -1900.19140625, 24.851400375366, false },
{ 1650.06640625, -1970.4521484375, 23.619260787964, false },
{ 1633.16015625, -2048.736328125, 21.302293777466, false },
{ 1553.1455078125, -2106.3701171875, 15.453705787659, false },
{ 1426.255859375, -2116.8583984375, 13.32557964325, false },
{ 1335.380859375, -2195.24609375, 13.319958686829, false },
{ 1329.4365234375, -2334.4150390625, 13.31812286377, false },
{ 1329.796875, -2436.4033203125, 13.310972213745, false },
{ 1330.5478515625, -2584.048828125, 13.317442893982, false },
{ 1370.09765625, -2659.779296875, 13.317261695862, false },
{ 1610.810546875, -2687.7412109375, 5.8215756416321, false },
{ 1842.130859375, -2687.626953125, 5.8013052940369, false },
{ 1924.92578125, -2687.8984375, 5.8823046684265, false },
{ 2064.908203125, -2687.095703125, 13.31924533844, false },
{ 2144.416015625, -2652.1640625, 13.315614700317, false },
{ 2177.4892578125, -2537.13671875, 13.313656806946, false },
{ 2177.3837890625, -2463.470703125, 13.310579299927, false },
{ 2199.18359375, -2382.572265625, 13.311345100403, false },
{ 2270.1787109375, -2308.005859375, 13.310154914856, false },
{ 2296.1123046875, -2282.8662109375, 13.309512138367, false },
{ 2300.4853515625, -2265.3798828125, 13.311322212219, false },
{ 2277.6328125, -2240.9033203125, 13.700066566467, false },
{ 2248.71875, -2212.05859375, 13.260064125061, false },
{ 2231.109375, -2216.025390625, 13.480456352234, false },
{ 2215.1396484375, -2228.1416015625, 13.481357574463, false },
{ 2192.9765625, -2214.7197265625, 13.481896400452, true, true}

}


function ickiBasla(cmd)
	if not getElementData(getLocalPlayer(), "ickiKacakciligi") then
		local oyuncuBirlik = getPlayerTeam(getLocalPlayer())
		local oyuncuBirlikType = getElementData(oyuncuBirlik, "type")
		local oyuncuBirlikLevel = getElementData(oyuncuBirlik, "birlik_level")
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 483
		if not getVehicleOccupant(oyuncuArac, 1) then
		--if (oyuncuBirlikType == 0) or (oyuncuBirlikType == 1) and (oyuncuBirlikLevel >= 3) then
			if oyuncuAracModel == kacakciAracModel then
				setElementData(getLocalPlayer(), "ickiKacakciligi", true)
				updateIckiRota()
				addEventHandler("onClientMarkerHit", resourceRoot, ickiRotaMarkerHit)
			end
		--end
		else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
		end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("ickibasla", ickiBasla)

function updateIckiRota()
	ickiMarker = ickiMarker + 1
	for i,v in ipairs(ickiRota) do
		if i == ickiMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(ickiCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(ickiCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(ickiCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function ickiRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 483 then
				for _, marker in ipairs(ickiCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updateIckiRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							ickiMarker = 0
							triggerServerEvent("ickiParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFAracınıza yeni mallar yükleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /ickibitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFAracınıza yeni mallar yüklenmiştir. Gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateIckiRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							outputChatBox("[!] #FFFFFFAracınızdaki mallar indiriliyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFAracınızdaki mallar indirilmiştir, geri dönebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									updateIckiRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function ickiBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local ickiKacakciligi = getElementData(getLocalPlayer(), "ickiKacakciligi")
	if pedVeh then
		if pedVehModel == 483 then
			if ickiKacakciligi then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "ickiKacakciligi", false)
				for i,v in ipairs(ickiCreatedMarkers) do
					destroyElement(v[1])
				end
				ickiCreatedMarkers = {}
				ickiMarker = 0
				triggerServerEvent("ickiBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, ickiRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), ickiAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("ickibitir", ickiBitir)

function ickiAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 483 and vehicleJob == 19 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 19 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için icki Kaçakçılığı mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), ickiAntiYabanci)

function ickiAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			ickiBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), ickiAntiAracTerketme)