local SCOREBOARD_WIDTH				= 400				-- The scoreboard window width
local SCOREBOARD_HEIGHT				= 460				-- The scoreboard window height
local SCOREBOARD_HEADER_HEIGHT		= 20				-- Height for the header in what you can see the server info
local SCOREBOARD_TOGGLE_CONTROL		= "tab"				-- Control/Key to toggle the scoreboard visibility
local SCOREBOARD_PGUP_CONTROL		= "mouse_wheel_up"	-- Control/Key to move one page up
local SCOREBOARD_PGDN_CONTROL		= "mouse_wheel_down"-- Control/Key to move one page down
local SCOREBOARD_DISABLED_CONTROLS	= { "next_weapon",	-- Controls that are disabled when the scoreboard is showing
										"previous_weapon",
										"aim_weapon",
										"radio_next",
										"radio_previous" }
local SCOREBOARD_TOGGLE_TIME		= 15				-- Time in miliseconds to make the scoreboard (dis)appear
local SCOREBOARD_POSTGUI			= true				-- Set to true if it must be drawn over the GUI
local SCOREBOARD_INFO_BACKGROUND	= { 0, 0, 0, 0 }			-- RGBA color for the info header background
local SCOREBOARD_SERVER_NAME_COLOR	= { 255, 255, 255, 255 }		-- RGBA color for the server name text
local SCOREBOARD_PLAYERCOUNT_COLOR	= { 255, 255, 255, 255 }	-- RGBA color for the server player count text
local SCOREBOARD_BACKGROUND			= { 10, 10, 10, 230 }			-- RGBA color for the background
local SCOREBOARD_BACKGROUND_IMAGE	= { 255, 255, 255, 225 }		-- RGBA color for the background image
local SCOREBOARD_HEADERS_COLOR		= { 200, 200, 200, 160 }	-- RGBA color for the headers
local SCOREBOARD_SEPARATOR_COLOR	= { 82, 82, 82, 140 }		-- RGBA color for the separator line between headers and body content
local SCOREBOARD_SCROLL_BACKGROUND	= { 0, 10, 20, 100 }		-- RGBA color for the scroll background
local SCOREBOARD_SCROLL_FOREGROUND	= { 120, 30, 30, 110 }		-- RGBA color for the scroll foreground
local SCOREBOARD_SCROLL_HEIGHT		= 60						-- Size for the scroll marker
local SCOREBOARD_COLUMNS_WIDTH		= { 0.08, 0.50, 0.20, 0.18, 0.04 }	-- Relative width for each column: id, player name, ping and scroll position
local SCOREBOARD_ROW_GAP			= 0							-- Gap between rows
local bgb_alpha = 255
local bgb_state = "-"



--[[ Global variables to this context ]]--
local g_isShowing = false		-- Marks if the scoreboard is showing
local g_currentWidth = 0		-- Current window width. Used for the fade in/out effect.
local g_currentHeight = 0		-- Current window height. Used for the fade in/out effect.
local g_scoreboardDummy			-- Will contain the scoreboard dummy element to gather info from.
local g_windowSize = { guiGetScreenSize () }	-- The window size
local g_localPlayer = getLocalPlayer ()			-- The local player...
local g_currentPage = 0			-- The current scroll page
local g_players					-- We will keep a cache of the conected player list
local g_oldControlStates		-- To save the old control states before disabling them for scrolling

--[[ Pre-calculate some stuff ]]--
-- Scoreboard position
local SCOREBOARD_X = math.floor ( ( g_windowSize[1] - SCOREBOARD_WIDTH ) / 2 )
local SCOREBOARD_Y = math.floor ( ( g_windowSize[2] - SCOREBOARD_HEIGHT ) / 1.6 )
-- Scoreboard colors
SCOREBOARD_INFO_BACKGROUND = tocolor ( unpack ( SCOREBOARD_INFO_BACKGROUND ) )
SCOREBOARD_SERVER_NAME_COLOR = tocolor ( unpack ( SCOREBOARD_SERVER_NAME_COLOR ) )
SCOREBOARD_PLAYERCOUNT_COLOR = tocolor ( unpack ( SCOREBOARD_PLAYERCOUNT_COLOR ) )
SCOREBOARD_BACKGROUND = tocolor ( unpack ( SCOREBOARD_BACKGROUND ) )
SCOREBOARD_BACKGROUND_IMAGE = tocolor ( unpack ( SCOREBOARD_BACKGROUND_IMAGE ) )
SCOREBOARD_HEADERS_COLOR = tocolor ( unpack ( SCOREBOARD_HEADERS_COLOR ) )
SCOREBOARD_SCROLL_BACKGROUND = tocolor ( unpack ( SCOREBOARD_SCROLL_BACKGROUND ) )
SCOREBOARD_SCROLL_FOREGROUND = tocolor ( unpack ( SCOREBOARD_SCROLL_FOREGROUND ) )
SCOREBOARD_SEPARATOR_COLOR = tocolor ( unpack ( SCOREBOARD_SEPARATOR_COLOR ) )

for k=1,#SCOREBOARD_COLUMNS_WIDTH do
	SCOREBOARD_COLUMNS_WIDTH[k] = math.floor ( SCOREBOARD_COLUMNS_WIDTH[k] * SCOREBOARD_WIDTH )
end

local rowsBoundingBox = { { SCOREBOARD_X, -1 }, { -1, -1 }, { -1, -1 }, { -1, -1 }, { -1, -1 } }

rowsBoundingBox[1][2] = SCOREBOARD_X + SCOREBOARD_COLUMNS_WIDTH[1]

rowsBoundingBox[2][1] = rowsBoundingBox[1][2]
rowsBoundingBox[2][2] = rowsBoundingBox[2][1] + SCOREBOARD_COLUMNS_WIDTH[2]

rowsBoundingBox[3][1] = rowsBoundingBox[2][2]
rowsBoundingBox[3][2] = rowsBoundingBox[3][1] + SCOREBOARD_COLUMNS_WIDTH[3]

rowsBoundingBox[4][1] = rowsBoundingBox[3][2]
rowsBoundingBox[4][2] = rowsBoundingBox[4][1] + SCOREBOARD_COLUMNS_WIDTH[4]

rowsBoundingBox[5][1] = rowsBoundingBox[4][2]
rowsBoundingBox[5][2] = SCOREBOARD_X + SCOREBOARD_WIDTH


local onRender
local fadeScoreboard
local drawBackground
local drawScoreboard


local function clamp ( valueMin, current, valueMax )
	if current < valueMin then
		return valueMin
	elseif current > valueMax then
		return valueMax
	else
		return current
	end
end


local function createPlayerCache ( ignorePlayer )

	if ignorePlayer then

		g_players = {}
		

		local players = getElementsByType ( "player" )
	
		for k, player in ipairs(players) do
			if ignorePlayer ~= player then
				table.insert ( g_players, player )
			end
		end
	else
		g_players = getElementsByType ( "player" )
	end
	
	

	table.sort ( g_players, function ( a, b )
		local idA = getElementData ( a, "playerid" ) or 0
		local idB = getElementData ( b, "playerid" ) or 0


		if a == g_localPlayer then
			idA = -1
		elseif b == g_localPlayer then
			idB = -1
		end
		
		return tonumber(idA) < tonumber(idB)
	end )
end

addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), function ()
	createPlayerCache ()
end, false )


addEventHandler ( "onClientElementDataChange", root, function ( dataName, dataValue )
	if dataName == "playerid" then
		createPlayerCache ()
	end
end )


addEventHandler ( "onClientPlayerQuit", root, function ()
	createPlayerCache ( source )
end )


local function toggleScoreboard ( show )

	local show = show == true
	

	if show ~= g_isShowing then
		g_isShowing = show
		
		if g_isShowing and g_currentWidth == 0 and g_currentHeight == 0 then
			addEventHandler ( "onClientPreRender", root, onRender, false )
		end
		
		if g_isShowing then
			g_oldControlStates = {}
			for k, control in ipairs ( SCOREBOARD_DISABLED_CONTROLS ) do
				g_oldControlStates[k] = isControlEnabled ( control )
				toggleControl ( control, false )
			end
		else
			for k, control in ipairs ( SCOREBOARD_DISABLED_CONTROLS ) do
				toggleControl ( control, g_oldControlStates[k] )
			end
			g_oldControlStates = nil
		end
	end
end


local function onToggleKey ( key, keyState )
	if not g_scoreboardDummy then
		local elementTable = getElementsByType ( "scoreboard" )
		if #elementTable > 0 then
			g_scoreboardDummy = elementTable[1]
		else
			return
		end
	end
	playSound("files/sound.mp3")
	toggleScoreboard ( keyState == "down" and getElementData ( g_scoreboardDummy, "allow" ) )
end
bindKey ( SCOREBOARD_TOGGLE_CONTROL, "both", onToggleKey )

local function onScrollKey ( direction )
	if g_isShowing then
		if direction then
			g_currentPage = g_currentPage + 1
			playSound("files/wheel.wav")
		else
			g_currentPage = g_currentPage - 1
			if g_currentPage < 0 then
				g_currentPage = 0
				playSound("files/wheel.wav")
			end
		end
	end
end
bindKey ( SCOREBOARD_PGUP_CONTROL, "down", function () onScrollKey ( false ) end )
bindKey ( SCOREBOARD_PGDN_CONTROL, "down", function () onScrollKey ( true ) end )


onRender = function ( timeshift )

	local drawIt = false
	
	if g_isShowing then

		if not getElementData ( g_scoreboardDummy, "allow" ) then
			toggleScoreboard ( false )

		elseif g_currentWidth < SCOREBOARD_WIDTH or g_currentHeight < SCOREBOARD_HEIGHT then
			drawIt = fadeScoreboard ( timeshift, 1 )
		else

			drawIt = true
		end
	else

		drawIt = fadeScoreboard ( timeshift, -1 )
	end
	

	if drawIt then
		drawScoreboard ()
	end
end


fadeScoreboard = function ( timeshift, multiplier )

	local growth = ( timeshift / SCOREBOARD_TOGGLE_TIME ) * multiplier
	

	g_currentWidth = clamp ( 0, g_currentWidth + ( SCOREBOARD_WIDTH * growth ), SCOREBOARD_WIDTH )
	g_currentHeight = clamp ( 0, g_currentHeight + ( SCOREBOARD_HEIGHT * growth ), SCOREBOARD_HEIGHT )
	

	if g_currentWidth == 0 or g_currentHeight == 0 then
		g_currentWidth = 0
		g_currentHeight = 0
		removeEventHandler ( "onClientPreRender", root, onRender )
		return false
	else
		return true
	end
end

drawBackground = function ()

	local headerHeight = clamp ( 0, SCOREBOARD_HEADER_HEIGHT, g_currentHeight )
	dxDrawRectangle ( SCOREBOARD_X, SCOREBOARD_Y,
					  g_currentWidth, headerHeight,
					  SCOREBOARD_INFO_BACKGROUND, SCOREBOARD_POSTGUI )
	
	

	if g_currentHeight > SCOREBOARD_HEADER_HEIGHT then

		dxDrawImage ( SCOREBOARD_X+15, SCOREBOARD_Y-240, SCOREBOARD_WIDTH-40 , SCOREBOARD_HEIGHT-140,"files/logo.png", 0, 0, 0, tocolor(255,255, 255, bgb_alpha))
				if bgb_state == "-" then
		bgb_alpha = bgb_alpha - 2
		if bgb_alpha <= 0 then
			bgb_alpha = 0
			bgb_state = "+"
		end
	elseif bgb_state == "+" then
		bgb_alpha = bgb_alpha + 2
		if bgb_alpha >= 255 then
			bgb_alpha = 255
			bgb_state = "-"
		end
	end

		roundedRectangle ( SCOREBOARD_X, SCOREBOARD_Y-35 + SCOREBOARD_HEADER_HEIGHT,g_currentWidth, g_currentHeight*0.1 - SCOREBOARD_HEADER_HEIGHT,tocolor(10, 10, 10, 230))
		dxDrawRectangle ( SCOREBOARD_X, SCOREBOARD_Y + SCOREBOARD_HEADER_HEIGHT,g_currentWidth, g_currentHeight - SCOREBOARD_HEADER_HEIGHT,SCOREBOARD_BACKGROUND,SCOREBOARD_POSTGUI)
		roundedRectangle ( SCOREBOARD_X, SCOREBOARD_Y+450+ SCOREBOARD_HEADER_HEIGHT,g_currentWidth, g_currentHeight*0.1 - SCOREBOARD_HEADER_HEIGHT,tocolor(10,10,10,230))

	end
end

local function drawRowBounded ( id, name, level, ping, colors, font, top )

	local bottom = clamp ( 0, top + dxGetFontHeight ( 1, font ), SCOREBOARD_Y + g_currentHeight )
	local maxWidth = SCOREBOARD_X + g_currentWidth
	
	if bottom < top then return end
	
	-- ID
	local left = rowsBoundingBox[1][1]
	local right = clamp ( 0, rowsBoundingBox[1][2], maxWidth )
	if left < right then
		dxDrawText ( id, left, top, right, bottom,
					 colors[1], 1, font, "right", "top",
					 true, false, SCOREBOARD_POSTGUI )
		
		-- Name
		left = rowsBoundingBox[2][1] + 17 
		right = clamp ( 0, rowsBoundingBox[2][2], maxWidth )
		if left < right then
			dxDrawText ( name, left, top, right, bottom,
						 colors[2], 1, font, "left", "top",
						 true, false, SCOREBOARD_POSTGUI )
						 
			-- Level
			left = rowsBoundingBox[3][1]
			right = clamp ( 0, rowsBoundingBox[3][2], maxWidth )
			if left < right then
				dxDrawText ( level, left, top, right, bottom,
							 colors[3], 1, font, "left", "top",
							 true, false, SCOREBOARD_POSTGUI )
			
				-- Ping
				left = rowsBoundingBox[4][1]
				right = clamp ( 0, rowsBoundingBox[4][2], maxWidth )
				if left < right then
					dxDrawText ( ping, left, top, right, bottom,colors[3], 1, font, "left", "top", true, false, SCOREBOARD_POSTGUI )
				end
			end
		end
	end
end


local function drawScrollBar ( top, position )
	local left = rowsBoundingBox[5][1]
	local right = clamp ( 0, rowsBoundingBox[5][2], SCOREBOARD_X + g_currentWidth )
	local bottom = clamp ( 0, SCOREBOARD_Y + SCOREBOARD_HEIGHT, SCOREBOARD_Y + g_currentHeight )
	

	if left < right and top < bottom then

		dxDrawRectangle ( left, top, right - left, bottom - top, SCOREBOARD_SCROLL_BACKGROUND, SCOREBOARD_POSTGUI )
		

		local top = top + position * ( SCOREBOARD_Y + SCOREBOARD_HEIGHT - SCOREBOARD_SCROLL_HEIGHT - top )
		bottom = clamp ( 0, top + SCOREBOARD_SCROLL_HEIGHT, SCOREBOARD_Y + g_currentHeight )
		

		if top < bottom then
			dxDrawRectangle ( left, top, right - left, bottom - top, SCOREBOARD_SCROLL_FOREGROUND, SCOREBOARD_POSTGUI )
		end
	end
end



drawScoreboard = function ()

	if not g_players then return end


	drawBackground ()
	

	local serverName = getElementData ( g_scoreboardDummy, "serverName" ) or "MTA server"
	local maxPlayers = getElementData ( g_scoreboardDummy, "maxPlayers" ) or 0
	serverName = tostring ( serverName )
	maxPlayers = tonumber ( maxPlayers )
	

	local left, top, right, bottom = SCOREBOARD_X + 2, SCOREBOARD_Y + 2, SCOREBOARD_X + g_currentWidth - 2, SCOREBOARD_Y + SCOREBOARD_HEADER_HEIGHT - 2
	
	local font1 = exports['titan_fonts']:getFont("BoldFont", 9) or 'default-bold'
	dxDrawText ( serverName, left, top-14, right, bottom, tocolor ( 255, 255, 255, 255 ), 1, font1,"center", "top",true, false, SCOREBOARD_POSTGUI )


	local usagePercent = (#g_players / maxPlayers)
	roundedRectangle( SCOREBOARD_X, SCOREBOARD_Y+450+ SCOREBOARD_HEADER_HEIGHT, 400*#g_players/maxPlayers, g_currentHeight*0.1 - SCOREBOARD_HEADER_HEIGHT,tocolor(80,0,0,215))
	local strPlayerCount = " Oyuncu: " .. tostring(#g_players) .. "/" .. tostring(maxPlayers) .. ""
	
	local offset = SCOREBOARD_WIDTH - dxGetTextWidth ( strPlayerCount, 1, "tahoma" ) - 4
	left = left + offset

	if left < right then
	local font1 = exports['titan_fonts']:getFont("FontAwesome", 9) or 'default-bold'

		dxDrawText ( strPlayerCount, left-170, top*0.1, right, bottom+472, tocolor ( 255, 255, 255, 255 ), 1, font1,"left", "bottom",true, false, SCOREBOARD_POSTGUI )

	end
	
	left, top, bottom = SCOREBOARD_X, SCOREBOARD_Y + SCOREBOARD_HEADER_HEIGHT + 2, SCOREBOARD_Y + g_currentHeight - 2

	local rowHeight = dxGetFontHeight ( 1, "default-bold" )
	
	local font1 = exports['titan_fonts']:getFont("FontAwesome", 8) or 'default-bold'
	drawRowBounded ( "ID ", "Oyuncu Ismi  ", "Saat  ", "Ping  ",
					 { SCOREBOARD_HEADERS_COLOR, SCOREBOARD_HEADERS_COLOR, SCOREBOARD_HEADERS_COLOR, SCOREBOARD_HEADERS_COLOR },
					 font1, top )
	
				 
	top = top + rowHeight + 3
	
	right = clamp ( 0, rowsBoundingBox[4][2] - 5, SCOREBOARD_X + g_currentWidth )
	if top < SCOREBOARD_Y + g_currentHeight then
		dxDrawLine ( SCOREBOARD_X + 5, top, right, top, SCOREBOARD_SEPARATOR_COLOR, 1, SCOREBOARD_POSTGUI )
	end
	top = top + 3
	
	local renderEntry = function ( player )
		local playerID = getElementData ( player, "playerid" ) or 0
		playerID = tostring ( playerID )
		local playerName = getPlayerName ( player )
		playerName = tostring ( playerName ):gsub( "_", " " )
		local username = getElementData ( player, "account:username" ) or ""
		local playerPing = getPlayerPing ( player )
		playerPing = tostring ( playerPing )
		local playerLevel = getElementData ( player, "hoursplayed") or 0
		playerLevel = tostring ( playerLevel )
		local r, g, b = getPlayerNametagColor ( player )
		local playerColor = tocolor ( r, g, b, 255 )
		
		local colors = { playerColor, playerColor, playerColor }
		
		top = top
		if exports.global:isPlayerAdmin(getLocalPlayer()) and getElementData(getLocalPlayer(), "adminduty") == 1 and getElementData(player, "loggedin") == 1 then
			playerName = tostring ( playerName ):gsub( "_", " " ).. " ("..username..")"
		else
			playerName = tostring ( playerName ):gsub( "_", " " )
		end
		drawRowBounded ( playerID, playerName, playerLevel,"", colors, font1, top )
	end
	
	local playersPerPage = math.floor ( ( SCOREBOARD_Y + SCOREBOARD_HEIGHT - top ) / ( rowHeight + SCOREBOARD_ROW_GAP ) )
	
	local playerShift = math.floor ( playersPerPage / 2 )
	
	local playersToSkip = playerShift * g_currentPage
	if (#g_players - playersToSkip) < playersPerPage then
		if (#g_players - playersToSkip) < playerShift then
			g_currentPage = g_currentPage - 1
			if g_currentPage < 0 then g_currentPage = 0 end
		end

		playersToSkip = #g_players - playersPerPage + 1
	end
	
	if playersToSkip < 0 then
		playersToSkip = 0
	end

	for k=playersToSkip + 1, #g_players do
		local player = g_players [ k ]
		
		if top < bottom - rowHeight - SCOREBOARD_ROW_GAP then
			renderEntry ( player )
			top = top + rowHeight + SCOREBOARD_ROW_GAP
		else break end
	end
	
	drawScrollBar ( SCOREBOARD_Y + SCOREBOARD_HEADER_HEIGHT + rowHeight + 8, playersToSkip / ( #g_players - playersPerPage + 1 ) )
end


function isVisible ( )
	return g_isShowing
end

function dxDrawFramedText ( message , left , top , width , height , color , scale , font , alignX , alignY , clip , wordBreak , postGUI )
    dxDrawText ( message , left + 1 , top + 1 , width + 1 , height + 1 , tocolor ( 0 , 0 , 0 , alpha ) , scale , font , alignX , alignY , clip , wordBreak , postGUI )
    dxDrawText ( message , left + 1 , top - 1 , width + 1 , height - 1 , tocolor ( 0 , 0 , 0 , alpha ) , scale , font , alignX , alignY , clip , wordBreak , postGUI )
    dxDrawText ( message , left - 1 , top + 1 , width - 1 , height + 1 , tocolor ( 0 , 0 , 0 , alpha ) , scale , font , alignX , alignY , clip , wordBreak , postGUI )
    dxDrawText ( message , left - 1 , top - 1 , width - 1 , height - 1 , tocolor ( 0 , 0 , 0 , alpha ) , scale , font , alignX , alignY , clip , wordBreak , postGUI )
    dxDrawText ( message , left , top , width , height , color , scale , font , alignX , alignY , clip , wordBreak , postGUI )
end

function dxDrawFramedRectangle ( left, top, right, bottom, shit, shit2)
	dxDrawRectangle ( left + 1, top + 1, right + 1 , bottom + 1, tocolor(0, 0, 0, 160), shit2 )
	dxDrawRectangle ( left + 1, top - 1, right + 1 , bottom - 1, tocolor(0, 0, 0, 160), shit2 )
	dxDrawRectangle ( left - 1, top + 1, right - 1 , bottom + 1, tocolor(0, 0, 0, 160), shit2 )
	dxDrawRectangle ( left - 1, top - 1, right - 1 , bottom - 1, tocolor(0, 0, 0, 160), shit2 )
	dxDrawRectangle ( left, top, right, bottom, shit, shit2 )
end


function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
	if (x and y and w and h) then
		if (not borderColor) then
			borderColor = tocolor(0, 0, 0, 200);
		end
		
		if (not bgColor) then
			bgColor = borderColor;
		end
		
		--> Background
		dxDrawRectangle(x, y, w, h, bgColor, postGUI);
		
		--> Border
		dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI); -- top
		dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI); -- bottom
		dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI); -- left
		dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI); -- right
	end
end