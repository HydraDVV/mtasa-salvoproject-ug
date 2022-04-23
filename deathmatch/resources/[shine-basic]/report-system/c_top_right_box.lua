local localPlayer = getLocalPlayer()
local show = false
local width, height = 500,300
local woffset, hoffset = 0, 0
local sx, sy = guiGetScreenSize()
local content = {}
local thisResourceElement = getResourceRootElement(getThisResource())

function drawOverlayTopRight(info, widthNew, woffsetNew, hoffsetNew, cooldown)
	if getElementData(localPlayer, "report-system:isAdminPanelEnabled") then
		content = info
		if tonumber(widthNew) then
			width = tonumber(widthNew)
		end
	end
end
addEvent("report-system:drawOverlayTopRight", true)
addEventHandler("report-system:drawOverlayTopRight", localPlayer, drawOverlayTopRight)

addEventHandler("onClientRender",getRootElement(), function ()
	if getElementData(localPlayer, "report-system:isAdminPanelEnabled") then 
		if ( getPedWeapon( localPlayer ) ~= 43 or not getControlState( "aim_weapon" ) ) then
			roundedRectangle(sx-width-5+woffset, 5+hoffset, width, 16*(#content)+30, tocolor(10, 10, 10, 200), false)
			
			for i=1, #content do
				if content[i] then
					dxDrawText( content[i][1] or "" , sx-width+10+woffset, (16*i)+hoffset, width-5, 15, tocolor ( content[i][2] or 255, content[i][3] or 255, content[i][4] or 255, content[i][5] or 255 ), content[i][6] or 1, content[i][7] or "default" )
				end
				
			end
			
		end
	end
end, false)

addEventHandler( "onClientElementDataChange", getResourceRootElement(getThisResource()) , 
	function(n)
		if n == "urAdmin" or n == "urGM" or n == "allReports" then
			if getElementData(localPlayer,"report:topRight") == 1 then
				drawOverlayTopRight(getElementData(thisResourceElement, "urAdmin") or false, 550)
			elseif getElementData(localPlayer,"report:topRight") == 2 then
				drawOverlayTopRight(getElementData(thisResourceElement, "urGM") or false, 550)
			elseif getElementData(localPlayer,"report:topRight") == 3 then
				drawOverlayTopRight(getElementData(thisResourceElement, "allReports") or false, 600)
			end
		end
	end, false
)

function startAutoUpdate()
	if exports.global:isPlayerAdmin(localPlayer) then
		setElementData(localPlayer, "report:topRight", 1, true)
	elseif exports.global:isPlayerGameMaster(localPlayer) then
		setElementData(localPlayer, "report:topRight", 2, true)
	else
		setElementData(localPlayer, "report:topRight", 3, true)
	end
end
addEventHandler("onClientResourceStart", thisResourceElement, startAutoUpdate)

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