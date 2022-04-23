-- ROTA --
local cimbicmeMarker = 0
local cimbicmeCreatedMarkers = {}
local cimbicmeRota = {
{2055.4443359375, -1231.1279296875, 23.464162826538, false },
{2054.451171875, -1147.86328125, 23.433776855469, false },
{2007.6572265625, -1147.203125, 24.383598327637, false },
{1982.580078125, -1149.7255859375, 20.756074905396, false },
{1999, -1152.150390625, 21.936550140381, false },
{2031.2802734375, -1152.1904296875, 22.849964141846, false },
{2045.0400390625, -1246.7998046875, 23.083818435669, false },
{1988.115234375, -1247.6171875, 19.83959197998, false },
{2020.158203125, -1243.83984375, 22.736064910889, false },
{2041.923828125, -1237.80859375, 22.595712661743, false },
{2036.93359375, -1169, 22.141132354736, false },
{1983.9794921875, -1164.7861328125, 20.24340057373, false },
{1981.7490234375, -1172.2763671875, 19.771158218384, false },
{2008.1767578125, -1174.24609375, 20.268039703369, false },
{2018.0732421875, -1224.201171875, 21.300765991211, false },
{1987.05859375, -1229.607421875, 19.813432693481, false },
{1984.90234375, -1225.2060546875, 19.685966491699, false },
{2005.310546875, -1216.1845703125, 19.651414871216, false },
{2013.62890625, -1214.546875, 20.110919952393, false },
{2014.9189453125, -1207.2705078125, 19.725011825562, false },
{2013.9443359375, -1191.236328125, 19.668563842773, false },
{2002.7158203125, -1181.5244140625, 19.648260116577, false },
{1983.298828125, -1174.69921875, 19.653144836426, false },
{1981.5390625, -1161.783203125, 20.408178329468, false },
{1957.232421875, -1160.87109375, 20.474489212036, false },
{1956.9765625, -1173.744140625, 19.691730499268, false },
{1938.71484375, -1181.4248046875, 19.659049987793, false },
{1925.5830078125, -1189.5126953125, 20.079359054565, false },
{1925.4794921875, -1202.6103515625, 19.595708847046, false },
{1934.732421875, -1218.205078125, 19.657726287842, false },
{1959.3095703125, -1227.494140625, 19.551637649536, false },
{1962.74609375, -1248.0380859375, 19.59889793396, false },
{1906.40234375, -1249.6865234375, 13.444125175476, false },
{1863.787109375, -1248.326171875, 13.360297203064, false },
{1862.8115234375, -1217.8583984375, 18.7822265625, false },
{1862.7470703125, -1193.2509765625, 23.142347335815, false },
{1872.138671875, -1185.48046875, 23.227005004883, false },
{1877.9755859375, -1171.765625, 23.423686981201, false },
{1878.732421875, -1149.21484375, 23.513410568237, false },
{1956.9140625, -1149.349609375, 21.163236618042, false },
{1957.392578125, -1153.0703125, 20.823331832886, false },
{1911.32421875, -1155.9833984375, 23.16934967041, false },
{1891.8173828125, -1156.5966796875, 23.795812606812, false },
{1876.3525390625, -1188.98828125, 22.298475265503, false },
{1873.3984375, -1225.529296875, 16.466033935547, false },
{1880.2001953125, -1233.595703125, 14.86579990387, false },
{1883.482421875, -1242.4345703125, 13.898483276367, false },
{1953.9677734375, -1240.861328125, 19.304695129395, false },
{1958.2939453125, -1233.208984375, 19.415460586548, false },
{1934.3017578125, -1218.5712890625, 19.660196304321, false },
{1921.494140625, -1203.2275390625, 19.49250793457, false },
{1927.357421875, -1185.9091796875, 20.161100387573, false },
{1961.271484375, -1177.611328125, 19.603378295898, false },
{2006.2216796875, -1188.4541015625, 19.603385925293, false },
{2047.3525390625, -1248.6923828125, 23.306386947632, true, true }
}

function cimbicmeBasla(cmd)
	if not getElementData(getLocalPlayer(), "cimbicmeSoforlugu") then
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 572
	if not getVehicleOccupant(oyuncuArac, 1) then	
		if oyuncuAracModel == kacakciAracModel then
			setElementData(getLocalPlayer(), "cimbicmeSoforlugu", true)
			updatecimbicmeRota()
			addEventHandler("onClientMarkerHit", resourceRoot, cimbicmeRotaMarkerHit)
		end
	else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
	end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("cimbicmebasla", cimbicmeBasla)

function updatecimbicmeRota()
	cimbicmeMarker = cimbicmeMarker + 1
	for i,v in ipairs(cimbicmeRota) do
		if i == cimbicmeMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(cimbicmeCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(cimbicmeCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(cimbicmeCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function cimbicmeRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 572 then
				for _, marker in ipairs(cimbicmeCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatecimbicmeRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							cimbicmeMarker = 0
							triggerServerEvent("cimbicmeParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFYeni rotanız belirleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /siparisbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFYeni rotanız belirlendi, gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatecimbicmeRota()
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
									updatecimbicmeRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function cimbicmeBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local cimbicmeSoforlugu = getElementData(getLocalPlayer(), "cimbicmeSoforlugu")
	if pedVeh then
		if pedVehModel == 572 then
			if cimbicmeSoforlugu then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "cimbicmeSoforlugu", false)
				for i,v in ipairs(cimbicmeCreatedMarkers) do
					destroyElement(v[1])
				end
				cimbicmeCreatedMarkers = {}
				cimbicmeMarker = 0
				triggerServerEvent("cimbicmeBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, cimbicmeRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), cimbicmeAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("cimbicmebitir", cimbicmeBitir)

function cimbicmeAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 572 and vehicleJob == 32 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 32 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için cimbicme Mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), cimbicmeAntiYabanci)

function cimbicmeAnticimbicmeerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			cimbicmeBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), cimbicmeAnticimbicmeerketme)