-- ROTA --
local cayMarker = 0
local cayCreatedMarkers = {}
local cayRota = {
{ 701.466796875, -466.306640625, 16.327495574951, false },
{ 679.1162109375, -499.6416015625, 16.174673080444, false },
{ 679.1708984375, -548.6513671875, 16.173984527588, false },
{ 679.216796875, -617.44921875, 16.17246055603, false },
{ 679.1787109375, -712.599609375, 16.081058502197, false },
{ 683.3046875, -795.4296875, 35.118915557861, false },
{ 716.25, -875.357421875, 43.245952606201, false },
{ 776.00390625, -912.4287109375, 43.26012802124, false },
{ 793.5947265625, -973.3681640625, 36.42208480835, false },
{ 792.435546875, -1031.9384765625, 24.977781295776, false },
{ 811.4482421875, -1056.1748046875, 24.829223632813, true, false },
{ 861.52734375, -1017.314453125, 29.80001449585, false },
{ 902.974609375, -989.029296875, 37.381889343262, false },
{ 951.107421875, -977.046875, 38.72945022583, false },
{ 960.259765625, -991.4775390625, 37.548236846924, false },
{ 960.2705078125, -1044.1572265625, 30.065635681152, false },
{ 959.91796875, -1127.998046875, 23.657695770264, false },
{ 976.779296875, -1149.1865234375, 23.955425262451, false },
{ 1040.83984375, -1149.6220703125, 23.644149780273, false },
{ 1056.080078125, -1164.361328125, 23.788215637207, false },
{ 1056.0869140625, -1231.44140625, 16.708150863647, false },
{ 1050.0126953125, -1264.9375, 13.930575370789, true, false }, 
{ 1055.9833984375, -1306.8818359375, 13.425834655762, false },
{ 1056.130859375, -1342.3486328125, 13.366270065308, false },
{ 1056.0927734375, -1383.30078125, 13.486186027527, false },
{ 1059.966796875, -1427.52734375, 13.352869987488, false },
{ 1051.150390625, -1482.7041015625, 13.37265586853, false },
{ 1040.9306640625, -1521.1083984375, 13.363900184631, false },
{ 1035.044921875, -1559.9521484375, 13.348118782043, false },
{ 1053.326171875, -1574.556640625, 13.375303268433, false },
{ 1093.5224609375, -1574.8056640625, 13.359141349792, false },
{ 1170.8193359375, -1574.3837890625, 13.298168182373, false },
{ 1236.7216796875, -1574.5205078125, 13.366716384888, true, false }, 
{ 1286.1396484375, -1574.44140625, 13.376212120056, false },
{ 1295.22265625, -1627.7099609375, 13.369291305542, false },
{ 1294.91015625, -1680.1044921875, 13.369835853577, false },
{ 1295.0498046875, -1744.6416015625, 13.36935043335, false },
{ 1294.9765625, -1804.2119140625, 13.368156433105, false },
{ 1295.0478515625, -1841.669921875, 13.370336532593, false },
{ 1313.3037109375, -1854.927734375, 13.371866226196, false },
{ 1350.7177734375, -1865.2470703125, 13.36976146698, false },
{ 1409.6923828125, -1874.6005859375, 13.36997795105, false },
{ 1479.9384765625, -1874.6044921875, 13.366335868835, false },
{ 1569.53125, -1875.4814453125, 13.367408752441, true, false }, 
{ 1637.1103515625, -1874.8076171875, 13.36723613739, false },
{ 1690.275390625, -1849.8974609375, 13.371999740601, false },
{ 1705.546875, -1814.7724609375, 13.354347229004, false },
{ 1764.0859375, -1827.1318359375, 13.368534088135, false },
{ 1811.6201171875, -1834.921875, 13.388553619385, false },
{ 1819.201171875, -1870.7373046875, 13.397655487061, false },
{ 1819.345703125, -1926.8720703125, 13.363110542297, false },
{ 1868.8916015625, -1934.947265625, 13.370662689209, false },
{ 1921.4931640625, -1934.830078125, 13.369765281677, false },
{ 1951.5205078125, -1934.7080078125, 13.366317749023, false },
{ 1959.2001953125, -1968.9794921875, 13.452402114868, false },
{ 1959.201171875, -2020.25, 13.37175655365, false },
{ 1958.2001953125, -2067.2587890625, 13.374911308289, true, false }, 
{ 1958.8447265625, -2121.16796875, 13.374715805054, false },
{ 1958.9765625, -2156.71875, 13.366621017456, false },
{ 1982.3095703125, -2169.0185546875, 13.3665599823, false },
{ 2068.892578125, -2172.7138671875, 13.366860389709, false },
{ 2107.6416015625, -2192.2578125, 13.368704795837, false },
{ 2133.4892578125, -2216.5732421875, 13.372022628784, false },
{ 2116.9208984375, -2243.91796875, 13.37135887146, false },
{ 2098.384765625, -2288.1708984375, 13.367268562317, false },
{ 2109.6142578125, -2324.630859375, 13.370449066162, false },
{ 2147.822265625, -2339.45703125, 13.341267585754, false },
{ 2177.83984375, -2363.7998046875, 13.368359565735, false },
{ 2171.44921875, -2392.7587890625, 13.360960960388, false },
{ 2157.68359375, -2480.3115234375, 13.358598709106, false },
{ 2168.1630859375, -2497.3046875, 13.367866516113, false },
{ 2212.3671875, -2498.1005859375, 13.387567520142, false },
{ 2222.541015625, -2514.4013671875, 13.398564338684, false },
{ 2222.138671875, -2563.7119140625, 13.378539085388, false },
{ 2221.9560546875, -2623.9208984375, 13.366707801819, false },
{ 2250.1611328125, -2666.02734375, 13.405261039734, false },
{ 2319.3232421875, -2665.732421875, 13.493598937988, false },
{ 2405.263671875, -2665.9375, 13.507467269897, false },
{ 2477.3779296875, -2660.9931640625, 13.495090484619, false },
{ 2487.5185546875, -2614.12890625, 13.470475196838, false },
{ 2487.3017578125, -2553.9140625, 13.512144088745, false },
{ 2498.052734375, -2508.1259765625, 13.481067657471, false },
{ 2588.880859375, -2506.330078125, 13.476684570313, false },
{ 2672.3330078125, -2506.4423828125, 13.513640403748, false },
{ 2744.2685546875, -2506.46484375, 13.466498374939, false },
{ 2763.625, -2471.2314453125, 13.475073814392, false },
{2777.111328125, -2455.9072265625, 13.620677947998, true, true}
}

function cayBasla(cmd)
	if not getElementData(getLocalPlayer(), "caySoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 499
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "caySoforlugu", true)
			updatecayRota()
			addEventHandler("onClientMarkerHit", resourceRoot, cayRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("caybasla", cayBasla)

function updatecayRota()
	cayMarker = cayMarker + 1
	for i,v in ipairs(cayRota) do
		if i == cayMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(cayCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(cayCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(cayCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function cayRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 499 then
				for _, marker in ipairs(cayCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatecayRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							cayMarker = 0
							triggerServerEvent("cayParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYolcular inidiriliyor/bindiriliyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /cayibusbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlenmiştir, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatecayRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFÇaylar teslim ediliyor, lütfen bekleyin.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFkaçak Çaylar teslim edili, bir sonraki rotadan devam edebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatecayRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function cayBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local caySoforlugu = getElementData(getLocalPlayer(), "caySoforlugu")
	if pedVeh then
		if pedVehModel == 499 then
			if caySoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "caySoforlugu", false)
				for i,v in ipairs(cayCreatedMarkers) do
					destroyElement(v[1])
				end
				cayCreatedMarkers = {}
				cayMarker = 0
				triggerServerEvent("cayBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, cayRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), cayAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("caybitir", cayBitir)

function cayAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 499 and vehicleJob == 8 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 8 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için cayibüs mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), cayAntiYabanci)

function cayAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			cayBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), cayAntiAracTerketme)