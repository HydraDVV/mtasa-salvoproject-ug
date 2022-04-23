rcmenu = false
local rcWidth = 0
local rcHeight = 0

function destroy()
	if rcmenu then
		destroyElement(rcmenu)
	end
	rcWidth = 0
	rcHeight = 0
	rcmenu = false
	if isCursorShowing() then
		showCursor(false)
		--outputDebugString("hide cursor: rightclick/rightclick_c")
		--triggerEvent("cursorHide", getLocalPlayer())
	end
	--triggerEvent("cursorHide", getLocalPlayer())
end

function leftClickAnywhere(button, state, absX, absY, wx, wy, wz, element)
	if(button == "left" and state == "down") then
		--outputDebugString("clicked "..tostring(getElementType(element)))
		--unbindKey("mouse1", leftClickAnywhere)
		--guiSetVisible(rcmenu, false)
		--if(getElementType(element) == "gui") then
			setTimer(destroy, 1000, 1)
		--else
		--	setTimer(destroy, 100, 1)
		--end
	end
end
addEventHandler("onClientClick", getRootElement(), leftClickAnywhere, true)
addEvent("serverTriggerLeftClick", true)
addEventHandler("serverTriggerLeftClick", localPlayer, leftClickAnywhere)

function create(title)
	if(rcmenu) then
		destroy()
	end
	local x,y,wx,wy,wz = getCursorPosition()
	rcmenu = guiCreateStaticImage(x,y,0,0,"131.png",true)
	rcTitleBg = guiCreateStaticImage(0,0,0,0,"0.png",false,rcmenu)
	rcTitle = guiCreateLabel(2,0,0,0,tostring(title),false,rcTitleBg)
	guiSetFont(rcTitle,"default-bold-small")
	guiLabelSetColor(rcTitle,255,255,255)
	local extent = guiLabelGetTextExtent(rcTitle)
	guiSetSize(rcTitleBg,500,15,false)
	guiSetSize(rcTitle,extent,15,false)
	rcWidth = extent + 4
	rcHeight = 15
	guiSetSize(rcmenu,rcWidth,rcHeight,false)
	--bindKey("mouse1", "down", leftClickAnywhere)
	return rcmenu
end

function addrow(title,header,nohover)
	local row
	if header then
		local rowbg = guiCreateStaticImage(0,rcHeight,500,15,"0.png",false,rcmenu)
		row = guiCreateLabel(2,0,0,0,tostring(title),false,rowbg)
		guiSetFont(row,"default-bold-small")
		guiLabelSetColor(row,255,255,255)
		local extent = guiLabelGetTextExtent(row)
		guiSetSize(row,extent,15,false)
		rcHeight = rcHeight + 15
		if(extent + 4 > rcWidth) then
			rcWidth = extent + 4
		end
		guiSetSize(rcmenu,rcWidth,rcHeight,false)
	else
		row = guiCreateLabel(2,rcHeight,0,0,tostring(title),false,rcmenu)
		guiSetFont(row,"default-normal")
		guiLabelSetColor(row,255,255,255)
		local extent = guiLabelGetTextExtent(row)
		guiSetSize(row,extent,15,false)
		rcHeight = rcHeight + 15
		if(extent + 4 > rcWidth) then
			rcWidth = extent + 4
		end
		guiSetSize(rcmenu,rcWidth,rcHeight,false)
		if not nohover then
			addEventHandler("onClientMouseEnter",row,function()
				guiLabelSetColor(row,255,187,0)
			end,false)
			addEventHandler("onClientMouseLeave",row,function()
				guiLabelSetColor(row,255,255,255)
			end,false)
		else
			guiLabelSetColor(row,180,180,180)
		end
	end
	return row
end