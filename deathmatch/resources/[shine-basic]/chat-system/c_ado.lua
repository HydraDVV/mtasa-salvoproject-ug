-- MAXIME
local textsToDraw = {}
local font = "default-bold"
local fontHeight = 20
local showtime = 3000
local characteraddition = 50
local bubblesEnabled = true
local color1 = {255, 51, 102}
local maxbubbles = 5

function addAdo(message)
	local infotable = {source,message, 1}
	--table.insert(textsToDraw,infotable)
	--setTimer(removeAme,showtime + (#message * characteraddition),1,infotable)
	if #textsToDraw >= maxbubbles then
		for i, p in ipairs(textsToDraw) do
			if p[1] == source and p[3] == maxbubbles-1 then
				removeAdo(p)
				break
			end
		end
	end

	local notfirst = false
	for i,infotable in ipairs(textsToDraw) do
		if infotable[1] == source then
			infotable[3] = infotable[3] + 1
			notfirst = true
		end
	end

	local infotable = {source,message,0}
	table.insert(textsToDraw,infotable)

	if not notfirst then
		setTimer(removeAdo,showtime + (#message * characteraddition),1,infotable)
	end

	setElementData(source, "isAdoshowing" , true, true)
end

function removeAdo(infotable)
	for i,v in ipairs(textsToDraw) do
		if v[1] == infotable[1] and v[2] == infotable[2] then
			for i2,v2 in ipairs(textsToDraw) do
				if v2[1] == v[1] and v[3] - v2[3] == 1 then
					setTimer(removeAdo,showtime + (#v[2] * characteraddition),1,v2)
				end
			end
			table.remove(textsToDraw,i)
			break
		end
	end
end

function getAdoTextsToRemove()
	for i,v in ipairs(textsToDraw) do
		if v[1] == source then
			removeAme(v)
		end
	end
end

function clearAdoTexts(source)
	for i,v in ipairs(textsToDraw) do
		if v[1] == source then
			removeAdo(v)
		end
	end
end
addEvent("clearAdo", true)
addEventHandler("clearAdo", getRootElement(), clearAdoTexts)

function displayAdo()
	for i,infotable in ipairs(textsToDraw) do
		local camPosXl, camPosYl, camPosZl = getPedBonePosition (infotable[1], 6)
		local camPosXr, camPosYr, camPosZr = getPedBonePosition (infotable[1], 7)
		local x,y,z = (camPosXl + camPosXr) / 2, (camPosYl + camPosYr) / 2, (camPosZl + camPosZr) / 2
		--local posx,posy = getScreenFromWorldPosition(x,y,z+0.25)
		local cx,cy,cz = getCameraMatrix()
		local px,py,pz = getElementPosition(infotable[1])
		local distance = getDistanceBetweenPoints3D(cx,cy,cz,px,py,pz)
		local posx,posy = getScreenFromWorldPosition(x,y,z+0.020*distance+0.10)
		local blocking = getPedOccupiedVehicle(getLocalPlayer()) or getPedOccupiedVehicle(infotable[1]) or nil
		if posx and distance <= 45 and isLineOfSightClear(cx,cy,cz,px,py,pz,true,true,false,true,false,true,true, blocking) then -- change this when multiple ignored elements can be specified
			local width = dxGetTextWidth(infotable[2],1,font)

			dxDrawRectangle(posx - (3 + (0.5 * width)),posy - (2 + (infotable[3] * fontHeight)),width + 5,19,tocolor(0,0,0,255))
			dxDrawRectangle(posx - (6 + (0.5 * width)),posy - (2 + (infotable[3] * fontHeight)),width + 11,19,tocolor(0,0,0,40))
			dxDrawRectangle(posx - (8 + (0.5 * width)),posy - (1 + (infotable[3] * fontHeight)),width + 15,17,tocolor(0,0,0,255))
			dxDrawRectangle(posx - (10 + (0.5 * width)),posy - (1 + (infotable[3] * fontHeight)),width + 19,17,tocolor(0,0,0,40))
			dxDrawRectangle(posx - (10 + (0.5 * width)),posy - (infotable[3] * fontHeight) + 1,width + 19,13,tocolor(0,0,0,255))
			dxDrawRectangle(posx - (12 + (0.5 * width)),posy - (infotable[3] * fontHeight) + 1,width + 23,13,tocolor(0,0,0,40))
			dxDrawRectangle(posx - (12 + (0.5 * width)),posy - (infotable[3] * fontHeight) + 4,width + 23,7,tocolor(0,0,0,255))

			dxDrawText(infotable[2],posx - (0.5 * width),posy - (infotable[3] * fontHeight),posx - (0.5 * width),posy - (infotable[3] * fontHeight),tocolor(unpack(color1)),1,font,"left","top",false,false,false)
		end
	end
	if #textsToDraw <= 0 then
		setElementData(localPlayer, "isAdoShowing" , false, true)
	end
end
addEvent("onClientAdo", true)
addEventHandler("onClientAdo",getRootElement(),addAdo)

addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), function()
	addEventHandler("onClientPlayerQuit",getRootElement(),getAdoTextsToRemove)
	addEventHandler("onClientRender",getRootElement(),displayAdo)
end)

--[[
local function applyClientConfigSettings()
	local chatBubblesEnabled = tonumber( exports.account:loadSavedData("chatbubbles", "1") )
	if (chatBubblesEnabled == 1) then
		if not bubblesEnabled then
			addEventHandler("onClientPlayerQuit",getRootElement(),getTextsToRemove)
			addEventHandler("onClientRender",getRootElement(),displayAme)
			addEventHandler("onClientChatMessage",getRootElement(),income)
			bubblesEnabled = true
		end
	else
		if bubblesEnabled then
			removeEventHandler("onClientPlayerQuit",getRootElement(),getTextsToRemove)
			removeEventHandler("onClientRender",getRootElement(),displayAme)
			removeEventHandler("onClientChatMessage",getRootElement(),income)
			bubblesEnabled = false
		end
	end
end
--addEventHandler("accounts:settings:loadGraphicSettings", getRootElement(), applyClientConfigSettings)
]]
