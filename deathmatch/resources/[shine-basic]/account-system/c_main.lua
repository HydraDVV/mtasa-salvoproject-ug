function onResourceStart()
	clearChat()
	setPlayerHudComponentVisible("weapon", false)
	setPlayerHudComponentVisible("ammo", false)
	setPlayerHudComponentVisible("vehicle_name", false)
	setPlayerHudComponentVisible("money", false)
	setPlayerHudComponentVisible("clock", false)
	setPlayerHudComponentVisible("health", false)
	setPlayerHudComponentVisible("armour", false)
	setPlayerHudComponentVisible("breath", false)
	setPlayerHudComponentVisible("area_name", false)
	--setPlayerHudComponentVisible("radar", false)
	setPlayerHudComponentVisible("crosshair", true)
	
	setPlayerHudComponentVisible( "gunfire", false )
	triggerServerEvent( "accounts:login:request", getLocalPlayer() )
end
addEventHandler( "onClientResourceStart", getResourceRootElement( ), onResourceStart )

--[[ XML STORAGE ]]--
local oldXmlFileName = "settings.xml"
local migratedSettingsFile = "@migratedsettings.empty"
local xmlFileName = "@settings.xml"
function loadSavedData(parameter, default)
	-- migrate existing settings
	if not fileExists(migratedSettingsFile) then
		if not fileExists(xmlFileName) and fileExists(oldXmlFileName) then
			fileRename(oldXmlFileName, xmlFileName)
		end
		fileClose(fileCreate(migratedSettingsFile))
	end
	local xmlRoot = xmlLoadFile( xmlFileName )
	if (xmlRoot) then
		local xmlNode = xmlFindChild(xmlRoot, parameter, 0)
		if (xmlNode) then
			return xmlNodeGetValue(xmlNode)
		end
	end
	return default or false
end

function appendSavedData(parameter, value)
	setElementData(getLocalPlayer(), parameter, value, false)
	local xmlFile = xmlLoadFile ( xmlFileName )
	if not (xmlFile) then
		xmlFile = xmlCreateFile( xmlFileName, "login" )
	end
	
	local xmlNode = xmlFindChild (xmlFile, parameter, 0)
	if not (xmlNode) then
		xmlNode = xmlCreateChild(xmlFile, parameter)
	end
	xmlNodeSetValue ( xmlNode, value )
	xmlSaveFile(xmlFile)
	xmlUnloadFile(xmlFile)
end

--MAXIME--
-- function loadSavedData3(parameter)
	-- for i = 2, 14, 2 do
		-- if loadSavedData(parameter, tostring(i*5)) then
			-- return loadSavedData(parameter, tostring(i*5))
		-- end
	-- end
	-- return "10"
-- end

--MAXIME
function loadSavedData2(parameter)
	
	for key, font in pairs(exports["titan_description"]:getOverLayFonts()) do
		local value = loadSavedData(parameter, font[1])
		if value then
			return value
		end
	end
	
	return false
end

--[[ END XML STORAGE ]]--

--[[ START ANIMATION STUFF ]]--
local happyAnims = {
	{ "ON_LOOKERS", "wave_loop"}
}

local idleAnims = {
	{ "PLAYIDLES", "shift"},
	{ "PLAYIDLES", "shldr"},
	{ "PLAYIDLES", "stretch"},
	{ "PLAYIDLES", "strleg"},
	{ "PLAYIDLES", "time"}
}

local danceAnims = {
	{ "DANCING", "dance_loop" }
}

local deathAnims = {
	{ "ped", "FLOOR_hit" }
}

function getRandomAnim( animType )
	if (animType == 1) then -- happy animations
		return happyAnims[ math.random(1, #happyAnims) ]
	elseif (animType == 2) then -- idle animations
		return idleAnims[ math.random(1, #idleAnims) ]
	elseif (animType == 3) then -- idle animations
		return danceAnims[ math.random(1, #danceAnims) ]
	elseif (animType == 4) then -- death animations
		return deathAnims[ math.random(1, #deathAnims) ]
	end
end
--[[ END ANIMATION STUFF ]]--

function clearChat()
	local lines = getChatboxLayout()["chat_lines"]
	for i=1,lines do
		outputChatBox("")
	end
end
addCommandHandler("clearchat", clearChat)
 


--MAXIME
function applyClientConfigSettings() 
	local rFontColorVehWhite = tonumber( loadSavedData("rFontColorVehWhite", "1") )
	setElementData(getLocalPlayer(), "rFontColorVehWhite", rFontColorVehWhite, false)
	
	local rFontColorProWhite = tonumber( loadSavedData("rFontColorProWhite", "1") )
	setElementData(getLocalPlayer(), "rFontColorProWhite", rFontColorProWhite, false)
	
	local borderVeh = tonumber( loadSavedData("borderVeh", "1") )
	setElementData(getLocalPlayer(), "borderVeh", borderVeh, false)
	
	local bgVeh = tonumber( loadSavedData("bgVeh", "1") )
	setElementData(getLocalPlayer(), "bgVeh", bgVeh, false)
	
	local bgPro = tonumber( loadSavedData("bgPro", "1") )
	setElementData(getLocalPlayer(), "bgPro", bgPro, false)
	
	local borderPro = tonumber( loadSavedData("borderPro", "1") )
	setElementData(getLocalPlayer(), "borderPro", borderPro, false)
	
	local enableOverlayDescription = tonumber( loadSavedData("enableOverlayDescription", "1") )
	setElementData(getLocalPlayer(), "enableOverlayDescription", enableOverlayDescription, false)
	
	local enableOverlayDescriptionVeh = tonumber( loadSavedData("enableOverlayDescriptionVeh", "1") )
	setElementData(getLocalPlayer(), "enableOverlayDescriptionVeh", enableOverlayDescriptionVeh, false)
	
	local enableOverlayDescriptionVehPin = tonumber( loadSavedData("enableOverlayDescriptionVehPin", "1") )
	setElementData(getLocalPlayer(), "enableOverlayDescriptionVehPin", enableOverlayDescriptionVehPin, false)
	
	local enableOverlayDescriptionPro = tonumber( loadSavedData("enableOverlayDescriptionPro", "1") )
	setElementData(getLocalPlayer(), "enableOverlayDescriptionPro", enableOverlayDescriptionPro, false)
	
	local enableOverlayDescriptionProPin = tonumber( loadSavedData("enableOverlayDescriptionProPin", "1") )
	setElementData(getLocalPlayer(), "enableOverlayDescriptionProPin", enableOverlayDescriptionProPin, false)
	
	local cFontPro = loadSavedData2("cFontPro")
	setElementData(getLocalPlayer(), "cFontPro", cFontPro or "default", false)
	
	local cFontVeh = loadSavedData2("cFontVeh")
	setElementData(getLocalPlayer(), "cFontVeh", cFontVeh or "default", false)
	
	-- local sVeh = tonumber( loadSavedData3("sVeh", "sVeh") )
	-- setElementData(getLocalPlayer(), "sVeh", sVeh, false)
	
	-- local sPro = tonumber( loadSavedData3("sPro") )
	-- setElementData(getLocalPlayer(), "sPro", sPro, false)

	
	
	
	local blurEnabled = tonumber( loadSavedData("motionblur", "1") )
	if (blurEnabled == 1) then
		setBlurLevel(38)
	else
		setBlurLevel(0)
	end
	
	local skyCloudsEnabled = tonumber( loadSavedData("skyclouds", "1") )
	if (skyCloudsEnabled == 1) then
		setCloudsEnabled ( true )
	else
		setCloudsEnabled ( false )
	end
	
	local streamingMediaEnabled = tonumber(loadSavedData("streamingmedia", "1"))
	if streamingMediaEnabled == 1 then
		setElementData(getLocalPlayer(), "streams", 1, true)
	else
		setElementData(getLocalPlayer(), "streams", 0, true)
	end
	--[[
	local setNametagsEnabled = tonumber( loadSavedData("shownametags", "1") )
	if (setNametagsEnabled == 1) then
		setNametagsEnabled ( true )
	else
		setNametagsEnabled ( false )
	end]]
end
addEventHandler("accounts:options:settings:updated", getRootElement(), applyClientConfigSettings)

-- For the skin selection
blackMales = {7, 16, 17, 18, 20, 21, 22, 24, 25, 28, 35, 36, 50, 51, 66, 67, 79, 80, 83, 84, 102, 103, 104, 105, 106, 107, 134, 136, 142, 143, 144, 156, 163, 166, 168, 176, 180, 182, 183, 185, 220, 221, 222, 249, 253, 260, 262 }
whiteMales = {23, 26, 27, 29, 30, 32, 33, 34, 35, 36, 37, 38, 43, 44, 47, 48, 50, 51, 52, 53, 58, 59, 60, 61, 62, 68, 70, 72, 73, 81, 82, 94, 95, 96, 97, 99, 100, 101, 108, 109, 110, 111, 112, 113, 114, 115, 116, 120, 121, 122, 124, 125, 126, 127, 128, 132, 135, 137, 146, 147, 153, 154, 155, 158, 159, 160, 161, 162, 164, 165, 170, 171, 173, 174, 175, 177, 179, 181, 184, 186, 187, 188, 189, 200, 202, 204, 206, 209, 212, 213, 217, 223, 230, 234, 235, 236, 240, 241, 242, 247, 248, 250, 252, 254, 255, 258, 259, 261, 264, 272 }
asianMales = {49, 57, 58, 59, 60, 117, 118, 120, 121, 122, 123, 170, 186, 187, 203, 210, 227, 228, 229, 294}
blackFemales = {9, 11, 12, 13, 40, 41, 63, 64, 69, 76, 91, 139, 148, 190, 195, 207, 215, 218, 219, 238, 243, 244, 245, 256 }
whiteFemales = {12, 31, 38, 39, 40, 41, 53, 54, 55, 56, 64, 75, 77, 85, 86, 87, 88, 89, 90, 91, 92, 93, 130, 131, 138, 140, 145, 150, 151, 152, 157, 172, 178, 192, 193, 194, 196, 197, 198, 199, 201, 205, 211, 214, 216, 224, 225, 226, 231, 232, 233, 237, 243, 246, 251, 257, 263 }
asianFemales = {38, 53, 54, 55, 56, 88, 141, 178, 224, 225, 226, 263}

local screenX, screenY = guiGetScreenSize( )
local label = guiCreateLabel( 0, 20, screenX, 15, "Salvo:world" .. scriptVersion , false )
guiSetSize( label, guiLabelGetTextExtent( label ) + 5, 14, false )
guiSetPosition( label, screenX - guiLabelGetTextExtent( label ) - 5, screenY - 27, false )
guiSetAlpha( label, 0.5 )

function stopNameChange(oldNick, newNick)
	if (source==getLocalPlayer()) then
		local legitNameChange = getElementData(getLocalPlayer(), "legitnamechange")

		if (oldNick~=newNick) and (legitNameChange==0) then
			triggerServerEvent("resetName", getLocalPlayer(), oldNick, newNick) 
			outputChatBox("Eger Roleplay Kimligini degistirmek istiyorsan ''Karakter Degistir'' e bas.", 255, 0, 0)
		end
	end
end
addEventHandler("onClientPlayerChangeNick", getRootElement(), stopNameChange)