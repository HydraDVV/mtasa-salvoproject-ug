local sx , sy = guiGetScreenSize()
local pvpTime = false
local font = exports.titan_fonts:getFont("FontAwesome" , 25)

addEvent("pvpTable" , true)
addEventHandler("pvpTable" , root , function(time)
    pvpTime = time
end)

addEventHandler("onClientRender" , root , function()
    if pvpTime then 
        dxDrawBorderedText( 1 ,"- "..pvpTime.." " , sx/1.85 - 136 , sy - (sy/1.1) , sx , sy , tocolor(250,250,250), 1 , font )
    end
end)

function dxDrawBorderedText (outline, text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
    for oX = (outline * -1), outline do
        for oY = (outline * -1), outline do
            dxDrawText (text, left + oX, top + oY, right + oX, bottom + oY, tocolor(0, 0, 0, 255), scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
        end
    end
    dxDrawText (text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end