mysql = exports.mysql
function mixDrugs(drug1, drug2, drug1name, drug2name)
	-- 30 = Cannabis Sativa
	-- 31 = Cocaine Alkaloid
	-- 32 = Lysergic Acid
	-- 33 = Unprocessed PCP
	
	-- 34 = Cocaine
	-- 35 = Drug 2
	-- 36 = Drug 3
	-- 37 = Drug 4
	-- 38 = Marijuana
	-- 39 = Drug 6
	-- 40 = Drug 7
	-- 41 = LSD
	-- 42 = Drug 9
	-- 43 = Angel Dust
	local drugName
	local drugID
	
	if (drug1 == 31 and drug2 == 31) then -- Cocaine
		drugID = 34
	elseif (drug1==30 and drug2==31) or (drug1==31 and drug2==30) then -- Drug 2
		drugID = 35
	elseif (drug1==32 and drug2==31) or (drug1==31 and drug2==32) then -- Drug 3
		drugID = 36
	elseif (drug1==33 and drug2==31) or (drug1==31 and drug2==33) then -- Drug 4
		drugID = 37
	elseif (drug1==30 and drug2==30) then -- Marijuana
		drugID = 38
	elseif (drug1==30 and drug2==32) or (drug1==32 and drug2==30) then -- Drug 6
		drugID = 39
	elseif (drug1==30 and drug2==33) or (drug1==33 and drug2==30) then -- Drug 7
		drugID = 40
	elseif (drug1==32 and drug2==32) then -- LSD
		drugID = 41
	elseif (drug1==32 and drug2==33) or (drug1==33 and drug2==32) then -- Drug 9
		drugID = 42
	elseif (drug1==33 and drug2==33) then -- Angel Dust
		drugID = 43
	end
	drugName = getItemName(drugID)
	
	if (drugName == nil or drugID == nil) then
		outputChatBox("Error #1000 - Report on http://owlgaming.net/mantis", source, 255, 0, 0)
		return
	end
	
	exports.global:takeItem(source, drug1)
	exports.global:takeItem(source, drug2)
	local given = exports.global:giveItem(source, drugID, 1)
	
	if (given) then
		outputChatBox("You mixed '" .. drug1name .. "' and '" .. drug2name .. "' to form '" .. drugName .. "'", source)
		exports.global:sendLocalMeAction(source, "mixes some chemicals together.")
	else
		outputChatBox("You do not have enough space to mix these chemicals.", source, 255, 0, 0)
		exports.global:giveItem(source, drug1, 1)
		exports.global:giveItem(source, drug2, 1)
	end
end
addEvent("mixDrugs", true)
addEventHandler("mixDrugs", getRootElement(), mixDrugs)

function bagimlilikArttir()
	local id = getElementData(source, "dbid")
	local bagimlilikOrani = getElementData(source, "saglik:uyusturucu_bagimlilik") or 0
	if bagimlilikOrani < 20 then
		mysql:query_free("UPDATE `characters` SET `bagimlilik`=20 WHERE `id`='"..tostring(id).."'" )
		setElementData(source, "saglik:uyusturucu_bagimlilik", 20)
	elseif bagimlilikOrani < 30 then
		mysql:query_free("UPDATE `characters` SET `bagimlilik`=30 WHERE `id`='"..tostring(id).."'" )
		setElementData(source, "saglik:uyusturucu_bagimlilik", 30)
	elseif bagimlilikOrani < 50 then
		mysql:query_free("UPDATE `characters` SET `bagimlilik`=50 WHERE `id`='"..tostring(id).."'" )
		setElementData(source, "saglik:uyusturucu_bagimlilik", 50)
	elseif bagimlilikOrani < 60 then
		mysql:query_free("UPDATE `characters` SET `bagimlilik`=60 WHERE `id`='"..tostring(id).."'" )
		setElementData(source, "saglik:uyusturucu_bagimlilik", 60)
	elseif bagimlilikOrani < 80 then
		mysql:query_free("UPDATE `characters` SET `bagimlilik`=80 WHERE `id`='"..tostring(id).."'" )
		setElementData(source, "saglik:uyusturucu_bagimlilik", 80)
	elseif bagimlilikOrani < 100 then
		mysql:query_free("UPDATE `characters` SET `bagimlilik`=100 WHERE `id`='"..tostring(id).."'" )
		setElementData(source, "saglik:uyusturucu_bagimlilik", 100)
	end
	if not (bagimlilikOrani >= 99) then
		outputChatBox("[!] #f0f0f0Uyuşturucuya bağımlılık oranınız artık %" .. getElementData(source, "saglik:uyusturucu_bagimlilik") .. " olmuştur!", source, 0, 0, 255, true)
	else
		outputChatBox("[!] #f0f0f0Bir uyuşturucu bağımlısısınız!", source, 0, 0, 255, true)
	end
end
addEvent("bagimlilikArttir", true)
addEventHandler("bagimlilikArttir", root, bagimlilikArttir)

function setBagimlilik(thePlayer, cmd, targetPlayerName, oran)
	if exports.integration:isPlayerLeadAdmin(thePlayer) then
		if not targetPlayerName or not oran then
			outputChatBox("SYNTAX: /" .. cmd .. " [Partial Player Nick] [Oran]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayerName )
			if not targetPlayer then
			elseif getElementData( targetPlayer, "loggedin" ) ~= 1 then
				outputChatBox( "Player is not logged in.", thePlayer, 255, 0, 0 )
			else
				local id = getElementData(thePlayer, "dbid")
				mysql:query_free("UPDATE `characters` SET `bagimlilik`="..tonumber(oran).." WHERE `id`='"..tostring(id).."'" )
				setElementData(targetPlayer, "saglik:uyusturucu_bagimlilik", tonumber(oran))
				outputChatBox("You've set ".. targetPlayerName .. "'s bagimlilik to " .. oran .. ".", thePlayer, 0, 255, 0)
				--outputChatBox("An admin set your bagimlilik to " .. hunger .. ".", targetPlayer, 0, 255, 0)
			end
		end
	end
end
addCommandHandler("setbagimlilik", setBagimlilik)

function bagimlilikOraniKontrol(thePlayer)
	local bagimlilikOrani = getElementData(thePlayer, "saglik:uyusturucu_bagimlilik") or 0
	outputChatBox("[!] #ffffffBağımlılık Oranınız: %" .. tostring(bagimlilikOrani) .. "! ))", thePlayer, 100, 100, 200, true)
end
addCommandHandler("bagimlilik", bagimlilikOraniKontrol)