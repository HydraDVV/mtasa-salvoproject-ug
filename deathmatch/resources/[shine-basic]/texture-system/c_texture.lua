local worldTexture = {}
local worldShader = {}
local previewCache = {}

local wTextureURL, tTextureURL, bTextureURLUpdate, bTextureURLClose, textureItemSlot, currentWorldTexture, previousWorldTexture, previewUrl, replacementTexture, previewTexture
local visibleTextures = {}
local shaders = {}
local invalidModels = {
	--["fridge_1b"] = false,
	["radardisc"] = true,
	["shad_ped"] = true,
	["radar_north"] = true,
	["radar_centre"] = true,
	["shad_exp"] = true,
	["coronastar"] = true,
	["cloudmasked"] = true,
}
--48-44

local dataID = 1
local dataName = 2
local dataURL = 3

local function enableDetail(model, url, interior)
	if not worldShader[interior] then
		worldShader[interior] = {}
	end
	if worldShader[interior][model] then
		engineRemoveShaderFromWorldTexture(worldShader[interior][model], model, nil)
		destroyElement(worldShader[interior][model])
		worldShader[interior][model] = nil
	end
	worldShader[interior][model], technique = dxCreateShader("replacement.fx", 1, 100, true, "world")
	dxSetShaderValue(worldShader[interior][model], "Tex0", worldTexture[url])
	engineApplyShaderToWorldTexture(worldShader[interior][model], model, nil, true)
	table.insert(shaders, {worldShader[interior][model], model, interior})
	--outputDebugString("#shaders="..tostring(#shaders))
	--outputChatBox("Texture '" .. model .. "' replaced.", 0, 255, 0, false)
	--outputDebugString("Texture '" .. model .. "' replaced.")
	--outputDebugString("worldShader["..tostring(interior).."]["..tostring(model).."]="..tostring(worldShader[interior][model]))
	--outputDebugString("#worldShader="..tostring(#worldShader))
end

addEvent("onClientImageReceived", true)
addEventHandler("onClientImageReceived", root,
	function(pixels, model, url, interior)
		if not invalidModels[model] then
			if worldTexture[url] then
				destroyElement(worldTexture[url])
				worldTexture[url] = nil
			end
			
			worldTexture[url] = dxCreateTexture(pixels, "argb", true, "clamp", "2d", 1)
			
			if worldTexture[url] then
				enableDetail(model, url, interior)
			else
				outputChatBox("Error occured while trying to create the texture.", 255, 0, 0, false)
			end
		else
			outputChatBox("Invalid texture model '" .. model .. "' entered.", 255, 0, 0, false)
		end
	end
)

function printVisibleTextureNames()
	if exports.global:isPlayerHeadAdmin(getLocalPlayer()) then
		for i,v in ipairs(engineGetVisibleTextureNames()) do
			outputChatBox(v)
		end
	end
end
addCommandHandler("printtextures", printVisibleTextureNames)


function canPlayerManageTextures(interior)
	local thePlayer = getLocalPlayer()
	if not interior then interior = getElementDimension(thePlayer) end
	if(interior > 0) then --interiors (houses and businesses)
		if(exports.global:isPlayerAdmin(thePlayer) and getElementData(thePlayer, "adminduty") == 1 or exports.global:hasItem(thePlayer, 4, tonumber(interior)) or exports.global:hasItem(thePlayer, 5, tonumber(interior)) or exports.global:isPlayerHeadAdmin(thePlayer)) then
			return true
		end
	else --the outside world (no interior)
		if exports.global:isPlayerHeadAdmin(thePlayer) then
			return true
		end
	end
	return false
end

function insideInterior()
	if exports.global:isPlayerHeadAdmin(getLocalPlayer()) then return true end
	local int = getElementInterior(getLocalPlayer())
	if int > 0 then
		return true
	end
	return false
end

function updateWorldTexturePreview()
	--fetchRemote(previewUrl, _return, "", false) Can only fetch locally, client-side
	if previewUrl then
		if previewCache[previewUrl] then
			--outputDebugString("texture-system: Preview texture already cached client-side.")
			--if(previewTexture ~= previewCache[previewUrl]) then
				destroyElement(previewTexture)
				previewTexture = dxCreateTexture(previewCache[previewUrl], "argb", true, "clamp", "2d", 1)
				previewTextureURL = previewUrl
			--end
			addPreviewTexture()
		else
			triggerServerEvent("texture-system:fetchTextureForPreview", getLocalPlayer(), previewUrl)
		end
	else
		outputChatBox("No preview url given.", 255, 0, 0)
	end
end
function addPreviewTexture()
	if previewTexture then
		if previousWorldTexture > 0 then
			--outputChatBox("Removing previous texture")
			engineRemoveShaderFromWorldTexture(previewShader, visibleTextures[previousWorldTexture], nil)
		end
		--if not previewShader and previewTechnique then
			previewShader, previewTechnique = dxCreateShader("replacement.fx", 1, 100, true, "world")
		--end
		dxSetShaderValue(previewShader, "Tex0", previewTexture)
		engineApplyShaderToWorldTexture(previewShader, visibleTextures[currentWorldTexture], nil, true)
		--outputChatBox("Texture '" .. visibleTextures[currentWorldTexture] .. "' replaced.", 0, 255, 0, false)
	else
		updateWorldTexturePreview()
	end
end

addEvent("texture-system:serverReturnPreviewTexture", true)
addEventHandler("texture-system:serverReturnPreviewTexture", root,
	function(pixels)
		if not pixels then outputChatBox("No pixels received.", 255, 0, 0) return end
		if previewTexture then
			destroyElement(previewTexture)
			previewTexture = nil
		end
		if previewCache[previewUrl] then
			if isElement(previewCache[previewUrl]) then
				destroyElement(previewCache[previewUrl])
			end
			previewCache[previewUrl] = nil
		end
		
		previewTexture = dxCreateTexture(pixels, "argb", true, "clamp", "2d", 1)
		previewCache[previewUrl] = previewTexture

		if previewTexture then
			addPreviewTexture()
		else
			destroyElement(previewTexture)
			previewTexture = nil
			outputChatBox("Error occured when tried to create the texture.", 255, 0, 0, false)
		end
	end
)
function previewPrevTexture()
	if not called_previewPrevTexture then
	called_previewPrevTexture = true
	if(currentWorldTexture <= 1) then
		previousWorldTexture = currentWorldTexture
		currentWorldTexture = #visibleTextures
	else
		previousWorldTexture = currentWorldTexture
		currentWorldTexture = currentWorldTexture - 1
	end
	updateWorldTexturePreview()
	end
	called_previewPrevTexture = false
end
function previewNextTexture()
	if not called_previewNextTexture then
	called_previewNextTexture = true
	if(currentWorldTexture >= #visibleTextures) then
		previousWorldTexture = currentWorldTexture
		currentWorldTexture = 1
	else
		previousWorldTexture = currentWorldTexture
		currentWorldTexture = currentWorldTexture + 1
	end
	updateWorldTexturePreview()
	end
	called_previewNextTexture = false
end
function setTextureToReplace(key, keyState, url)
	stopReplacementSelection()
	local split = exports.global:split(url, ";")
	url = split[1]
	triggerServerEvent("item-system:saveTextureReplacement", getLocalPlayer(), textureItemSlot, url, visibleTextures[currentWorldTexture])
end
function setTextureNoReplace(key, keyState, url)
	stopReplacementSelection()
	local split = exports.global:split(url, ";")
	url = split[1]
	triggerServerEvent("item-system:saveTextureReplacement", getLocalPlayer(), textureItemSlot, url, false)
end
function stopReplacementSelection()
	unbindKey("num_4", "down", previewPrevTexture)
	unbindKey("num_6", "down", previewNextTexture)
	unbindKey("num_5", "down", setTextureToReplace)
	unbindKey("num_2", "down", setTextureNoReplace)
	removeEventHandler("onClientRender", getRootElement(), drawHelpGui)
	engineRemoveShaderFromWorldTexture(previewShader, visibleTextures[currentWorldTexture], nil)
end

function selectTextureToReplace(slot, url)
	if not called_selectTextureToReplace then
	called_selectTextureToReplace = true
	if insideInterior() then
		if canPlayerManageTextures() then
			if slot then textureItemSlot = slot else outputDebugString("texture-system: No slot ID received") return end
			if not url then outputDebugString("texture-system: No url received") return end
			local split = exports.global:split(url, ";")
			previewUrl = split[1]
			visibleTextures = {}
			for k,v in ipairs(engineGetVisibleTextureNames()) do
				if not invalidModels[v] then
					table.insert(visibleTextures, v)
				end
			end
			--[[
			local x,y,z = getElementPosition(getLocalPlayer())
			--local sphere = createColSphere(x,y,z,100)
			--local objects = getElementsWithinColShape(sphere, "object")
			local objects = getElementsByType("object")
			for key,object in ipairs(objects) do
				if isElementOnScreen(object) then
					local model = getElementModel(object)
					if model then
						for k,texturename in ipairs(engineGetModelTextureNames(model)) do
							table.insert(visibleTextures, texturename)
						end
					end
				end
			end
			--]]
			previousWorldTexture = 0
			currentWorldTexture = 1
			if(#visibleTextures > 0) then
				updateWorldTexturePreview()
				addEventHandler("onClientRender", getRootElement(), drawHelpGui)
				bindKey("num_4", "down", previewPrevTexture, url)
				bindKey("num_6", "down", previewNextTexture, url)
				bindKey("num_5", "down", setTextureToReplace, url)
				bindKey("num_2", "down", setTextureNoReplace, url)
				outputChatBox("Use numpad 4 and 6 to change what to replace, and numpad 5 to save current selection. 2 to set no replace.", 0, 255, 0)
			else
				outputChatBox("No textures to replace in this interior.", 255, 0, 0)
			end
		else
			outputChatBox("You need a key to this interior in order to retexture it.", 255, 0, 0)
		end
	else
		outputChatBox("You need to be in an interior to retexture.", 255, 0, 0)
	end
	end
	called_selectTextureToReplace = false
end
addEvent("texture-system:selectTexture", true)
addEventHandler("texture-system:selectTexture", getRootElement(), selectTextureToReplace)

function saveTextureURL()
	local url = guiGetText(tTextureURL)
	if(url and string.len(url) > 5) then
		if (string.find(url, ";")) then
			outputChatBox("Invalid URL! May not contain character ';'.", 255, 0, 0)
		else
			triggerServerEvent("item-system:saveTextureURL", getLocalPlayer(), textureItemSlot, url)
			closeTextureURL()
		end
	end
end

function inputTextureURL(slot)
	if slot then textureItemSlot = slot end
	if not (wTextureURL) then
		local width, height = 300, 200
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (width/2)
		local y = scrHeight/2 - (height/2)

		wTextureURL = guiCreateWindow(x, y, width, height, "Enter image URL", false)
		tTextureURL = guiCreateEdit(0.1, 0.2, 0.85, 0.1, "", true, wTextureURL)

		guiSetInputEnabled(true)

		bTextureURLUpdate = guiCreateButton(0.1, 0.6, 0.85, 0.15, "Save", true, wTextureURL)
		addEventHandler("onClientGUIClick", bTextureURLUpdate, saveTextureURL, false)

		bTextureURLClose= guiCreateButton(0.1, 0.775, 0.85, 0.15, "Close Window", true, wTextureURL)
		addEventHandler("onClientGUIClick", bTextureURLClose, closeTextureURL, false)
	else
		guiBringToFront(wTextureURL)
	end	
end
addEvent("texture-system:itemUrlGui", true)
addEventHandler("texture-system:itemUrlGui", getRootElement(), inputTextureURL)

function closeTextureURL()
	if (wTextureURL) then
		guiSetInputEnabled(false)
		destroyElement(wTextureURL)
		wTextureURL, tTextureURL, bTextureURLUpdate, bTextureURLClose = nil, nil, nil, nil
	end
end

function textureListGUI(data)
	if not wTextureList then
		local width, height = 400, 390
		local scrWidth, scrHeight = guiGetScreenSize()
		local x = scrWidth/2 - (width/2)
		local y = scrHeight/2 - (height/2)

		local intName
		local interior = getElementDimension(getLocalPlayer())
		local interiorElement = getElementByID("int"..tostring(interior))
		if interiorElement then
			intName = getElementData(interiorElement, "name")
		end

		if intName then
			wTextureList = guiCreateWindow(x, y, width, height, "Textures for "..tostring(intName), false)
		else
			wTextureList = guiCreateWindow(x, y, width, height, "Textures", false)
		end

		textureList = guiCreateGridList(0.05, 0.1, 0.9, 0.74, true, wTextureList)
		local columnID = guiGridListAddColumn(textureList, "ID", 0.1)
		local columnTexture = guiGridListAddColumn(textureList, "Texture", 0.3)
		local columnURL = guiGridListAddColumn(textureList, "URL", 0.9)
		
		bRemove = guiCreateButton(0.05, 0.84, 0.45, 0.1, "Remove", true, wTextureList)
		bCancel = guiCreateButton(0.5, 0.84, 0.45, 0.1, "Cancel", true, wTextureList)
		
		if data then
			for k,v in ipairs(data) do
				local row = guiGridListAddRow(textureList)
				guiGridListSetItemText(textureList, row, columnID, tostring(v[dataID]), false, false)
				guiGridListSetItemText(textureList, row, columnTexture, tostring(v[dataName]), false, false)
				guiGridListSetItemText(textureList, row, columnURL, tostring(v[dataURL]), false, false)
			end
		end
		--guiGridListAutoSizeColumn(textureList, columnID)
		--guiGridListAutoSizeColumn(textureList, columnTexture)
		--guiGridListAutoSizeColumn(textureList, columnURL)
		
		showCursor(true)

		addEventHandler("onClientGUIClick", bRemove, removeTextureFromList)
		--addEventHandler("onClientGUIDoubleClick", floorList, gotoFloor)
		addEventHandler("onClientGUIClick", bCancel, hideTextureListGUI)
	end
end
addEvent("texture-system:showTextureList", true)
addEventHandler("texture-system:showTextureList", getRootElement(), textureListGUI)
function hideTextureListGUI(button, state)
	if textureList then destroyElement(textureList) end
	if bRemove then destroyElement(bRemove) end
	if bCancel then destroyElement(bCancel) end
	if wTextureList then destroyElement(wTextureList) end
	wTextureList, textureList, bRemove, bCancel = nil, nil, nil, nil
	if isCursorShowing() then showCursor(false) end
end
function removeTextureFromList()
	if wTextureList and textureList then
		if insideInterior() and canPlayerManageTextures() then
			local row, col = guiGridListGetSelectedItem(textureList)
			if (row==-1) then
				outputChatBox("Please select a texture to remove.", 255, 0, 0)
			else
				local id = tonumber(guiGridListGetItemText(textureList, row, 1))
				local texture = guiGridListGetItemText(textureList, row, 2)
				local url = guiGridListGetItemText(textureList, row, 3)
				local interior = getElementDimension(getLocalPlayer())
				guiGridListRemoveRow(textureList, row)
				--outputDebugString("worldShader["..tostring(interior).."]["..tostring(texture).."] = "..tostring(worldShader[interior][texture]))
				if worldShader[interior][texture] then
					--outputDebugString("found worldShader")
					engineRemoveShaderFromWorldTexture(worldShader[interior][texture], texture, nil)
					destroyElement(worldShader[interior][texture])
					worldShader[interior][texture] = nil
				end
				triggerServerEvent("texture-system:removeTextureFromInterior", getLocalPlayer(), id, texture, url, interior)
			end
		else
			outputChatBox("Not authorized.", 255, 0, 0)
		end
	end
end

function removeWorldTexture(texture, interior)
	if worldShader[interior][texture] then
		engineRemoveShaderFromWorldTexture(worldShader[interior][texture], texture, nil)
		destroyElement(worldShader[interior][texture])
		worldShader[interior][texture] = nil
	end
end
addEvent("texture-system:removeWorldTexture", true)
addEventHandler("texture-system:removeWorldTexture", getRootElement(), removeWorldTexture)

function addCustomTextures(data, interior)
	if not data then return end
	if not interior then interior = getElementDimension(getLocalPlayer()) end
	local loadList = {}
	for k,v in ipairs(data) do
		if(worldTexture[v[dataURL]]) then --if texture already cached, go directly to enableDetail
			enableDetail(v[dataName], v[dataURL], interior)
		else --if not cached, add to load-list
			table.insert(loadList, {v[dataID], v[dataName], v[dataURL]})
		end
	end
	if(#loadList > 0) then
		triggerServerEvent("texture-system:loadUncachedTextures", getLocalPlayer(), interior, loadList)
	end
end
addEvent("texture-system:addCustomTextures", true)
addEventHandler("texture-system:addCustomTextures", getRootElement(), addCustomTextures)

function clearTextures()
	--outputDebugString("texture-system: clearTextures()")
	--outputDebugString("#shaders="..tostring(#shaders))
	--local i = 1
	for k,v in ipairs(shaders) do
		--outputDebugString("round "..tostring(i))
		engineRemoveShaderFromWorldTexture(v[1], v[2], nil)
		destroyElement(v[1])
		worldShader[v[3]][v[2]] = nil
		--i = i + 1
	end
	shaders = {}
	--worldShader = {}
	--[[outputDebugString("#worldShader="..tostring(#worldShader))
	for k,v in ipairs(worldShader) do
		local interior = k
		ouputDebugString("interior="..tostring(interior))
		for k2,v2 in ipairs(v) do
			local texture = k2
			outputDebugString("interior="..tostring(interior).." texture="..tostring(texture))
			engineRemoveShaderFromWorldTexture(worldShader[interior][texture], texture, nil)
			destroyElement(worldShader[interior][texture])
			worldShader[interior][texture] = nil
		end
		worldShader[interior] = nil
	end
	worldShader = {}
	--]]
end
addEvent("texture-system:clearTextures", true)
addEventHandler("texture-system:clearTextures", getRootElement(), clearTextures)
addCommandHandler("clearmytextures", clearTextures)

addCommandHandler("cleartexturecache",
	function(cmd)
		worldTexture = {}
		outputChatBox("Local texture cache cleared.", 0, 255, 0)
	end
)

function drawHelpGui()
	local x, y = guiGetScreenSize()
	text = tostring(currentWorldTexture).."/"..tostring(#visibleTextures)..": "..tostring(visibleTextures[currentWorldTexture])
	local width = dxGetTextWidth(text)
	local height = 25
	dxDrawRectangle((x/2)-((width+20)/2), (y/2)-(height/2), width + 20, height, tocolor(0, 0, 0, 127))
	dxDrawText(text, (x/2)-(width/2), (y/2)-(height/2))
end


addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
    function(res)
        if res == getThisResource() then
        	if(getElementData(getLocalPlayer(), "loggedin")) then
			outputDebugString("texture-system: LOADING CUSTOM TEXTURES FOR ALL PLAYERS")
			triggerServerEvent("texture-system:loadCustomTextures", getLocalPlayer())
		end
        end
    end
);