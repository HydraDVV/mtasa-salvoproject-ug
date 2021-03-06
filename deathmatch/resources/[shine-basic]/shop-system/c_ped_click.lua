local messages = { "Bana vurduğun için sana ürün falan satmayacağım", "Burada bekle polisi arıyorum!.", "Aptal herif!", "Ugrasacak baska birini bul.", "Kaybol." }

function pedDamage()
	if getElementData(source,"shopkeeper") then
		setElementData(source,"ignores", true, false)
		setTimer(setElementData,300000,1,source,"ignores", nil, true)
		cancelEvent()
	end
end
addEventHandler("onClientPedDamage", getRootElement(), pedDamage)

function clickPed(button, state, absX, absY, wx, wy, wz, element)
	if getElementData(getLocalPlayer(), "exclusiveGUI") then
		return
	end
	if element and getElementType(element) == "ped" and state=="down" and getElementData(element,"shopkeeper") then
		local x, y, z = getElementPosition(getLocalPlayer())

		if getDistanceBetweenPoints3D(x, y, z, wx, wy, wz)<=4 then
			if not getElementData(element,"ignores") then
				triggerServerEvent("shop:keeper", element)
			else
				outputChatBox('Saticic: ' .. messages[math.random(1, #messages)])
			end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), clickPed, true)
