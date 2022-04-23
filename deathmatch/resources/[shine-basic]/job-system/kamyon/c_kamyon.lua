-- ROTA --
local KamyonMarker = 0
local KamyonCreatedMarkers = {}
local KamyonRota = {
{2228.4873046875, -2626.9404296875, 13.42059135437, false },
{2228.5791015625, -2568.6279296875, 13.404233932495, false },
{2228.521484375, -2520.220703125, 13.367550849915, false },
{2219.4052734375, -2494.7392578125, 13.410853385925, false },
{2188.998046875, -2492.935546875, 13.400792121887, false },
{2176.390625, -2483.6708984375, 13.380116462708, false },
{2186.33984375, -2408.435546875, 13.370976448059, false },
{2289.8623046875, -2287.845703125, 13.399119377136, false },
{2361.08203125, -2217.2841796875, 13.383327484131, false },
{2442.2138671875, -2176.189453125, 13.379060745239, false },
{2576.0830078125, -2173.2958984375, 12.86089515686, false },
{2736.3427734375, -2171.703125, 10.934186935425, false },
{2828.462890625, -2103.8369140625, 10.946055412292, false },
{2840.4296875, -1951.44921875, 10.947783470154, false },
{2859.9765625, -1734.5625, 10.891724586487, false },
{2902.1552734375, -1587.5361328125, 10.875522613525, false },
{2927.837890625, -1400.5810546875, 10.875031471252, false },
{2894.345703125, -1185.8115234375, 10.878364562988, false },
{2898.123046875, -719.345703125, 10.842885971069, false },
{2885.9375, -543.3916015625, 13.055445671082, false },
{2761.6591796875, -380.2490234375, 24.342378616333, false },
{2734.501953125, -233.9560546875, 28.772264480591, false },
{2774.2666015625, 7.818359375, 34.504383087158, false },
{2776.8330078125, 187.9267578125, 20.267040252686, false },
{2643.802734375, 330.9912109375, 23.297853469849, false },
{2472.6279296875, 325.5390625, 31.450458526611, false },
{2289.2607421875, 338.0966796875, 32.69921875, false },
{2310.3642578125, 402.115234375, 28.360486984253, false },
{2341.9150390625, 330.55078125, 26.358953475952, false },
{2341.2919921875, 257.021484375, 26.334421157837, false },
{2329.94921875, 216.1904296875, 26.330675125122, false },
{2256.1328125, 217.8056640625, 17.032691955566, false },
{2119.876953125, 249.6875, 15.989776611328, false },
{2040.7890625, 289.55078125, 25.939258575439, false },
{1956.39453125, 355.9375, 22.274482727051, false },
{1776.3515625, 388.3916015625, 19.216665267944, false },
{1593.5576171875, 386.212890625, 19.888401031494, false },
{1434.3203125, 421.595703125, 19.893941879272, false },
{1322.728515625, 475.6796875, 19.878765106201, false },
{1138.7822265625, 567.9248046875, 19.88787651062, false },
{1026.279296875, 496.2001953125, 19.886154174805, false },
{933.00390625, 377.5107421875, 19.890092849731, false },
{709.74609375, 319.2412109375, 19.888257980347, false },
{602.896484375, 307.3046875, 19.414073944092, false },
{476.5078125, 207.755859375, 11.381258010864, false },
{351.193359375, 105.37890625, 4.674232006073, false },
{233.8056640625, 52.8642578125, 2.4192299842834, false },
{118.7314453125, 92.2890625, 2.0882973670959, false },
{33.103515625, 143.53515625, 2.0749988555908, false },
{-26.6064453125, 164.62890625, 2.3591184616089, false },
{-40.3115234375, 127.2861328125, 3.1245362758636, false },
{-30.2880859375, 89.341796875, 3.13685297966, false },
{-37.240234375, 59.388671875, 3.1260664463043, true, false },
{-30.779296875, 86.236328125, 3.1190872192383, false },
{-40.70703125, 128.560546875, 3.1217279434204, false },
{-29.0087890625, 160.921875, 2.4690952301025, false },
{-13.4755859375, 164.71875, 2.0864684581757, false },
{55.341796875, 121.853515625, 2.0806076526642, false },
{170.3095703125, 60.640625, 2.0831091403961, false },
{244.1806640625, 47.1337890625, 2.3433032035828, false },
{310.45703125, 69.693359375, 2.8154401779175, false },
{423.177734375, 153.1416015625, 8.3001394271851, false },
{505.615234375, 224.806640625, 13.248774528503, false },
{578.0087890625, 282.501953125, 17.852914810181, false },
{651.93359375, 306.888671875, 19.888942718506, false },
{788.7548828125, 326.7294921875, 19.887401580811, false },
{912.2568359375, 361.30859375, 19.895236968994, false },
{1008.8720703125, 441.734375, 19.88823890686, false },
{1042.369140625, 511.4345703125, 19.888498306274, false },
{1110.6396484375, 571.056640625, 19.889802932739, false },
{1219.7119140625, 521.6650390625, 19.884780883789, false },
{1336.4248046875, 462.697265625, 19.891511917114, false },
{1430.359375, 416.298828125, 19.874464035034, false },
{1577.810546875, 379.5244140625, 19.891761779785, false },
{1716.185546875, 382.6259765625, 19.792575836182, false },
{1883.337890625, 356.6083984375, 20.123285293579, false },
{2011.2373046875, 329.046875, 28.043033599854, false },
{2071.8056640625, 248.759765625, 24.281963348389, false },
{2215.07421875, 223.0390625, 14.574460983276, false },
{2321.966796875, 210.990234375, 26.001739501953, false },
{2346.572265625, 231.501953125, 26.343564987183, false },
{2345.509765625, 265.505859375, 26.344453811646, false },
{2358.939453125, 281.58203125, 26.338106155396, false },
{2465.927734375, 301.2216796875, 31.517887115479, false },
{2607.3125, 301.884765625, 35.020427703857, false },
{2737.88671875, 231.5029296875, 30.065069198608, false },
{2757.357421875, 96.5087890625, 24.496433258057, false },
{2751.8125, -63.0263671875, 34.791667938232, false },
{2718.20703125, -201.99609375, 30.321510314941, false },
{2716.2939453125, -368.443359375, 26.901388168335, false },
{2865.640625, -560.9658203125, 12.572250366211, false },
{2873.15234375, -714.7265625, 10.834561347961, false },
{2868.5068359375, -951.99609375, 10.883831977844, false },
{2866.078125, -1118.0712890625, 10.883657455444, false },
{2876.4853515625, -1237.2197265625, 10.893891334534, false },
{2902.1611328125, -1403.8984375, 10.889602661133, false },
{2885.62890625, -1556.337890625, 10.880560874939, false },
{2839.203125, -1710.46875, 10.879320144653, false },
{2821.2392578125, -1851.826171875, 10.946360588074, false },
{2820.9033203125, -1982.6337890625, 10.934830665588, false },
{2813.1025390625, -2092.3095703125, 10.926347732544, false },
{2736.962890625, -2152.37109375, 10.938986778259, false },
{2587.3828125, -2153.10546875, 12.70289516449, false },
{2477.9423828125, -2152.87109375, 13.513664245605, false },
{2344.390625, -2206.392578125, 13.379041671753, false },
{2258.240234375, -2291.7548828125, 13.363236427307, false },
{2176.0703125, -2380.296875, 13.361319541931, false },
{2157.1552734375, -2477.33203125, 13.38035774231, false },
{2174.775390625, -2498.6083984375, 13.36501789093, false },
{2212.505859375, -2497.564453125, 13.416103363037, false },
{2222.4970703125, -2517.6298828125, 13.419145584106, false },
{2222.4228515625, -2593.1865234375, 13.392768859863, false },
{2222.1630859375, -2637.1708984375, 13.382132530212, false },
{2239.5205078125, -2674.125, 13.574842453003, true, true }
}

function KamyonBasla(cmd)
	if not getElementData(getLocalPlayer(), "KamyonSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 455
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "KamyonSoforlugu", true)
			updateKamyonRota()
			addEventHandler("onClientMarkerHit", resourceRoot, KamyonRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("kamyonbasla", KamyonBasla)

function updateKamyonRota()
	KamyonMarker = KamyonMarker + 1
	for i,v in ipairs(KamyonRota) do
		if i == KamyonMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(KamyonCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(KamyonCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(KamyonCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function KamyonRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 455 then
				for _, marker in ipairs(KamyonCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updateKamyonRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							KamyonMarker = 0
							triggerServerEvent("KamyonParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeni rotanız belirleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /siparisbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlendi, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateKamyonRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFArabanızdaki malzemeler sahiplerine teslim ediliyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFArabanızdaki samanlar teslim edilmiştir., geri dönebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateKamyonRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function KamyonBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local KamyonSoforlugu = getElementData(getLocalPlayer(), "KamyonSoforlugu")
	if pedVeh then
		if pedVehModel == 455 then
			if KamyonSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "KamyonSoforlugu", false)
				for i,v in ipairs(KamyonCreatedMarkers) do
					destroyElement(v[1])
				end
				KamyonCreatedMarkers = {}
				KamyonMarker = 0
				triggerServerEvent("KamyonBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, KamyonRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), KamyonAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("kamyonbitir", KamyonBitir)

function KamyonAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 455 and vehicleJob == 22 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 22 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Kamyon Mesleğinde olmanız gerKamyontedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), KamyonAntiYabanci)

function KamyonAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			KamyonBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), KamyonAntiAracTerketme)