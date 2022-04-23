-- ROTA --
local tupMarker = 0
local tupCreatedMarkers = {}
local tupRota = {
{ 2291.5146484375, -2069.701171875, 13.358852386475, false },
{ 2238.6015625, -2032.1767578125, 13.331240653992, false },
{ 2217.0390625, -1950.791015625, 13.341023445129, false },
{ 2220.4970703125, -1854.265625, 13.301344871521, false },
{ 2227.2421875, -1751.248046875, 13.365138053894, false },
{ 2300.0126953125, -1752.5654296875, 13.369558334351, true, false }, 
{ 2376.396484375, -1752.5283203125, 13.368167877197, false },
{ 2415.9638671875, -1742.9423828125, 13.371397018433, false },
{ 2433.5361328125, -1696.4716796875, 17.878812789917, false },
{ 2433.5869140625, -1608.1416015625, 26.349880218506, false },
{ 2433.66015625, -1515.1494140625, 23.816074371338, false },
{ 2434.427734375, -1461.861328125, 23.814708709717, true, false }, 
{ 2453.6494140625, -1430.5458984375, 23.804180145264, false },
{ 2453.7158203125, -1364.552734375, 23.815183639526, false },
{ 2454.0947265625, -1267.2861328125, 23.790893554688, false },
{ 2423.0302734375, -1253.748046875, 23.822540283203, false },
{ 2373.384765625, -1240.9736328125, 24.72013092041, false },
{ 2374.5732421875, -1197.36328125, 27.418174743652, true, false }, 
{ 2364.3759765625, -1151.27734375, 27.433811187744, false },
{ 2279.171875, -1146.0654296875, 26.714361190796, false },
{ 2197.2763671875, -1123.4169921875, 25.148485183716, false },
{ 2136.3466796875, -1111.7607421875, 25.22806930542, false },
{ 2079.2587890625, -1089.7626953125, 24.855350494385, true, false },
{ 2065.701171875, -1102.2939453125, 24.648544311523, false },
{ 2065.7880859375, -1211.4970703125, 23.800077438354, false },
{ 2065.236328125, -1300.1650390625, 23.799100875854, false },
{ 2101.9501953125, -1303.3994140625, 23.823312759399, false },
{ 2154.0673828125, -1303.244140625, 23.806427001953, false },
{ 2234, -1304.7421875, 23.835344314575, true, false },
{ 2268.41015625, -1313.16796875, 23.817543029785, false },
{ 2268.4384765625, -1355.7509765625, 23.826284408569, false },
{ 2257.783203125, -1381.9228515625, 23.830947875977, false },
{ 2213.6669921875, -1381.7060546875, 23.81297492981, false },
{ 2210.095703125, -1406.1728515625, 23.804779052734, false },
{ 2209.20703125, -1468.0712890625, 23.806427001953, true, false }, 
{ 2210.1728515625, -1551.970703125, 23.814971923828, false },
{ 2198.02734375, -1629.4423828125, 15.515309333801, false },
{ 2186.8896484375, -1674.90625, 14.20348072052, false },
{ 2182.4873046875, -1741.984375, 13.360718727112, false },
{ 2145.44921875, -1749.6376953125, 13.380972862244, false },
{ 2113.4609375, -1748.46484375, 13.39256477356, true, false }, 
{ 2086.3212890625, -1764.2919921875, 13.38459777832, false },
{ 2079.201171875, -1826.8232421875, 13.370002746582, false },
{ 2078.9423828125, -1881.4560546875, 13.324928283691, false },
{ 2096.25, -1896.7060546875, 13.360788345337, false },
{ 2147.58984375, -1898.3125, 13.323530197144, true, false }, 
{ 2208.6748046875, -1896.8408203125, 13.50318813324, false },
{ 2212.76953125, -1932.7099609375, 13.359375953674, false },
{ 2211.3466796875, -1998.9609375, 13.309868812561, false },
{ 2248.419921875, -2048.5634765625, 13.386811256409, false },
{ 2272.478515625, -2073.318359375, 13.362350463867, false },
{ 2294.876953125, -2072.90234375, 13.338593482971, false },
{ 2310.7919921875, -2072.4189453125, 13.538502693176, true, true } 
}

function tupBasla(cmd)
	if not getElementData(getLocalPlayer(), "tupSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 478
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "tupSoforlugu", true)
			updatetupRota()
			addEventHandler("onClientMarkerHit", resourceRoot, tupRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("tupbasla", tupBasla)

function updatetupRota()
	tupMarker = tupMarker + 1
	for i,v in ipairs(tupRota) do
		if i == tupMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(tupCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(tupCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(tupCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function tupRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 478 then
				for _, marker in ipairs(tupCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatetupRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							tupMarker = 0
							triggerServerEvent("tupParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFTüpler verildi, aracınız şuan da dolum yapıyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /tupbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlenmiştir, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatetupRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFTüpler veriliyor/alınıyor.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFTüpler verildi/alındı, bir sonraki rotadan devam edebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatetupRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function tupBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local tupSoforlugu = getElementData(getLocalPlayer(), "tupSoforlugu")
	if pedVeh then
		if pedVehModel == 478 then
			if tupSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "tupSoforlugu", false)
				for i,v in ipairs(tupCreatedMarkers) do
					destroyElement(v[1])
				end
				tupCreatedMarkers = {}
				tupMarker = 0
				triggerServerEvent("tupBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, tupRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), tupAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("tupbitir", tupBitir)

function tupAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 478 and vehicleJob == 7 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 7 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Tüp Dağıtım mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), tupAntiYabanci)

function tupAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			tupBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), tupAntiAracTerketme)