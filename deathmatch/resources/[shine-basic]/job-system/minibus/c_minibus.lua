-- ROTA --
local MinMarker = 0
local MinCreatedMarkers = {}
local MinRota = {
{1809.810546875, -1891.8994140625, 13.197883605957, false }, 
{1819.5146484375, -1914.001953125, 13.143920898438, false },
{1835.83203125, -1934.5859375, 13.134069442749, false },
{1880.7958984375, -1934.6865234375, 13.139296531677, false },
{1930.0361328125, -1934.646484375, 13.139671325684, false },
{1983.353515625, -1935.048828125, 13.138531684875, false },
{2041.765625, -1935.0048828125, 13.082225799561, false },
{2074.142578125, -1934.1328125, 13.13011932373, false },
{2084.2060546875, -1922.703125, 13.114565849304, false },
{2083.8857421875, -1878.7880859375, 13.089027404785, false },
{2083.787109375, -1797.3173828125, 13.142143249512, false },
{2096.3134765625, -1748.5869140625, 13.160157203674, false },
{2113.4150390625, -1687.478515625, 13.136426925659, false },
{2114.5390625, -1624.822265625, 21.645050048828, false },
{2114.83984375, -1586.2392578125, 25.617235183716, false },
{2114.7197265625, -1514.025390625, 23.499681472778, false },
{2114.7998046875, -1462.6669921875, 23.585994720459, false },
{2114.9404296875, -1398.6640625, 23.584440231323, false },
{2119.89453125, -1386.6025390625, 23.586124420166, false },
{2149.9248046875, -1386.578125, 23.592889785767, false },
{2196.318359375, -1386.8154296875, 23.584930419922, false },
{2228.0380859375, -1386.8740234375, 23.587976455688, false },
{2286.4833984375, -1386.904296875, 23.866279602051, false },
{2327.5322265625, -1386.654296875, 23.60346031189, false },
{2339.7763671875, -1396.8837890625, 23.569236755371, false },
{2340.087890625, -1452.3642578125, 23.584690093994, false },
{2340.0634765625, -1495.89453125, 23.589942932129, false },
{2339.892578125, -1548.146484375, 23.592357635498, false },
{2339.5751953125, -1577.5341796875, 23.547554016113, false },
{2339.96875, -1649.421875, 13.551993370056, false },
{2329.1357421875, -1656.6181640625, 13.307035446167, false },
{2295.484375, -1656.521484375, 14.469038963318, true, false },
{2259.0947265625, -1656.24609375, 14.953572273254, false },
{2227.1376953125, -1648.37109375, 15.071412086487, false },
{2191.564453125, -1656.2353515625, 14.864635467529, false },
{2183.7880859375, -1687.6015625, 13.433281898499, true, false }, 
{2182.9404296875, -1730.7353515625, 13.132655143738, false },
{2166.9951171875, -1749.9013671875, 13.140922546387, false },
{2140.0498046875, -1748.5458984375, 13.153881072998, true, false },
{2108.6357421875, -1750.1796875, 13.162943840027, false },
{2076.1953125, -1750.048828125, 13.141871452332, false },
{2026.109375, -1749.935546875, 13.139026641846, false },
{1988.087890625, -1749.9619140625, 13.13939666748, false },
{1959.1337890625, -1749.96875, 13.140937805176, false },
{1921.8544921875, -1748.51171875, 13.140997886658, true, false },
{1895.154296875, -1749.2177734375, 13.140001296997, false },
{1844.0126953125, -1750.1748046875, 13.140204429626, false },
{1824.8125, -1743.22265625, 13.139474868774, false },
{1807.09375, -1730.1630859375, 13.148419380188, false },
{1773.5322265625, -1728.478515625, 13.140623092651, true, false }, 
{1735.408203125, -1729.4482421875, 13.151091575623, false },
{1702.9345703125, -1729.82421875, 13.140307426453, false },
{1686.8203125, -1751.6357421875, 13.146183013916, false },
{1685.8251953125, -1766.6484375, 13.139385223389, true, false }, 
{1687.34375, -1791.8662109375, 13.138611793518, false },
{1702.0634765625, -1814.404296875, 13.124533653259, false },
{1723.044921875, -1816.5, 13.115686416626, false },
{1739.6884765625, -1822.0048828125, 13.125805854797, true, false },
{1773.1767578125, -1829.435546875, 13.139729499817, false },
{1809.2919921875, -1834.427734375, 13.141467094421, false },
{1819.09375, -1843.3134765625, 13.170381546021, false },
{1818.5986328125, -1868.8837890625, 13.169893264771, false },
{1811.14453125, -1889.2978515625, 13.166298866272, true, false }, 
{1804.076171875, -1915.580078125, 13.152884483337, true, true } 

}

function MinBasla(cmd)
	if not getElementData(getLocalPlayer(), "MinSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 483
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "MinSoforlugu", true)
			updateMinRota()
			addEventHandler("onClientMarkerHit", resourceRoot, MinRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("minibusbasla", MinBasla)

function updateMinRota()
	MinMarker = MinMarker + 1
	for i,v in ipairs(MinRota) do
		if i == MinMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(MinCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(MinCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(MinCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function MinRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 483 then
				for _, marker in ipairs(MinCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updateMinRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							MinMarker = 0
							triggerServerEvent("MinParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYolcular inidiriliyor/bindiriliyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /minibusbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlenmiştir, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateMinRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFYolcular indiriliyor/bindiriliyor.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYolcular indirildi/bindirildi, bir sonraki rotadan devam edebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateMinRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function MinBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local MinSoforlugu = getElementData(getLocalPlayer(), "MinSoforlugu")
	if pedVeh then
		if pedVehModel == 483 then
			if MinSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "MinSoforlugu", false)
				for i,v in ipairs(MinCreatedMarkers) do
					destroyElement(v[1])
				end
				MinCreatedMarkers = {}
				MinMarker = 0
				triggerServerEvent("MinBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, MinRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), MinAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("minibusbitir", MinBitir)

function MinAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 483 and vehicleJob == 21 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 21 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Minibüs mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), MinAntiYabanci)

function MinAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			MinBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), MinAntiAracTerketme)