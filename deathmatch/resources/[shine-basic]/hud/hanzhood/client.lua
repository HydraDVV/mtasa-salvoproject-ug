event = false
local px, py = guiGetScreenSize()
local REMAJORfont = exports.titan_fonts:getFont("FontAwesome",13)
function REMAJOR ()
	if getElementData(localPlayer,"Alan:giren") then
		x,y,w,h = px/2-100,py/1-100/2,150,20
		tx,ty,tw,th = x-25,y-68,w-2,10
		roundedRectangle(x,y,w+dxGetTextWidth(getElementData(localPlayer,"Alan:giren"))/9,h+5,tocolor(190,190,190,150))
		dxDrawText("  "..getElementData(localPlayer,"Alan:giren"),tx+32,ty+69,tw+tx,th+ty,tocolor(125, 45, 45),1, REMAJORfont,"left","top",false,false,false,true)
	end
end
addEventHandler("onClientRender", root, REMAJOR)
addEvent("KorumaliAlan:AlanKontrol", true)
addEventHandler("KorumaliAlan:AlanKontrol", root, function(area,kontrol)
	if kontrol == "Girdi" then
		event = true
		if event then
		end
		setRadarAreaFlashing(area, true)
	elseif kontrol == "Cikti" then
		event = false
		setRadarAreaFlashing(area, false)
	end
end)
function iptalFunc()
	cancelEvent()
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

