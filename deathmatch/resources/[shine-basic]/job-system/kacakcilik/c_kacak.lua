local kacakcilikPed = createPed(16, 0, 0, 2938.625, -2049.6083984375, 3.5480432510376, true)
setElementData(kacakcilikPed, "talk", 1)
setElementData(kacakcilikPed, "name", "Ahmet Delen")
setElementFrozen(kacakcilikPed, true)

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

function kacakcilikGUI(thePlayer)
	local oyuncuBirlik = getPlayerTeam(thePlayer)
	local birlikTip = getElementData(oyuncuBirlik, "type")

	if (birlikTip == 0) or (birlikTip == 1) then
		triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[English] Joffrey Yount fısıldar: Hey, elimde bir içki kaçakçılığı işi var. Ne dersin, ha?", 255, 255, 255, 3, {}, true)
		kacakcilikKabulGUI(thePlayer)
		return
	else
        triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[English] Joffrey Yount diyor ki: Seninle bir işim yok. Derhal toz ol buradan.", 255, 255, 255, 10, {}, true)
		return	
	end
end
addEvent("kacakcilikGUI", true)
addEventHandler("kacakcilikGUI", getRootElement(), kacakcilikGUI)

function kacakcilikKabulGUI(thePlayer)
	local screenW, screenH = guiGetScreenSize()
	local kacakcilikWindow = guiCreateWindow((screenW - 308) / 2, (screenH - 102) / 2, 308, 102, "SalvoMTA - İçki Kaçakçılığı © REMAJOR", false)
	guiWindowSetSizable(kacakcilikWindow, false)

	local isLbl = guiCreateLabel(9, 26, 289, 19, "İşi kabul ediyor musun?", false, kacakcilikWindow)
	guiLabelSetHorizontalAlign(isLbl, "center", false)
	guiLabelSetVerticalAlign(isLbl, "center")
	
	local kacakcilikKabulBtn = guiCreateButton(9, 55, 142, 33, "Kabul Et", false, kacakcilikWindow)
	addEventHandler("onClientGUIClick", kacakcilikKabulBtn, 
		function()
			destroyElement(kacakcilikWindow)
			triggerServerEvent("acceptJob", getLocalPlayer(), 19)
			triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[English] " .. getPlayerName(thePlayer):gsub("_", " ") .. " diyor ki: " .. kabulEtMsg[math.random(#kabulEtMsg)], 255, 255, 255, 3, {}, true)
			triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[English] Joffrey Yount diyor ki: Yandaki kamyonlardan birini alarak işe başla, kamyonlar yüklü ve yola çıkmaya hazır. Bol şanslar, ahbap.", 255, 255, 255, 3, {}, true)
			setTimer(function() outputChatBox("[!] #FFFFFFYandaki beyaz kamyonlardan birini alıp, /kacakcilikbasla yazarak işe başlayabilirsiniz!", 0, 0, 255, true) end, 500, 1)
			return	
		end
	)
	
	local line = guiCreateLabel(9, 32, 289, 19, "____________________________________________________", false, kacakcilikWindow)
	guiLabelSetHorizontalAlign(line, "center", false)
	guiLabelSetVerticalAlign(line, "center")
	local kacakcilikIptalBtn = guiCreateButton(159, 55, 139, 33, "İptal Et", false, kacakcilikWindow)
	addEventHandler("onClientGUIClick", kacakcilikIptalBtn, 
		function()
			destroyElement(kacakcilikWindow)
			triggerServerEvent("sendLocalText", getLocalPlayer(), getLocalPlayer(), "[English] " .. getPlayerName(thePlayer):gsub("_", " ") .. " diyor ki: " .. kabulEtmeMsg[math.random(#kabulEtmeMsg)], 255, 255, 255, 3, {}, true)
			return	
		end
	)
end

-- ROTA --
local kacakcilikMarker = 0
local kacakcilikCreatedMarkers = {}
local kacakcilikRota = {
	{ 2934.3037109375, -2104.1298828125, 0.02403549477458, false },
	{ 2934.3037109375, -2104.1298828125, 0.02403549477458, false },
	{ 2906.642578125, -2394.1396484375, -0.36936607956886, false },
	{ 2885.7802734375, -2507.3515625, -0.70199108123779, false },
	{ 2807.9599609375, -2595.751953125, -0.63114011287689, false },
	{ 2691.673828125, -2655.0380859375, -0.19913052022457, false },
	{ 2584.3994140625, -2697.392578125, 0.067584589123726, false },
	{ 2482.123046875, -2716.52734375, -0.46727314591408, false },
	{ 2365.67578125, -2731.0302734375, -0.16923420131207, false },
	{ 2194.8037109375, -2762.5625, -0.30930188298225, false },
	{ 2042.4033203125, -2786.1708984375, -0.17180898785591, false },
	{ 1909.57421875, -2793.744140625, -0.10615152865648, false },
	{ 1748.4609375, -2799.3876953125, 0.03777289763093, false },
	{ 1607.4716796875, -2800.3369140625, -0.28102907538414, false },
	{ 1402.5634765625, -2782.4296875, -0.20133428275585, false },
	{ 1277.513671875, -2701.2705078125, -0.34861117601395, false },
	{ 1242.201171875, -2615.9072265625, -0.21563597023487, false },
	{ 1231.55859375, -2509.34375, -0.36510440707207, false },
	{ 1149.2529296875, -2451.3935546875, -0.34215775132179, false },
	{ 1054.541015625, -2380.7919921875, -0.062695913016796, false },
	{ 979.2939453125, -2297.73046875, -0.22605140507221, false },
	{ 937.2294921875, -2199.7958984375, -0.2375659942627, false },
	{ 760.03515625, -2089.435546875, -0.2721221446991, false },
	{ 630.8515625, -2072.228515625, -0.34035611152649, false },
	{ 519.7021484375, -2081.2861328125, -0.4063678085804, false },
	{ 429.2392578125, -2080.138671875, -0.24099351465702, false },
	{ 313.4580078125, -2077.1083984375, -0.061027765274048, false },
	{ 121.0166015625, -1931.3662109375, -0.13473209738731, false },
	{ 87.80078125, -1795.8056640625, -0.45203378796577, false },
	{ 70.6083984375, -1644.765625, -0.18462470173836, false },
	{ -3.20703125, -1560.8896484375, -0.32389333844185, true, false },
	{ 70.6083984375, -1644.765625, -0.18462470173836, false },
	{ 87.80078125, -1795.8056640625, -0.45203378796577, false },
	{ 121.0166015625, -1931.3662109375, -0.13473209738731, false },
	{ 313.4580078125, -2077.1083984375, -0.061027765274048, false },
	{ 429.2392578125, -2080.138671875, -0.24099351465702, false },
	{ 519.7021484375, -2081.2861328125, -0.4063678085804, false },
	{ 630.8515625, -2072.228515625, -0.34035611152649, false },
	{ 760.03515625, -2089.435546875, -0.2721221446991, false },
	{ 937.2294921875, -2199.7958984375, -0.2375659942627, false },
	{ 979.2939453125, -2297.73046875, -0.22605140507221, false },
	{ 1054.541015625, -2380.7919921875, -0.062695913016796, false },
	{ 1149.2529296875, -2451.3935546875, -0.34215775132179, false },
	{ 1231.55859375, -2509.34375, -0.36510440707207, false },
	{ 1242.201171875, -2615.9072265625, -0.21563597023487, false },
	{ 1277.513671875, -2701.2705078125, -0.34861117601395, false },
	{ 1402.5634765625, -2782.4296875, -0.20133428275585, false },
	{ 1607.4716796875, -2800.3369140625, -0.28102907538414, false },
	{ 1748.4609375, -2799.3876953125, 0.03777289763093, false },
	{ 1909.57421875, -2793.744140625, -0.10615152865648, false },
	{ 2042.4033203125, -2786.1708984375, -0.17180898785591, false },
	{ 2194.8037109375, -2762.5625, -0.309301882982252, false },
	{ 2365.67578125, -2731.0302734375, -0.16923420131207, false },
	{ 2482.123046875, -2716.52734375, -0.46727314591408, false },
	{ 2584.3994140625, -2697.392578125, 0.067584589123726, false },
	{ 2691.673828125, -2655.0380859375, -0.19913052022457, false },
	{ 2807.9599609375, -2595.751953125, -0.63114011287689, false },
	{ 2885.7802734375, -2507.3515625, -0.70199108123779, false },
	{ 2906.642578125, -2394.1396484375, -0.36936607956886, false },
	{ 2934.3037109375, -2104.1298828125, 0.02403549477458, false },
	{ 2934.3037109375, -2104.1298828125, 0.02403549477458, true, false }

}

function kacakcilikBasla(cmd)
	if not getElementData(getLocalPlayer(), "kacakcilikKacakciligi") then
		local oyuncuBirlik = getPlayerTeam(getLocalPlayer())
		local oyuncuBirlikType = getElementData(oyuncuBirlik, "type")
		local oyuncuBirlikLevel = getElementData(oyuncuBirlik, "birlik_level")
		local oyuncuArac = getPedOccupiedVehicle(getLocalPlayer())
		local oyuncuAracModel = getElementModel(oyuncuArac)
		local kacakciAracModel = 453
		if not getVehicleOccupant(oyuncuArac, 1) then
		--if (oyuncuBirlikType == 0) or (oyuncuBirlikType == 1) and (oyuncuBirlikLevel >= 3) then
			if oyuncuAracModel == kacakciAracModel then
				setElementData(getLocalPlayer(), "kacakcilikKacakciligi", true)
				updatekacakcilikRota()
				addEventHandler("onClientMarkerHit", resourceRoot, kacakcilikRotaMarkerHit)
			end
		--end
		else
		outputChatBox("[!] #FFFFFFSürücünün yanındaki koltuk boş olmalı.", 255, 0, 0, true)
		end
	else
		outputChatBox("[!] #FFFFFFZaten mesleğe başladınız!", 255, 0, 0, true)
	end
end
addCommandHandler("kacakcilikbasla", kacakcilikBasla)

function updatekacakcilikRota()
	kacakcilikMarker = kacakcilikMarker + 1
	for i,v in ipairs(kacakcilikRota) do
		if i == kacakcilikMarker then
			if not v[4] == true then
				local rotaMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 0, 0, 255, getLocalPlayer())
				table.insert(kacakcilikCreatedMarkers, { rotaMarker, false })
			elseif v[4] == true and v[5] == true then 
				local bitMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(kacakcilikCreatedMarkers, { bitMarker, true, true })	
			elseif v[4] == true then
				local malMarker = createMarker(v[1], v[2], v[3], "checkpoint", 4, 255, 255, 0, 255, getLocalPlayer())
				table.insert(kacakcilikCreatedMarkers, { malMarker, true, false })			
			end
		end
	end
end

function kacakcilikRotaMarkerHit(hitPlayer, matchingDimension)
	if hitPlayer == getLocalPlayer() then
		local hitVehicle = getPedOccupiedVehicle(hitPlayer)
		if hitVehicle then
			local hitVehicleModel = getElementModel(hitVehicle)
			if hitVehicleModel == 453 then
				for _, marker in ipairs(kacakcilikCreatedMarkers) do
					if source == marker[1] and matchingDimension then
						if marker[2] == false then
							destroyElement(source)
							updatekacakcilikRota()
						elseif marker[2] == true and marker[3] == true then
							local hitVehicle = getPedOccupiedVehicle(hitPlayer)
							setElementFrozen(hitVehicle, true)
							setElementFrozen(hitPlayer, true)
							toggleAllControls(false, true, false)
							kacakcilikMarker = 0
							triggerServerEvent("kacakcilikParaVer", hitPlayer, hitPlayer)
							outputChatBox("[!] #FFFFFFAracınıza yeni mallar yükleniyor, lütfen bekleyiniz. Eğer devam etmek istemiyorsanız, /kacakcilikbitir yazınız.", 0, 0, 255, true)
							setTimer(
								function(thePlayer, hitVehicle, hitMarker)
									destroyElement(hitMarker)
									outputChatBox("[!] #FFFFFFAracınıza yeni mallar yüklenmiştir. Gidebilirsiniz.", 0, 255, 0, true)
									setElementFrozen(hitVehicle, false)
									setElementFrozen(thePlayer, false)
									toggleAllControls(true)
									updatekacakcilikRota()
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
									updatekacakcilikRota()
								end, 100, 1, hitPlayer, hitVehicle, source
							)						
						end
					end
				end
			end
		end
	end
end

function kacakcilikBitir()
	local pedVeh = getPedOccupiedVehicle(getLocalPlayer())
	local pedVehModel = getElementModel(pedVeh)
	local kacakcilikKacakciligi = getElementData(getLocalPlayer(), "kacakcilikKacakciligi")
	if pedVeh then
		if pedVehModel == 456 then
			if kacakcilikKacakciligi then
				exports.global:fadeToBlack()
				setElementData(getLocalPlayer(), "kacakcilikKacakciligi", false)
				for i,v in ipairs(kacakcilikCreatedMarkers) do
					destroyElement(v[1])
				end
				kacakcilikCreatedMarkers = {}
				kacakcilikMarker = 0
				triggerServerEvent("kacakcilikBitir", getLocalPlayer(), getLocalPlayer())
				removeEventHandler("onClientMarkerHit", resourceRoot, kacakcilikRotaMarkerHit)
				removeEventHandler("onClientVehicleStartEnter", getRootElement(), kacakcilikAntiYabanci)
				setTimer(function() exports.global:fadeFromBlack() end, 2000, 1)
			end
		end
	end
end
addCommandHandler("kacakcilikbitir", kacakcilikBitir)

function kacakcilikAntiYabanci(thePlayer, seat, door) 
	local vehicleModel = getElementModel(source)
	local vehicleJob = getElementData(source, "job")
	local playerJob = getElementData(thePlayer, "job")
	
	if vehicleModel == 453 and vehicleJob == 22 then
		if thePlayer == getLocalPlayer() and seat ~= 0 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFMeslek aracına binemezsiniz.", 255, 0, 0, true)
		elseif thePlayer == getLocalPlayer() and playerJob ~= 22 then
			setElementFrozen(thePlayer, true)
			setElementFrozen(thePlayer, false)
			outputChatBox("[!] #FFFFFFBu araca binmek için Kaçakçılığı mesleğinde olmanız gerekmektedir.", 255, 0, 0, true)
		end
	end
end
addEventHandler("onClientVehicleStartEnter", getRootElement(), kacakcilikAntiYabanci)

function kacakcilikAntiAracTerketme(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		local theVehicle = source
		if seat == 0 then
			kacakcilikBitir()
		end
	end
end
addEventHandler("onClientVehicleStartExit", getRootElement(), kacakcilikAntiAracTerketme)