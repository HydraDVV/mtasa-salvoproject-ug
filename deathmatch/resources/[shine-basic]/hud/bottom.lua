local FPSLimit, lastTick, framesRendered, FPS = 100, getTickCount(), 0, 0
local sX, sY = guiGetScreenSize()
local REMAJORfont = exports.titan_fonts:getFont("FontAwesome",9)
addEventHandler("onClientRender",root,
function()
    local currentTick = getTickCount()
    local elapsedTime = currentTick - lastTick
    if elapsedTime >= 1000 then
        FPS = framesRendered
        lastTick = currentTick
        framesRendered = 2
    else
        framesRendered = framesRendered + 1
   end
 if FPS > FPSLimit then
    FPS = FPSLimit
   end
            
	local playerPing = getPlayerPing ( localPlayer ) 
           local yil = getRealTime().year+1900
           
           local hour, minute = getRealTime()
           time = getRealTime()
           if time.hour >= 0 and time.hour < 10 then
               time.hour = "0"..time.hour
           end
       
           if time.minute >= 0 and time.minute < 10 then
               time.minute = "0"..time.minute
           end
               
           if time.second >= 0 and time.second < 10 then
               time.second = "0"..time.second
           end
       
           if time.month >= 0 and time.month < 10 then
               time.month = "0"..time.month+1
           end
       
           if time.monthday >=0 and time.monthday < 10 then
               time.monthday = "0"..time.monthday
           end
           dxDrawBorderedText("Salvo:world |  "..time.monthday.."/"..time.month.."/"..yil.." |  "..time.hour..":"..time.minute..":"..time.second.." |  "..tostring(FPS).." |  "..playerPing.."ms |",sX-460,sY,-209,sY-18,tocolor(255,255,255,250),1, REMAJORfont,"left","center",false,false,true,true)
           function dxDrawBorderedText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak,postGUI) 
            for oX = -1, 1 do -- Border size is 1 
                for oY = -1, 1 do -- Border size is 1 
                        dxDrawText(text, left + oX, top + oY, right + oX, bottom + oY, tocolor(20, 20, 20, 40), scale, font, alignX, alignY, clip, wordBreak,postGUI) 
                end 
            end 
            dxDrawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI) 
        end 
end
)
