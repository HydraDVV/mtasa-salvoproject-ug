local screenX, screenY = guiGetScreenSize()

local font = exports.titan_fonts:getFont("FontAwesome", 10)

local lastClick = 1
local currentVoiceMode = 1
local texts = {
	[1] = {
		text = "Normal"	
	},
	[2] = {
		text = "Telefon"
	},
	[3] = {
		text = "Telsiz"
	}
}

localPlayer:setData("currentVoice", currentVoiceMode)

bindKey(",", "down",
	function()
		if localPlayer:getData("loggedin") ~= 1 then return end
		currentVoiceMode = currentVoiceMode + 1
		if currentVoiceMode > 3 then currentVoiceMode = 1 end
		runChangeVoice()
	end
)

function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
	if (x and y and w and h) then
		if (not borderColor) then
			borderColor = tocolor(0, 0, 0, 200);
		end
		if (not bgColor) then
			bgColor = borderColor;
		end
		dxDrawRectangle(x, y, w, h, bgColor, postGUI);
		dxDrawRectangle(x + 2, y - 1, w - 3, 1, borderColor, postGUI);
		dxDrawRectangle(x + 2, y + h, w - 3, 1, borderColor, postGUI);
		dxDrawRectangle(x - 1, y + 2, 1, h - 3, borderColor, postGUI);
		dxDrawRectangle(x + w, y + 2, 1, h - 3, borderColor, postGUI);
	end
end

setTimer(
	function()
		if localPlayer:getData("loggedin") ~= 1 then return end

		local textWidth = dxGetTextWidth(texts[currentVoiceMode].text, 1, "default")
		local width, height = 83, 23
		local x = screenX - 90
		local y = 5
		roundedRectangle(x, y, width, height, tocolor(180, 180, 180, 200))
		dxDrawText("  - "..texts[currentVoiceMode].text, x+2, y, width, height+y, tocolor(15, 15, 15), 1, font, "left", "center")

		for i=1, #texts do
			local row = texts[i]
			if row then
				local xx,yy = x+((i-1)*29), y
				if i == currentVoiceMode then
				end
				if inArea(xx, yy, 24, 24) then
					if getKeyState("mouse1") and lastClick+200 <= getTickCount() then
						lastClick = getTickCount()
						currentVoiceMode = i
						runChangeVoice()
					end
				end
			end
		end
	end,
0,0)

function runChangeVoice()
	localPlayer:setData("currentVoice", currentVoiceMode)
	localPlayer:setData("maxVol", 1)
	if currentVoiceMode == 1 then

	elseif currentVoiceMode == 2 then

	elseif currentVoiceMode == 3 then

	end
end

function inArea(x,y,w,h)
	if isCursorShowing() then
		local aX,aY = getCursorPosition()
		aX,aY = aX*screenX,aY*screenY
		if aX > x and aX < x+w and aY>y and aY<y+h then return true
		else return false end
	else return false end
end