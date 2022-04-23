-- ROTA --
local tirMarker = 0
local tirCreatedMarkers = {}
local tirRota = {
{2587.0322265625, -2223.5830078125, 13.609477996826, false },
{2499.896484375, -2223.8017578125, 13.622403144836, false },
{2390.65234375, -2266.6552734375, 13.688282966614, false },
{2317.203125, -2329.212890625, 13.694186210632, false },
{2290.943359375, -2279.693359375, 13.671246528625, false },
{2289.255859375, -2251.9345703125, 13.662899017334, false },
{2234.615234375, -2197.134765625, 13.628485679626, false },
{2186.6396484375, -2173.302734375, 13.68141746521, false },
{2135.138671875, -2212.171875, 13.678994178772, false },
{2068.6201171875, -2167.451171875, 13.67590045929, false },
{1977.865234375, -2164.1640625, 13.6745262146, false },
{1851.8798828125, -2163.802734375, 13.682804107666, false },
{1736.3525390625, -2163.857421875, 13.895768165588, false },
{1600.6630859375, -2139.181640625, 29.045291900635, false },
{1532.6220703125, -1942.0732421875, 18.497507095337, false },
{1521.1904296875, -1870.0908203125, 13.668992042542, false },
{1454.7607421875, -1869.990234375, 13.689035415649, false },
{1378.31640625, -1869.8173828125, 13.684139251709, false },
{1287.724609375, -1850.0185546875, 13.686882019043, false },
{1200.8173828125, -1850.013671875, 13.687622070313, false },
{1085.89453125, -1850.46484375, 13.688717842102, false },
{1061.333984375, -1836.0419921875, 13.808574676514, false },
{1003.923828125, -1787.98046875, 14.338054656982, false },
{896.5693359375, -1769.0283203125, 13.68164730072, false },
{777.88671875, -1765.4580078125, 13.278561592102, false },
{671.4921875, -1737.3955078125, 13.749550819397, false },
{552.0869140625, -1716.26953125, 13.355233192444, false },
{417.5517578125, -1699.59765625, 9.7308549880981, false },
{287.033203125, -1687.8642578125, 7.7700967788696, false },
{184.673828125, -1591.8818359375, 14.145725250244, false },
{124.7392578125, -1537.4248046875, 8.256555557251, false },
{9.6455078125, -1519.0419921875, 3.813996553421, false },
{-94.6181640625, -1493.2021484375, 2.9928617477417, false },
{-149.5703125, -1366.326171875, 2.9943282604218, false },
{-118.7548828125, -1184.25, 2.9953632354736, false },
{-84.3671875, -1039.529296875, 23.342485427856, false },
{-163.26171875, -950.197265625, 30.820878982544, false },
{-256.224609375, -890.5947265625, 44.743927001953, false },
{-284.0029296875, -846.3623046875, 45.680938720703, false },
{-326.8203125, -784.6005859375, 33.367630004883, false },
{-350.337890625, -769.62890625, 30.254590988159, false },
{-378.998046875, -700.98828125, 21.654588699341, false },
{-427.4931640625, -633.0888671875, 11.915607452393, false },
{-472.4462890625, -611.9580078125, 17.363780975342, false },
{-506.85546875, -551.2607421875, 25.821943283081, false },
{-539.9501953125, -557.01953125, 25.821073532104, false },
{-574.58203125, -546.0068359375, 25.829126358032, true, false },  ---SARI
{-560.3505859375, -556.31640625, 25.819036483765, false },
{-494.9814453125, -558.3251953125, 25.821159362793, false },
{-473.314453125, -619.3876953125, 17.340976715088, false },
{-417.662109375, -639.6650390625, 12.264544487, false },
{-385.3544921875, -699.837890625, 21.092985153198, false },
{-355.7607421875, -763.9140625, 30.013555526733, false },
{-340.6826171875, -786.791015625, 31.802272796631, false },
{-289.2421875, -817.2197265625, 41.450332641602, false },
{-293.9052734375, -879.658203125, 46.733425140381, false },
{-220.5966796875, -918.1435546875, 40.316173553467, false },
{-115.6611328125, -1000.3017578125, 25.165920257568, false },
{-82.9228515625, -1069.6650390625, 14.813026428223, false },
{-117.451171875, -1166.16796875, 2.8807780742645, false },
{-151.61328125, -1309.2431640625, 2.9939730167389, false },
{-135.6142578125, -1452.8984375, 2.9942283630371, false },
{-8.45703125, -1523.025390625, 2.6375925540924, false },
{97.4375, -1547.865234375, 6.5951762199402, false },
{153.44140625, -1586.5224609375, 12.782354354858, false },
{277.298828125, -1704.9033203125, 7.893810749054, false },
{473.9375, -1726.0458984375, 11.094841003418, false },
{597.3837890625, -1742.6748046875, 13.534262657166, false },
{767.205078125, -1785.36328125, 13.186971664429, false },
{1001.720703125, -1808.6279296875, 14.340878486633, false },
{1053.1748046875, -1854.466796875, 13.787404060364, false },
{1142.6416015625, -1855.125, 13.686294555664, false },
{1252.310546875, -1855.1435546875, 13.685122489929, false },
{1351.470703125, -1865.6953125, 13.685303688049, false },
{1449.8154296875, -1874.7734375, 13.686864852905, false },
{1527.6748046875, -1878.400390625, 13.69757938385, false },
{1527.416015625, -1940.6162109375, 18.305425643921, false },
{1546.240234375, -2088.138671875, 34.271926879883, false },
{1707.40234375, -2169.0478515625, 15.455941200256, false },
{1852.505859375, -2169.5078125, 13.680750846863, false },
{1945.60546875, -2169.2578125, 13.685888290405, false },
{2086.1962890625, -2179.2421875, 13.678719520569, false },
{2130.435546875, -2213.3916015625, 13.689903259277, false },
{2158.8544921875, -2208.8115234375, 13.699426651001, false },
{2189.9091796875, -2176.994140625, 13.684096336365, false },
{2208.0927734375, -2177.4208984375, 13.67483997345, false },
{2258.3740234375, -2228, 13.609919548035, false },
{2284.4658203125, -2265.80859375, 13.685269355774, false },
{2277.4033203125, -2297.2294921875, 13.675213813782, false },
{2307.6240234375, -2327.939453125, 13.687047958374, false },
{2339.1748046875, -2325.716796875, 13.696888923645, false },
{2425.4365234375, -2239.8798828125, 13.616642951965, false },
{2549.0673828125, -2229.7099609375, 13.624066352844, false },
{2617.3876953125, -2209.8701171875, 13.847336769104, true, true }
}

function tirBasla(cmd)
	if not getElementData(getLocalPlayer(), "tirSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 515
	if not getVehicleOccupant(oyuncuArac, 1) and not getVehicleOccupant(oyuncuArac, 2) and not getVehicleOccupant(oyuncuArac, 3) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "tirSoforlugu", true)
			updatetirRota()
			addEventHandler("onClientMarkerHit", resourceRoot, tirRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("tirbasla", tirBasla)

function updatetirRota()
	tirMarker = tirMarker + 1
	for i,v in ipairs(tirRota) do
		if i == tirMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(tirCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(tirCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(tirCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function tirRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 515 then
				for _, marker in ipairs(tirCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatetirRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							tirMarker = 0
							triggerServerEvent("tirParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeni rotanız belirleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /siparisbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlendi, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatetirRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFArabanızdaki tirler sahiplerine teslim ediliyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFArabanızdaki tirler teslim edilmiştir., geri dönebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatetirRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function tirBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local tirSoforlugu = getElementData(getLocalPlayer(), "tirSoforlugu")
	if pedVeh then
		if pedVehModel == 515 then
			if tirSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "tirSoforlugu", false)
				for i,v in ipairs(tirCreatedMarkers) do
					destroyElement(v[1])
				end
				tirCreatedMarkers = {}
				tirMarker = 0
				triggerServerEvent("tirBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, tirRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), tirAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("tirbitir", tirBitir)

function tirAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 515 and vehicleJob == 32 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 32 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için tir Mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), tirAntiYabanci)

function tirAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			tirBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), tirAntiAracTerketme)