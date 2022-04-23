local sx, sy= guiGetScreenSize()
local lastClick = getTickCount()
local colShape = {}
local id = 0
setElementData(localPlayer,"bildirimgitti",nil)

function dxDrawRoundedRectangle(x, y, width, height, radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+radius, width-(radius), height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawCircle(x+radius, y+radius, radius, 180, 270, color, color, 16, 1, postGUI)
    dxDrawCircle(x+radius, (y+height)-radius, radius, 90, 180, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, (y+height)-radius, radius, 0, 90, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, y+radius, radius, 270, 360, color, color, 16, 1, postGUI)
    dxDrawRectangle(x, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+height-radius, width-(radius*2), radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+width-radius, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y, width-(radius*2), radius, color, postGUI, subPixelPositioning)
end
	
function pdnotification ( )
 if getElementData(localPlayer, "loggedin") == 1 then
  if getElementData(localPlayer,"faction") == 1 then

 	    dxDrawRoundedRectangle (sx *0.8000, sy * 0.2500, sx * 0.1800, sy * 0.1000, 2, tocolor(36 ,35 ,43, 250), false) 
	    dxDrawImage(sx*0.9500, sy*0.2700, sx*0.0300, sy*0.0300, "files/tik.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
   if isInSlot(sx*0.9500, sy*0.2650, sx*0.0280, sy*0.0350) then
        dxDrawRoundedRectangle (sx*0.9500, sy*0.2650, sx*0.0290, sy*0.0350,  0, tocolor(255,255,255, 15), false)
   end
		 --kapat
	    dxDrawImage(sx*0.9500, sy*0.3000, sx*0.0300, sy*0.0300, "files/carpi.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
 	if isInSlot(sx*0.9500, sy*0.3000, sx*0.0300, sy*0.0300) then
        dxDrawRoundedRectangle (sx*0.9500, sy*0.3000, sx*0.0290, sy*0.0300,  0, tocolor(255,255,255, 15), false)
    end	 
     if isInSlot(sx*0.9500, sy*0.3000, sx*0.0300, sy*0.0300)and getKeyState("mouse1") and lastClick < getTickCount() then
        removeEventHandler("onClientRender", root, pdnotification)
     end
    if isInSlot(sx*0.9500, sy*0.2650, sx*0.0280, sy*0.0350)and getKeyState("mouse1") and lastClick < getTickCount() then
        removeEventHandler("onClientRender", root, pdnotification)
        local resourceTable = getElementData(resourceRoot,"fireposition")
        local id = id + 1
        colShape[id] = createColSphere(resourceTable[1],resourceTable[2],resourceTable[3],10)
        setElementData(colShape[id],"firepos",true)
        setElementData(colShape[id],"dbid",id)
		setElementData(colShape[id],"fireingpos",{resourceTable[1],resourceTable[2],resourceTable[3]})
    end
      local colorCoded = true
	         dxDrawText("[POLİS TELSİZİ]", sx * 0.8040, sy * 0.4850, sx * 0.1500, sy * 0.0500, tocolor(8  ,162  ,214  , 250), 1, "default-bold", "left", "center",  false, false, false, false, false)
	     dxDrawText("    Silah sesleri duyuldu. \n    Konumu haritada işaretlemek için \n    (✓) işaretine bas.", sx * 0.79500, sy * 0.5700, sx * 0.1500, sy * 0.0500, tocolor(255  ,255  ,255  , 250), 1, "default-bold", "left", "center",  false, false, false, false, false)
	 end
  end
 end

addEventHandler("onClientColShapeHit",root,function(theElement)
    if (theElement == localPlayer) and getElementData(source,"firepos",true) and getElementData(theElement,"faction") == 1 then
        local id = getElementData(source,"dbid")
        if isElement(colShape[id]) then
            destroyElement(colShape[id])
        end
    end
end)

screenSize = {guiGetScreenSize()}
getCursorPos = getCursorPosition
function getCursorPosition()
    if isCursorShowing() then
   local x,y = getCursorPos()
   x, y = x * screenSize[1], y * screenSize[2] 
   return x,y
    else
   return -5000, -5000
    end
end

cursorState = isCursorShowing()
cursorX, cursorY = getCursorPosition()

function isInBox(dX, dY, dSZ, dM, eX, eY)
    if eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM then
   return true
    else
   return false
    end
end

function isInSlot(xS,yS,wS,hS)
    if isCursorShowing() then
   local cursorX, cursorY = getCursorPosition()
   if isInBox(xS,yS,wS,hS, cursorX, cursorY) then
  return true
   else
  return false
   end
    end 
end
function isPlayerUsingWeapon()
    for _,players in ipairs(getElementsByType("player")) do
        --if getElementData(source,"faction") == 1 then return end
        if getElementData(players,"faction") == 1 and not getElementData(players,"bildirimgitti",true) then
            addEventHandler("onClientRender", root, pdnotification)
            setElementData(players,"bildirimgitti",true)
            local x,y,z = getElementPosition(source)
            setElementData(resourceRoot,"fireposition",{x,y,z})
            setTimer(function()
                removeEventHandler("onClientRender", root, pdnotification)
                setElementData(players,"bildirimgitti",nil)
                setElementData(resourceRoot,"fireposition",nil)
            end,10000,1) 
        end
    end
end
addEventHandler("onClientPlayerWeaponFire",root,isPlayerUsingWeapon)

