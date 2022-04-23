local silahTurleri = {
	["colt45"]	= { 22, 17, 50000 },
	["deagle"]	= { 24, 17, 50000 },
	["silenced"]= { 23, 17, 60000 },
	["uzi"] 	= { 28, 25, 100000 },
	["tec9"]	= { 32, 25, 100000 },
	["mp5"] 	= { 29, 25, 100000 },
	["shotgun"]	= { 25, 10, 90000 },
	["ak47"]	= { 30, 25, 150000 },
	["m4"]		= { 31, 25, 170000 },
	["rifle"]	= { 33, 25, 100000 },
}

function mermiBilgi(thePlayer, cmd)
	for index, colShape in ipairs(exports.pool:getPoolElementsByType("colshape")) do
		if getElementData(colShape, "mermiYeri") then
			if isElementWithinColShape(thePlayer, colShape) then
				local playerTeam = getPlayerTeam(thePlayer)
				local playerTeamType = getElementData(playerTeam, "type")
				if not playerTeam then
					outputChatBox("[!] #f0f0f0Herhangi bir birliğiniz yok!", thePlayer, 255, 0, 0, true)
					return false
				end
				if playerTeamType == 1 or playerTeamType == 0 then
					outputChatBox("#FF0000===#C7E600> #FFFFFFColt45(colt45):17 Mermi (1 Şarjör) [₺50.000]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFRifle(rifle):17 Mermi (1 Şarjör) [₺100.000]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFDEAGLE(deagle):17 Mermi (1 Şarjör) [₺50.000]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFSİLENCED(silenced):17 Mermi (1 Şarjör) [₺60.000]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFUZI(uzi):25 Mermi (1 Şarjör) [₺100.000]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFTEC-9(tec9):25 Mermi (1 Şarjör) [₺100.000]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFMP5(mp5):25 Mermi (1 Şarjör) [₺100.000]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFSHOTGUN(shotgun):10 Mermi (1 Şarjör) [₺90.000]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFAK47(ak47):25 Mermi (1 Şarjör) [₺150.000]", thePlayer, 255, 255, 255, true)
					outputChatBox("#FF0000===#C7E600> #FFFFFFM4(m4):25 Mermi (1 Şarjör) [₺170.000]", thePlayer, 255, 255, 255, true)
					outputChatBox("#66FF33/mermial #FFFFFFcolt45 2 || yazarak 2 şarjor pistol mermisi alabilirsiniz.", thePlayer, 255, 255, 255, true)
					outputChatBox("#66FF33Colt 45'in adı colt45 olarak geçmektedir. /mermial colt45 2 yazarsanız colt45 markası alırsınız.", thePlayer, 255, 255, 255, true)
				else
					outputChatBox("[!] #f0f0f0Bu işlemi yapabilmek için bir illegal birliğe dahil olmanız gerekmektedir!", thePlayer, 255, 0, 0, true)
				end
			end
		end
	end
end
addCommandHandler("mermi", mermiBilgi)

function mermiAl(thePlayer, cmd, silahTuru, sarjorMiktari)
	for index, colShape in ipairs(exports.pool:getPoolElementsByType("colshape")) do
		if getElementData(colShape, "mermiYeri") then
			if isElementWithinColShape(thePlayer, colShape) then
				local playerTeam = getPlayerTeam(thePlayer)
				local playerTeamType = getElementData(playerTeam, "type")
				if playerTeamType == 1 or playerTeamType == 0 then
					if not silahTuru or not silahTurleri[string.lower(silahTuru)] or not sarjorMiktari then
						outputChatBox("[!] #f0f0f0SÖZDİZİMİ: /" .. cmd .. " [Mermi Türü] [Şarjör Miktarı]", thePlayer, 255, 0, 0, true)
						return false
					end
					if silahTurleri[string.lower(silahTuru)] then
						local playerWeapons = getPedWeapons(thePlayer)
						if not playerWeapons[1] then
							outputChatBox("[!] #f0f0f0Bu mermiyi satın almak için uygun silahınız yok veya üstünüzde başka silahlar var.", thePlayer, 255, 0, 0, true)
							return false
						end
						
						for index, weaponID in ipairs(playerWeapons) do
							if weaponID == silahTurleri[string.lower(silahTuru)][1] then
								local toplamFiyat = silahTurleri[string.lower(silahTuru)][3] * sarjorMiktari
								outputChatBox("[!] #f0f0f0Toplam tutar: $" .. toplamFiyat .. "! Satışı onaylamak için /mermionayla, iptal etmek için /mermiiptal yazın!", thePlayer, 0, 0, 255, true)
								setElementData(thePlayer, "mermi:tutar", toplamFiyat)
								setElementData(thePlayer, "mermi:sarjorMiktari", sarjorMiktari)
								setElementData(thePlayer, "mermi:silahTuru", silahTurleri[string.lower(silahTuru)][1])
								setElementData(thePlayer, "mermi:mermiMiktari", silahTurleri[string.lower(silahTuru)][2])
								return true
							else
								outputChatBox("[!] #f0f0f0Bu mermiyi satın almak için uygun silahınız yok veya üstünüzde başka silahlar var.", thePlayer, 255, 0, 0, true)
								return false
							end
						end
					end
				end
			end
		end
	end	
end
addCommandHandler("mermial", mermiAl)

function mermiOnayla(thePlayer, cmd)
	local mermiTutari = getElementData(thePlayer, "mermi:tutar")
	if mermiTutari then
		if exports.global:hasMoney(thePlayer, mermiTutari) then
			local sarjorMiktari = getElementData(thePlayer, "mermi:sarjorMiktari")
			local silahTuru = getElementData(thePlayer, "mermi:silahTuru")
			local mermiMiktari = getElementData(thePlayer, "mermi:mermiMiktari")
			
			exports.global:takeMoney(thePlayer, mermiTutari)
			for i = 1, sarjorMiktari do
				give, error = exports.global:giveItem(thePlayer, 116, silahTuru..":"..mermiMiktari..":Ammo for "..getWeaponNameFromID(silahTuru))
			end
			setElementData(thePlayer, "mermi:tutar", false)
			setElementData(thePlayer, "mermi:sarjorMiktari", false)
			setElementData(thePlayer, "mermi:silahTuru", false)
			outputChatBox("[!] #f0f0f0Satış başarıyla gerçekleştirildi! " .. sarjorMiktari .. " Şarjör (" .. mermiMiktari .. ") için toplam $" .. mermiTutari .. " ödediniz!", thePlayer, 0, 255, 0, true)
		else
			outputChatBox("[!] #f0f0f0Yeterli paranız yok!", thePlayer, 255, 0, 0, true)
		end
	end
end
addCommandHandler("mermionayla", mermiOnayla)

function mermiIptal(thePlayer, cmd)
	local mermiTutari = getElementData(thePlayer, "mermi:tutar")
	if mermiTutari then
		setElementData(thePlayer, "mermi:tutar", false)
		setElementData(thePlayer, "mermi:sarjorMiktari", false)
		setElementData(thePlayer, "mermi:silahTuru", false)
		outputChatBox("[!] #f0f0f0Satışı başarıyla iptal ettiniz!", thePlayer, 0, 255, 0, true)
	end
end
addCommandHandler("mermiiptal", mermiIptal)

-- NECKTROX
function getPedWeapons(ped)
    local weaponList = {}
 
    for i = 0, 12 do
        local weaponID = getPedWeapon(ped, i)
 
        if weaponID ~= 0 then
            table.insert(weaponList, weaponID)
        end
    end
   
    return weaponList
end