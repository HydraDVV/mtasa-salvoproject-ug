-- ROTA --
local aractMarker = 0
local aractCreatedMarkers = {}
local aractRota = {
   {2639.640625, -2402.5849609375, 14.1069688797, false },
{2589.74609375, -2382.70703125, 14.084114074707, false },
{2506.4423828125, -2299.95703125, 25.055807113647, false },
{2403.33203125, -2196.35546875, 24.939302444458, false },
{2295.2548828125, -2088.5625, 13.972966194153, false },
{2230.4462890625, -2024.384765625, 13.982705116272, false },
{2217.5556640625, -1949.869140625, 13.97004699707, false },
{2219.9765625, -1845.2177734375, 13.861745834351, false },
{2217.9736328125, -1760.50390625, 14.008170127869, false },
{2227.7412109375, -1750.9326171875, 14.037614822388, false },
{2279.4384765625, -1750.451171875, 14.017683029175, false },
{2317.134765625, -1739.1181640625, 14.02091884613, false },
{2346.015625, -1734.9873046875, 14.014434814453, false },
{2469.3876953125, -1735.529296875, 14.015473365784, false },
{2626.1494140625, -1735.326171875, 11.749007225037, false },
{2645.0595703125, -1685.3037109375, 11.388957023621, false },
{2694.5966796875, -1659.537109375, 12.501710891724, false },
{2821.662109375, -1659.828125, 11.321441650391, false },
{2882.6630859375, -1630.2529296875, 11.510895729065, false },
{2919.29296875, -1497.904296875, 11.513378143311, false },
{2911.189453125, -1321.884765625, 11.508248329163, false },
{2886.4697265625, -1127.763671875, 11.508067131042, false },
{2887.9287109375, -976.732421875, 11.510882377625, false },
{2892.9140625, -747.7119140625, 11.468849182129, false },
{2850.166015625, -487.0517578125, 17.953699111938, false },
{2720.9609375, -339.337890625, 27.273860931396, false },
{2765.443359375, -120.1884765625, 35.160991668701, false },
{2772.888671875, 176.6943359375, 20.921573638916, false },
{2575.7158203125, 318.0380859375, 28.92989730835, false },
{2348.5615234375, 325.1435546875, 33.288875579834, false },
{2346.04296875, 324.9619140625, 33.266723632813, false },
{2112.83203125, 319.3515625, 34.733722686768, false },
{1761.35546875, 273.986328125, 19.107353210449, false },
{1623.5029296875, 309.7490234375, 21.703081130981, false },
{1620.3955078125, 376.2529296875, 29.072954177856, false },
{1657.9326171875, 319.541015625, 30.901510238647, false },
{1620.2294921875, 16.2763671875, 37.435691833496, false },
{1658.9716796875, -291.04296875, 40.582633972168, false },
{1701.216796875, -538.3310546875, 35.691764831543, false },
{1708.240234375, -576.3291015625, 37.614742279053, false },
{1726.771484375, -545.169921875, 36.059070587158, false },
{1714.44921875, -488.0498046875, 49.841068267822, false },
{1630.537109375, -469.4765625, 48.479961395264, false },
{1458.1611328125, -426.1748046875, 39.283779144287, false },
{1274.5390625, -567.548828125, 94.791625976563, false },
{1258.16015625, -614.1328125, 104.20086669922, false },
{1159.4794921875, -631.5556640625, 104.39191436768, false },
{1071.9736328125, -613.9970703125, 115.10569000244, false },
{932.892578125, -667.6552734375, 119.98641204834, false },
{775.576171875, -800.7353515625, 65.701110839844, false },
{583.4931640625, -901.712890625, 66.011260986328, false },
{389.5732421875, -1013.8740234375, 92.733047485352, false },
{271.076171875, -1114.3662109375, 80.132278442383, false },
{179.890625, -1183.8232421875, 53.917072296143, false },
{170.1630859375, -1184.38671875, 53.601463317871, false },
{229.67578125, -1068.7587890625, 61.193622589111, false },
{262.4287109375, -1008.0966796875, 54.932872772217, false },
{358.10546875, -793.470703125, 14.097590446472, false },
{414.81640625, -611.4609375, 34.657958984375, false },
{435.0791015625, -538.6943359375, 43.174301147461, false },
{474.53125, -398.6845703125, 28.328241348267, false },
{503.3876953125, -280.88671875, 40.766269683838, false },
{528.84375, -150.9072265625, 38.410037994385, false },
{533.4052734375, -4.45703125, 26.239597320557, false },
{521.3720703125, 171.33984375, 22.477712631226, false },
{506.748046875, 222.9873046875, 13.901837348938, false },
{461.6865234375, 193.130859375, 11.529725074768, false },
{343.037109375, 97.3212890625, 4.870288848877, false },
{143.1689453125, 79.421875, 2.7110908031464, false },
{-109.9189453125, 216.8076171875, 4.8810720443726, false },
{-204.6943359375, 226.4736328125, 12.595010757446, false },
{-273.8564453125, 68.685546875, 1.7113046646118, false },
{-295.564453125, -194.486328125, 1.7102904319763, false },
{-154.919921875, -353.685546875, 2.011812210083, false },
{-58.916015625, -351.017578125, 1.8384033441544, false },
{-27.9091796875, -316.2353515625, 5.7482924461365, false },
{-21.630859375, -276.73828125, 6.0636429786682,true, false }, -- TRUE
{-23.3935546875, -301.302734375, 6.0589632987976, false },
{-118.96875, -353.2333984375, 2.0636506080627, false },
{-157.3486328125, -356.0439453125, 1.8819979429245, false },
{-130.3623046875, -395.4736328125, 1.711106300354, false },
{31.9619140625, -520.640625, 10.846612930298, false },
{34.986328125, -634.80859375, 3.7448928356171, false },
{77.0380859375, -671.0693359375, 5.6897864341736, false },
{263.5966796875, -572.2177734375, 39.886241912842, false },
{408.8037109375, -595.1025390625, 36.859363555908, false },
{379.5693359375, -703.376953125, 22.808610916138, false },
{307.484375, -901.0078125, 20.993175506592, false },
{255.6318359375, -1020.9921875, 56.857345581055, false },
{295.9541015625, -1070.9619140625, 62.691379547119, false },
{368.3212890625, -1156.822265625, 78.787284851074, false },
{548.548828125, -1155.39453125, 54.8987159729, false },
{741.287109375, -960.6767578125, 54.910346984863, false },
{766.146484375, -931.1884765625, 56.736312866211, false },
{838.955078125, -881.2939453125, 68.083023071289, false },
{844.0087890625, -934.1103515625, 55.119529724121, false },
{921.03515625, -951.404296875, 40.58443069458, false },
{1012.68359375, -965.29296875, 42.489391326904, false },
{1129.28125, -952.369140625, 43.22465133667, false },
{1258.5576171875, -933.1328125, 43.146224975586, false },
{1381.68359375, -942.755859375, 34.845752716064, false },
{1666.0322265625, -979.919921875, 38.547729492188, false },
{1925.7265625, -1025.2666015625, 34.592166900635, false },
{2130.6181640625, -1087.9375, 24.802852630615, false },
{2264.470703125, -1147.3447265625, 27.41795539856, false },
{2374.576171875, -1155.9365234375, 28.090705871582, false },
{2691.009765625, -1156.0390625, 53.767398834229, false },
{2861.1103515625, -1141.4677734375, 11.632783889771, false },
{2895.3642578125, -1342.9423828125, 11.512974739075, false },
{2862.029296875, -1631.75, 11.507270812988, false },
{2826.662109375, -1883.556640625, 11.570604324341, false },
{2846.7099609375, -1890.4560546875, 11.564173698425, false },
{2857.5693359375, -1965.4248046875, 11.569952964783, false },
{2853.384765625, -2011.759765625, 11.646368980408, true, false }, -- TRUE
{2849.79296875, -2046.05078125, 11.559259414673, false },
{2796.05078125, -2120.0869140625, 11.565872192383, false },
{2410.3251953125, -2168.509765625, 14.00857257843, false },
{2280.189453125, -2277.0263671875, 14.008913993835, false },
{2305.3388671875, -2324.474609375, 14.016110420227, false },
{2422.1337890625, -2441.3427734375, 14.054684638977, false },
{2480.5849609375, -2422.814453125, 14.078515052795, false },
{2569.5615234375, -2400.0390625, 14.104342460632, false },
{2633.29296875, -2407.953125, 14.071042060852, false },
{2677.5927734375, -2408.1513671875, 14.097982406616, false },
{2705.623046875, -2410.4541015625, 14.162212371826, true, true} -- TRUE

}

function aractBasla(cmd)
	if not getElementData(getLocalPlayer(), "aractSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 443
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "aractSoforlugu", true)
			updatearactRota()
			addEventHandler("onClientMarkerHit", resourceRoot, aractRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("aractasimabasla", aractBasla)

function updatearactRota()
	aractMarker = aractMarker + 1
	for i,v in ipairs(aractRota) do
		if i == aractMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(aractCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(aractCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(aractCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function aractRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 443 then
				for _, marker in ipairs(aractCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatearactRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							aractMarker = 0
							triggerServerEvent("aractParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeni rotanız belirleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /aractasimabitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlendi, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatearactRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFYük arabaları teslim ediliyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYük arabaları teslim edilmiştir., geri dönebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatearactRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function aractBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local aractSoforlugu = getElementData(getLocalPlayer(), "aractSoforlugu")
	if pedVeh then
		if pedVehModel == 443 then
			if aractSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "aractSoforlugu", false)
				for i,v in ipairs(aractCreatedMarkers) do
					destroyElement(v[1])
				end
				aractCreatedMarkers = {}
				aractMarker = 0
				triggerServerEvent("aractBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, aractRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), aractAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("aractasimabitir", aractBitir)

function aractAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 443 and vehicleJob == 30 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 30 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için aract Mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), aractAntiYabanci)

function aractAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			aractBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), aractAntiAracTerketme)