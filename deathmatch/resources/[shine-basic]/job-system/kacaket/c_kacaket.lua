-- ROTA --
local kacaketMarker = 0
local kacaketCreatedMarkers = {}
local kacaketRota = {
{2732.1572265625, -2502.1220703125, 13.557418823242, false },
{2685.9775390625, -2491.193359375, 13.58509349823, false },
{2666.0556640625, -2403.0302734375, 13.524701118469, false },
{2592.1826171875, -2385.435546875, 13.472831726074, false },
{2273.4111328125, -2067.466796875, 13.450149536133, false },
{2216.23828125, -1987.9443359375, 13.4054479599, false },
{2220.5478515625, -1850.6982421875, 13.335757255554, false },
{2230.2958984375, -1734.8671875, 13.451912879944, false },
{2344.7685546875, -1717.146484375, 13.425168037415, false },
{2297.4130859375, -1653.2109375, 14.788640975952, true, false },
{2230.0537109375, -1648.966796875, 15.377535820007, false },
{2185.046875, -1686.2900390625, 13.786909103394, false },
{2176.453125, -1749.1689453125, 13.447034835815, false },
{2089.03125, -1803.66796875, 13.519086837769, true, false },
{2079.3798828125, -1855.2138671875, 13.450114250183, false },
{2076.9892578125, -1928.65234375, 13.387903213501, false },
{1947.5400390625, -1930.138671875, 13.450206756592, false },
{1828.4443359375, -1929.732421875, 13.45112991333, false },
{1808.3466796875, -1830.0361328125, 13.459852218628, false },
{1687.419921875, -1822.7646484375, 13.450278282166, false },
{1672.68359375, -1866.166015625, 13.45897102356, false },
{1564.466796875, -1878.48828125, 13.61434173584, true, false },
{1533.6669921875, -1870.0380859375, 13.450359344482, false },
{1359.7734375, -1864.736328125, 13.451820373535, false },
{1284.783203125, -1849.8232421875, 13.458206176758, false },
 {1182.298828125, -1849.6904296875, 13.470550537109, false },
 {1088.4375, -1857.6240234375, 13.532218933105, false },
 {1052.181640625, -1817.8701171875, 13.698272705078, false },
 {1039.5380859375, -1750.7607421875, 13.446292877197, false },
 {1040.0068359375, -1661.046875, 13.450360298157, false },
 {1045.5751953125, -1545.48046875, 13.618316650391, false },
 {1062.4609375, -1451.693359375, 13.429272651672, false },
{1035.70703125, -1393.4267578125, 13.352274894714, false },
{919.1650390625, -1387.03515625, 13.39787197113, false },
{923.23046875, -1355.3369140625, 13.340140342712, true, false },
 {907.7646484375, -1320.845703125, 13.581448554993, false },
 {775.326171875, -1317.4453125, 13.452391624451, false },
 {630.396484375, -1335, 13.456097602844, false },
{629.8193359375, -1421.29296875, 13.661266326904, false },
 {630.3662109375, -1600.0986328125, 15.700603485107, false },
 {626.72265625, -1716.744140625, 14.073259353638, false },
{664.451171875, -1756.095703125, 13.511565208435, false },
{835.146484375, -1786.099609375, 13.814679145813, false },
{1034.251953125, -1824.634765625, 13.727000236511, false },
 {1044.6953125, -1889.4052734375, 13.083667755127, false },
{1037.306640625, -2002.892578125, 13.19868183136, false },
 {1032.6396484375, -2068.3740234375, 13.016139030457, false },
{1317.7001953125, -2478.12890625, 8.3860635757446, false },
{1355.9189453125, -2644.1943359375, 13.439370155334, false },
{2136.8642578125, -2659.4794921875, 13.442721366882, false },
{2177.44140625, -2480.84765625, 13.440185546875, false },
 {2210.4833984375, -2368.7275390625, 13.442430496216, false },
 {2297.640625, -2267.40625, 13.442897796631, false },
{2215.0263671875, -2173.12109375, 13.613589286804, true, false },
 {2219.75, -2147.9619140625, 13.450862884521, false },
 {2291.2109375, -2092.3134765625, 13.391305923462, false },
{2372.3994140625, -2173.3798828125, 22.501594543457, false },
 {2617.8271484375, -2407.0546875, 13.575577735901, false },
 {2748.7412109375, -2409.7841796875, 13.534058570862, false },
{2768.8408203125, -2473.873046875, 13.715260505676, true, true }

}

function kacaketBasla(cmd)
	if not getElementData(getLocalPlayer(), "kacaketSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 609
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "kacaketSoforlugu", true)
			updatekacaketRota()
			addEventHandler("onClientMarkerHit", resourceRoot, kacaketRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("kacaketbasla", kacaketBasla)

function updatekacaketRota()
	kacaketMarker = kacaketMarker + 1
	for i,v in ipairs(kacaketRota) do
		if i == kacaketMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(kacaketCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(kacaketCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(kacaketCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function kacaketRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 609 then
				for _, marker in ipairs(kacaketCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatekacaketRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							kacaketMarker = 0
							triggerServerEvent("kacaketParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeni rotanız belirleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /siparisbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlendi, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatekacaketRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFAracınızdaki emanetler teslim ediliyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFAracınızdaki emanetler teslim edilmiştir., geri dönebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatekacaketRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function kacaketBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local kacaketSoforlugu = getElementData(getLocalPlayer(), "kacaketSoforlugu")
	if pedVeh then
		if pedVehModel == 609 then
			if kacaketSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "kacaketSoforlugu", false)
				for i,v in ipairs(kacaketCreatedMarkers) do
					destroyElement(v[1])
				end
				kacaketCreatedMarkers = {}
				kacaketMarker = 0
				triggerServerEvent("kacaketBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, kacaketRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), kacaketAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("kacaketbitir", kacaketBitir)

function kacaketAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 609 and vehicleJob == 31 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 31 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için kacaket Mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), kacaketAntiYabanci)

function kacaketAntikacaketerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			kacaketBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), kacaketAntikacaketerketme)