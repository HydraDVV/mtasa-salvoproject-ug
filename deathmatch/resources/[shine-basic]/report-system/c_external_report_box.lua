--MAXIME
local hfont = exports.titan_fonts:getFont("Roboto",10)
local localPlayer = getLocalPlayer()
local show = false
local width, height = 650,300
local woffset, hoffset = 0, 0
local sx, sy = guiGetScreenSize()
local content = {}
local line = 15
local thisResourceElement = getResourceRootElement(getThisResource())
local BizNoteFont18 = dxCreateFont ( ":interior-system/BizNote.ttf" , 18 )

function updateOverlay(info, widthNew, woffsetNew, hoffsetNew)
	if getElementData(localPlayer, "report-system:isAdminPanelEnabled") then
		if info then
			table.insert(content, info)
			playSoundFrontEnd ( 101 )
		end
		if widthNew then
			width = widthNew
		end
		if woffsetNew then
			woffset = woffsetNew
		end
		if hoffsetNew then
			hoffset = hoffsetNew
		end
	end
end
addEvent("report-system:updateOverlay", true)
addEventHandler("report-system:updateOverlay", localPlayer, updateOverlay)

addEventHandler( "onClientElementDataChange", thisResourceElement , 
	function(n)
		if n == "reportPanel" then
			updateOverlay(getElementData(thisResourceElement, "reportPanel") or false)
		end
	end, false
)

addEventHandler( "onClientElementDataChange", localPlayer, 
	function(n)
		if n == "adminlevel" or n=="account:gmlevel" or n=="account:gmduty" or n=="adminduty" then
			if not (exports.global:isPlayerAdmin(localPlayer) and (getElementData(localPlayer, "adminduty")==1) ) and not (exports.global:isPlayerGameMaster(localPlayer) and getElementData(localPlayer, "account:gmduty"))then
				setElementData(localPlayer, "report-system:isAdminPanelEnabled", false, true)
			else
				setElementData(localPlayer, "report-system:isAdminPanelEnabled", true, true)
			end
		end
	end, false
)

addEventHandler( "onClientResourceStart", thisResourceElement, 
	function()
		if not (exports.global:isPlayerAdmin(localPlayer) and (getElementData(localPlayer, "adminduty")==1) ) and not (exports.global:isPlayerGameMaster(localPlayer) and getElementData(localPlayer, "account:gmduty"))then
			setElementData(localPlayer, "report-system:isAdminPanelEnabled", false, true)
		else
			setElementData(localPlayer, "report-system:isAdminPanelEnabled", true, true)
		end
	end
, false)

addEventHandler("onClientRender",getRootElement(), function ()
	if getElementData(localPlayer, "report-system:isAdminPanelEnabled") then 
		if ( getPedWeapon( localPlayer ) ~= 43 or not getControlState( "aim_weapon" ) ) then
			local w = width
			local h = 16*(line)+30
			local posX = (sx/2)-(w/2)+woffset
			local posY = sy-(h+30)+hoffset 
			roundedRectangle(posX, posY , w, h , tocolor(10, 10, 10, 200), false)
			dxDrawText( "'F6' Tuşuna basarak arayüzü kapatabilirsiniz." , posX+395, posY, w-5, 5, tocolor ( 250, 250, 250, 100 ), 1 ,hfont)
			dxDrawText( "Salvo:world | report-system ©REMAJOR" , posX+10, posY, w-5, 5, tocolor ( 250, 250, 250, 100 ), 1, hfont)
			
			local lastIndex = #content
			local count = 1
			for i = (lastIndex-line+2), (lastIndex) do
				if content[i] then
					dxDrawText( content[i][1] or "" , posX+16, posY+(15*count)+30, w-5, 15, tocolor ( content[i][2] or 255, content[i][3] or 255, content[i][4] or 255, content[i][5] or 255 ), content[i][6] or 1, content[i][7] or "default" )
					count = count + 1
				end
			end
			
		end
	end
end, false)

function togAdminPanel()
	if exports.global:isPlayerAdmin(localPlayer) or exports.global:isPlayerGameMaster(localPlayer) then
		local currentState = getElementData(localPlayer, "report-system:isAdminPanelEnabled") or false
		setElementData(localPlayer, "report-system:isAdminPanelEnabled", not currentState ,true)
	end
end
bindKey ( "F6", "down" , togAdminPanel)

function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
	if (x and y and w and h) then
		if (not borderColor) then
			borderColor = tocolor(0, 0, 0, 180)
		end
		if (not bgColor) then
			bgColor = borderColor
		end
		dxDrawRectangle(x, y, w, h, bgColor, postGUI);
		dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI);
		dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI);
		dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI);
		dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI);
        
        --Sarkokba pötty:
        dxDrawRectangle(x + 0.5, y + 0.5, 1, 2, borderColor, postGUI);
        dxDrawRectangle(x + 0.5, y + h - 1.5, 1, 2, borderColor, postGUI);
        dxDrawRectangle(x + w - 0.5, y + 0.5, 1, 2, borderColor, postGUI);
        dxDrawRectangle(x + w - 0.5, y + h - 1.5, 1, 2, borderColor, postGUI);
	end
end