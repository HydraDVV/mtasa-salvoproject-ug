-- ROTA --
local kargoMarker = 0
local kargoCreatedMarkers = {}
local kargoRota = {
    { 1244.2578125, -1831.748046875, 13.398206710815, false }, -- başlangıç
	{ 1211.8330078125, -1846.3466796875, 13.3828125, false }, -- başlangıç
	{ 1182.53125, -1849.1318359375, 13.3984375, false },
	{ 1098.505859375, -1849.8525390625, 13.3828125, false },
	{ 1063.9052734375, -1846.705078125, 13.402320861816, false },
	{ 1012.3203125, -1791.7001953125, 13.89582824707, false },
	{ 913.1923828125, -1771.1884765625, 13.3828125, false },
	{ 808.9814453125, -1767.9326171875, 13.3984375, false },
	{ 720.36328125, -1752.9873046875, 14.437936782837, false },
	{ 627.4482421875, -1732.115234375, 13.730028152466, false },
	{ 533.4306640625, -1718.44921875, 12.645606040955, false },
	{ 469.697265625, -1710.7138671875, 11.007640838623, false },
	{ 456.2783203125, -1729.9345703125, 10.23951625824, false },
	{ 450.509765625, -1765.8349609375, 5.3875961303711, false },
	{ 425.890625, -1769.650390625, 5.2896904945374,  false },
	{ 406.8935546875, -1767.8876953125, 5.2897524833679, true, false },
	{ 375.69140625, -1769.54296875, 5.4030199050903, false },
	{ 346.923828125, -1760.658203125, 5.0115013122559, false },
	{ 297.484375, -1733.84765625, 4.2228045463562, false },
	{ 221.93359375, -1730.6640625, 4.2589917182922, false },
	{ 143.2197265625, -1731.21484375, 6.2034339904785, false },
	{ 117.923828125, -1672.0458984375, 9.7694330215454, false },
	{ 121.251953125, -1606.171875, 10.436918258667, false },
	{ 160.953125, -1558.52734375, 11.425116539001, false },
	{ 186.4248046875, -1518.1943359375, 12.457390785217, false },
	{ 252.169921875, -1440.0419921875, 13.45796585083, false },
	{ 344.7158203125, -1391.560546875, 14.260659217834, false },
	{ 477.3310546875, -1308.0283203125, 15.390844345093, false },
	{ 501.298828125, -1336.705078125, 15.9609375,  false },
	{ 513.109375, -1344.4072265625, 15.9609375,  false },
	{ 604.44140625, -1323.0556640625, 13.491295814514,  false },
	{ 674.1328125, -1321.88671875, 13.489936828613, false },
	{ 784.09765625, -1322.8291015625, 13.3828125, false },
{ 830.7138671875, -1328.5849609375, 13.401429176331, false },
{ 902.60546875, -1329.25, 13.46277141571, false },
{ 915.6259765625, -1338.369140625, 13.368521690369,  false },
{ 912.3720703125, -1379.9404296875, 13.310222625732, true, false },
{ 923.8291015625, -1407.814453125, 13.27187538147, false },
{ 1032.1748046875, -1408.158203125, 13.114892959595, false },
{ 1060.220703125, -1412.78125, 13.390127182007,  false },
{ 1051.97265625, -1481.001953125, 13.38666343689,  false },
{ 1035.72265625, -1547.259765625, 13.3515625,  false },
{ 1032.693359375, -1559.0166015625, 13.543376922607, true, false },
{ 1035.2626953125, -1613.89453125, 13.3828125,  false },
{ 1034.76171875, -1706.482421875, 13.390571594238,  false },
{ 1070.7646484375, -1714.734375, 13.3828125,  false },
{ 1161.9931640625, -1714.8486328125, 13.777568817139,  false },
{ 1172.755859375, -1743.322265625, 13.3984375,  false },
{ 1172.525390625, -1839.2041015625, 13.406253814697,  false },
{ 1196.0107421875, -1854.2705078125, 13.395920753479,  false },
{ 1251.255859375, -1854.5791015625, 13.3828125,  false },
{ 1269.802734375, -1840.076171875, 13.386640548706,  false },
{ 1242.3857421875, -1818.23046875, 13.416341781616, true, true }

}

function kargoBasla(cmd)
	if not getElementData(getLocalPlayer(), "kargoSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 482
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "kargoSoforlugu", true)
			updatekargoRota()
			addEventHandler("onClientMarkerHit", resourceRoot, kargoRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("kargobasla", kargoBasla)

function updatekargoRota()
	kargoMarker = kargoMarker + 1
	for i,v in ipairs(kargoRota) do
		if i == kargoMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(kargoCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(kargoCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(kargoCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function kargoRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 482 then
				for _, marker in ipairs(kargoCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatekargoRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							kargoMarker = 0
							triggerServerEvent("kargoParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeni rotanız belirleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /siparisbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlendi, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatekargoRota()
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
									updatekargoRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function kargoBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local kargoSoforlugu = getElementData(getLocalPlayer(), "kargoSoforlugu")
	if pedVeh then
		if pedVehModel == 482 then
			if kargoSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "kargoSoforlugu", false)
				for i,v in ipairs(kargoCreatedMarkers) do
					destroyElement(v[1])
				end
				kargoCreatedMarkers = {}
				kargoMarker = 0
				triggerServerEvent("kargoBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, kargoRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), kargoAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("kargobitir", kargoBitir)

function kargoAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 482 and vehicleJob == 28 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 28 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için kargo Mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), kargoAntiYabanci)

function kargoAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			kargoBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), kargoAntiAracTerketme)