local ped = createPed(1 , 0 , 0 , 3)


addCommandHandler("kucakla" , function(plr , cmd , arg1)
	if plr:getData("kucakTimer") then
		if plr.vehicle then 
			outputChatBox("[!]#ffffff Araç içerisinde herhangi birini kucağından bırakamazsın!",plr,255,0,0,true)
		return end

		local attachedElements = getAttachedElements ( plr )
		for i,v in ipairs ( attachedElements ) do
			if getElementType(v) == "player" or getElementType(v) == "ped" then 
				plr:setAnimation()
				detachElements ( v, plr )
				setElementCollisionsEnabled(v , true)

				local indirelenkisi = v:getData("kucak:alinankisi")
				v:setData("kucak:alinankisi","")
				if isElement(indirelenkisi) then
					indirelenkisi:setData("kucak:alinankisi","")
					indirelenkisi:setAnimation()
				end
				--iprint(getPlayerName(indirelenkisi).." / "..getPlayerName(plr))

				toggleControl(plr , "fire", true)
				toggleControl(plr , "sprint", true)
				toggleControl(plr , "crouch", true)
				toggleControl(plr , "jump", true)
				local timer = plr:getData("kucakTimer") or false
				if timer and isTimer(timer) then
					killTimer(timer)
				end
				
				setElementCollisionsEnabled(v , true)
				
				outputChatBox("[!]#ffffff Kucağındaki kişi başarıyla indirildi!",plr,0,153,255,true)
				plr:setData("kucak:durum",false)
		
				

			end
		end
		plr:setData("kucakTimer" , nil)
	return end

	if not arg1 then outputChatBox("KULLANIM : /"..cmd.." [OYUNCU ID]",plr,254,194,14) return end

	local target, targetName = exports.global:findPlayerByPartialNick(plr , arg1)

	if target then 

		local pos = plr.position 
		local tpos = target.position 

		if getDistanceBetweenPoints3D(pos , tpos) > 5 then
			outputChatBox("[!]#ffffff Uzakta olan birisini kucağına alamazsın!",plr,255,0,0,true)
		return end

		target:setData("kucakTeklif" , plr)

		outputChatBox("[!]#ffffff "..plr.name.." adlı kişi sizi kucağına almak istiyor!",target,0,153,255,true)
		outputChatBox("[!]#ffffff "..target.name.." adlı kişiyi kucağınıza almak için teklif yolladınız!",plr,0,153,255,true)

	end


end)

addCommandHandler("kucak" , function(plr , cmd , arg1)
	if not arg1 then outputChatBox("KULLANIM : /"..cmd.." [kabul/red]",plr ,254,194,14) return end 

	if not plr:getData("kucakTeklif") then
		outputChatBox("[!]#ffffff Herhangi bir teklifin yok!", plr, 255,0,0,true)
	return end

	if arg1 == "kabul" then 

		target = plr:getData("kucakTeklif")
		
		if not target then return end

		plr:setAnimation("lowrider", "sit_relaxed", 0, true, false, true, true)

		attachElements(plr , target , -0.05 , 0.3 , 0.30)

		setElementCollisionsEnabled(plr , false)
		target:setData("kucak:durum",true)
		plr:setData("kucak:alinankisi",plr)
				
		toggleControl(target , "fire", false)
		toggleControl(target , "sprint", false)
		toggleControl(target , "crouch", false)
		toggleControl(target , "jump", false)

		target:setAnimation("CARRY", "crry_prtial", 0, true, false, true, true)

		timer = setTimer(function(target , plr)
			if not target then return end
			local _, _, grabberRotZ = getElementRotation(target)
			if not grabberRotZ then
				local timer = target:getData("kucakTimer") or false
				if timer and isTimer(timer) then
					killTimer(timer)
				end
				target:setData("kucakTimer" , nil)
			end
			if isElement(plr) then 
			setElementRotation(plr , 0,0,(grabberRotZ or 0)+90)
			end
			--target:setAnimation("CARRY", "crry_prtial", 0, true, false, true, true)
		end,150,6000,target , plr )

		target:setData("kucakTimer" , timer)
		plr:setData("kucakTeklif" , false)
	
	elseif arg1 == "red" then

		local target = plr:getData("kucakTeklif")

		outputChatBox("[!]#ffffff Karşı tarafın kucak teklifini red ettiniz!" , plr,255,0,0,true)
		outputChatBox("[!]#ffffff Karşı taraf kucak teklifinizi red etti!" , target,255,0,0,true)

		plr:setData("kucakTeklif" , nil)

	end

end)

addEventHandler("onVehicleStartEnter",root,function(oyuncu)
    if oyuncu:getData("kucak:durum") == true then
		outputChatBox("[!] #ffffffKucağında biriyle araç sürmeye deneme bu tehlikeli olur!",oyuncu,196,0,0,true)
		cancelEvent()
	   return
    end
end)