--    ____        __     ____  __            ____               _           __ 
--   / __ \____  / /__  / __ \/ /___ ___  __/ __ \_________    (_)__  _____/ /_
--  / /_/ / __ \/ / _ \/ /_/ / / __ `/ / / / /_/ / ___/ __ \  / / _ \/ ___/ __/
-- / _, _/ /_/ / /  __/ ____/ / /_/ / /_/ / ____/ /  / /_/ / / /  __/ /__/ /_  
--/_/ |_|\____/_/\___/_/   /_/\__,_/\__, /_/   /_/   \____/_/ /\___/\___/\__/  
--                                 /____/                /___/                 
--Server side script: Core script with basic functionalities, join/initialize, utility functions, etc.
--Last updated 23.02.2011 by Exciter
--Copyright 2008-2011, The Roleplay Project (www.roleplayproject.sotramedia.com)

function elementClicked( theButton, theState, thePlayer )
    if theButton == "right" and theState == "down" then -- if right mouse button was pressed down
        local theElement = source
        local elementType = getElementType(theElement)
        if(elementType == "Player") then
        	local elementName = getPlayerNametagText(theElement)
        	local playerAdmin = isPlayerAdmin(thePlayer)
        	triggerClientEvent(thePlayer,"clientCreateRightClickPlayerMenu",theElement,elementName,playerAdmin)
        elseif(elementType == "Vehicle") then
        	local elementName = getVehicleName(theElement)
        	local elementOwner = getElementData(theVehicle, "rpp.vh.owner")
        	local playerAdmin = isPlayerAdmin(thePlayer)
        	triggerClientEvent(thePlayer,"clientCreateRightClickVehicleMenu",theElement,elementName,elementOwner,playerAdmin)
        elseif(elementType == "Object") then
        	local elementModel = getObjectModel(theElement)
        	if(elementModel == 1216 or elementModel == 1346 or elementModel == 1363) then
        		local elementName = "Public Phone"
        		triggerClientEvent(thePlayer,"clientCreateRightClickObjectMenu",theElement,elementName,elementModel,playerAdmin)
        	elseif(elementModel == 1257) then
        		local elementName = "Bus Stop"
        		triggerClientEvent(thePlayer,"clientCreateRightClickObjectMenu",theElement,elementName,elementModel,playerAdmin)
        	elseif(elementModel == 1340) then
        		local elementName = "Chilli Dogs"
        		triggerClientEvent(thePlayer,"clientCreateRightClickObjectMenu",theElement,elementName,elementModel,playerAdmin)
        	elseif(elementModel == 1341) then
        		local elementName = "Ice-Cream Cart"
        		triggerClientEvent(thePlayer,"clientCreateRightClickObjectMenu",theElement,elementName,elementModel,playerAdmin)
        	elseif(elementModel == 1342) then
        		local elementName = "Noodle Exchange"
        		triggerClientEvent(thePlayer,"clientCreateRightClickObjectMenu",theElement,elementName,elementModel,playerAdmin)
        	end
        end
    end
end
addEventHandler("onElementClicked", getRootElement(), elementClicked)