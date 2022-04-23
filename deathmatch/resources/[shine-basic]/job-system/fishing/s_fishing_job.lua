-- FORCE
-- EDITLEYEBİLİRSİNZ.
local bonus = 0
local sudakPara = 35 + bonus
local denizPara = 25 + bonus
local derePara = 20 + bonus
local dagPara = 30 + bonus

--[[

]]--

-- BURADAN AŞAĞIDAKİLERİ EDITLEMEYIN.
local yemx, yemy, yemz = 356.5810546875, -2026.201171875, 7.8359375
local yemCol = createColSphere(yemx, yemy, yemz, 2)
local balikCol = createColPolygon(360.2646484375, -2047.708984375, 349.84375, -2047.708984375, 349.8466796875, -2088.7978515625, 409.24609375, -2088.7978515625, 409.25390625, -2047.7099609375, 399.392578125, -2047.7099609375, 399.513671875, -2048.248046875, 408.4306640625, -2048.2607421875, 408.322265625, -2087.6474609375, 350.8984375, -2087.5585937, 350.7744140625, -2048.453125, 360.427734375, -2048.681640625, 360.2431640625, -2047.709960937)

local mangalCol1 = createColSphere(362.359375, -2030.1826171875, 7.8300905227661, 1)
local mangalCol2 = createColSphere(362.453125, -2032.466796875, 7.8300905227661, 1)
local mangalCol3 = createColSphere(362.453125, -2034.3486328125, 7.8300905227661, 1)
local mangalCol4 = createColSphere(362.4521484375, -2036.52734375, 7.8359375, 1)

function balikYardim(thePlayer)
	if isElementWithinColShape(thePlayer, yemCol) then
		outputChatBox("----------------------------------------------------------------------------------", thePlayer, 255, 0, 0)
		outputChatBox("==> Yem Almak İçin /yemal --",thePlayer,255,240,240)
		outputChatBox("==> Balık Satmak İçin /baliksat --",thePlayer,255,240,240)
		outputChatBox("==> Yem ve Balık Bilgileriniz İçin /balikdurum --",thePlayer,255,240,240)
		outputChatBox("==> Oltaniz bug'a girerse /balikbug yazip duzeltebilirsiniz. --",thePlayer,255,240,240)
		outputChatBox("----------------------------------------------------------------------------------", thePlayer, 255, 0, 0)
	end
end
addCommandHandler("balikyardim", balikYardim)

addCommandHandler("baliktut", 
	function(thePlayer, cmd)
		if isElementWithinColShape(thePlayer, balikCol) then
			if (not getElementData(thePlayer, "balikTutuyor")) then
				local toplamyem = getElementData(thePlayer, "toplamyem") or 0
				if toplamyem > 0 then
					triggerEvent("artifacts:toggle", thePlayer, thePlayer, "rod")
					exports.global:applyAnimation(thePlayer, "SWORD", "sword_IDLE", -1, false, true, true, false)
					setElementData(thePlayer, "balikTutuyor", true)
					exports.global:sendLocalMeAction(thePlayer, "oltasını denize doğru sallar.", false, true)
					outputChatBox("[!] #ffffffBalık tutuyorsunuz, lütfen bekleyin!", thePlayer, 10, 10, 255, true)
					setElementData(thePlayer, "toplamyem", toplamyem - 1)
					setTimer(function(thePlayer) 
						--local toplambalik = getElementData(thePlayer, "toplambalik") or 0
						local rastgeleSayi = math.random(1, 2)
						if rastgeleSayi == 1 then
							local balikTipi1 = yuzdelikOran(50)
							local balikTipi2 = yuzdelikOran(30)
							local balikTipi3 = yuzdelikOran(10)
							
							-- ORANI EN DÜŞÜKTEN BAŞLAYARAK SIRALANMALIDIR.
							if balikTipi3 then
								exports["item-system"]:giveItem(thePlayer, 239, 1) -- SUDAK BALIĞI
								outputChatBox("[!] #ffffffTebrikler, bir adet 'Sudak Balığı' tuttunuz!", thePlayer, 0, 255, 0, true)					
							elseif balikTipi2 then
								exports["item-system"]:giveItem(thePlayer, 236, 1) -- DAĞ ALABALIĞI
								outputChatBox("[!] #ffffffTebrikler, bir adet 'Dağ Alabalığı' tuttunuz!", thePlayer, 0, 255, 0, true)
							elseif balikTipi1 then
								exports["item-system"]:giveItem(thePlayer, 238, 1) -- DENİZ ALABALIĞI
								outputChatBox("[!] #ffffffTebrikler, bir adet 'Deniz Alabalığı' tuttunuz!", thePlayer, 0, 255, 0, true)		
							else -- Hiçbiri Vurmazsa, (Değeri en düşük balık.)
								exports["item-system"]:giveItem(thePlayer, 237, 1) -- DERE ALABALIĞI
								outputChatBox("[!] #ffffffTebrikler, bir adet 'Dere Alabalığı' tuttunuz!", thePlayer, 0, 255, 0, true)		
							end
							--setElementData(thePlayer, "toplambalik", toplambalik + 1)
						elseif rastgeleSayi >= 2 then
							outputChatBox("[!] #ffffffMalesef, balık tutamadınız.", thePlayer, 255, 0, 0, true)
						end
						exports.global:removeAnimation(thePlayer)
						triggerEvent("artifacts:toggle", thePlayer, thePlayer, "rod")
						setElementData(thePlayer, "balikTutuyor", false)
					end, 20000, 1, thePlayer)
				else
					outputChatBox("[!] #ffffffMalesef, üzerinizde yem kalmadı.", thePlayer, 255, 0, 0, true)
				end
			end
		end
	end
)

--addCommandHandler("balikbug", function(thePlayer) setElementData(thePlayer, "balikTutuyor", false) end)

addCommandHandler("balikdurum", 
	function(thePlayer, cmd)
		local yem = getElementData(thePlayer, "toplamyem") or 0
		--local balik = getElementData(thePlayer, "toplambalik") or 0
		local toplamBalik = exports["item-system"]:countItems(thePlayer, 236, 1) + exports["item-system"]:countItems(thePlayer, 237, 1) + exports["item-system"]:countItems(thePlayer, 238, 1) + exports["item-system"]:countItems(thePlayer, 239, 1)
		outputChatBox("-----------------------------------------", thePlayer, 255, 0, 0)
		outputChatBox("==> Toplam Balık: " .. tostring(toplamBalik), thePlayer, 255, 240, 240)
		outputChatBox("==> Toplam Yem: " .. tostring(yem), thePlayer, 255, 240, 240)
		outputChatBox("-----------------------------------------", thePlayer, 255, 0, 0)
	end
)

function yemAl(thePlayer, cmd)
	local para = exports.global:getMoney(thePlayer)
	if para >= 1 then
		if isElementWithinColShape(thePlayer, yemCol) then
			local toplamyem = getElementData(thePlayer, "toplamyem") or 0
			if toplamyem >= 20 then
				outputChatBox("[!] #ffffffMalesef, daha fazla yem alamazsınız.", thePlayer, 255, 0, 0, true)
				return
			elseif toplamyem <= 20 then
				exports.global:takeMoney(thePlayer, 1)
				if (toplamyem + 10) <= 20 then
					setElementData(thePlayer, "toplamyem", toplamyem + 10)
					outputChatBox("[!] #ffffff10 Adet yem aldınız.", thePlayer, 10, 10, 255, true)
				elseif (toplamyem + 10) >= 20 then
					alinamayanYem = toplamyem + 10 - 20
					alinanYem = 10 - alinamayanYem
					setElementData(thePlayer, "toplamyem", 20)
					outputChatBox("[!] #ffffff" .. tostring(alinanYem) .. " Adet yem aldınız.", thePlayer, 10, 10, 255, true)
				end
			end
		end
	else
		outputChatBox("[!] #ffffffYem almak için paranız yok.", thePlayer, 255, 0, 0, true)
	end
end
addCommandHandler("yemal", yemAl)

function balikSat(thePlayer, cmd)
	local denizMiktar = exports["item-system"]:countItems(thePlayer, 237, 1) or 0
	local dagMiktar = exports["item-system"]:countItems(thePlayer, 236, 1) or 0
	local dereMiktar = exports["item-system"]:countItems(thePlayer, 238, 1) or 0
	local sudakMiktar = exports["item-system"]:countItems(thePlayer, 239, 1) or 0
	
	if isElementWithinColShape(thePlayer, yemCol) then
		local toplambalik = denizMiktar + dagMiktar + dereMiktar + sudakMiktar
		if toplambalik <= 0 then
			outputChatBox("[!] #ffffffSatacak balığınız yok!", thePlayer, 255, 0, 0, true)
			return
		else
			verilecekPara = (denizMiktar * denizPara) + (dagMiktar * dagPara) + (dereMiktar * derePara) + (sudakMiktar * sudakPara)
			exports.global:giveMoney(thePlayer, verilecekPara)
			for i = 0, denizMiktar do
				exports["item-system"]:takeItem(thePlayer, 237, 1)
			end
			for i = 0, dagMiktar do
				exports["item-system"]:takeItem(thePlayer, 236, 1)
			end
			for i = 0, dereMiktar do
				exports["item-system"]:takeItem(thePlayer, 238, 1)
			end
			for i = 0, sudakMiktar do
				exports["item-system"]:takeItem(thePlayer, 239, 1)
			end
			outputChatBox("[!] #ffffff" .. tostring(toplambalik) .. " tane balıktan toplam $" .. tostring(verilecekPara) .. " kazandınız!", thePlayer, 0, 255, 0, true)
			outputChatBox("[!] #ffffffTuttugunuz Baliklar;", thePlayer, 0, 0, 255, true)
			outputChatBox("✹ #ffffff '" .. tostring(sudakMiktar) .. "' Sudak Balığı '$" .. tostring(sudakMiktar * sudakPara) .. " kazandınız.", thePlayer, 0, 0, 255, true)
			outputChatBox("✹ #ffffff '" .. tostring(dereMiktar) .. "' Dere Alabalığından '$" .. tostring(dereMiktar * derePara) .. " kazandınız.", thePlayer, 0, 0, 255, true)
			outputChatBox("✹ #ffffff '" .. tostring(denizMiktar) .. "' Deniz Alabalığından '$" .. tostring(denizMiktar * denizPara) .. " kazandınız.", thePlayer, 0, 0, 255, true)
			outputChatBox("✹ #ffffff '" .. tostring(dagMiktar) .. "' Dağ Alabalığından '$" .. tostring(dagMiktar * dagPara) .. " kazandınız.", thePlayer, 0, 0, 255, true)
			
			--setElementData(thePlayer, "toplambalik", 0)
		end
	end
end
addCommandHandler("baliksat", balikSat)

--addCommandHandler("bugtest", function(thePlayer, cmd, miktar) setElementData(thePlayer, "toplambalik", tonumber(miktar)) end)


--[[function balikPisir(thePlayer, cmd)
	local toplamBalik = getElementData(thePlayer, "toplambalik") or 0
	if isElementWithinColShape(thePlayer, mangalCol1) or isElementWithinColShape(thePlayer, mangalCol2) or isElementWithinColShape(thePlayer, mangalCol3) or isElementWithinColShape(thePlayer, mangalCol4) then
		if toplamBalik > 0 then
			outputChatBox("[!] #ffffffBalıklarınız pişiriliyor, lütfen bekleyin!", thePlayer, 10, 10, 255, true)
			exports.global:sendLocalMeAction(thePlayer, "kovasında bulunan balığı mangala yerleştirir ve pişmesini bekler.", false, true)
			setTimer(function(thePlayer)
				outputChatBox("[!] #ffffffBalklarınız pişirildi!", thePlayer, 0, 255, 0, true)
				if getElementData(thePlayer, "hunger") + 20 >= 100 then
					setElementData(thePlayer, "hunger", 100)
				else
					setElementData(thePlayer, "hunger", getElementData(thePlayer, "hunger") + 20)
				end
				setElementData(thePlayer, "toplambalik", toplamBalik - 1)
				exports.global:sendLocalDoAction(thePlayer, "Balık pişmiştir.", false, true)
				exports.global:sendLocalMeAction(thePlayer, "balığı mangaldan alır ve yemeye başlar.", false, true)
			end, 5000, 1, thePlayer)
		else
			outputChatBox("[!] #ffffffPişirecek balığınız yok!", thePlayer, 255, 0, 0, true)
		end
	end
end
addCommandHandler("balikpisir", balikPisir)
]]

function yuzdelikOran (percent)
	assert(percent >= 0 and percent <= 100) 
	return percent >= math.random(1, 100)
end