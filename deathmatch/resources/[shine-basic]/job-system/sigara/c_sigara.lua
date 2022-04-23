local sigaraPed = createPed(16, 2235.8134765625, -2225.5595703125, 13.554685592651, 45, true)
setElementData(sigaraPed, "talk", 1)
setElementData(sigaraPed, "name", "Baran Sancak")
setElementFrozen(sigaraPed, true)

local levelEksikMsg = {
	"Şu sıralar pek iş yok, adamım.",
	"İşler biraz kötü, sonra gel."
}

local kabulEtMsg = {
	"Bana uyar, ahbap.",
	"Huh, güzel teklif.",
	"Ne zaman başlıyorum?",
}

local kabulEtmeMsg = {
	"İşim olmaz, adamım.",
	"Daha önemli işlerim var.",
	"Meşgulüm, ahbap.",
}

function sigaraGUI(thePlayer)
	local oyuncuBirlik = getPlayerTeam(thePlayer)
	local birlikTip = getElementData(oyuncuBirlik, "type")
	local birlikLevel = getElementData(oyuncuBirlik, "birlikLevel") or 1

	if (birlikTip == 0) or (birlikTip == 1) then
		if birlikLevel <= 0 then
			triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[Türkçe] Murak Elibaşında diyor ki: " .. levelEksikMsg[math.random(#levelEksikMsg)], 255, 255, 255, 10, {}, true)
			outputChatBox("[!] #FFFFFFBu işi yapabilmek için birliğinizin en az 3.seviye olması gerekmektedir.", 255, 0, 0, true)
			return
		else
			triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[Türkçe] Murak Elibaşında fısıldar: Hey, elimde bir sigara kaçakçılığı işi var. Ne dersin, ha?", 255, 255, 255, 3, {}, true)
			sigaraKabulGUI(thePlayer)
			return
		end
	else
		triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[Türkçe] Murak Elibaşında diyor ki: Seninle bir işim yok. Derhal toz ol buradan.", 255, 255, 255, 10, {}, true)			
		return
	end
end
addEvent("sigaraGUI", true)
addEventHandler("sigaraGUI", getRootElement(), sigaraGUI)

function sigaraKabulGUI(thePlayer)
	local screenW, screenH = guiGetScreenSize()
	local kacakcilikWindow = guiCreateWindow((screenW - 308) / 2, (screenH - 102) / 2, 308, 102, "SalvoMTA - Sigara Kaçakçılığı © REMAJOR", false)
	guiWindowSetSizable(kacakcilikWindow, false)

	local isLbl = guiCreateLabel(9, 26, 289, 19, "İşi kabul ediyor musun?", false, kacakcilikWindow)
	guiLabelSetHorizontalAlign(isLbl, "center", false)
	guiLabelSetVerticalAlign(isLbl, "center")
	
	local sigaraKabulBtn = guiCreateButton(9, 55, 142, 33, "Kabul Et", false, kacakcilikWindow)
	addEventHandler("onClientGUIClick", sigaraKabulBtn, 
		function()
			destroyElement(kacakcilikWindow)
			triggerServerEvent("acceptJob", getLocalPlayer(), 18)
			triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[Türkçe] " .. getPlayerName(thePlayer):gsub("_", " ") .. " diyor ki: " .. kabulEtMsg[math.random(#kabulEtMsg)], 255, 255, 255, 3, {}, true)
			triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[Türkçe] Murak Elibaşında diyor ki: Yandaki vanlardan birini alarak işe başla, araçlar yüklü ve yola çıkmaya hazır. Bol şanslar, ahbap.", 255, 255, 255, 3, {}, true)
			setTimer(function() outputChatBox("[!] #FFFFFFYandaki beyaz kamyonlardan birini alıp, /sigarabasla yazarak işe başlayabilirsiniz!", 0, 0, 255, true) end, 500, 1)
			return	
		end
	)
	
	local line = guiCreateLabel(9, 32, 289, 19, "____________________________________________________", false, kacakcilikWindow)
	guiLabelSetHorizontalAlign(line, "center", false)
	guiLabelSetVerticalAlign(line, "center")
	local sigaraIptalBtn = guiCreateButton(159, 55, 139, 33, "İptal Et", false, kacakcilikWindow)
	addEventHandler("onClientGUIClick", sigaraIptalBtn, 
		function()
			destroyElement(kacakcilikWindow)
			triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[Türkçe] " .. getPlayerName(thePlayer):gsub("_", " ") .. " diyor ki: " .. kabulEtmeMsg[math.random(#kabulEtmeMsg)], 255, 255, 255, 3, {}, true)
			return	
		end
	)
end

-- ROTA --
local sigaraMarker = 0
local sigaraCreatedMarkers = {}
local sigaraRota = {
{2232.6630859375, -2217.1240234375, 13.520951271057, false },
{2259.544921875, -2229.71875, 13.243564605713, false },
{2284.7080078125, -2254.99609375, 13.308483123779, false },
{2254.4453125, -2296.1337890625, 13.311322212219, false },
{2207.861328125, -2342.1142578125, 13.310049057007, false },
{2168.5771484375, -2398.2880859375, 13.309708595276, false },
{2157.79296875, -2452.4599609375, 13.309531211853, false },
{2157.8974609375, -2528.904296875, 13.309769630432, false },
{2151.66015625, -2603.310546875, 13.316577911377, false },
{2120.7216796875, -2646.478515625, 13.310260772705, false },
{2067.6689453125, -2666.7763671875, 13.30943107605, false },
{1988.724609375, -2667.9501953125, 9.1481733322144, false },
{1849.224609375, -2667.6923828125, 5.8024010658264, false },
{1713.4716796875, -2667.05078125, 5.8127841949463, false },
{1523.9384765625, -2667.412109375, 8.8129558563232, false },
{1429.076171875, -2665.642578125, 13.310145378113, false },
{1355.8623046875, -2603.716796875, 13.310329437256, false },
{1350.666015625, -2542.9560546875, 13.310524940491, false },
{1359.169921875, -2497.0771484375, 11.342221260071, false },
{1357.9482421875, -2457.779296875, 7.5934381484985, false },
{1334.486328125, -2447.6494140625, 7.5925645828247, false },
{1260.4970703125, -2442.7744140625, 8.5823812484741, false },
{1178.0107421875, -2411.828125, 10.258950233459, false },
{1109.6474609375, -2354.7666015625, 11.955703735352, false },
{1073.93359375, -2308.0634765625, 12.84715461731, false },
{1044.3125, -2248.9423828125, 12.882483482361, false },
{1038.6123046875, -2142.787109375, 12.890386581421, false },
{1056.6318359375, -2047.3935546875, 12.885977745056, false },
{1064.84765625, -1952.1416015625, 12.884034156799, false },
{1063.7275390625, -1852.98828125, 13.33349609375, false },
{1031.873046875, -1799.267578125, 13.609358787537, false },
{956.705078125, -1776.5673828125, 14.036981582642, false },
{905.7001953125, -1770.0625, 13.317483901978, false },
{828.765625, -1767.7197265625, 13.32917881012, false },
{746.49609375, -1760.115234375, 12.876399040222, false },
{669.6015625, -1737.673828125, 13.405106544495, false },
{601.6875, -1722.9912109375, 13.670255661011, false },
{502.87109375, -1709.7080078125, 11.879375457764, false },
{439.3193359375, -1701.5595703125, 10.181328773499, false },
{348.0556640625, -1698.3125, 6.5701489448547, false },
{263.3349609375, -1676.9140625, 8.845085144043, false },
{201.689453125, -1614.0029296875, 14.360291481018, false },
{151.42578125, -1558.13671875, 10.70819568634, false },
{111.19140625, -1531.541015625, 6.7353267669678, false },
{50.640625, -1522.8046875, 4.9977703094482, false },
{-20.3095703125, -1515.1513671875, 1.7520835399628, false },
{-71.4794921875, -1504.7919921875, 2.2279312610626, false },
{-125.02734375, -1458.9326171875, 2.6305463314056, false },
{-148.048828125, -1395.625, 2.6306483745575, false },
{-145.5576171875, -1310.6044921875, 2.6285605430603, false },
{-130.294921875, -1217.583984375, 2.630092382431, false },
{-101.099609375, -1145.986328125, 1.408389210701, false },
{-78.513671875, -1081.9296875, 9.8026838302612, false },
{-94.076171875, -1020.9384765625, 24.057598114014, false },
{-117.0771484375, -991.9091796875, 25.123525619507, false },
{-108.05078125, -962.923828125, 23.266971588135, false },
{-69.7294921875, -886.0341796875, 15.305816650391, false },
{-11.21484375, -764.9609375, 8.4273614883423, false },
{22.048828125, -687.0166015625, 4.5153923034668, false },
{50.7626953125, -594.0068359375, 4.9439878463745, false },
{32.197265625, -509.6767578125, 9.8550701141357, false },
{-32.125, -454.166015625, 1.5316977500916, false },
{-113.9931640625, -400.9521484375, 1.0130068063736, false },
{-159.5634765625, -360.466796875, 1.0124604701996, false },
{-199.73046875, -319.017578125, 1.0123265981674, false },
{-210.212890625, -296.244140625, 1.3601151704788, false },
{-187.9150390625, -278.7392578125, 1.3671941757202, true, false },
{-216.837890625, -286.6162109375, 1.3670933246613, false },
{-216.5439453125, -311.8203125, 1.0217773914337, false },
{-168.8515625, -360.8857421875, 1.0128189325333, false },
{-113.029296875, -408.9501953125, 1.0128420591354, false },
{-38.291015625, -456.537109375, 1.4221595525742, false },
{18.73046875, -502.7314453125, 8.8201246261597, false },
{44.2451171875, -544.2509765625, 10.141499519348, false },
{31.017578125, -643.7138671875, 3.0699415206909, false },
{-7.2802734375, -740.8203125, 7.2800970077515, false },
{-47.71875, -827.9462890625, 12.076612472534, false },
{-91.2470703125, -918.7197265625, 18.461660385132, false },
{-118.7607421875, -970.2001953125, 24.867826461792 , false },
{-106.0087890625, -1013.4013671875, 23.933979034424, false },
{-85.107421875, -1053.1982421875, 19.928369522095, false },
{-94.2080078125, -1116.232421875, 1.2137794494629, false },
{-123.138671875, -1180.1875, 2.6292078495026, false },
{-145.6416015625, -1267.947265625, 2.630175113678, false },
{-154.9580078125, -1354.1650390625, 2.6300024986267, false },
{-146.2509765625, -1427.8125, 2.6296350955963, false },
{-90.9052734375, -1501.083984375, 2.630841255188, false },
{-12.5732421875, -1522.6171875, 2.0062572956085, false },
{42.505859375, -1538.0810546875, 5.1381254196167, false },
{108.3544921875, -1552.55859375, 7.1813907623291, false },
{155.7421875, -1589.9404296875, 12.689070701599, false },
{209.68359375, -1655.482421875, 12.887615203857, false },
{273.796875, -1704.412109375, 7.6662993431091, false },
{372.2841796875, -1718.55078125, 7.0781836509705, false },
{449.6845703125, -1722.978515625, 10.067591667175, false },
{531.2138671875, -1733.357421875, 12.094234466553, false },
{620.5048828125, -1747.12890625, 13.231558799744, false },
{718.5966796875, -1773.455078125, 13.734676361084, false },
{803.8876953125, -1786.6279296875, 13.285682678223, false },
{871.703125, -1787.5283203125, 13.587615013123, false },
{967.9638671875, -1800.1044921875, 14.031594276428, false },
{1030.8203125, -1822.0546875, 13.644742965698, false },
{1043.68359375, -1857.8125, 13.341976165771, false },
{1044.744140625, -1969.6611328125, 12.882729530334, false },
{1032.921875, -2068.099609375, 12.882435798645, false },
{1016.1513671875, -2162.185546875, 12.884217262268, false },
{1033.8671875, -2275.3134765625, 12.890784263611, false },
{1101.2861328125, -2375.61328125, 11.750956535339, false },
{1197.1015625, -2443.876953125, 9.7271757125854, false },
{1282.5009765625, -2465.8310546875, 7.9802289009094, false },
{1314.0341796875, -2467.501953125, 7.5912189483643, false },
{1317.9189453125, -2487.9345703125, 9.8455266952515, false },
{1321.953125, -2525.62109375, 13.307488441467, false },
{1330.3955078125, -2573.7587890625, 13.316061973572, false },
{1357.1767578125, -2646.5048828125, 13.31005191803, false },
{1414.9931640625, -2682.3984375, 13.310290336609, false },
{1519.48828125, -2686.9853515625, 9.0674886703491, false },
{1632.4560546875, -2686.51171875, 5.8025317192078, false },
{1767.1171875, -2687.294921875, 5.8213276863098, false },
{1896.7060546875, -2687.623046875, 5.8267831802368, false },
{2026.322265625, -2687.18359375, 11.307124137878, false },
{2085.953125, -2684.5205078125, 13.311042785645, false },
{2140.1123046875, -2656.5146484375, 13.310208320618, false },
{2177.3916015625, -2574.47265625, 13.308637619019, false },
{2177.3994140625, -2475.9326171875, 13.309562683105, false },
{2183.09765625, -2417.375, 13.309600830078, false },
{2212.6044921875, -2366.16796875, 13.310888290405, false },
{2258.2255859375, -2319.7568359375, 13.310158729553, false },
{2294.38671875, -2283.744140625, 13.312514305115, false },
{2299.66015625, -2263.44921875, 13.310137748718, false },
{2284.1953125, -2247.779296875, 13.343690872192, false },
{2252.5078125, -2215.861328125, 13.260972976685, false },
{2232.6103515625, -2215.7880859375, 13.485271453857, false },
{2202.9765625, -2266.15234375, 13.489721298218, true, true}


}

function sigaraBasla(cmd)
	if not getElementData(getLocalPlayer(), "sigaraKacakciligi") then
		local oyuncuBirlik = getPlayerTeam(getLocalPlayer())
		local oyuncuBirlikType = getElementData(oyuncuBirlik, "type")
		local oyuncuBirlikLevel = getElementData(oyuncuBirlik, "birlik_level")
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 482
		if not getVehicleOccupant(oyuncuArac, 1) then
		if (oyuncuBirlikType == 0) or (oyuncuBirlikType == 1) then
			if oyuncuAracModel == kacakciAracModel then
				setElementData(getLocalPlayer(), "sigaraKacakciligi", true)
				updateSigaraRota()
				addEventHandler("onClientMarkerHit", resourceRoot, sigaraRotaMarkerHit)
			end
		end
		else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
		end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("sigarabasla", sigaraBasla)

function updateSigaraRota()
	sigaraMarker = sigaraMarker + 1
	for i,v in ipairs(sigaraRota) do
		if i == sigaraMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(sigaraCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(sigaraCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(sigaraCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function sigaraRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 482 then
				for _, marker in ipairs(sigaraCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updateSigaraRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							sigaraMarker = 0
							triggerServerEvent("sigaraParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFAracınıza yeni mallar yükleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /sigarabitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFAracınıza yeni mallar yüklenmiştir. Gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updateSigaraRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)	
						elseif marker[2] == true and marker[3] == false then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitPlayer, true)
							setElementFrozen(hitVehicle, true)
							outputChatBox("[!] #FFFFFFAracınızdaki mallar indiriliyor, lütfen bekleyiniz.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFAracınızdaki mallar indirilmiştir, geri dönebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									updateSigaraRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function sigaraBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local sigaraKacakciligi = getElementData(getLocalPlayer(), "sigaraKacakciligi")
	if pedVeh then
		if pedVehModel == 482 then
			if sigaraKacakciligi then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "sigaraKacakciligi", false)
				for i,v in ipairs(sigaraCreatedMarkers) do
					destroyElement(v[1])
				end
				sigaraCreatedMarkers = {}
				sigaraMarker = 0
				triggerServerEvent("sigaraBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, sigaraRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), sigaraAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("sigarabitir", sigaraBitir)

function sigaraAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 482 and vehicleJob == 18 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 18 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Sigara Kaçakçılığı mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), sigaraAntiYabanci)

function sigaraAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			sigaraBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), sigaraAntiAracTerketme)