-- ROTA --
local pizzaMarker = 0
local pizzaCreatedMarkers = {}
local pizzaRota = {
    { 2088.646484375, -1778.984375, 12.965497016907, false }, -- başlangıç
	{ 2113.6142578125, -1755.3203125, 12.98411655426, false }, -- başlangıç
	{ 2179.826171875, -1755.3662109375, 12.969033241272, false },
	{ 2185.3095703125, -1771.5361328125, 12.964796066284, false },
	{ 2178.21875, -1793.2939453125, 12.941838264465, false },
	{ 2170.015625, -1794.7763671875, 12.963752746582, true, false },
	{ 2162.5419921875, -1796.7724609375, 12.964126586914, true, false },
	{ 2162.4111328125, -1805.1494140625, 12.958400726318, true, false },
	{ 2174.8798828125, -1805.5146484375, 12.969396591187, true, false },
	{ 2184.896484375, -1795.017578125, 12.966539382935, false },
	{  2185.666015625, -1760.751953125, 12.972797393799, false },
	{ 2193.1435546875, -1735.58984375, 12.987034797668, false },
	{ 2212.78515625, -1739.775390625, 12.910401344299, false },
	{ 2213.4697265625, -1766.736328125, 12.96332359314, false },
	{ 2220.0927734375, -1789.5234375, 12.792966842651, false },
	{ 2244.037109375, -1792.2470703125, 13.149513244629, false },
	{ 2257.150390625, -1796.8701171875, 13.147100448608, false },
	{ 2244.458984375, -1817.0400390625, 13.148864746094, true, false },
	{ 2262.1728515625, -1795.2421875, 13.140301704407, true, false },
	{ 2279.2939453125, -1817.3896484375, 13.141298294067, false },
	{ 2267.69921875, -1797.900390625, 13.147191047668, false },
	{ 2298.19140625, -1787.9501953125, 13.14172744751, false },
	{ 2301.6953125, -1769.2236328125, 13.24432849884, true, false },
	{ 2307.2978515625, -1756.5615234375, 13.19859790802, false },
	{ 2338.8603515625, -1764.47265625, 13.146818161011, true, false },
	{ 2337.4765625, -1783.287109375, 13.144289970398, false },
	{ 2355.6083984375, -1794.802734375, 13.142462730408, true, false },
	{ 2370.59375, -1791.287109375, 13.139799118042, false },
	{ 2390.98046875, -1795.943359375, 13.147346496582, true, false },
	{ 2416.31640625, -1786.5205078125, 12.97652053833, false },
	{ 2415.830078125, -1740.1171875, 12.982783317566, false },
	{ 2405.814453125, -1729.7421875, 13.000094413757, false },
{ 2346.8037109375, -1730.2578125, 12.969155311584, false },
{ 2229.6689453125, -1729.544921875, 12.979884147644, false },
{ 2201.5302734375, -1730.1298828125, 13.019406318665,  false },
{ 2175.0712890625, -1750.09765625, 12.978452682495, false },
{ 2113.3291015625, -1749.8056640625, 12.994348526001, false },
{ 2085.275390625, -1772.4169921875, 12.980630874634, false },
{ 2091.9599609375, -1796.7021484375, 12.979608535767, true, true}


}

function pizzaBasla(cmd)
	if not getElementData(getLocalPlayer(), "pizzaSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 448
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "pizzaSoforlugu", true)
			updatepizzaRota()
			addEventHandler("onClientMarkerHit", resourceRoot, pizzaRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("siparisbasla", pizzaBasla)

function updatepizzaRota()
	pizzaMarker = pizzaMarker + 1
	for i,v in ipairs(pizzaRota) do
		if i == pizzaMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(pizzaCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(pizzaCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(pizzaCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function pizzaRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 448 then
				for _, marker in ipairs(pizzaCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatepizzaRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							pizzaMarker = 0
							triggerServerEvent("pizzaParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeni rotanız belirleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /siparisbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlendi, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatepizzaRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFMotorunuzdaki siparişler sahiplerine teslim ediliyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFMotorunuzdaki siparişler teslim edilmiştir., geri dönebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatepizzaRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function pizzaBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local pizzaSoforlugu = getElementData(getLocalPlayer(), "pizzaSoforlugu")
	if pedVeh then
		if pedVehModel == 448 then
			if pizzaSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "pizzaSoforlugu", false)
				for i,v in ipairs(pizzaCreatedMarkers) do
					destroyElement(v[1])
				end
				pizzaCreatedMarkers = {}
				pizzaMarker = 0
				triggerServerEvent("pizzaBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, pizzaRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), pizzaAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("sipaisbitir", pizzaBitir)

function pizzaAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 448 and vehicleJob == 25 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 25 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için pizza Mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), pizzaAntiYabanci)

function pizzaAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			pizzaBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), pizzaAntiAracTerketme)