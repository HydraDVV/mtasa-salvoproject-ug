local debugModelOutput = false
local showering = {}

function clickObject(button, state, absX, absY, wx, wy, wz, element)
	--outputDebugString("You clicked a "..tostring(getElementType(element)).." ("..tostring(getElementModel(element))..")")
	if getElementData(getLocalPlayer(), "exclusiveGUI") then
		return
	end
	if (element) and (getElementType(element)=="object") and (button=="right") and (state=="down") then
		local x, y, z = getElementPosition(getLocalPlayer())
		if (getDistanceBetweenPoints3D(x, y, z, wx, wy, wz)<=3) then
			local model = getElementModel(element)
			local rcMenu
			local row = {}
			if(model == 2517) then --SHOWERS
				rcMenu = exports.rightclick:create("Shower")
				if showering[1] then
					row.a = exports.rightclick:addrow("Stop showering")
					addEventHandler("onClientGUIClick", row.a,  function (button, state)
						takeShower(element)
					end, true)
				else
					row.a = exports.rightclick:addrow("Take a shower")
					addEventHandler("onClientGUIClick", row.a,  function (button, state)
						takeShower(element)
					end, true)
				end
			--[[elseif(model == 2964) then --Pool table / Billiard
				rcMenu = exports.rightclick:create("Pool Table")
				row.a = exports.rightclick:addrow("New Game")
				addEventHandler("onClientGUIClick", row.a,  function (button, state)
					outputDebugString("object-interaction: triggering billiard")
					--exports['minigame-billiard'].startNewGame(element, getLocalPlayer())
					triggerServerEvent("sendLocalMeAction", getLocalPlayer(), getLocalPlayer(), "test message")
					triggerServerEvent("billiardnewgame", getLocalPlayer(), getLocalPlayer(), "test message")
					local result = triggerServerEvent("newBilliardGame", getLocalPlayer(), element)
					outputDebugString("server trigger "..tostring(result)..", "..tostring(element))
					
				end, true)
			--]]
			--[[
			elseif(model == 2146) then --Stretcher (ES)
				rcMenu = exports.rightclick:create("Stretcher")
				row.a = exports.rightclick:addrow("Take Stretcher")				
				addEventHandler("onClientGUIClick", row.a,  function (button, state)
					triggerServerEvent("stretcher:takeStretcher", getLocalPlayer(), element)	
				end, true)
			--]]
			elseif(model == 962) then --Airport gate control box
				local airGateID = getElementData(element, "airport.gate.id")
				if airGateID then
					rcMenu = exports.rightclick:create("Control Box")
					row.a = exports.rightclick:addrow("Control Gate")				
					addEventHandler("onClientGUIClick", row.a,  function (button, state)
						triggerEvent("airport-gates:controlGUI", getLocalPlayer(), element)	
					end, true)			
				end
			elseif(model == 1819) then --Airport fuel
				local airFuel = getElementData(element, "airport.fuel")
				if airFuel then
					outputDebugString("Air fuel: TODO")
				end
			elseif(model == 1808) then --Water cooler
				rcMenu = exports.rightclick:create("Water Cooler")
				row.a = exports.rightclick:addrow("Take a cup")
				addEventHandler("onClientGUIClick", row.a,  function (button, state)
					triggerServerEvent("object-interaction:getWater", getLocalPlayer())
				end, true)	
			else
				if debugModelOutput then
					outputChatBox("Model ID "..tostring(model))
				end
			end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), clickObject, true)

function debugToggleModelOutput(commandName)
	if exports.global:isPlayerHeadAdmin(getLocalPlayer()) then
		debugModelOutput = not debugModelOutput
		outputChatBox("DBG: ModelOutput set to "..tostring(debugModelOutput))
	end
end
addCommandHandler("debugmodeloutput", debugToggleModelOutput)