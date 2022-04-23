addEventHandler("onClientResourceStart", getRootElement(), function() setPlayerHudComponentVisible ( "crosshair", true ) setElementData(getLocalPlayer(), "stamina", 100) end)
local sX, sY = guiGetScreenSize()
local showHud = true
local hfont = exports.titan_fonts:getFont("Roboto",15)
local hfont1 = exports.titan_fonts:getFont("FontAwesome",10)
local hfont2 = exports.titan_fonts:getFont("FontAwesome",12)
local benim_ekranim  = dxCreateScreenSource(sX, sY)
local dotCounter = 0
sefaflik = 0
sefaflik_duyuru = 0
local doubleDot = ":"
local hudElements = {
	{"hud-main", sX-325, 25, 300, 80},
}
local images = {
	--["hud-main"] = "img/arkapng.png",
}
addEventHandler("onClientRender", getRootElement(), function()
	if showHud and (getElementData(localPlayer, "loggedin") == 1) then
		for i, k in ipairs(hudElements) do
			local x, y, w, h, m, r, ru = getElementData(localPlayer, k[1] .. "X") or k[2], getElementData(localPlayer, k[1] .. "Y") or k[3], getElementData(localPlayer, k[1] .. "W") or k[4], getElementData(localPlayer, k[1] .. "H") or k[5], getElementData(localPlayer,k[1] .. "Moving") or false, getElementData(localPlayer, k[1] .. "Resize") or false, getElementData(localPlayer, k[1] .. "ResizeUse") or false
			local hudType = tostring(k[1])
			if (hudType == "hud-main") then
				--dxDrawImage(x, y, w, h, images[hudType])
				dxDrawCircleBar(x, y, w, h)
				--dxDrawTime(x, y)
				if m then
					local cX, cY = getCursorPosition()
					setElementData(localPlayer, hudType.."X", cX-defX)
					setElementData(localPlayer, hudType.."Y", cY-defY)
				end

			end
		end
	end
end)
addEventHandler("onClientClick", getRootElement(), function(button, state, aX, aY, wX, wY, wZ, element)
	if showHud then
		if button == "left" then
			if state == "down" then
				for i, k in ipairs(hudElements) do
					local x, y, w, h, r = getElementData(localPlayer, k[1].."X") or k[2], getElementData(localPlayer, k[1].."Y") or k[3], getElementData(localPlayer, k[1] .. "W") or k[4], getElementData(localPlayer, k[1] .. "H") or k[5], getElementData(localPlayer, k[1] .. "Resize") or false
					local cX, cY = getCursorPosition()
					if isMouseInPosition(cX, cY, x, y, w, h) then
						setElementData(localPlayer, k[1].."Moving", true)
						defX, defY = cX-x, cY-y
					end
				end
			elseif state == "up" then
				for i, k in ipairs(hudElements) do
					local m, r = getElementData(localPlayer, k[1].."Moving") or false, getElementData(localPlayer, k[1].."Resize") or false
					if m then
						setElementData(localPlayer, k[1].."Moving", false)
					end
				end
				saveHudPosition()
			end
		end
	end
end)
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
function mouseKonum ( x, y, width, height )
    if ( not isCursorShowing( ) ) then
        return false
    end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = _getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end
local blurBoxElement = nil
local FPSLimit, lastTick, framesRendered, FPS = 100, getTickCount(), 0, 0
local durum = 0
local can_durum = 0
function dxDrawCircleBar(startX, startY, w, h)
	local currentTick = getTickCount()
	local elapsedTime = currentTick - lastTick
	local img_x = 0
	if getElementData(getLocalPlayer(), "hide_hud") ~= "0" and getElementData(getLocalPlayer(), "loggedin") == 1 and (not isPlayerMapVisible()) then
		if getElementData(getLocalPlayer(), "samp")  == 0 then
		local money = getElementData(getLocalPlayer(), "money") or 0
		local can = getElementHealth(getLocalPlayer()) or 100
		local bmoney = getElementData(getLocalPlayer(), "bankmoney") or 0
		local stamina = getElementData(getLocalPlayer(), "stamina") or 100
		local armor = getPedArmor(getLocalPlayer()) or 0
		--local seconds = getTickCount() / 1000
		--local angle = math.sin(seconds) * 20
		local time = getRealTime()
		local day = time.monthday-1
		local month = time.month+1
		local year = time.year+1900
		local hours = time.hour
		local min = time.minute
		local sec = time.second
		--local skin = getElementModel(getLocalPlayer())
		local exp = getElementData(getLocalPlayer(), "exp") or 0
		local exprange = getElementData(getLocalPlayer(), "exprange") or 8
		local level = getElementData(getLocalPlayer(), "level") or 1
		sefaflik = sefaflik + 5
		sefaflik_duyuru = sefaflik_duyuru + 5
		if sefaflik > 255 then sefaflik = 255 end
		if sefaflik_duyuru > 190 then sefaflik_duyuru = 190 end
		dxUpdateScreenSource(benim_ekranim)
        roundedRectangle(startX, startY+15, 300, 30, tocolor(180, 180, 180, 210))
        dxDrawText(" "..getPlayerName(getLocalPlayer()):gsub("_", " "), startX + 5, startY + 19, 0, 0, tocolor(15, 15, 15), 1, hfont2, "left", "top", true, true, true, true)
        dxDrawText(" "..exports.global:formatMoney(money), startX+285-(dxGetTextWidth(" "..exports.global:formatMoney(money), 1)*1), startY + 20, 0, 0, tocolor(15, 15, 15), 1, hfont1, "left", "top", true, true, true, true)
		dxDrawImage(startX+110, startY-12, 75, 85,"img/Salvo.png", 0, 0, 0,tocolor(255,255,255,sefaflik_duyuru))
		end
	end
end
function dxDrawRectangleBordered(startX, startY, width, height, bgColor, slotColor, index)
	dxDrawRectangle(startX, startY, width, height, slotColor,index)
	dxDrawRectangle(startX - 1, startY + 1, 1, height - 2, bgColor,index)
	dxDrawRectangle(startX + width, startY + 1, 1, height - 2, bgColor,index)
	dxDrawRectangle(startX + 1, startY - 1, width - 2, 1, bgColor,index)
	dxDrawRectangle(startX + 1, startY + height, width - 2, 1, bgColor,index)
end
function dxDrawBorderedText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak,postGUI) 
    for oX = -1, 1 do -- Border size is 1 
        for oY = -1, 1 do -- Border size is 1 
                dxDrawText(text, left + oX, top + oY, right + oX, bottom + oY, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak,postGUI) 
        end 
    end 
    dxDrawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI) 
end 

function removeColorCoding(string)
	return string:gsub("#%x%x%x%x%x%x", "") or string
end
_getCursorPosition = getCursorPosition
function getCursorPosition()
	cX, cY = _getCursorPosition()
	cX, cY = cX*sX, cY*sY
	return cX, cY
end
function isMouseInPosition(cx, cy, x, y, w, h)
	if cx > x and cx < x+w and cy > y and cy < y+h then
		return true
	else
		return false
	end
end
function saveHudPosition()
	local table = {}
	for v, k in ipairs(hudElements) do
		local x, y = getElementData(localPlayer, k[1].."X"), getElementData(localPlayer, k[1].."Y")
		table[k[1]] = {x, y}
	end
end