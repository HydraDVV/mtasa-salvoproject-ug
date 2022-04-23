-- ROTA --
local taksiMarker = 0
local taksiCreatedMarkers = {}
local taksiRota = {
{1824.29296875, -1847.90625, 13.194293022156, false }, 
{1824.1376953125, -1787.197265625, 13.160802841187, false }, 
{1835.583984375, -1755.0947265625, 13.163785934448, false }, 
{1891.5263671875, -1754.787109375, 13.161005020142, true, false }, 
{1927.212890625, -1754.857421875, 13.160804748535, false }, 
{1944.158203125, -1736.875, 13.159008979797, false }, 
{1944.1728515625, -1681.14453125, 13.159844398499, false }, 
{1943.912109375, -1620.8857421875, 13.163585662842, false }, 
{1892.734375, -1609.544921875, 13.160872459412, false }, 
{1834.9638671875, -1609.8076171875, 13.161896705627, false }, 
{1773.388671875, -1604.1044921875, 13.155320167542, false }, 
{1682.1953125, -1589.9384765625, 13.16270160675, false }, 
{1607.2939453125, -1589.98828125, 13.316329956055, false }, 
{1521.62890625, -1589.673828125, 13.16116809845, false }, 
{1470.3662109375, -1589.5546875, 13.160054206848, false }, 
{1411.1201171875, -1589.5537109375, 13.136631011963, false }, 
{1357.2451171875, -1578.0400390625, 13.159172058105, false }, 
{1315.470703125, -1559.5693359375, 13.169567108154, false }, 
{1336.4365234375, -1506.25390625, 13.159160614014, false }, 
{1360.1103515625, -1418.638671875, 13.159970283508, false }, 
{1350.1962890625, -1393.982421875, 13.171453475952, false }, 
{1305.7802734375, -1391.705078125, 13.071016311646, true, false },  
{1271.1689453125, -1392.65625, 12.956521987915, false }, 
{1261.2568359375, -1368.9970703125, 13.004240989685, false }, 
{1261.330078125, -1327.1748046875, 12.909400939941, false }, 
{1261.2685546875, -1293.6259765625, 13.047284126282, false }, 
{1238.1103515625, -1277.67578125, 13.162739753723, false }, 
{1195.9892578125, -1294.1748046875, 13.162172317505, false }, 
{1191.8154296875, -1324.669921875, 13.176447868347, true, false },  
{1195.146484375, -1381.9248046875, 13.086052894592, false }, 
{1193.578125, -1426.60546875, 13.038679122925, false }, 
{1193.5791015625, -1501.1904296875, 13.162825584412, false }, 
{1193.7392578125, -1559.4912109375, 13.161368370056, false }, 
{1182.1767578125, -1569.75, 13.137101173401, false }, 
{1137.328125, -1569.501953125, 13.073866844177, false }, 
{1089.314453125, -1569.7666015625, 13.158744812012, false }, 
{1050.294921875, -1569.861328125, 13.168795585632, false }, 
{998.7529296875, -1569.92578125, 13.160307884216, false }, 
{933.5390625, -1570.025390625, 13.161298751831, false }, 
{880.7109375, -1572.720703125, 13.163017272949, false }, 
{844.8427734375, -1602.501953125, 13.171014785767, false }, 
{822.9990234375, -1624.2236328125, 13.161548614502, true, false },  
{807.798828125, -1662.09765625, 13.159594535828, false }, 
{795.7294921875, -1672.5498046875, 13.12634563446, false }, 
{725.9912109375, -1671.291015625, 10.299174308777, false }, 
{653.814453125, -1670.0146484375, 14.162433624268, false }, 
{642.650390625, -1659.0546875, 14.747372627258, false }, 
{640.2890625, -1601.8818359375, 15.30513381958, false }, 
{639.9384765625, -1548.7548828125, 15.00756072998, false }, 
{639.935546875, -1483.916015625, 14.310830116272, false }, 
{640.01171875, -1419.4365234375, 13.307145118713, false }, 
{641.62890625, -1355.9501953125, 13.178009986877, true, false },  
{640.4677734375, -1302.71875, 13.849142074585, false }, 
{639.015625, -1260.1806640625, 16.573905944824, false }, 
{634.828125, -1226.43359375, 17.767498016357, false }, 
{652.6552734375, -1206.232421875, 17.925771713257, false }, 
{699.5693359375, -1151.1884765625, 15.481323242188, false }, 
{733.365234375, -1087.49609375, 21.021535873413, false }, 
{780.1796875, -1057.2509765625, 24.349317550659, false }, 
{847.203125, -1033.7568359375, 25.533983230591, false }, 
{877.853515625, -1002.935546875, 34.660064697266, false }, 
{929.6748046875, -981.306640625, 38.028568267822, false }, 
{994.4501953125, -971.998046875, 40.415332794189, false }, 
{1068.16015625, -962.7431640625, 42.364326477051, false }, 
{1140.728515625, -957.298828125, 42.29833984375, false }, 
{1220.9052734375, -945.880859375, 42.396903991699, false }, 
{1302.7548828125, -935.1640625, 39.199138641357, false }, 
{1351.00390625, -944.26171875, 34.231170654297, false }, 
{1410.5546875, -947.861328125, 35.288837432861, false }, 
{1501.3447265625, -961.5751953125, 35.978118896484, false }, 
{1620.076171875, -974.9560546875, 37.949039459229, false }, 
{1749.31640625, -994.501953125, 36.928722381592, false }, 
{1852.3994140625, -1015.8623046875, 35.913101196289, false }, 
{1945.8759765625, -1028.349609375, 32.986930847168, false }, 
{2022.474609375, -1031.9619140625, 35.27424621582, false }, 
{2094.30859375, -1062.1025390625, 27.574304580688, false }, 
{2151.7099609375, -1099.2509765625, 24.852674484253, true, false },  
{2205.423828125, -1121.3076171875, 25.334245681763, false }, 
{2232.8291015625, -1140.78125, 25.406099319458, true, false }, 
{2260.9423828125, -1147.3251953125, 26.581457138062, false }, 
{2268.296875, -1164.1357421875, 26.115474700928, false }, 
{2268.5224609375, -1208.4560546875, 23.719869613647, false }, 
{2268.6005859375, -1261.5986328125, 23.598453521729, false }, 
{2268.3212890625, -1314.451171875, 23.609352111816, false }, 
{2268.25390625, -1370.943359375, 23.608320236206, false }, 
{2240.599609375, -1381.5625, 23.610862731934, false }, 
{2210.255859375, -1398.2041015625, 23.599912643433, false }, 
{2210.1083984375, -1460.916015625, 23.593511581421, false }, 
{2210.248046875, -1537.060546875, 23.606325149536, false }, 
{2206.3935546875, -1594.7177734375, 20.305118560791, false }, 
{2187.4736328125, -1672.3447265625, 14.116569519043, false }, 
{2182.783203125, -1728.1865234375, 13.153542518616, false }, 
{2171.6494140625, -1749.556640625, 13.162586212158, false }, 
{2107.8671875, -1749.740234375, 13.182898521423, false }, 
{2067.1630859375, -1749.8369140625, 13.163401603699, false }, 
{2016.15234375, -1749.865234375, 13.160287857056, false }, 
{1956.1806640625, -1749.6953125, 13.160703659058, false }, 
{1890.8828125, -1749.82421875, 13.159375190735, false }, 
{1834.78125, -1749.892578125, 13.160054206848, false }, 
{1807.9248046875, -1729.845703125, 13.170534133911, false }, 
{1735.0908203125, -1729.6884765625, 13.17294883728, false }, 
{1666.8916015625, -1729.7744140625, 13.162749290466, false }, 
{1597.9921875, -1729.66015625, 13.161626815796, false }, 
{1542.173828125, -1729.6884765625, 13.161925315857, false }, 
{1486.322265625, -1728.8251953125, 13.160126686096, true, false },  
{1442.7412109375, -1729.462890625, 13.161509513855, false }, 
{1400.76953125, -1729.52734375, 13.172276496887, false }, 
{1386.505859375, -1755.3896484375, 13.161875724792, false }, 
{1386.5400390625, -1816.982421875, 13.165526390076, false }, 
{1386.6865234375, -1859.3603515625, 13.161605834961, false }, 
{1403.9873046875, -1875.09375, 13.162320137024, false }, 
{1473.0009765625, -1875.078125, 13.160369873047, false }, 
{1518.72265625, -1875.009765625, 13.16464805603, false }, 
{1567.619140625, -1875.759765625, 13.158488273621, true, false },  
{1572.1240234375, -1845.40234375, 13.159872055054, false }, 
{1571.9833984375, -1791.146484375, 13.161111831665, false }, 
{1572.115234375, -1745.189453125, 13.158689498901, false }, 
{1546.1650390625, -1729.548828125, 13.161508560181, false }, 
{1477.1875, -1729.7890625, 13.162615776062, false }, 
{1406.3466796875, -1729.576171875, 13.167499542236, false }, 
{1326.712890625, -1729.576171875, 13.163756370544, false }, 
{1315.046875, -1718.1025390625, 13.162752151489, false }, 
{1314.94140625, -1659.65625, 13.165549278259, false }, 
{1314.8955078125, -1602.3662109375, 13.159223556519, false }, 
{1321.1162109375, -1534.5673828125, 13.161086082458, false }, 
{1352.13671875, -1473.6337890625, 13.164004325867, false }, 
{1360.154296875, -1419.728515625, 13.159232139587, false }, 
{1350.578125, -1394.59375, 13.160477638245, false }, 
{1298.4033203125, -1392.6259765625, 13.044173240662, false }, 
{1235.3994140625, -1392.5302734375, 12.951642036438, false }, 
{1205.9609375, -1374.9384765625, 13.058609008789, false }, 
{1209.6025390625, -1334.3994140625, 13.174414634705, true, false },
{1206.681640625, -1294.8720703125, 13.160778999329, false }, 
{1226.42578125, -1283.505859375, 13.177491188049, false }, 
{1273.7578125, -1283.23046875, 13.088629722595, false }, 
{1329.5986328125, -1283.390625, 13.160137176514, false }, 
{1339.8623046875, -1297.2314453125, 13.291166305542, false }, 
{1340.166015625, -1339.896484375, 13.163280487061, false }, 
{1340.2529296875, -1380.541015625, 13.28343963623, false }, 
{1338.642578125, -1438.3525390625, 13.162605285645, false }, 
{1321.63671875, -1493.0380859375, 13.161015510559, false }, 
{1295.443359375, -1557.765625, 13.171882629395, false }, 
{1295.13671875, -1640.537109375, 13.162318229675, false }, 
{1294.9072265625, -1699.322265625, 13.160798072815, false }, 
{1294.7158203125, -1749.18359375, 13.162631988525, false }, 
{1294.8837890625, -1800.05078125, 13.162063598633, false }, 
{1294.853515625, -1839.24609375, 13.162519454956, false }, 
{1316.0029296875, -1854.9033203125, 13.158828735352, false }, 
{1347.98046875, -1864.2177734375, 13.162304878235, false }, 
{1412.189453125, -1874.6787109375, 13.160396575928, false }, 
{1469.9462890625, -1874.8037109375, 13.16291809082, false }, 
{1516.7490234375, -1874.71875, 13.162704467773, false }, 
{1588.169921875, -1874.900390625, 13.162452697754, false }, 
{1663.41796875, -1873.9482421875, 13.168088912964, false }, 
{1692.5107421875, -1826.9541015625, 13.159408569336, false }, 
{1704.6689453125, -1814.998046875, 13.144945144653, false }, 
{1761.794921875, -1826.62890625, 13.159896850586, false }, 
{1809.095703125, -1834.796875, 13.16254901886, false }, 
{1818.88671875, -1844.8359375, 13.194055557251, false }, 
{1807.3779296875, -1852.0126953125, 13.193270683289, true, true} 
}

function taksiBasla(cmd)
	if not getElementData(getLocalPlayer(), "taksiSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 420
	if not getVehicleOccupant(oyuncuArac, 1) and not getVehicleOccupant(oyuncuArac, 2) and not getVehicleOccupant(oyuncuArac, 3) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "taksiSoforlugu", true)
			updatetaksiRota()
			addEventHandler("onClientMarkerHit", resourceRoot, taksiRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("taksibasla", taksiBasla)

function updatetaksiRota()
	taksiMarker = taksiMarker + 1
	for i,v in ipairs(taksiRota) do
		if i == taksiMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(taksiCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(taksiCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(taksiCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function taksiRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 420 then
				for _, marker in ipairs(taksiCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatetaksiRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							taksiMarker = 0
							triggerServerEvent("taksiParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeni rotanız belirleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /siparisbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlendi, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatetaksiRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFArabanızdaki taksiler sahiplerine teslim ediliyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFArabanızdaki taksiler teslim edilmiştir., geri dönebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatetaksiRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function taksiBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local taksiSoforlugu = getElementData(getLocalPlayer(), "taksiSoforlugu")
	if pedVeh then
		if pedVehModel == 420 then
			if taksiSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "taksiSoforlugu", false)
				for i,v in ipairs(taksiCreatedMarkers) do
					destroyElement(v[1])
				end
				taksiCreatedMarkers = {}
				taksiMarker = 0
				triggerServerEvent("taksiBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, taksiRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), taksiAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("taksibitir", taksiBitir)

function taksiAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 420 and vehicleJob == 29 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 29 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Taksi Mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), taksiAntiYabanci)

function taksiAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			taksiBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), taksiAntiAracTerketme)