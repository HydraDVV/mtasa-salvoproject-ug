mysql = exports.mysql
local textureItemID = 147
local cachedURL = {}
local dataCache = {}

function loadImageFile(player, url, texture)
	fetchRemote(url, _return, "", false, player, texture)
end

function _return(responseData, errno, player, texture)
	if isElement(player) then
		if errno == 0 then
			triggerClientEvent(player, "onClientImageReceived", player, responseData, texture)
		else
			outputChatBox("Error occured when trying to reach the URL-address.", player, 255, 0, 0, false)
		end
	end
end

--[[
addCommandHandler("texturesystemaddtabletodb",
	function(player, cmd)
		if(tostring(getElementData(player, "account:username")) == "Exciter") then
			local result = mysql:query_free("CREATE TABLE IF NOT EXISTS `interior_textures` (`id` int(11) NOT NULL AUTO_INCREMENT, `interior` int(11) NOT NULL, `texture` varchar(255) NOT NULL, `url` varchar(255) NOT NULL, PRIMARY KEY (`id`)) ENGINE=MyISAM  DEFAULT CHARSET=utf8;")
			outputChatBox("It's done!")
			outputChatBox(tostring(result))
		else
			outputChatBox("Sorry, you are not Exciter.")
		end
	end
)
--]]

--[[
addCommandHandler("replacetextures",
	function(player, cmd, url, texture)
		if url then
			loadImageFile(player, url, texture)
		else
			outputChatBox("Syntax: /" .. cmd .. " [url] [texture]", player, 255, 180, 20, false)
		end
	end
)
--]]

function canPlayerManageTextures(thePlayer, interior)
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
function insideInterior(player, interior)
	if exports.global:isPlayerHeadAdmin(player) then return true end
	if not interior then interior = getElementInterior(player) end
	if interior > 0 then
		return true
	end
	return false
end

function returnPreviewTexture(responseData, errno, player, url)
	if isElement(player) then
		if errno == 0 then
			cachedURL[url] = responseData
			triggerClientEvent(player, "texture-system:serverReturnPreviewTexture", player, responseData)
		else
			outputChatBox("Error occured when trying to reach the URL-address (#"..tostring(errno)..").", player, 255, 0, 0)
		end
	end
end
function getTextureForPreview(url)
	if cachedURL[url] then
		returnPreviewTexture(cachedURL[url], 0, client, url)
	else
		outputDebugString("PREVIEW not cached: "..tostring(url))
		fetchRemote(url, 2, returnPreviewTexture, "", false, client, url)
	end
end
addEvent("texture-system:fetchTextureForPreview", true)
addEventHandler("texture-system:fetchTextureForPreview", getRootElement(), getTextureForPreview)

function placeTexture(player, slot, texture, url)
	local interior = getElementDimension(player)
	if insideInterior(player, interior) then
		if canPlayerManageTextures(player, interior) then
			local insertid = mysql:query_insert_free("INSERT INTO interior_textures SET interior='" .. mysql:escape_string(interior) .. "', texture='" .. mysql:escape_string(texture) .. "', url='" .. mysql:escape_string(url) .. "'")
			exports['item-system']:takeItemFromSlot(player, slot)
			if dataCache[interior] then
				table.insert(dataCache[interior], {insertid, texture, url})
			else
				dataCache[interior] = {{insertid, texture, url}}
			end
			if cachedURL[url] then
				doPlaceTexture(cachedURL[url], 0, player, texture, slot, url)
			else
				fetchRemote(url, doPlaceTexture, "", false, player, texture, slot, url)
			end
		else
			outputChatBox("You need a key to this interior in order to retexture it.", player, 255, 0, 0)
		end
	else
		outputChatBox("You need to be in an interior to retexture.", player, 255, 0, 0)
	end
end
function doPlaceTexture(responseData, errno, player, texture, slot, url)
	if isElement(player) then
		if errno == 0 then
			cachedURL[url] = responseData
			local interior = getElementDimension(player)
			triggerClientEvent(player, "onClientImageReceived", player, responseData, texture, url, interior)
			local affectedElements = {}
			for k,v in ipairs(getElementsByType("player")) do
				if(getElementDimension(v) == interior and v ~= player) then
					table.insert(affectedElements, v)
				end
			end
			for k,v in ipairs(affectedElements) do
				triggerClientEvent(v, "onClientImageReceived", v, responseData, texture, url, interior)
			end			
		else
			outputChatBox("Error occured when trying to reach the URL-address.", player, 255, 0, 0, false)
		end
	end
end


function texturelist(player)
	if(player) then
		local interior = tonumber(getElementDimension(player))
		if insideInterior(player, interior) then
			if canPlayerManageTextures(player, interior) then
				local theList = {} --id, texture, url
				if dataCache[interior] then
					theList = dataCache[interior]
				else
					local query = mysql:query("SELECT id, texture, url FROM interior_textures WHERE `interior`='"..mysql:escape_string(interior).."' ORDER BY `id` ASC")
					if query then
						while true do
							local row = mysql:fetch_assoc(query)
							if not row then break end
							table.insert(theList, {row.id, row.texture, row.url})
						end
						mysql:free_result(query)
					end
					--outputDebugString("#theList="..tostring(#theList))
					dataCache[interior] = theList
				end
				triggerClientEvent(player, "texture-system:showTextureList", getRootElement(), theList)
			else
				outputChatBox("A key to this interior is required to manage its textures.", player, 255, 0, 0)
			end
		else
			outputChatBox("You need to be in an interior to retexture.", player, 255, 0, 0)
		end
	end
end
addCommandHandler("texturelist", texturelist)
addCommandHandler("textures", texturelist)
addCommandHandler("texture", texturelist)

function removeTextureFromInterior(id, texture, url, interior)
	if id then
		mysql:query_free("DELETE FROM interior_textures WHERE id='" .. mysql:escape_string(id) .. "'")
		exports['item-system']:giveItem(source, textureItemID, tostring(url)..";"..tostring(texture))
		if dataCache[interior] then
			for k,v in ipairs(dataCache[interior]) do
				if(v[1] == id) then
					table.remove(dataCache[interior], k)
					break
				end
			end
		end
		if texture then
			local interior = getElementDimension(source)
			local affectedElements = {}
			for k,v in ipairs(getElementsByType("player")) do
				if(getElementDimension(v) == interior and v ~= source) then
					table.insert(affectedElements, v)
				end
			end
			for k,v in ipairs(affectedElements) do
				triggerClientEvent(v, "texture-system:removeWorldTexture", getRootElement(), texture, interior)
			end
		end
	end
end
addEvent("texture-system:removeTextureFromInterior", true)
addEventHandler("texture-system:removeTextureFromInterior", getRootElement(), removeTextureFromInterior)


function loadCustomTextures(player)
	if not player then player = source end
	if isElement(player) then
		triggerClientEvent(player, "texture-system:clearTextures", getRootElement())
		local interior = tonumber(getElementDimension(player))
		local theList = {} --id, texture, url
		if dataCache[interior] then
			theList = dataCache[interior]
		else
			local query = mysql:query("SELECT id, texture, url FROM interior_textures WHERE `interior`='"..mysql:escape_string(interior).."' ORDER BY `id` ASC")
			if query then
				while true do
					local row = mysql:fetch_assoc(query)
					if not row then break end
					table.insert(theList, {row.id, row.texture, row.url})
				end
				mysql:free_result(query)
			end
			dataCache[interior] = theList
		end
		--outputDebugString("#theList="..tostring(#theList))
		if(#theList > 0) then
			triggerClientEvent(player, "texture-system:addCustomTextures", getRootElement(), theList, interior)
		end
	end
end
addEvent("texture-system:loadCustomTextures", true)
addEventHandler("texture-system:loadCustomTextures", getRootElement(), loadCustomTextures)

function loadUncachedTextures(interior, data)
	for k,v in ipairs(data) do
		if cachedURL[v[3]] then
			sendCustomTexture(cachedURL[v[3]], 0, source, v[2], v[3], interior)
		else
			outputDebugString("URL not cached: "..tostring(v[3]))
			fetchRemote(v[3], sendCustomTexture, "", false, source, v[2], v[3], interior)
		end
	end
end
addEvent("texture-system:loadUncachedTextures", true)
addEventHandler("texture-system:loadUncachedTextures", getRootElement(), loadUncachedTextures)
function sendCustomTexture(responseData, errno, player, texture, url, interior)
	if isElement(player) then
		if errno == 0 then
			cachedURL[url] = responseData
			triggerClientEvent(player, "onClientImageReceived", player, responseData, texture, url, interior)
		else
			--outputChatBox("Error occured when trying to reach the URL-address.", player, 255, 0, 0, false)
			outputDebugString("texture-system: Unable to reach URL-address (int"..tostring(interior)..").", 2)
		end
	end
end

addCommandHandler("cleartexturecacheserver",
	function(player, cmd)
		if(exports.global:isPlayerSuperAdmin(player)) then
			cachedURL = {}
			outputChatBox("Server-side texture cache cleared.", player, 0, 255, 0)
			--exports.global:sendMessageToAdmins("[texture-system] "..tostring(getPlayerName(player)).." cleared server texture cache.")
			for k, arrayPlayer in ipairs(exports.global:getAdmins()) do
				local logged = getElementData(arrayPlayer, "loggedin")
				if (logged) then
					if exports.global:isPlayerLeadAdmin(arrayPlayer) then
						outputChatBox( "LeadAdmWarn: " .. getPlayerName(player) .. " cleared server texture cache.", arrayPlayer, 255, 194, 14)
					end
				end
			end
			exports.logs:dbLog(player, 4, player, "cleartexturecacheserver")
		end
	end
)

--[[
function initializeTextures(res)
	if res == getThisResource() then
		outputDebugString("texture-system: LOADING ALL CUSTOM TEXTURES")

		for key,player in ipairs(getElementsByType("player")) do
			loadCustomTextures(player)
		end
	end
end
addEventHandler( "onResourceStart", getResourceRootElement(getThisResource()), initializeTextures)
--]]