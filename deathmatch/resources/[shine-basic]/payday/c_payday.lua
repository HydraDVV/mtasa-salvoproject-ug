function cPayDay(faction, pay, profit, interest, donatormoney, tax, incomeTax, vtax, ptax, rent, grossincome)
	--local cPayDaySound = playSound("mission_accomplished.mp3")
	local Perc = 0
	local bankmoney = getElementData(getLocalPlayer(), "bankmoney")
	local moneyonhand = getElementData(getLocalPlayer(), "money")
	local wealthCheck = moneyonhand + bankmoney
	if (wealthCheck >= 0) and (wealthCheck < 99000) then
		Perc = 2
	elseif (wealthCheck >= 99000) and (wealthCheck < 500000) then
		Perc = 0.5
	elseif (wealthCheck >= 500000) then
		Perc = 0.1
	end
	--setSoundVolume(cPayDaySound, 0.7)
	
	-- output payslip
	-- output payslip
	--outputChatBox("Dev:#ffffff Saatlik Bonus Sistemi", 44,44,44,true)
		
	-- state earnings/money from faction
	if not (faction) then
		if (pay + tax > 0) then
		--	outputChatBox("Dev: #ffffffDevlet Faydaları: #00FF00₺" .. exports.global:formatMoney(pay+tax), 44,44,44, true)
		end
	else
		if (pay + tax > 0) then
		--	outputChatBox("Dev: #ffffffMaaş: #00FF00₺" .. exports.global:formatMoney(pay+tax), 44,44,44, true)
		end
	end
	
	-- business profit
	if (profit > 0) then
		--outputChatBox("Dev: #ffffffİş Kari: #00FF00₺" .. exports.global:formatMoney(profit), 44,44,44, true)
	end
	
	-- bank interest
	if (interest > 0) then
	--	outputChatBox("Dev: #ffffffBanka Faizleriniz: #00FF00₺" .. exports.global:formatMoney(interest) .. " (" ..tonumber(Perc).. "%)",44,44,44, true)
	end
	
	-- donator money (nonRP)
	if (donatormoney > 0) then
		--outputChatBox("Donater Parasi: #00FF00₺" .. exports.global:formatMoney(donatormoney), 44,44,44, true)
	end
	
	-- Above all the + stuff
	-- Now the - stuff below
	
	-- income tax
	if (tax > 0) then
		--outputChatBox("Dev: #ffffffGelir Vergisi " .. (math.ceil(incomeTax*100)) .. "%: #FF0000₺" .. exports.global:formatMoney(tax), 44,44,44, true)
	end
	
	if (vtax > 0) then
		--outputChatBox("Dev: #ffffffTaşıt Vergisi: #FF0000₺" .. exports.global:formatMoney(vtax), 44,44,44, true)
	end
	
	if (ptax > 0) then
		--outputChatBox("Dev: #ffffffMülkiyet Giderleri: #FF0000₺" .. exports.global:formatMoney(ptax), 44,44,44, true )
	end
	
	if (rent > 0) then
		--outputChatBox("Dev: #ffffffDaire Kiralık: #FF0000₺" .. exports.global:formatMoney(rent), 44,44,44, true)
	end
	
	--outputChatBox("-----------------------------------------------------------------------------------------------", 44,44,44,true)
	
	if grossincome == 0 then
		--outputChatBox("Dev: #ffffffBrüt Gelir: ₺0",44,44,44, true)
	elseif (grossincome > 0) then
		--outputChatBox("Dev: #ffffffBrüt Gelir: #00FF00₺" .. exports.global:formatMoney(grossincome),44,44,44, true)
		--outputChatBox("Dev: #ffffffRemark(s): Transfered to your bank account.", 44,44,44,true)
	else
		--outputChatBox("Dev: #ffffffBrüt Gelir: #FF0000₺" .. exports.global:formatMoney(grossincome), 44,44,44, true)
		--outputChatBox("Dev: #ffffffRemark(s): Taking from your bank account.", 44,44,44,true)
	end
	
	
	if (pay + tax == 0) then
		if not (faction) then
			--outputChatBox("#ffcc00[?] #ff0000Hükümet size devlet yardımı yapamadı.", 255, 0, 0,true)
		else
		--	outputChatBox("#ffcc00[?] #ff0000İşvereniniz maaşınızı ödeyemedi.", 255, 0, 0,true)
		end
	end
	
	if (rent == -1) then
		--outputChatBox("Artık kira ödeyemediğin için kovuldun.", 255, 0, 0)
	end
	
	--outputChatBox("#ffffff-----------------------------------------------------------------------------------------------", 44,44,44,true)
	-- end of output payslip
	
	triggerEvent("updateWaves", getLocalPlayer())
end
addEvent("cPayDay", true)
addEventHandler("cPayDay", getRootElement(), cPayDay)



addEvent("paraGelmeSesiCalistir", true)
addEventHandler("paraGelmeSesiCalistir", getRootElement(),
	function()
		local randomSayi = math.random(1,3)
		if randomSayi == 1 then
			local paraGelmeSesi = playSound("music/paraGelmeSesi.mp3")   
			setSoundVolume(paraGelmeSesi, 0.1)
		elseif randomSayi == 2 then
			local paraGelmeSesi = playSound("music/paraGelmeSesi1.mp3")   
			setSoundVolume(paraGelmeSesi, 0.1)
		elseif randomSayi == 3 then
			local paraGelmeSesi = playSound("music/paraGelmeSesi2.mp3")   
			setSoundVolume(paraGelmeSesi, 0.1)
		end
	end
)