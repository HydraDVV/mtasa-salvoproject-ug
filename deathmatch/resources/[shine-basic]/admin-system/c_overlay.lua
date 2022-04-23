local sx, sy = guiGetScreenSize()
local localPlayer = getLocalPlayer()

local openReports = 0
local handledReports = 0
local ckAmount = 0
local chopAmount = 0
local unansweredReports = {}
local ownReports = {}

-- dx stuff
local textString = ""
local admstr = ""
local show = false

-- Admin Titles
function getAdminTitle(thePlayer)
	local adminLevel = tonumber(getElementData(thePlayer, "adminlevel")) or 0
	local text = ({ "Cezalı Admin", "Deneme Admin", "Stajer Admin", "Kıdemli Admin", "Baş Admin", "Yönetim Ekibi Üyesi", "Yönetim Ekibi Üyesi", "Server Sahibi", nil, "Server Kurucusu" })[adminLevel] or "Player"
	
	local hiddenAdmin = getElementData(thePlayer, "hiddenadmin") or 0
	if (hiddenAdmin==1) then
		text = text .. " (Gizli)"
	end
	
	if adminLevel == 0 then
		text = getPlayerGMTitle(thePlayer)
	end
	
	return text
end

local GMtitles = { "Deneme GameMaster", "GameMaster", "Kıdemli GameMaster", "Lider GameMaster", "Baş GameMaster" }
function getPlayerGMTitle(thePlayer)
	local gmLevel = tonumber(getElementData(thePlayer, "account:gmlevel")) or 0
	local text = GMtitles[gmLevel] or "Player"
	return text
end

-- update the labels
local function updateGUI()
	if show then

		local reporttext = ""
		if #unansweredReports > 0 then
			reporttext = ": #" .. table.concat(unansweredReports, ", #")
		end
		
		local ownreporttext = ""
		if #ownReports > 0 then
			ownreporttext = ": #" .. table.concat(ownReports, ", #")
		end
		
		local onduty = getElementData( localPlayer, "adminlevel" ) <= 7 and "Off Duty " or ""
		if getElementData( localPlayer, "adminduty" ) == 1 or getElementData( localPlayer, "account:gmduty" ) then
			onduty = "" .. " "
		else
		end
		
			textString =  ( ( "| Mevcut Raporlar: " .. reporttext .. "") or "" )
	end
end

-- create the gui
local function createGUI()
	show = false
	local adminlevel = getElementData( localPlayer, "adminlevel" ) or 0
	local gmlevel = getElementData( localPlayer, "account:gmlevel" ) or 0

	if adminlevel > 1 or gmlevel > 0 then
		show = true
		updateGUI()
	end
end

addEventHandler( "onClientResourceStart", getResourceRootElement(), createGUI, false )
addEventHandler( "onClientElementDataChange", localPlayer, 
	function(n)
		if n == "adminlevel" or n == "hiddenadmin" or n=="account:gmlevel" or n=="account:gmduty" or n=="adminduty" then
			createGUI()
		end
	end, false
)

addEvent( "updateReportsCount", true )
addEventHandler( "updateReportsCount", localPlayer,
	function( open, handled, unanswered, own, admst )
		openReports = open
		handledReports = handled
		unansweredReports = unanswered
		admstr = admst
		ownReports = own or {}
		updateGUI()
	end, false
)


addEvent( "addOneToCKCount", true )
addEventHandler("addOneToCKCount", localPlayer,
	function( )
		ckAmount = ckAmount + 1
		updateGUI()
	end, false
)

addEvent( "addOneToCKCountFromSpawn", true )
addEventHandler("addOneToCKCountFromSpawn", localPlayer,
	function( )
		if (ckAmount>=1) then
			return
		else
		ckAmount = ckAmount + 1
		updateGUI()
		end
	end, false
)

addEvent( "subtractOneFromCKCount", true )
addEventHandler("subtractOneFromCKCount", localPlayer,
	function( )
	if (ckAmount~=0) then
		ckAmount = ckAmount - 1
		updateGUI()
	else
		ckAmount = 0
	end
	end, false
)

addEventHandler( "onClientPlayerQuit", getRootElement(), updateGUI )

function drawText ( )
				 dxDrawImage(3, sy-28, 23, 23,'Salvo.png')
				 dxDrawText( textString, 33, sy- 25, sx, sy, tocolor ( 255, 255, 255, 255/0.6 ), 1, exports['titan_fonts']:getFont('Roboto',10))
end
addEventHandler("onClientRender",getRootElement(), drawText)


addEventHandler("onClientRender",getRootElement(), drawText)

addEvent( "addOneToChopCount", true )
addEventHandler("addOneToChopCount", localPlayer,
	function( )
		chopAmount = chopAmount + 1
		updateGUI()
	end, false
)

addEvent( "subtractOneFromChopCount", true )
addEventHandler("subtractOneFromChopCount", localPlayer,
	function( )
	if (chopAmount~=0) then
		chopAmount = chopAmount - 1
		updateGUI()
	else
		chopAmount = 0
	end
	end, false
)