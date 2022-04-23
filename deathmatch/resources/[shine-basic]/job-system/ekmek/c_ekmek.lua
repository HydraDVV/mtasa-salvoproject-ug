-- ROTA --
local ekmekMarker = 0
local ekmekCreatedMarkers = {}
local ekmekRota = {
{2076.115234375, -1907.0537109375, 13.546875, false },
{2085.0595703125, -1898.8974609375, 13.3828125, false },
{2084.921875, -1850.6142578125, 13.3828125, false },
{2085.279296875, -1808.4248046875, 13.3828125, false },
{2093.412109375, -1762.5, 13.401577949524, false },
{2104.3056640625, -1722.361328125, 13.390009880066, false },
{2115.29296875, -1662.0986328125, 14.526705741882, false },
{2115.3310546875, -1592.2158203125, 25.719997406006, false },
{2115.248046875, -1565.7900390625, 25.564004898071, false },
{2115.7705078125, -1518.9658203125, 23.723232269287, false },
{2114.810546875, -1463.8720703125, 23.832387924194, false },
{2093.2431640625, -1459.3173828125, 23.791145324707, false },
{2060.2138671875, -1459.287109375, 20.917350769043, false },
{1998.3525390625, -1458.5947265625, 13.390625, false },
{1989.7587890625, -1435.6171875, 14.216904640198, false },
{1989.6220703125, -1390.7197265625, 22.324893951416, false },
{1989.4404296875, -1351.57421875, 23.810035705566, false },
{1994.09765625, -1343.5234375, 23.8203125, false },
{2052.7509765625, -1343.2978515625, 23.8203125, false },
{2073.033203125, -1342.330078125, 23.8203125, false },
{2073.1875, -1307.876953125, 23.8203125, false },
{2089.6572265625, -1303.2958984375, 23.828813552856, false },
{2126.431640625, -1303.48046875, 23.840726852417, false },
{2158.458984375, -1303.310546875, 23.8203125, false },
{2164.5712890625, -1316.0478515625, 23.8203125, false },
{2163.7802734375, -1374.6337890625, 23.828125, false },
{2166.9677734375, -1386.5888671875, 23.828125, false },
{2203.849609375, -1386.7314453125, 23.828966140747, false },
{2210.2783203125, -1396.623046875, 23.819202423096, false },
{2210.2177734375, -1449.5927734375, 23.817699432373, false },
{2210.4404296875, -1485.0908203125, 23.818031311035, false },
{2208.751953125, -1575.833984375, 22.862668991089, false },
{2197.6875, -1629.990234375, 15.488639831543, false },
{2211.064453125, -1649.0859375, 15.237428665161, false },
{2248.830078125, -1659.0615234375, 15.284266471863, false },
{2278.6025390625, -1661.232421875, 15.085003852844, false },
{2332.9482421875, -1661.513671875, 13.431135177612, false },
{2340.1259765625, -1678.0859375, 13.360567092896, false },
{2339.982421875, -1720.650390625, 13.359375, false },
{2340.46484375, -1734.9541015625, 13.3828125, false },
{2405.935546875, -1734.6123046875, 13.3828125, false },
{2410.9033203125, -1746.2294921875, 13.3828125, false },
{2411.388671875, -1915.1259765625, 13.3828125, false },
{2411.3837890625, -1969.6376953125, 13.384978294373, false },
{2386.080078125, -1969.953125, 13.3828125, false },
{2338.947265625, -1969.6435546875, 13.307777404785, false },
{2294.6748046875, -1969.4501953125, 13.40962600708, false },
{2243.0458984375, -1969.6337890625, 13.327303886414, false },
{2216.521484375, -1968.94140625, 13.390619277954, false },
{2220.9345703125, -1905.0537109375, 13.384492874146, false },
{2199.2177734375, -1892.3896484375, 13.75, false },
{2171.6181640625, -1891.8076171875, 13.336507797241, false },
{2135.154296875, -1891.8759765625, 13.337887763977, false },
{2093.0419921875, -1891.9931640625, 13.379998207092, false },
{2061.0625, -1912.16796875, 13.546875, true, true }
}

function ekmekBasla(cmd)
	if not getElementData(getLocalPlayer(), "ekmekSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 422
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "ekmekSoforlugu", true)
			updateekmekRota()
			addEventHandler("onClientMarkerHit", resourceRoot, ekmekRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("ekmekbasla", ekmekBasla)

function updateekmekRota()
	ekmekMarker = ekmekMarker + 1
	for i,v in ipairs(ekmekRota) do
		if i == ekmekMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(ekmekCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(ekmekCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(ekmekCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function ekmekRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 422 then
				for _, marker in ipairs(ekmekCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updateekmekRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							ekmekMarker = 0
							triggerServerEvent("ekmekParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeni rotanız belirleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /siparisbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlendi, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateekmekRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFArabanızdaki ekmekler sahiplerine teslim ediliyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFArabanızdaki ekmekler teslim edilmiştir., geri dönebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateekmekRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function ekmekBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local ekmekSoforlugu = getElementData(getLocalPlayer(), "ekmekSoforlugu")
	if pedVeh then
		if pedVehModel == 422 then
			if ekmekSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "ekmekSoforlugu", false)
				for i,v in ipairs(ekmekCreatedMarkers) do
					destroyElement(v[1])
				end
				ekmekCreatedMarkers = {}
				ekmekMarker = 0
				triggerServerEvent("ekmekBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, ekmekRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), ekmekAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("ekmekbitir", ekmekBitir)

function ekmekAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 422 and vehicleJob == 27 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 27 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için ekmek Mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), ekmekAntiYabanci)

function ekmekAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			ekmekBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), ekmekAntiAracTerketme)