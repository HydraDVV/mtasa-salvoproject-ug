--Poseidon Scripting
--Copyright Irresistible

local sX, sY = guiGetScreenSize()
local px, py = (sX/1366), (sY/768)



function policePanel ()
    if getElementData(localPlayer, "panel:pd") == 1 then
        dxDrawImage(px*0, py*0, px*1366, py*768, "icons/sayfa1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		--dxDrawRectangle( px*890, py*495, px*130,py*55, tocolor ( 0, 0, 0, 150 ) )

    elseif getElementData(localPlayer, "panel:pd") == 2 then
        dxDrawImage(px*0, py*0, px*1366, py*768, "icons/sayfa2.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

    end
end

addEvent("pd:panel",true)
addEventHandler("pd:panel",getRootElement(),function()
if getElementData(getLocalPlayer(),"faction") == 1 then
addEventHandler("onClientRender",root,policePanel)
setElementData(localPlayer,"panel:pd",1)
panel = true
else
	outputChatBox("Panele Erişebilmen İçin Polis Memuru Olman Lazım #1a677f[Salvo Roleplay]",255,255,255,true)
end
end)

function isMouseInPosition ( x, y, width, height )
    if ( not isCursorShowing( ) ) then
        return false
    end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    
    return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end
 
 
addEventHandler("onClientClick", root, function(button, state, x, y)
	if panel == false then return end
	if state == "down" then return end


    if isMouseInPosition(px*850, py*210, px*210,py*33)  and getElementData(localPlayer, "panel:pd") == 1 then
		removeEventHandler("onClientRender", root, policePanel)
		setElementData(localPlayer, 'panel:pd', 0)

		
	elseif isMouseInPosition(px*850, py*170, px*210,py*33)  and getElementData(localPlayer, "panel:pd") == 1 then
		setElementData(localPlayer, 'panel:pd', 2)
		
		
	elseif isMouseInPosition(px*850, py*210, px*210,py*33)  and getElementData(localPlayer, "panel:pd") == 2 then
		setElementData(localPlayer, 'panel:pd', 1)
	
	elseif isMouseInPosition(px*850, py*170, px*210,py*33)  and getElementData(localPlayer, "panel:pd") == 2 then
		removeEventHandler("onClientRender", root, policePanel)
		setElementData(localPlayer, 'panel:pd', 0)

	elseif isMouseInPosition(px*890, py*330, px*130,py*55)  and getElementData(localPlayer, "panel:pd") == 1 then
		triggerServerEvent("pdaraccikart", localPlayer, localPlayer,  "suv")
		removeEventHandler("onClientRender", root, policePanel)
		setElementData(localPlayer, 'panel:pd', 0)
	
	elseif isMouseInPosition(px*890, py*415, px*130,py*55)  and getElementData(localPlayer, "panel:pd") == 1 then
		triggerServerEvent("pdaraccikart", localPlayer, localPlayer,  "patrol")
		removeEventHandler("onClientRender", root, policePanel)
		setElementData(localPlayer, 'panel:pd', 0)		


	elseif isMouseInPosition(px*890, py*495, px*130,py*55)  and getElementData(localPlayer, "panel:pd") == 1 then
		triggerServerEvent("pdaraccikart", localPlayer, localPlayer,  "maverick")
		removeEventHandler("onClientRender", root, policePanel)
		setElementData(localPlayer, 'panel:pd', 0)


	elseif isMouseInPosition(px*890, py*330, px*130,py*55)  and getElementData(localPlayer, "panel:pd") == 2 then
		triggerServerEvent("pdaraccikart", localPlayer, localPlayer,  "boxville")
		removeEventHandler("onClientRender", root, policePanel)
		setElementData(localPlayer, 'panel:pd', 0)
	
	elseif isMouseInPosition(px*890, py*415, px*130,py*55)  and getElementData(localPlayer, "panel:pd") == 2 then
		triggerServerEvent("pdaraccikart", localPlayer, localPlayer,  "HPV1000")
		removeEventHandler("onClientRender", root, policePanel)
		setElementData(localPlayer, 'panel:pd', 0)		


	elseif isMouseInPosition(px*890, py*495, px*130,py*55)  and getElementData(localPlayer, "panel:pd") == 2 then
		triggerServerEvent("pdaraccikart", localPlayer, localPlayer,  "police")
		removeEventHandler("onClientRender", root, policePanel)
		setElementData(localPlayer, 'panel:pd', 0)

	end
end)

-- triggerEvent(pd:open)
-- Aslı Peker
local thePed = createPed(267, 1578.2421875, -1620.3876953125, 13.546875)
setElementDimension(thePed, 0)
setElementInterior(thePed, 0)
setElementRotation(thePed, 0, 0, 270.7209777832)
setElementFrozen(thePed, true)
setElementData(thePed, "talk", 1)
setElementData(thePed, "name", "Aslı Peker")