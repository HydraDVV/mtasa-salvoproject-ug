-- ROTA --
local busiMarker = 0
local busiCreatedMarkers = {}
local busiRota = {
{1734.3642578125, -2269.4150390625, -2.4575595855713, false },
{1769.9599609375, -2254.7646484375, 3.0078492164612, false },
{1795.4033203125, -2302.783203125, 12.791063308716, false },
{1734.447265625, -2304.5, 13.770334243774, false },
{1716.5908203125, -2250.458984375, 13.771474838257, true, false },
{1671.072265625, -2250.9072265625, 13.77003288269, true, false },
{1614.1923828125, -2250.87109375, 13.734239578247, true, false },
{1572.076171875, -2280.806640625, 13.762046813965, false },
{1526.521484375, -2282.4580078125, 13.773119926453, false },
{1480.4619140625, -2235.8994140625, 13.777515411377, false },
{1479.4560546875, -2199.6689453125, 13.779058456421, false },
{1718.7861328125, -2197.7724609375, 13.769801139832, false },
{1776.9091796875, -2176.572265625, 13.941565513611, false },
{1844.2197265625, -2168.73828125, 13.779077529907, false },
{2009.970703125, -2169.1669921875, 13.774047851563, false },
{2130.7998046875, -2213.9033203125, 13.772878646851 , false },
{2166.4892578125, -2200.9580078125, 13.771481513977, false },
{2192.005859375, -2177.109375, 13.77537727356, true, false },
{2179.76953125, -2141.5380859375, 13.731789588928, false },
{2077.6787109375, -2107.4609375, 13.75691318512, false },
{1972.818359375, -2107.359375, 13.768210411072, false },
{1963.3447265625, -2082.494140625, 13.779421806335, false },
{1965.7421875, -2008.7314453125, 13.822227478027, true, false },
{1972.33203125, -1935.6728515625, 13.753226280212, false },
{2074.8056640625, -1934.4951171875, 13.756119728088, false },
{2089.5751953125, -1897.521484375, 13.777297973633, false },
{2187.4130859375, -1896.5234375, 13.902027130127, false },
{2219.4814453125, -1881.2490234375, 13.791120529175, false },
{2218.048828125, -1762.2060546875, 13.766492843628, false },
{2233.8310546875, -1751.2119140625, 13.783539772034, false },
{2398.3525390625, -1751.9541015625, 13.777117729187, false },
{2433.234375, -1716.4091796875, 14.602111816406, false },
{2432.9638671875, -1543.6982421875, 24.229557037354, false },
{2409.490234375, -1522.087890625, 24.224466323853, false },
{2355.4912109375, -1521.7880859375, 24.222305297852, true, false },
{2340.6953125, -1547.9150390625, 24.227668762207, false },
{2325.8310546875, -1656.912109375, 14.081686973572, false },
{2232.494140625, -1649.4091796875, 15.694875717163, false },
{2185.3154296875, -1682.2861328125, 14.263798713684, false },
{2175.15234375, -1749.35546875, 13.774065971375, false },
{2108.0908203125, -1750.2109375, 13.78874206543, false },
{1965.939453125, -1748.857421875, 13.776822090149, true, false },
{1835.39453125, -1749.6923828125, 13.797202110291, false },
{1819.55078125, -1770.3662109375, 13.777319908142, false },
{1818.7431640625, -1823.80078125, 13.808091163635, false },
{1758.9736328125, -1820.705078125, 13.779462814331, false },
{1692.1611328125, -1804.3251953125, 13.777661323547, false },
{1691.8349609375, -1747.5048828125, 13.785432815552, false },
{1691.853515625, -1747.7177734375, 13.783542633057, false },
{1664.37109375, -1729.1884765625, 13.773023605347, false },
{1475.65234375, -1728.919921875, 13.775812149048, true, false },
{1387.287109375, -1751.0400390625, 13.778631210327, false },
{1380.7607421875, -1868.267578125, 13.779647827148, false },
{1324.3759765625, -1849.9775390625, 13.773488998413, false },
{1315.0927734375, -1701.28125, 13.77645778656, false },
{1317.220703125, -1549.404296875, 13.784649848938, false },
{1359.5380859375, -1441.8720703125, 13.784449577332, true, false },
{1330.4033203125, -1393.408203125, 13.765947341919, false },
{1178.4072265625, -1392.5556640625, 13.706198692322, false },
{1065.0068359375, -1388.255859375, 13.985896110535, false },
{1065.0849609375, -1217.646484375, 17.28084564209, true, false },
{1064.9091796875, -1150.3525390625, 24.054533004761, false },
{1084.11328125, -1113.5751953125, 24.555974960327, false },
{1096.853515625, -1043.2568359375, 32.006755828857, false },
{1245.826171875, -1040.61328125, 32.125061035156, false },
{1463.146484375, -1038.7685546875, 24.147575378418, true, false},
{1564.9345703125, -1086.853515625, 23.893871307373, false },
{1575.4833984375, -1146.4150390625, 24.186862945557, false },
{1624.4677734375, -1163.4072265625, 24.286550521851, false },
{1785.466796875, -1174.9248046875, 24.051614761353, false },
{1863.46875, -1180.4677734375, 24.054517745972, false },
{1875.2333984375, -1138.2861328125, 24.13822555542, false },
{2047.3701171875, -1138.2646484375, 24.389354705811, false },
{2072.0830078125, -1108.8369140625, 24.865533828735, false },
{2158.7626953125, -1119.654296875, 25.762851715088, true, false },
{2173.0966796875, -1178.40234375, 24.72572517395, false },
{2194.275390625, -1222.5029296875, 24.209936141968, false },
{2272.611328125, -1205.59375, 24.487440109253, false },
{2256.1220703125, -1141.77734375, 26.983854293823, false },
{2144.767578125, -1091.6796875, 25.06357383728, false },
{2054.2607421875, -1033.1357421875, 35.074954986572, false },
{1847.1064453125, -1009.98046875, 36.526473999023, false },
{1679.263671875, -978.013671875, 38.222450256348, false },
{1176.26953125, -938.0517578125, 43.193435668945, false },
{1025.408203125, -950.115234375, 42.744678497314, true, false },
{1001.087890625, -942.193359375, 42.460510253906, false },
{977.580078125, -957.8095703125, 40.461784362793, false },
{875.2822265625, -985.6513671875, 36.007251739502, false },
{776.4892578125, -1042.8408203125, 24.605907440186, false },
{691.5771484375, -1132.7705078125, 16.842380523682, false },
{574.0166015625, -1221.98828125, 17.921867370605, false },
{426.3427734375, -1325.64453125, 15.246123313904, false },
{276.06640625, -1409.0400390625, 14.065365791321, false },
{155.509765625, -1541.4794921875, 11.209399223328, false },
{171.3154296875, -1608.15625, 14.423892974854, false },
{347.302734375, -1718.1279296875, 7.039776802063, false },
{543.7783203125, -1735.5595703125, 12.799224853516, false },
{817.921875, -1790.18359375, 14.159152984619, false },
{944.388671875, -1794.7607421875, 14.283136367798, false },
{1043.833984375, -1913.630859375, 13.386113166809, true, false },
{1031.89453125, -2073.2265625, 13.328866958618, false },
{1052.7451171875, -2311.423828125, 13.314973831177, false },
{1302.4287109375, -2465.8955078125, 8.0565404891968, false },
{1358.1220703125, -2455.5439453125, 8.0556011199951, false },
{1349.951171875, -2375.6591796875, 13.770869255066, false },
{1359.2216796875, -2300.2470703125, 13.771968841553, false },
{1422.5166015625, -2289.654296875, 13.773225784302, false },
{1435.9677734375, -2320.876953125, 13.780765533447, false },
{1509.767578125, -2325.0498046875, 13.778331756592, false },
{1526.00390625, -2290.767578125, 13.772192001343, false },
{1571.0478515625, -2291.7724609375, 13.751198768616, false },
{1575.15234375, -2313.34375, 13.777817726135, false },
{1788.0732421875, -2321.685546875, 13.768238067627, false },
{1800.4619140625, -2267.697265625, 7.2891411781311, false },
{1746.75, -2251.9951171875, -1.5960594415665, false },
{1615.5849609375, -2251.01171875, -2.4576675891876, true, true }
}
function busiBasla(cmd)
	if not getElementData(getLocalPlayer(), "busiSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 431
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "busiSoforlugu", true)
			updatebusiRota()
			addEventHandler("onClientMarkerHit", resourceRoot, busiRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("busibasla", busiBasla)

function updatebusiRota()
	busiMarker = busiMarker + 1
	for i,v in ipairs(busiRota) do
		if i == busiMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(busiCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(busiCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(busiCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function busiRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 431 then
				for _, marker in ipairs(busiCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatebusiRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							busiMarker = 0
							triggerServerEvent("busiParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeni rotanız belirleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /siparisbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlendi, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatebusiRota()
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
									updatebusiRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function busiBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local busiSoforlugu = getElementData(getLocalPlayer(), "busiSoforlugu")
	if pedVeh then
		if pedVehModel == 431 then
			if busiSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "busiSoforlugu", false)
				for i,v in ipairs(busiCreatedMarkers) do
					destroyElement(v[1])
				end
				busiCreatedMarkers = {}
				busiMarker = 0
				triggerServerEvent("busiBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, busiRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), busiAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("busibitir", busiBitir)

function busiAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 431 and vehicleJob == 33 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 33 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için busi Mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), busiAntiYabanci)

function busiAntibusierketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			busiBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), busiAntibusierketme)