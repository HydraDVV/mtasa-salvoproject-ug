local font1 = exports.titan_fonts:getFont("Roboto",14)
local font = exports.titan_fonts:getFont("Roboto",11)
local sw, sh = guiGetScreenSize()
local lastJailtime = nil
local currentSecs = "Hesaplaniyor.."
local timer = nil
function showAdminJailCounter()
	local jailtime = getElementData(localPlayer, "jailtime")
	if jailtime and (tonumber(jailtime) and tonumber(jailtime) > 0) or jailtime == "Sınırsız" then
		if lastJailtime ~= jailtime then
			currentSecs = tonumber(jailtime) and jailtime*60 or jailtime
			lastJailtime = jailtime
			if timer and isTimer(timer) then
				killTimer(timer)
				timer = nil
			end
			if tonumber(currentSecs) then
				timer = setTimer(function ()
					if tonumber(currentSecs) then
						currentSecs = currentSecs - 1
					end
				end, 1000, 59)
			end
		end

		local w, h = 412, 135
		local x, y = (sw-w)/2, 45
	    roundedRectangle(x, y, w, h, tocolor(0, 0, 0, 190))

		local w, h = 412, 126
		local x, y = (sw-w)/2, 50
		local xo, yo = (543-x), (28-y)
	    dxDrawText("Salvo Roleplay | jail-system © REMAJOR ", 630-xo, 28-yo, 872-xo, 76-yo, tocolor(255, 255, 255, 255), 1.00, font1, "center", "center", false, false, true, false, false)
	    dxDrawText("Açıklama: "..(getElementData(localPlayer, "jailreason") or "Bilinmiyor"), 553-xo, 100-yo, 945-xo, 127-yo, tocolor(255, 255, 255, 255), 1.00, font, "center", "center", false, true, true, false, false)
	    dxDrawText(tonumber(currentSecs) and exports.datetime:formatSeconds(currentSecs) or jailtime, 563-xo, 65-yo, 945-xo, 100-yo, tocolor(200, 103, 73, 255), 1.00, "pricedown", "center", "center", false, false, true, false, false)
	    dxDrawText("Hapise atan admin "..(getElementData(localPlayer, "jailadmin") or "Bilinmiyor"), 553-xo, 117-yo, 945-xo, 144-yo, tocolor(255, 255, 255, 255), 1.00, font, "center", "bottom", false, true, true, false, false)
	else
		currentSecs = "Hesaplanıyor.."
		lastJailtime = nil
	end
end
addEventHandler("onClientRender", root, showAdminJailCounter)

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

