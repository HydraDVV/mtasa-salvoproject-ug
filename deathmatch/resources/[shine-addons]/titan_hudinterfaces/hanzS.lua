mysql = exports.mysql
addEvent("levelGosterS", true)
addEventHandler("levelGosterS", getRootElement(), function()
	local serverName = getServerName()
	if string.find(serverName, "Safak Roleplay") then
		triggerClientEvent(source, "levelGoster", source)
	end
end)
addEvent("yorgunlukAnim",true)
	addEventHandler("yorgunlukAnim",root,function(target)
	setPedAnimation ( target, "FAT", "IDLE_tired", -1, true, false )
	setElementData(target, "tired", true)
	setTimer(triggerEvent, 6000, 1, "normalAnim", root, target )
end)
addEvent("normalAnim",true)
addEventHandler("normalAnim",root,function(target)
setPedAnimation ( target, "ped", "IDLE_tired", 200 )
setElementData(target, "tired", false)
end)
function saatlikBonus()
	for _, player in ipairs(exports.pool:getPoolElementsByType("player")) do
		if getElementData(player, "loggedin") == 1 then
			local exp = getElementData(player, "exp") or 0
			local exprange = getElementData(player, "exprange") or 8
			local level = getElementData(player, "level") or 1
			local bonus_m = 7000
			if getElementData(player, "vipver") == 1 then
				bonus_m = 13000
			elseif getElementData(player, "vipver") == 2 then
				bonus_m = 18000 
			elseif getElementData(player, "vipver") == 3 then
				bonus_m = 22000
			end
			exports.global:giveMoney(player, bonus_m)
			outputChatBox("[!] #FFFFFFTebrikler, saatlik bonus ["..bonus_m.."TL] kazandınız.", player, 0, 255, 0, true)
			if exp >= exprange then
				mysql:query_free("UPDATE characters SET level = "..tonumber(level + 1)..",exprange = "..tonumber(exprange + 8)..",exp = "..tonumber(0).." WHERE id = " .. mysql:escape_string(getElementData( player, "dbid" )) )
				setElementData(player, "level", level + 1)
				setElementData(player, "exprange", exprange + 8)
				setElementData(player, "exp", 0)
				outputChatBox("[!] #FFFFFFTebrikler, bir seviye atladınız!", player, 0, 255, 0, true)
				if getElementData(player, "level") == 5 then
					exports.global:giveMoney(player, 20000)
					outputChatBox("[!] #FFFFFFTebrikler, 5. seviyeye ulaştığınız için 20.000TL kazandınız.", player, 0, 255, 0, true)
				elseif getElementData(player, "level") == 10 then
					exports.global:giveMoney(player, 30000)
					outputChatBox("[!] #FFFFFFTebrikler, 10. seviyeye ulaştığınız için 30.000TL kazandınız.", player, 0, 255, 0, true)
				elseif getElementData(player, "level") == 15 then
					exports.global:giveMoney(player, 40000)
					outputChatBox("[!] #FFFFFFTebrikler, 15. seviyeye ulaştığınız için 40.000TL kazandınız.", player, 0, 255, 0, true)
				elseif getElementData(player, "level") == 20 then
					exports.global:giveMoney(player, 50000)
					outputChatBox("[!] #FFFFFFTebrikler, 20. seviyeye ulaştığınız için 50.000TL kazandınız.", player, 0, 255, 0, true)
				end
			else
				mysql:query_free("UPDATE characters SET exp = "..tonumber(exp+1).." WHERE id = " .. mysql:escape_string(getElementData( player, "dbid" )) )
				setElementData(player, "exp", exp+1)
			end
		end
	end
end
setTimer(saatlikBonus, 3600000, 0)
addCommandHandler("bonus",
	function (thePlayer)
		if exports.global:isPlayerLeadAdmin(thePlayer) then
			saatlikBonus()
		end
	end
)

--[[function aracVergi(thePlayer)
	for _, vehicle in ipairs(getElementsByType("vehicle")) do
		local vehicleID = getElementData(vehicle, "dbid")
		local vehOwner = getElementData(vehicle, "owner")
		local vehFact = getElementData(vehicle, "faction")
		if vehicleID > 0 and vehOwner > 0 and vehFact ~= 1 then
			local toplamVergi = getElementData(vehicle, "toplamvergi") or 0
			local faizKilidi = getElementData(vehicle, "faizkilidi")
			local aracfiyat = exports["carshop-system"]:getVehiclePrice(vehicle)
			local vergiSiniri = math.ceil((tonumber(aracfiyat) / 100) * 20)
			local vergiMiktari = 2*1000
			setElementData(vehicle, "toplamvergi", toplamVergi + vergiMiktari)
			local yeniVergi = getElementData(vehicle, "toplamvergi")
			if yeniVergi >= vergiSiniri then
				setElementData(vehicle, "faizkilidi", true)
				setVehicleEngineState(vehicle, false)
				setVehicleLocked(vehicle, true)
				setElementData(vehicle, "enginebroke", 1)
			end
		end
	end
end
addCommandHandler("vergi", aracVergi)]]
--[[addEvent("kaydet:aclikvesusuzluk", true)
function veriKaydetAclikveSusuzluk(client)
	local hunger = getElementData(client, "hunger")
	local thirst = getElementData(client, "thirst")
	local id = getElementData(client, "dbid") -- account:character:id
	if id then
		exports.mysql:query_free("UPDATE `characters` SET `hunger`='"..hunger.."' WHERE `id`='"..id.."' ")
		exports.mysql:query_free("UPDATE `characters` SET `thirst`='"..thirst.."' WHERE `id`='"..id.."' ")
	end
end
addEventHandler ("kaydet:aclikvesusuzluk",getRootElement(), veriKaydetAclikveSusuzluk)]]