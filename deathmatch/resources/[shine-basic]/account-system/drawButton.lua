local sx,sy = guiGetScreenSize()
local sign = exports.titan_fonts:getFont("FontAwesome",9)

function drawButton(text, left, top, width, height, color, textColor, textSize, nohoverable, customData, forceHover)
    if not color then color = tocolor(0, 0, 0, 200); end
    if type(color) == "string" then color = stringToColor(color); end
    if type(textColor) == "string" then color = stringToColor(textColor); end
    local this = {"button", left, top, width, height, customData};
    
    local r, g, b, a = toRGBA(color);
    local border = 2;
    if height > 120 then
        border = 5;
    elseif height > 80 then
        border = 4;
    elseif height > 40 then
        border = 3;
    end
    
    local isHover = not nohoverable and isButtonHover(this, forceHover);
    if isHover then
        color = colorDarker(color, 1.2);
        r, g, b, a = toRGBA(color);
    end
    dxDrawRectangleBordered(left, top, width, height, tocolor(r, g, b, a * 0.75), tocolor(r, g, b, a * 0.75));
    dxDrawRectangleBordered(left + border, top + border, width - border * 2, height - border * 2, color, color);



    dxDrawText(text, left, top, left + width, top + height, textColor or tocolor(255,255,255), 1, sign, "center", "center");
 
    return this, isHover;
end
function isButtonHover(button, force)
    if button and #button > 0 then
        local type, left, top, width, height, data = unpack(button);
        if type == "button" then
            local inbox = isCursorOnBox(left, top, width, height);
            if force then
               return inbox;
            else
                return false;
            end
        end
    end
    return false;
end

function getButtonCustomData(button)
    if button and #button > 0 then
        local type, _, _, _, _, data = unpack(button);
        if type == "button" then
            return data;
        end
    end
    return false;
end

function dxDrawRectangleBordered(startX, startY, width, height, bgColor, slotColor)
	dxDrawRectangle(startX, startY, width, height, slotColor)
	dxDrawRectangle(startX - 1, startY + 1, 1, height - 2, bgColor)
	dxDrawRectangle(startX + width, startY + 1, 1, height - 2, bgColor)
	dxDrawRectangle(startX + 1, startY - 1, width - 2, 1, bgColor)
	dxDrawRectangle(startX + 1, startY + height, width - 2, 1, bgColor)
end