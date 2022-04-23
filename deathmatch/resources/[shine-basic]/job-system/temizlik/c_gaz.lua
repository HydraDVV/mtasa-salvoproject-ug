-- ROTA --
local gazeteMarker = 0
local gazeteCreatedMarkers = {}
local gazeteRota = {
      {1258.4091796875, -1830.9404296875, 13.110165596008, false },
{1285.53125, -1854.068359375, 13.115746498108, false },
{1333.376953125, -1857.3701171875, 13.113475799561, false },
{1367.9375, -1873.0068359375, 13.107960700989, false },
{1425.9541015625, -1874.326171875, 13.107982635498, false },
{1513.7900390625, -1874.810546875, 13.107913970947, false },
{1559.5185546875, -1875.048828125, 13.107968330383, false },
{1571.927734375, -1846.0400390625, 13.107956886292, false },
{1571.9541015625, -1755.6611328125, 13.107963562012, false },
{1552.455078125, -1730.7177734375, 13.107992172241, false },
{1482.484375, -1730.1923828125, 13.107944488525, false },
{1431.28515625, -1716.9052734375, 13.107944488525, false },
{1431.341796875, -1651.025390625, 13.107950210571, false },
{1431.3857421875, -1605.6640625, 13.107968330383, false },
{1439.1015625, -1538.1650390625, 13.10066318512, false },
{1456.181640625, -1454.658203125, 13.091095924377, false },
{1479.8662109375, -1443.0703125, 13.107954978943, false },
{1539.41015625, -1443.23828125, 13.107959747314, false },
{1595.013671875, -1443.39453125, 13.111899375916, false },
{1607.0576171875, -1415.9892578125, 13.318507194519, false },
{1609.283203125, -1330.08203125, 17.025804519653, false },
{1635.6142578125, -1304.1845703125, 15.8690366745, false },
{1702.232421875, -1304.421875, 13.152853965759, false },
{1717.0419921875, -1284.6728515625, 13.10795211792, false },
{1716.8017578125, -1238.8544921875, 15.03083896637, false },
{1703.5068359375, -1159.0654296875, 23.381282806396, false },
{1682.64453125, -1158.9541015625, 23.380907058716, false },
{1648.8564453125, -1158.7529296875, 23.604070663452, false },
{1615.12890625, -1158.5810546875, 23.623123168945, false },
{1588.15234375, -1158.431640625, 23.631406784058, false },
{1550.650390625, -1158.1904296875, 23.631319046021, false },
{1506.6181640625, -1157.9384765625, 23.639621734619, false },
{1461.3974609375, -1157.623046875, 23.398988723755, false },
{1452.4580078125, -1179.0087890625, 22.877859115601, false },
{1452.3193359375, -1229.3173828125, 13.244059562683, false },
{1452.1572265625, -1283.482421875, 13.107929229736, false },
{1452.3876953125, -1337.0947265625, 13.107932090759, false },
{1452.3857421875, -1369.951171875, 13.107968330383, false },
{1451.990234375, -1426.9609375, 13.107970237732, false },
{1445.494140625, -1494.6708984375, 13.099008560181, false },
{1427.1376953125, -1578.3056640625, 13.08833694458, false },
{1427.2880859375, -1684.0654296875, 13.107966423035, false },
{1422.74609375, -1729.5302734375, 13.10796546936, false },
{1326.5947265625, -1729.9208984375, 13.107981681824, false },
{1295.7138671875, -1741.2001953125, 13.107970237732, false },
{1294.947265625, -1837.2080078125, 13.107969284058, false },
{1271.8818359375, -1843.556640625, 13.115390777588, false },
{1261.4453125, -1816.9765625, 13.124059677124, true, true }
}

function gazeteBasla(cmd)
	if not getElementData(getLocalPlayer(), "gazeteSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 574
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "gazeteSoforlugu", true)
			updategazeteRota()
			addEventHandler("onClientMarkerHit", resourceRoot, gazeteRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("temizlikbasla", gazeteBasla)

function updategazeteRota()
	gazeteMarker = gazeteMarker + 1
	for i,v in ipairs(gazeteRota) do
		if i == gazeteMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(gazeteCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(gazeteCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(gazeteCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function gazeteRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 574 then
				for _, marker in ipairs(gazeteCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updategazeteRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							gazeteMarker = 0
							triggerServerEvent("gazeteParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeni rotanız belirleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /siparisbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlendi, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updategazeteRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							toggleAllControls(false, true, false)
							outputChatBox("[!] #FFFFFFGazeteler sahiplerine teslim ediliyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFGazeteler teslim edilmiştir., geri dönebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updategazeteRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function gazeteBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local gazeteSoforlugu = getElementData(getLocalPlayer(), "gazeteSoforlugu")
	if pedVeh then
		if pedVehModel == 574 then
			if gazeteSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "gazeteSoforlugu", false)
				for i,v in ipairs(gazeteCreatedMarkers) do
					destroyElement(v[1])
				end
				gazeteCreatedMarkers = {}
				gazeteMarker = 0
				triggerServerEvent("gazeteBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, gazeteRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), gazeteAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("sipaisbitir", gazeteBitir)

function gazeteAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 574 and vehicleJob == 26 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 26 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için gazete Mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), gazeteAntiYabanci)

function gazeteAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			gazeteBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), gazeteAntiAracTerketme)