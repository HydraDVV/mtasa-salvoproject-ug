-- ROTA --
local cminibusMarker = 0
local cminibusCreatedMarkers = {}
local cminibusRota = {
{-1996.845703125, 184.6201171875, 27.223854064941, false },
{-2003.6513671875, 206.048828125, 27.223527908325, true, false}, -- (Sarı)
{-2001.9091796875, 257.287109375, 30.348628997803, false },
{-2000.1201171875, 305.5390625, 34.540302276611, false },
{-2007.3310546875, 320.2158203125, 34.699974060059, false },
{-2033.17578125, 322.4541015625, 34.699726104736, true, false },   -- (Sarı)
{-2091.8623046875, 322.724609375, 34.699542999268, false },
{-2133.8095703125, 322.4638671875, 34.829620361328, false },
{-2143.876953125, 327.81640625, 34.852668762207, false },
{-2144.4423828125, 368.896484375, 34.856452941895, false },
{-2142.2646484375, 434.115234375, 34.699466705322, false },
{-2139.5390625, 490.2265625, 34.699932098389, true, false },      -- (Sarı)
{-2159.994140625, 507.3330078125, 34.699851989746, false },
{-2212.5576171875, 510.9150390625, 34.699893951416, false },
{-2245.6162109375, 510.59375, 34.699714660645, false },
{-2306.2275390625, 510.71875, 33.567588806152, false },
{-2360.7763671875, 510.32421875, 28.96494102478, false },
{-2371.0712890625, 495.0703125, 29.623386383057, true, false }, --   (Sarı)
{-2348.2041015625, 458.923828125, 31.87554359436, false },
{-2322.73046875, 429.1484375, 34.498931884766, false },
{-2317.4775390625, 416.0234375, 34.696445465088, false },
{-2335.39453125, 397.7041015625, 34.704437255859, true, false },  -- (Sarı)
{-2352.587890625, 380.0390625, 35.007801055908, false },
{-2359.5263671875, 371.7216796875, 35.008373260498, false },
{-2390.3349609375, 336.07421875, 35.007797241211, false },
{-2416.0849609375, 283.72265625, 34.991031646729, false },
{-2418.298828125, 226.5400390625, 35.0078125, false },
{-2422.5400390625, 163.416015625, 35.015689849854, false },
{-2423.345703125, 117.0166015625, 35.01195526123, false },
{-2423.841796875, 66.60546875, 35.007656097412, false },
{-2423.6708984375, 23.9580078125, 35.048717498779, false },
{-2424.544921875, 3.6162109375, 35.164134979248, true, false },  -- (Sarı)
{-2423.7626953125, -55.578125, 35.164081573486, false },
{-2409.1923828125, -72.126953125, 35.157279968262, false },
{-2362.5400390625, -72.9892578125, 35.185417175293, false },
{-2315.6845703125, -73.0615234375, 35.156131744385, true, false },  -- (Sarı)
{-2273.0634765625, -72.74609375, 35.156448364258, false },
{-2237.3974609375, -72.6279296875, 35.164409637451, false },
{-2181.46875, -72.5302734375, 35.164096832275, false },
{-2164.4814453125, -57.009765625, 35.163928985596, false },
{-2164.724609375, -28.9521484375, 35.163875579834, false },
{-2164.7041015625, 13.271484375, 35.163925170898, false },
{-2154.5576171875, 27.361328125, 35.164447784424, false },
{-2131.5556640625, 27.49609375, 35.164237976074, true, false },  --  (Sarı)
{-2098.9736328125, 27.66796875, 35.163955688477, false },
{-2089.177734375, 16.7734375, 35.164028167725, false },
{-2089.6943359375, -57.3349609375, 35.191902160645, false },
{-2083.50390625, -72.4521484375, 35.163990020752, false },
{-2020.5009765625, -72.5556640625, 35.164001464844, false },
{-2004.95703125, -57.3798828125, 35.157123565674, false },
{-2004.736328125, -19.294921875, 34.901725769043, false },
{-2004.5302734375, 21.9619140625, 32.809631347656, false },
{-2004.666015625, 56.5478515625, 30.238374710083, false },
{-1999.5224609375, 103.5703125, 27.532049179077, true, true}    -- (Bitir)

}

function cminibusBasla(cmd)
	if not getElementData(getLocalPlayer(), "cminibusSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 431
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "cminibusSoforlugu", true)
			updatecminibusRota()
			addEventHandler("onClientMarkerHit", resourceRoot, cminibusRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("otobusbasla", cminibusBasla)

function updatecminibusRota()
	cminibusMarker = cminibusMarker + 1
	for i,v in ipairs(cminibusRota) do
		if i == cminibusMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(cminibusCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(cminibusCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(cminibusCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function cminibusRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 431 then
				for _, marker in ipairs(cminibusCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatecminibusRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							cminibusMarker = 0
							triggerServerEvent("cminibusParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeni rotanız belirleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /cminibusasimabitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlendi, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatecminibusRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFYolcular indiriliyor/bindiriliyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYolcular indirildi/bindirildi., rotanıza devam edin", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatecminibusRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function cminibusBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local cminibusSoforlugu = getElementData(getLocalPlayer(), "cminibusSoforlugu")
	if pedVeh then
		if pedVehModel == 431 then
			if cminibusSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "cminibusSoforlugu", false)
				for i,v in ipairs(cminibusCreatedMarkers) do
					destroyElement(v[1])
				end
				cminibusCreatedMarkers = {}
				cminibusMarker = 0
				triggerServerEvent("cminibusBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, cminibusRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), cminibusAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("otobusbitir", cminibusBitir)

function cminibusAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 431 and vehicleJob == 32 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 32 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Minibus Mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), cminibusAntiYabanci)

function cminibusAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			cminibusBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), cminibusAntiAracTerketme)