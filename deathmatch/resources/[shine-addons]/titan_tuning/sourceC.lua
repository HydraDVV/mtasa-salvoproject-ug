local screenX, screenY = guiGetScreenSize()

local scaleFactor = screenX / 1280

local tuningMarkers = {}
local tuningMarkersCount = 0

local markerImageMaxVisibleDistance = 35

local availableTextures = {
	["logo"] = dxCreateTexture("files/images/logo.png", "argb", true, "clamp"),
	["hoveredrow"] = dxCreateTexture("files/images/hoveredrow.png", "argb", true, "clamp"),
	["menunav"] = dxCreateTexture("files/images/menunav.png", "argb", true, "clamp"),
	["mouse"] = dxCreateTexture("files/images/navbar/mouse.png", "argb", true, "clamp"),
}

local availableIcons = {
	["wrench"] = "",
	["long-arrow-up"] = "",
	["long-arrow-down"] = "",
	["info-circle"] = "",
	["check"] = "",
	["exclamation-triangle"] = "",
}

local mouseTable = {
	["speed"] = {0, 0},
	["last"] = {0, 0},
	["move"] = {0, 0}
}

local panelState = false
local enteredVehicle = false
local availableFonts = nil

local panelWidth, rowHeight = 350 * scaleFactor, 35 * scaleFactor
local panelX, panelY = 32, 32
local logoHeight = panelWidth / 2

local hoveredCategory, selectedCategory, selectedSubCategory = 1, 0, 0
local maxRowsPerPage, currentPage = 7, 1

local compatibleOpticalUpgrades = {}
local equippedTuning = 1

local navbarButtonHeight = 30 * scaleFactor
local navigationBar = {
	{"", {"Enter"}, false},
	{"", {"long-arrow-up", "long-arrow-down"}, true},
	{"", {"Backspace"}, false},
	{getLocalizedText("navbar.camera"), {"mouse"}, "image", 30}
}

local noticeData = {
	["text"] = false,
	["type"] = "info",
	["tick"] = 0,
	["state"] = "",
	["height"] = 0,
	["timer"] = nil
}

local cameraSettings = {}

local promptDialog = {
	["state"] = false,
	["itemName"] = "",
	["itemPrice"] = 0
}

local availableOffroadAbilities = {
	["dirt"] = {0x100000, 2},
    ["sand"] = {0x200000, 3}
}

local availableWheelSizes = {
	["front"] = {
		["verynarrow"] = {0x100, 1},
		["narrow"] = {0x200, 2},
		["wide"] = {0x400, 4},
		["verywide"] = {0x800, 5}
	},
	["rear"] = {
		["verynarrow"] = {0x1000, 1},
		["narrow"] = {0x2000, 2},
		["wide"] = {0x4000, 4},
		["verywide"] = {0x8000, 5}
	}
}

local savedVehicleColors = {["all"] = false, ["headlight"] = false}
local moneyChangeTable = {["tick"] = 0, ["amount"] = 0}

local vehicleNumberplate = ""

addEvent("tuning->ShowMenu", true)
addEvent("tuning->HideMenu", true)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for _, value in ipairs(getElementsByType("marker", root, true)) do
		if getElementData(value, "tuningMarkerSettings") then
			tuningMarkers[value] = true
			tuningMarkersCount = tuningMarkersCount + 1
		end
	end
	
	for i = 1, 4 do
		table.insert(tuningMenu[getMainCategoryIDByName(getLocalizedText("menu.color"))]["subMenu"], {
			["categoryName"] = getLocalizedText("menu.color") .. " " .. i,
			["tuningPrice"] = 10000,
			["tuningData"] = "color" .. i
		})
	end
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
	if panelState and enteredVehicle then
		resetOpticalUpgrade()
		setVehicleColorsToDefault()
		triggerEvent("tuning->HideMenu", localPlayer)
	end
end)

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "marker" then
		if getElementData(source, "tuningMarkerSettings") then
			tuningMarkers[source] = true
			tuningMarkersCount = tuningMarkersCount + 1
		end
	end
end)

addEventHandler("onClientElementStreamOut", root, function()
	if getElementType(source) == "marker" then
		if getElementData(source, "tuningMarkerSettings") then
			tuningMarkers[source] = nil
			tuningMarkersCount = tuningMarkersCount - 1
		end
	end
end)

addEventHandler("onClientRender", root, function()
	--** Tuning marker image
	if tuningMarkersCount ~= 0 then
		local cameraX, cameraY, cameraZ = getCameraMatrix()

		for marker, id in pairs(tuningMarkers) do
			if marker and isElement(marker) then
				if getElementAlpha(marker) ~= 0 and getElementDimension(marker) == getElementDimension(localPlayer) then
					local markerX, markerY, markerZ = getElementPosition(marker)
					local markerDistance = getDistanceBetweenPoints3D(cameraX, cameraY, cameraZ, markerX, markerY, markerZ)
					
					if markerDistance <= markerImageMaxVisibleDistance then
						if isLineOfSightClear(cameraX, cameraY, cameraZ, markerX, markerY, markerZ, false, false, false, true, false, false, false) then
							local screenX, screenY = getScreenFromWorldPosition(markerX, markerY, markerZ + 1, 1)
							
							if screenX and screenY then
								local imageScale = 1 - (markerDistance / markerImageMaxVisibleDistance) * 0.5
								local alphaScale = 255 - (markerDistance / markerImageMaxVisibleDistance) * 1.0
								
								local imageWidth, imageHeight = 256 * imageScale, 128 * imageScale
								local imageX, imageY = screenX - (imageWidth / 2), screenY - (imageHeight / 2)
								
								--dxDrawImage(imageX, imageY, imageWidth, imageHeight, availableTextures["logo"], 0, 0, 0, tocolor(255, 255, 255, 255 * alphaScale))
							end
						end
					end
				end
			else
				tuningMarkers[marker] = nil
			end
		end
	end
	
	-- ** Tuning menu
	if panelState and enteredVehicle then
		--> Logo
	--	dxDrawRectangle(panelX, panelY, panelWidth, logoHeight * scaleFactor, tocolor(0, 0, 0, 200))
	--	dxDrawImage(panelX, panelY, panelWidth, logoHeight * scaleFactor, availableTextures["logo"])
		
		--> Current Money
		drawTextWithBorder("$" .. formatNumber(getElementData(localPlayer, 'money'), ","), 2, panelX, panelY, panelX + screenX - (panelX * 2), panelY + screenY - (panelY * 2), tocolor(0, 0, 0, 255), tocolor(189, 227, 188, 255), 1.2, 1.3, "pricedown", "right", "top", false, false, false, true)
		
		if moneyChangeTable["tick"] >= getTickCount() then
			drawTextWithBorder("-$" .. formatNumber(moneyChangeTable["amount"], ","), 2, panelX, panelY + dxGetFontHeight(1.0, "pricedown"), panelX + screenX - (panelX * 2), panelY + screenY - (panelY * 2), tocolor(0, 0, 0, 255), tocolor(200, 80, 80, 255), 1.2, 1.3, "pricedown", "right", "top", false, false, false, true)
		end
		
		--> Notification
		if noticeData["text"] then
			if noticeData["state"] == "showNotice" then
				local animationProgress = (getTickCount() - noticeData["tick"]) / 300
				local animationState = interpolateBetween(0, 0, 0, logoHeight * scaleFactor, 0, 0, animationProgress, "Linear")
				
				noticeData["height"] = animationState
				
				if animationProgress > 1 then
					noticeData["state"] = "fixNoticeJumping"
					
					noticeData["timer"] = setTimer(function()
						noticeData["tick"] = getTickCount()
						noticeData["state"] = "hideNotice"
					end, string.len(noticeData["text"]) * 50, 1)
				end
			elseif noticeData["state"] == "hideNotice" then
				local animationProgress = (getTickCount() - noticeData["tick"]) / 300
				local animationState = interpolateBetween(logoHeight * scaleFactor, 0, 0, 0, 0, 0, animationProgress, "Linear")
				
				noticeData["height"] = animationState
				
				if animationProgress > 1 then
					noticeData["text"] = false
				end
			elseif noticeData["state"] == "fixNoticeJumping" then
				noticeData["height"] = (logoHeight * scaleFactor)
			end
			
			dxDrawRectangle(panelX, panelY, panelWidth, noticeData["height"], tocolor(0, 0, 0, 200))
			
			if noticeData["height"] == (logoHeight * scaleFactor) then
				local noticeIcon, iconColor = "", {255, 255, 255}
				
				if noticeData["type"] == "info" then
					noticeIcon, iconColor = availableIcons["info-circle"], {85, 178, 243}
				elseif noticeData["type"] == "warning" then
					noticeIcon, iconColor = availableIcons["exclamation-triangle"], {220, 190, 120}
				elseif noticeData["type"] == "error" then
					noticeIcon, iconColor = availableIcons["exclamation-triangle"], {200, 80, 80}
				elseif noticeData["type"] == "success" then
					noticeIcon, iconColor = availableIcons["check"], {130, 220, 115}
				end
				
				dxDrawText(noticeIcon, panelX + 5, panelY + 5, panelX + 5 + panelWidth - 10, panelY + 5 + noticeData["height"] - 10, tocolor(iconColor[1], iconColor[2], iconColor[3], 255), 1.0, availableFonts["icons"], "left", "top")
				dxDrawText(noticeData["text"], panelX + 10, panelY, panelX + 10 + panelWidth - 20, panelY + noticeData["height"], tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "center", "center", false, true)
			end
		end
		
		--> Looping table
		loopTable, categoryCount, categoryName = {}, 0, "N/A"
		
		if selectedCategory == 0 then
			loopTable = tuningMenu
			categoryName = getLocalizedText("menu.mainMenu")
			
			navigationBar[1][1] = getLocalizedText("navbar.select")
			navigationBar[3][1] = getLocalizedText("navbar.exit")
		elseif selectedCategory ~= 0 and selectedSubCategory == 0 then
			loopTable = tuningMenu[selectedCategory]["subMenu"]
			categoryName = tuningMenu[selectedCategory]["categoryName"]
			
			if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then -- Color
				navigationBar[1][1] = getLocalizedText("navbar.buy")
			else
				navigationBar[1][1] = getLocalizedText("navbar.select")
			end
			
			navigationBar[3][1] = getLocalizedText("navbar.back")
		elseif selectedCategory ~= 0 and selectedSubCategory ~= 0 then
			if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then -- Optical
				if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
					loopTable = tuningMenu[selectedCategory]["availableUpgrades"]
					categoryName = tuningMenu[selectedCategory]["categoryName"]
				else
					loopTable = tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["subMenu"]
					categoryName = tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["categoryName"]
				end
			else
				loopTable = tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["subMenu"]
				categoryName = tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["categoryName"]
			end
			
			navigationBar[1][1] = getLocalizedText("navbar.buy")
			navigationBar[3][1] = getLocalizedText("navbar.back")
		end
		
		--> Current category
		local panelY = panelY + (logoHeight * scaleFactor)
		
		dxDrawRectangle(panelX, panelY, panelWidth, rowHeight, tocolor(0, 0, 0, 255))
		dxDrawText(utf8.upper(categoryName), panelX + 10, panelY, panelX + 10 + panelWidth - 20, panelY + rowHeight, tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "left", "center", false, false, false, true)
		dxDrawText(hoveredCategory .. " / " .. #loopTable, panelX + 10, panelY, panelX + 10 + panelWidth - 20, panelY + rowHeight, tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)
	
		--> Menu rows
		local panelY = panelY + rowHeight
		
		for id, row in ipairs(loopTable) do
			if id >= currentPage and id <= currentPage + maxRowsPerPage then
				local rowX, rowY, rowWidth, rowHeight = panelX, panelY + (categoryCount * rowHeight), panelWidth, rowHeight
				
				if selectedCategory == 0 or selectedSubCategory == 0 then
					equippedUpgrade = -1
				elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then
					if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
						if row["upgradeID"] == equippedTuning then
							equippedUpgrade = id
						end
					else
						if id == equippedTuning then
							equippedUpgrade = id
						end
					end
				else
					if id == equippedTuning then
						equippedUpgrade = id
					end
				end
				
				if hoveredCategory ~= id then
					if categoryCount %2 == 0 then
						dxDrawRectangle(rowX, rowY, rowWidth, rowHeight, tocolor(0, 0, 0, 150))
					else
						dxDrawRectangle(rowX, rowY, rowWidth, rowHeight, tocolor(0, 0, 0, 200))
					end
					
					dxDrawText(row["categoryName"], rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "left", "center", false, false, false, true)
				
					if equippedUpgrade ~= id then
						if row["tuningPrice"] then
							if row["tuningPrice"] == 0 then
								dxDrawText(getLocalizedText("tuningPrice.free"), rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(198, 83, 82, 255), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)
							else
								dxDrawText("$ " .. formatNumber(row["tuningPrice"], ","), rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(255, 255, 255, 200), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)
							end
						end
					else
						dxDrawText(getLocalizedText("tuning.active"), rowX + 15, rowY, rowX + 15 + rowWidth - 30 - dxGetTextWidth(availableIcons["wrench"], 1.0, availableFonts["icons"]) - 10, rowY + rowHeight, tocolor(150, 255, 150, 255), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)
						dxDrawText(availableIcons["wrench"], rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(150, 255, 150, 255), 1.0, availableFonts["icons"], "right", "center", false, false, false, true)
					end
				else
					dxDrawImage(rowX, rowY, rowWidth, rowHeight, availableTextures["hoveredrow"])
					
					dxDrawText(row["categoryName"], rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(0, 0, 0, 255), 0.5, availableFonts["chalet"], "left", "center", false, false, false, true)
				
					if equippedUpgrade ~= id then
						if row["tuningPrice"] then
							if row["tuningPrice"] == 0 then
								dxDrawText(getLocalizedText("tuningPrice.free"), rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(0, 0, 0, 255), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)
							else
								dxDrawText("$ " .. formatNumber(row["tuningPrice"], ","), rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(0, 0, 0, 200), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)
							end
						end
					else
						dxDrawText(getLocalizedText("tuning.active"), rowX + 15, rowY, rowX + 15 + rowWidth - 30 - dxGetTextWidth(availableIcons["wrench"], 1.0, availableFonts["icons"]) - 10, rowY + rowHeight, tocolor(0, 0, 0, 255), 0.5, availableFonts["chalet"], "right", "center", false, false, false, true)
						dxDrawText(availableIcons["wrench"], rowX + 15, rowY, rowX + 15 + rowWidth - 30, rowY + rowHeight, tocolor(0, 0, 0, 255), 1.0, availableFonts["icons"], "right", "center", false, false, false, true)
					end
				end
				
				categoryCount = categoryCount + 1
			end
		end
		
		dxDrawImage(panelX, panelY + (categoryCount * rowHeight), panelWidth, rowHeight, availableTextures["menunav"])
		
		--> Scrollbar
		if categoryCount >= (maxRowsPerPage + 1) and categoryCount ~= #loopTable then
			local rowVisible = math.max(0.05, math.min(1.0, (maxRowsPerPage + 1) / #loopTable))
			local scrollbarHeight = ((maxRowsPerPage + 1) * rowHeight) * rowVisible
			local scrollbarPosition = math.min((currentPage - 1) / #loopTable, 1.0 - rowVisible) * ((maxRowsPerPage + 1) * rowHeight)
			
			dxDrawRectangle(panelX + panelWidth - 2, panelY + scrollbarPosition, 2, scrollbarHeight, tocolor(255, 255, 255, 255))
		end
		
		--> Navigation Bar
		local navbarWidth = getNavbarWidth()
		local barOffsetX = 0
		
		drawRoundedRectangle(screenX - navbarWidth - 32 - 10, screenY - 32 - rowHeight, navbarWidth, rowHeight, 1, tocolor(0, 0, 0, 200))
		
		for _, row in ipairs(navigationBar) do
			local textLength = dxGetTextWidth(row[1], 0.5, availableFonts["chalet"]) + 20
			local navX, navY, navHeight = screenX - navbarWidth - 32 + barOffsetX, screenY - 32 - rowHeight, rowHeight
			local navWidth = 0
			
			for id, icon in ipairs(row[2]) do
				local buttonWidth = 0
				
				if type(row[3]) == "string" and row[3] == "image" then
					buttonWidth = row[4]
				elseif type(row[3]) == "boolean" and row[3] then
					buttonWidth = dxGetTextWidth(availableIcons[icon], 1.0, availableFonts["icons"]) + 20
				elseif type(row[3]) == "boolean" and not row[3] then
					buttonWidth = dxGetTextWidth(icon, 0.5, availableFonts["chalet"]) + 10
				end
				
				local iconX = navX + textLength - 10 + ((id - 1) * buttonWidth) + ((id - 1) * 5)
				
				if type(row[3]) == "boolean" then
					drawRoundedRectangle(iconX, navY + ((rowHeight / 2) - (navbarButtonHeight / 2)), buttonWidth, navbarButtonHeight, 1, tocolor(255, 255, 255, 255))
				end
				
				if type(row[3]) == "string" and row[3] == "image" then
					dxDrawImage(iconX, navY + ((rowHeight / 2) - (navbarButtonHeight / 2)), buttonWidth, navbarButtonHeight, availableTextures[icon])
				elseif type(row[3]) == "boolean" and row[3] then
					dxDrawText(availableIcons[icon], iconX, navY + ((rowHeight / 2) - (navbarButtonHeight / 2)), iconX + buttonWidth, navY + ((rowHeight / 2) - (navbarButtonHeight / 2)) + navbarButtonHeight, tocolor(0, 0, 0, 255), 1.0, availableFonts["icons"], "center", "center")
				elseif type(row[3]) == "boolean" and not row[3] then
					dxDrawText(icon, iconX, navY + ((rowHeight / 2) - (navbarButtonHeight / 2)), iconX + buttonWidth, navY + ((rowHeight / 2) - (navbarButtonHeight / 2)) + navbarButtonHeight, tocolor(0, 0, 0, 255), 0.5, availableFonts["chalet"], "center", "center")
				end
				
				navWidth = navWidth + buttonWidth + 10
			end
			
			dxDrawText(row[1], navX, navY, navX + navWidth, navY + navHeight, tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "left", "center")
			
			barOffsetX = barOffsetX + (navWidth + textLength)
		end
		
		--> Prompt dialog
		if promptDialog["state"] then
			local promptWidth = dxGetTextWidth(getLocalizedText("prompt.text"), 0.5, availableFonts["chalet"]) + 20
			local promptWidth, promptHeight = promptWidth, 120 * scaleFactor
			local promptX, promptY = (screenX / 2) - (promptWidth / 2), (screenY / 2) - (promptHeight / 2)
			
			drawRoundedRectangle(promptX, promptY, promptWidth, promptHeight, 1, tocolor(0, 0, 0, 200))
			dxDrawText(getLocalizedText("prompt.text"), promptX + 10, promptY + 5, promptX + 10 + promptWidth - 20, promptY + 5 + promptHeight - 10, tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "left", "top")
		
			dxDrawText("#cccccc" .. getLocalizedText("prompt.info.1") ..": #ffffff" .. promptDialog["itemName"], promptX + 15, promptY + 30, promptX + 15 + promptWidth - 30, promptY + 30 + promptHeight - 60, tocolor(255, 255, 255, 255), 0.45, availableFonts["chalet"], "left", "top", false, false, false, true)
			dxDrawText("#cccccc" .. getLocalizedText("prompt.info.2") .. ": #ffffff$ " .. formatNumber(promptDialog["itemPrice"], ","), promptX + 15, promptY + 30 + dxGetFontHeight(0.45, availableFonts["chalet"]), promptX + 15 + promptWidth - 30, promptY + 30 + dxGetFontHeight(0.45, availableFonts["chalet"]) + promptHeight - 60, tocolor(255, 255, 255, 255), 0.45, availableFonts["chalet"], "left", "top", false, false, false, true)
		
			local buttonX, buttonY, buttonWidth, buttonHeight = promptX + 10, promptY + promptHeight - 10 - navbarButtonHeight, (promptWidth / 2) - 20, navbarButtonHeight
		
			drawRoundedRectangle(buttonX, buttonY, buttonWidth, buttonHeight, 1, tocolor(110, 207, 112, 255))
			dxDrawText(getLocalizedText("prompt.button.1"), buttonX, buttonY, buttonX + buttonWidth, buttonY + buttonHeight, tocolor(0, 0, 0, 255), 0.5, availableFonts["chalet"], "center", "center")
			
			drawRoundedRectangle((buttonX + buttonWidth + 20), buttonY, buttonWidth, buttonHeight, 1, tocolor(200, 80, 80, 255))
			dxDrawText(getLocalizedText("prompt.button.2"), (buttonX + buttonWidth + 20), buttonY, (buttonX + buttonWidth + 20) + buttonWidth, buttonY + buttonHeight, tocolor(0, 0, 0, 255), 0.5, availableFonts["chalet"], "center", "center")
		end
		
		--> License Plate inputbox
		if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then
			if selectedSubCategory == 8 and hoveredCategory == 2 then
				local boxX, boxY, boxWidth, boxHeight = panelX + 2, panelY + (categoryCount * rowHeight) + rowHeight, panelWidth - 4, rowHeight
				
				drawBorderedRectangle(boxX, boxY, boxWidth, boxHeight, 2, tocolor(0, 0, 0, 255), tocolor(30, 30, 30, 255))
				dxDrawText(vehicleNumberplate, boxX, boxY, boxX + boxWidth, boxY + boxHeight, tocolor(255, 255, 255, 255), 0.5, availableFonts["chalet"], "center", "center")
			end
		end
	end
end)

addEventHandler("onClientPreRender", root, function(timeSlice)
	--> Calculate mouse move speed
	if isCursorShowing() then
		local cursorX, cursorY = getCursorPosition()
		
		mouseTable["speed"][1] = math.sqrt(math.pow((mouseTable["last"][1] - cursorX) / timeSlice, 2))
		mouseTable["speed"][2] = math.sqrt(math.pow((mouseTable["last"][2] - cursorY) / timeSlice, 2))
		
		mouseTable["last"][1] = cursorX
		mouseTable["last"][2] = cursorY
	end
	
	--> Camera
	if panelState and enteredVehicle then
		local _, _, _, _, _, _, roll, fov = getCameraMatrix()
		local cameraZoomProgress = (getTickCount() - cameraSettings["zoomTick"]) / 500
		local cameraZoomAnimation = interpolateBetween(fov, 0, 0, cameraSettings["zoom"], 0, 0, cameraZoomProgress, "Linear")
		
		if cameraSettings["moveState"] == "moveToElement" then
			local currentCameraX, currentCameraY, currentCameraZ, currentCameraRotX, currentCameraRotY, currentCameraRotZ = getCameraMatrix()
			local cameraProgress = (getTickCount() - cameraSettings["moveTick"]) / 1000
			local cameraX, cameraY, cameraZ, componentX, componentY, componentZ = _getCameraPosition("component")
			local newCameraX, newCameraY, newCameraZ = interpolateBetween(currentCameraX, currentCameraY, currentCameraZ, cameraX, cameraY, cameraZ, cameraProgress, "Linear")
			local newCameraRotX, newCameraRotY, newCameraRotZ = interpolateBetween(currentCameraRotX, currentCameraRotY, currentCameraRotZ, componentX, componentY, componentZ, cameraProgress, "Linear")
			local newCameraZoom = interpolateBetween(fov, 0, 0, 60, 0, 0, cameraProgress, "Linear")
			
			setCameraMatrix(newCameraX, newCameraY, newCameraZ, newCameraRotX, newCameraRotY, newCameraRotZ, roll, newCameraZoom)
			
			if cameraProgress > 0.5 then
				cameraSettings["moveState"] = "freeMode"
				cameraSettings["zoom"] = 60
			end
		elseif cameraSettings["moveState"] == "backToVehicle" then
			local currentCameraX, currentCameraY, currentCameraZ, currentCameraRotX, currentCameraRotY, currentCameraRotZ = getCameraMatrix()
			local cameraProgress = (getTickCount() - cameraSettings["moveTick"]) / 1000
			local cameraX, cameraY, cameraZ, vehicleX, vehicleY, vehicleZ = _getCameraPosition("vehicle")
			local newCameraX, newCameraY, newCameraZ = interpolateBetween(currentCameraX, currentCameraY, currentCameraZ, cameraX, cameraY, cameraZ, cameraProgress, "Linear")
			local newCameraRotX, newCameraRotY, newCameraRotZ = interpolateBetween(currentCameraRotX, currentCameraRotY, currentCameraRotZ, vehicleX, vehicleY, vehicleZ, cameraProgress, "Linear")
			local newCameraZoom = interpolateBetween(fov, 0, 0, 60, 0, 0, cameraProgress, "Linear")
			
			setCameraMatrix(newCameraX, newCameraY, newCameraZ, newCameraRotX, newCameraRotY, newCameraRotZ, roll, newCameraZoom)
			
			if cameraProgress > 0.5 then
				cameraSettings["moveState"] = "freeMode"
				cameraSettings["zoom"] = 60
			end
		elseif cameraSettings["moveState"] == "freeMode" then
			local cameraX, cameraY, cameraZ, elementX, elementY, elementZ = _getCameraPosition("both")
			
			setCameraMatrix(cameraX, cameraY, cameraZ, elementX, elementY, elementZ, roll, cameraZoomAnimation)
			
			if getKeyState("mouse1") and not pickingColor and not pickingLuminance and isCursorShowing() and not isMTAWindowActive() and not promptDialog["state"] then
				cameraSettings["freeModeActive"] = true
			else
				cameraSettings["freeModeActive"] = false
			end
		end
	end
end)

addEventHandler("onClientCursorMove", root, function(cursorX, cursorY, absoluteX, absoluteY)
	if panelState and enteredVehicle then
		if cameraSettings["freeModeActive"] then
			lastCursorX = mouseTable["move"][1]
			lastCursorY = mouseTable["move"][2]
			
			mouseTable["move"][1] = cursorX
			mouseTable["move"][2] = cursorY
			
			if cursorX > lastCursorX then
				cameraSettings["currentX"] = cameraSettings["currentX"] - (mouseTable["speed"][1] * 100)
			elseif cursorX < lastCursorX then
				cameraSettings["currentX"] = cameraSettings["currentX"] + (mouseTable["speed"][1] * 100)
			end
			
			if cursorY > lastCursorY then
				cameraSettings["currentZ"] = cameraSettings["currentZ"] + (mouseTable["speed"][2] * 50)
			elseif cursorY < lastCursorY then
				cameraSettings["currentZ"] = cameraSettings["currentZ"] - (mouseTable["speed"][2] * 50)
			end
			
			cameraSettings["currentY"] = cameraSettings["currentX"]
			cameraSettings["currentZ"] = math.max(cameraSettings["minimumZ"], math.min(cameraSettings["maximumZ"], cameraSettings["currentZ"]))
		end
	end
end)

addEventHandler("onClientCharacter", root, function(character)
	if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then
		if selectedSubCategory == 8 and hoveredCategory == 2 then
			if #vehicleNumberplate < 8 then
				local supportedCharacters = {
					["q"] = true, ["w"] = true, ["x"] = true, ["4"] = true,
					["e"] = true, ["r"] = true, ["c"] = true, ["5"] = true,
					["t"] = true, ["z"] = true, ["v"] = true, ["6"] = true,
					["u"] = true, ["i"] = true, ["b"] = true, ["7"] = true,
					["o"] = true, ["p"] = true, ["n"] = true, ["8"] = true,
					["a"] = true, ["s"] = true, ["m"] = true, ["9"] = true,
					["d"] = true, ["f"] = true, ["0"] = true, ["-"] = true,
					["g"] = true, ["h"] = true, ["1"] = true, [" "] = true,
					["j"] = true, ["k"] = true, ["2"] = true,
					["l"] = true, ["y"] = true, ["3"] = true,
				}
				
				if supportedCharacters[character] then
					vehicleNumberplate = vehicleNumberplate .. utf8.upper(character)
					setVehiclePlateText(enteredVehicle, vehicleNumberplate)
				end
			end
		end
	end
end)

addEventHandler("onClientKey", root, function(key, pressed)
	if panelState and enteredVehicle then
		if pressed then
			if key == "arrow_d" and not promptDialog["state"] then
				if hoveredCategory > #loopTable or hoveredCategory == #loopTable then
					hoveredCategory = #loopTable
				else
					if hoveredCategory > maxRowsPerPage then
						currentPage = currentPage + 1
					end
				
					hoveredCategory = hoveredCategory + 1
					
					if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then
						if selectedSubCategory ~= 0 then
							if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
								showNextOpticalUpgrade()
							else
								if selectedSubCategory == 12 then -- Neon
									addNeon(enteredVehicle, loopTable[hoveredCategory]["tuningData"])
								end
							end
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then
						if selectedSubCategory == 1 then
							triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "front", loopTable[hoveredCategory]["tuningData"])
						elseif selectedSubCategory == 2 then
							triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "rear", loopTable[hoveredCategory]["tuningData"])
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then
						setVehicleColorsToDefault()
						setPaletteType(loopTable[hoveredCategory]["tuningData"])
						updatePaletteColor(enteredVehicle, loopTable[hoveredCategory]["tuningData"])
					end
					
					playSoundEffect("menunavigate.mp3")
				end
			elseif key == "arrow_u" and not promptDialog["state"] then
				if hoveredCategory < 1 or hoveredCategory == 1 then
					hoveredCategory = 1
					
					if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then
						if selectedSubCategory ~= 0 then
							if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
								showDefaultOpticalUpgrade()
							end
						end
					end
				else
					if currentPage - 1 >= 1 then
						currentPage = currentPage - 1
					end
					
					hoveredCategory = hoveredCategory - 1
					
					if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then
						if selectedSubCategory ~= 0 then
							if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
								if hoveredCategory == 1 then -- Default upgrade
									removeVehicleUpgrade(enteredVehicle, compatibleOpticalUpgrades[hoveredCategory])
								else
									showNextOpticalUpgrade()
								end
							else
								if selectedSubCategory == 12 then -- Neon
									if hoveredCategory == 1 then
										removeNeon(enteredVehicle, true)
									else
										addNeon(enteredVehicle, loopTable[hoveredCategory]["tuningData"])
									end
								end
							end
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then
						if selectedSubCategory == 1 then
							triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "front", loopTable[hoveredCategory]["tuningData"])
						elseif selectedSubCategory == 2 then
							triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "rear", loopTable[hoveredCategory]["tuningData"])
						elseif selectedSubCategory == 8 then
							if equippedTuning ~= vehicleNumberplate then
								setVehiclePlateText(enteredVehicle, equippedTuning)
								vehicleNumberplate = equippedTuning
							end
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then
						setVehicleColorsToDefault()
						setPaletteType(loopTable[hoveredCategory]["tuningData"])
						updatePaletteColor(enteredVehicle, loopTable[hoveredCategory]["tuningData"])
					end
					
					playSoundEffect("menunavigate.mp3")
				end
			elseif key == "backspace" then
				if promptDialog["state"] then
					promptDialog["state"] = false
				else
					if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) and selectedSubCategory == 8 then
						if hoveredCategory == 2 then
							if #vehicleNumberplate - 1 >= 0 then
								vehicleNumberplate = string.sub(vehicleNumberplate, 1, #vehicleNumberplate - 1)
								setVehiclePlateText(enteredVehicle, vehicleNumberplate)
							else
								setVehiclePlateText(enteredVehicle, "")
								vehicleNumberplate = ""
							end
							
							return
						else
							if equippedTuning ~= vehicleNumberplate then
								setVehiclePlateText(enteredVehicle, equippedTuning)
								vehicleNumberplate = equippedTuning
							end
						end
					end
					
					if selectedCategory == 0 and selectedSubCategory == 0 then
						triggerEvent("tuning->HideMenu", localPlayer)
					elseif selectedCategory ~= 0 and selectedSubCategory == 0 then
						if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then -- Color
							destroyColorPicker()
							setVehicleColorsToDefault()
						end
						
						selectedCategory, hoveredCategory, currentPage = 0, 1, 1
					elseif selectedCategory ~= 0 and selectedSubCategory ~= 0 then
						moveCameraToDefaultPosition()
						
						if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then -- Optical
							if selectedSubCategory ~= 0 then
								if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
									resetOpticalUpgrade() -- reset to equipped upgrade
									tuningMenu[selectedCategory]["availableUpgrades"] = {}
									equippedTuning = 1
								else
									if selectedSubCategory == 11 then -- Lamp color
										destroyColorPicker()
										setVehicleColorsToDefault()
										setVehicleOverrideLights(enteredVehicle, 1)
									elseif selectedSubCategory == 12 then -- Neon
										restoreOldNeon(enteredVehicle)
									end
								end
							end
						elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then -- Extras
							if selectedSubCategory == 1 then
								local defaultWheelSize = (equippedTuning == 1 and "verynarrow") or (equippedTuning == 2 and "narrow") or (equippedTuning == 3 and "default") or (equippedTuning == 4 and "wide") or (equippedTuning == 5 and "verywide")
								
								triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "front", defaultWheelSize)
							elseif selectedSubCategory == 2 then
								local defaultWheelSize = (equippedTuning == 1 and "verynarrow") or (equippedTuning == 2 and "narrow") or (equippedTuning == 3 and "default") or (equippedTuning == 4 and "wide") or (equippedTuning == 5 and "verywide")
								
								triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "rear", defaultWheelSize)
							elseif selectedSubCategory == 6 then
								setVehicleDoorOpenRatio(enteredVehicle, 2, 0, 500)
								setVehicleDoorOpenRatio(enteredVehicle, 3, 0, 500)
								
								setVehicleDoorToLSD(enteredVehicle, ((equippedTuning == 1 and false) or (equippedTuning == 2 and true)))
							end
						end
						
						selectedSubCategory, hoveredCategory, currentPage = 0, 1, 1
					end
					
					playSoundEffect("menuback.wav")
					
					if enteredVehicle then
						for component in pairs(getVehicleComponents(enteredVehicle)) do
							setVehicleComponentVisible(enteredVehicle, component, true)
						end
					end
				end
			elseif key == "enter" then
				if not promptDialog["state"] then
					if selectedCategory == 0 then
						selectedCategory, currentPage, hoveredCategory = hoveredCategory, 1, 1
						
						if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then
							savedVehicleColors["all"] = {getVehicleColor(enteredVehicle, true)}
							savedVehicleColors["headlight"] = {getVehicleHeadLightColor(enteredVehicle)}
							
							createColorPicker(enteredVehicle, panelX + 2, (panelY + (logoHeight * scaleFactor) + rowHeight + (categoryCount * rowHeight) + rowHeight) + 2, panelWidth - 4, (panelWidth / 2) * scaleFactor, "color1")
						end
						
						playSoundEffect("menuenter.mp3")
					elseif selectedCategory ~= 0 and selectedSubCategory == 0 then
						if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.performance")) then
							local componentCompatible = false
						
							if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck", "Quad", "Bike"}) then
								local tuningDataName = loopTable[hoveredCategory]["upgradeData"]
								local equippedTuningID = getElementData(enteredVehicle, "tuning." .. tuningDataName) or 1
								
								if tuningDataName ~= "nitro" then
									equippedTuning = equippedTuningID
									componentCompatible = true
								else
									if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck"}) then
										equippedTuning = -1
										componentCompatible = true
									end
								end
							end
							
							if componentCompatible then
								setCameraAndComponentVisible()
								selectedSubCategory, hoveredCategory, currentPage = hoveredCategory, 1, 1
							end
						elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then
							if isGTAUpgradeSlot(loopTable[hoveredCategory]["upgradeSlot"]) then
								local upgradeSlot = loopTable[hoveredCategory]["upgradeSlot"]
								local compatibleUpgrades = getVehicleCompatibleUpgrades(enteredVehicle, upgradeSlot)
							
								if compatibleUpgrades[1] == nil then
									giveNotification("error", getLocalizedText("notification.error.notCompatible", loopTable[hoveredCategory]["categoryName"]))
								else
									setCameraAndComponentVisible()
									
									compatibleOpticalUpgrades = compatibleUpgrades
									equippedTuning = getVehicleUpgradeOnSlot(enteredVehicle, upgradeSlot)
									
									table.insert(tuningMenu[selectedCategory]["availableUpgrades"], {
										["categoryName"] = getLocalizedText("tuningPack.0"),
										["tuningPrice"] = 0,
										["upgradeID"] = 0
									})
									
									for id, upgrade in pairs(compatibleOpticalUpgrades) do
										table.insert(tuningMenu[selectedCategory]["availableUpgrades"], {
											["categoryName"] = tuningMenu[selectedCategory]["subMenu"][hoveredCategory]["categoryName"] .. " " .. id,
											["tuningPrice"] = tuningMenu[selectedCategory]["subMenu"][hoveredCategory]["tuningPrice"],
											["upgradeID"] = upgrade
										})
									end
									
									selectedSubCategory, hoveredCategory, currentPage = hoveredCategory, 1, 1
									showDefaultOpticalUpgrade()
								end
							else -- Customs optical elements (Neon, Air-Ride etc..)
								local componentCompatible = false
								
								if hoveredCategory == 10 then -- Air-Ride
									if isComponentCompatible(enteredVehicle, "Automobile") then
										equippedTuning = (getElementData(enteredVehicle, "tuning.airRide") and 2) or 1
										componentCompatible = true
									end
								elseif hoveredCategory == 11 then -- Lamp color
									if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck", "Quad", "Bike"}) then
										equippedTuning = -1
										
										setVehicleOverrideLights(enteredVehicle, 2)
										
										savedVehicleColors["all"] = {getVehicleColor(enteredVehicle, true)}
										savedVehicleColors["headlight"] = {getVehicleHeadLightColor(enteredVehicle)}
										
										createColorPicker(enteredVehicle, panelX + 2, (panelY + (logoHeight * scaleFactor) + (rowHeight * 2) + rowHeight) + 2, panelWidth - 4, (panelWidth / 2) * scaleFactor, "headlight")
										
										componentCompatible = true
									end
								elseif hoveredCategory == 12 then -- Neon
									if isComponentCompatible(enteredVehicle, "Automobile") then
										local currentNeon = getElementData(enteredVehicle, "tuning.neon") or false
										
										if currentNeon == "white" then currentNeon = 2
										elseif currentNeon == "blue" then currentNeon = 3
										elseif currentNeon == "green" then currentNeon = 4
										elseif currentNeon == "red" then currentNeon = 5
										elseif currentNeon == "yellow" then currentNeon = 6
										elseif currentNeon == "pink" then currentNeon = 7
										elseif currentNeon == "orange" then currentNeon = 8
										elseif currentNeon == "lightblue" then currentNeon = 9
										elseif currentNeon == "rasta" then currentNeon = 10
										elseif currentNeon == "ice" then currentNeon = 11
										else currentNeon = 1
										end
										
										equippedTuning = currentNeon
										removeNeon(enteredVehicle, true)
										
										componentCompatible = true
									end
								end
								
								if componentCompatible then
									setCameraAndComponentVisible()
									selectedSubCategory, hoveredCategory, currentPage = hoveredCategory, 1, 1
								end
							end
						elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then
							local componentCompatible = false
							
							if hoveredCategory == 1 then
								if isComponentCompatible(enteredVehicle, "Automobile") then
									equippedTuning = getVehicleWheelSize(enteredVehicle, "front")
									triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "front", loopTable[hoveredCategory]["subMenu"][1]["tuningData"])
									
									componentCompatible = true
								end
							elseif hoveredCategory == 2 then
								if isComponentCompatible(enteredVehicle, "Automobile") then
									equippedTuning = getVehicleWheelSize(enteredVehicle, "rear")
									triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, "rear", loopTable[hoveredCategory]["subMenu"][1]["tuningData"])
									
									componentCompatible = true
								end
							elseif hoveredCategory == 3 then
								if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck", "Quad", "Bike"}) then
									equippedTuning = getVehicleOffroadAbility(enteredVehicle)
									componentCompatible = true
								end
							elseif hoveredCategory == 4 then
								if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck", "Quad"}) then
									local driveType = getVehicleHandling(enteredVehicle)["driveType"]
									
									equippedTuning = (driveType == "fwd" and 1) or (driveType == "awd" and 2) or (driveType == "rwd" and 3)
									componentCompatible = true
								end
							elseif hoveredCategory == 5 then
								if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck", "Quad", "Bike"}) then
									equippedTuning = (getElementData(enteredVehicle, "tuning.bulletProofTires") and 2) or 1
									componentCompatible = true
								end
							elseif hoveredCategory == 6 then
								if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck"}) then
									equippedTuning = (getElementData(enteredVehicle, "tuning.lsdDoor") and 2) or 1
									
									setVehicleDoorOpenRatio(enteredVehicle, 2, 1, 500)
									setVehicleDoorOpenRatio(enteredVehicle, 3, 1, 500)
									
									setVehicleDoorToLSD(enteredVehicle, true)
									
									componentCompatible = true
								end
							elseif hoveredCategory == 7 then
								if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck", "Quad", "Bike", "BMX"}) then
									local steeringLock = getVehicleHandling(enteredVehicle)["steeringLock"]
									
									equippedTuning = (steeringLock == 30 and 2) or (steeringLock == 40 and 3) or (steeringLock == 50 and 4) or (steeringLock == 60 and 5) or 1
									componentCompatible = true
								end
							elseif hoveredCategory == 8 then
								if isComponentCompatible(enteredVehicle, {"Automobile", "Monster Truck", "Quad", "Bike"}) then
									equippedTuning = getVehiclePlateText(enteredVehicle)
									vehicleNumberplate = equippedTuning
									componentCompatible = true
								end
							end
							
							if componentCompatible then
								setCameraAndComponentVisible()
								selectedSubCategory, hoveredCategory, currentPage = hoveredCategory, 1, 1
							end
						elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then
							promptDialog = {
								["state"] = true,
								["itemName"] = categoryName .. " (" .. loopTable[hoveredCategory]["categoryName"] .. ")",
								["itemPrice"] = loopTable[hoveredCategory]["tuningPrice"]
							}
						end
						
						playSoundEffect("menuenter.mp3")
					elseif selectedCategory ~= 0 and selectedSubCategory ~= 0 then
						promptDialog = {
							["state"] = true,
							["itemName"] = categoryName .. " (" .. loopTable[hoveredCategory]["categoryName"] .. ")",
							["itemPrice"] = loopTable[hoveredCategory]["tuningPrice"]
						}
					end
				else -- Buying item after accepted prompt
					if selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.performance")) then
						if hoveredCategory == equippedTuning then
							giveNotification("error", getLocalizedText("notification.error.itemIsPurchased", loopTable[hoveredCategory]["categoryName"]))
							promptDialog["state"] = false
						else
							if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
								local tuningName = tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeData"]
				
								setElementData(enteredVehicle, "tuning." .. tuningName, hoveredCategory, true)
								
								if tuningName ~= "nitro" then
									triggerServerEvent("tuning->PerformanceUpgrade", localPlayer, enteredVehicle, loopTable[hoveredCategory]["tuningData"])
									equippedTuning = hoveredCategory
								else
									if loopTable[hoveredCategory]["tuningData"] == 0 then
										triggerServerEvent("tuning->OpticalUpgrade", localPlayer, enteredVehicle, "remove", 1010)
									else
										triggerServerEvent("tuning->OpticalUpgrade", localPlayer, enteredVehicle, "add", 1010)
									end
									
									setElementData(enteredVehicle, "tuning.nitroLevel", loopTable[hoveredCategory]["tuningData"])
									refreshVehicleNitroLevel(enteredVehicle, loopTable[hoveredCategory]["tuningData"])
								end
								
								moneyChange(loopTable[hoveredCategory]["tuningPrice"])
								promptDialog["state"] = false
							else
								giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
								promptDialog["state"] = false
							end
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.optical")) then
						if isGTAUpgradeSlot(tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["upgradeSlot"]) then
							if equippedTuning == loopTable[hoveredCategory]["upgradeID"] then
								giveNotification("error", getLocalizedText("notification.error.itemIsPurchased", loopTable[hoveredCategory]["categoryName"]))
								promptDialog["state"] = false
							else
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									if getElementData(enteredVehicle, "tuning.airRide") and selectedSubCategory == 9 then
										giveNotification("warning", getLocalizedText("notification.warning.airRideInstalled"))
									else
										if loopTable[hoveredCategory]["upgradeID"] == 0 then
											triggerServerEvent("tuning->OpticalUpgrade", localPlayer, enteredVehicle, "remove", equippedTuning)
											equippedTuning = 0
										else
											triggerServerEvent("tuning->OpticalUpgrade", localPlayer, enteredVehicle, "add", loopTable[hoveredCategory]["upgradeID"])
											equippedTuning = loopTable[hoveredCategory]["upgradeID"]
										end
										
										moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									end
									
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							end
						else
							if selectedSubCategory == 10 then -- Air-Ride
								if hoveredCategory == equippedTuning then
									giveNotification("error", getLocalizedText("notification.error.itemIsPurchased", loopTable[hoveredCategory]["categoryName"]))
									promptDialog["state"] = false
								else
									if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
										setElementData(enteredVehicle, "tuning.airRide", loopTable[hoveredCategory]["tuningData"], true)
										
										if hoveredCategory == 1 then
											removeAirRide(enteredVehicle)
										end
										
										equippedTuning = hoveredCategory
										moneyChange(loopTable[hoveredCategory]["tuningPrice"])
										promptDialog["state"] = false
									else
										giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
										promptDialog["state"] = false
									end
								end
							elseif selectedSubCategory == 11 then -- Lamp color
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									savedVehicleColors["all"] = {getVehicleColor(enteredVehicle, true)}
									savedVehicleColors["headlight"] = {getVehicleHeadLightColor(enteredVehicle)}
									
									triggerServerEvent("tuning->Color", localPlayer, enteredVehicle, savedVehicleColors["all"], savedVehicleColors["headlight"])
									
									equippedTuning = -1
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							elseif selectedSubCategory == 12 then -- Neon
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									saveNeon(enteredVehicle, loopTable[hoveredCategory]["tuningData"], true)
									
									equippedTuning = hoveredCategory
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							end
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.extras")) then
						if selectedSubCategory == 1 or selectedSubCategory == 2 then
							local vehicleSide = (selectedSubCategory == 1 and "front") or (selectedSubCategory == 2 and "rear")
							
							if hoveredCategory == equippedTuning then
								giveNotification("error", getLocalizedText("notification.error.itemIsPurchased", loopTable[hoveredCategory]["categoryName"]))
								promptDialog["state"] = false
							else
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									triggerServerEvent("tuning->WheelWidth", localPlayer, enteredVehicle, vehicleSide, loopTable[hoveredCategory]["tuningData"])
									
									equippedTuning = hoveredCategory
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							end
						elseif selectedSubCategory == 3 then
							if hoveredCategory == equippedTuning then
								giveNotification("error", getLocalizedText("notification.error.itemIsPurchased", loopTable[hoveredCategory]["categoryName"]))
								promptDialog["state"] = false
							else
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									triggerServerEvent("tuning->OffroadAbility", localPlayer, enteredVehicle, loopTable[hoveredCategory]["tuningData"])
									
									equippedTuning = hoveredCategory
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							end
						elseif selectedSubCategory == 4 or selectedSubCategory == 7 then
							if hoveredCategory == equippedTuning then
								giveNotification("error", getLocalizedText("notification.error.itemIsPurchased", loopTable[hoveredCategory]["categoryName"]))
								promptDialog["state"] = false
							else
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									triggerServerEvent("tuning->HandlingUpdate", localPlayer, enteredVehicle, tuningMenu[selectedCategory]["subMenu"][selectedSubCategory]["propertyName"], loopTable[hoveredCategory]["tuningData"])
									
									equippedTuning = hoveredCategory
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							end
						elseif selectedSubCategory == 5 then
							if hoveredCategory == equippedTuning then
								giveNotification("error", getLocalizedText("notification.error.itemIsPurchased", loopTable[hoveredCategory]["categoryName"]))
								promptDialog["state"] = false
							else
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									setElementData(enteredVehicle, "tuning.bulletProofTires", loopTable[hoveredCategory]["tuningData"], true)
									
									equippedTuning = hoveredCategory
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							end
						elseif selectedSubCategory == 6 then
							if hoveredCategory == equippedTuning then
								giveNotification("error", getLocalizedText("notification.error.itemIsPurchased", loopTable[hoveredCategory]["categoryName"]))
								promptDialog["state"] = false
							else
								if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
									setVehicleDoorToLSD(enteredVehicle, loopTable[hoveredCategory]["tuningData"])
									
									equippedTuning = hoveredCategory
									moneyChange(loopTable[hoveredCategory]["tuningPrice"])
									promptDialog["state"] = false
								else
									giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
									promptDialog["state"] = false
								end
							end
						elseif selectedSubCategory == 8 then
							if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
								if loopTable[hoveredCategory]["tuningData"] == "random" then
									vehicleNumberplate = generateString(8)
								elseif loopTable[hoveredCategory]["tuningData"] == "custom" then
									vehicleNumberplate = vehicleNumberplate
								end
								
								triggerServerEvent("tuning->LicensePlate", localPlayer, enteredVehicle, vehicleNumberplate)
								
								equippedTuning = vehicleNumberplate
								moneyChange(loopTable[hoveredCategory]["tuningPrice"])
								promptDialog["state"] = false
							else
								giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
								promptDialog["state"] = false
							end
						end
					elseif selectedCategory == getMainCategoryIDByName(getLocalizedText("menu.color")) then
						if hasPlayerMoney(loopTable[hoveredCategory]["tuningPrice"]) then
							savedVehicleColors["all"] = {getVehicleColor(enteredVehicle, true)}
							savedVehicleColors["headlight"] = {getVehicleHeadLightColor(enteredVehicle)}
							
							triggerServerEvent("tuning->Color", localPlayer, enteredVehicle, savedVehicleColors["all"], savedVehicleColors["headlight"])
							
							equippedTuning = hoveredCategory
							moneyChange(loopTable[hoveredCategory]["tuningPrice"])
							promptDialog["state"] = false
						else
							giveNotification("error", getLocalizedText("notification.error.notEnoughMoney"))
							promptDialog["state"] = false
						end
					end
				end
			end
			
			if key == "mouse_wheel_up" and not promptDialog["state"] then
				if isCursorShowing() and not isMTAWindowActive() then
					cameraSettings["zoom"] = math.max(cameraSettings["zoom"] - 5, 30)
					cameraSettings["zoomTick"] = getTickCount()
				end
			elseif key == "mouse_wheel_down" and not promptDialog["state"] then
				if isCursorShowing() and not isMTAWindowActive() then
					cameraSettings["zoom"] = math.min(cameraSettings["zoom"] + 5, 60)
					cameraSettings["zoomTick"] = getTickCount()
				end
			end
		end
	end
end)

addEventHandler("tuning->ShowMenu", root, function(vehicle)
	if source and vehicle then
		if not panelState then
			enteredVehicle = vehicle
			
			createFonts()
			
			hoveredCategory, selectedCategory, selectedSubCategory = 1, 0, 0
			maxRowsPerPage, currentPage = 7, 1
			
			navigationBar[1][1] = getLocalizedText("navbar.select")
			navigationBar[2][1] = getLocalizedText("navbar.navigate")
			navigationBar[3][1] = getLocalizedText("navbar.back")
			
			if noticeData["timer"] then
				if isTimer(noticeData["timer"]) then
					killTimer(noticeData["timer"])
				end
			end
			
			noticeData = {
				["text"] = false,
				["type"] = "info",
				["tick"] = 0,
				["state"] = "",
				["height"] = 0,
				["timer"] = nil
			}
			
			local _, _, vehicleRotation = getElementRotation(enteredVehicle)
			local cameraRotation = vehicleRotation + 60
			
			cameraSettings = {
				["distance"] = 9,
				["movingSpeed"] = 2,
				["currentX"] = math.rad(cameraRotation),
				["defaultX"] = math.rad(cameraRotation),
				["currentY"] = math.rad(cameraRotation),
				["currentZ"] = math.rad(15),
				["maximumZ"] = math.rad(35),
				["minimumZ"] = math.rad(0),
				["freeModeActive"] = false,
				["zoomTick"] = 0,
				["zoom"] = 60
			}
			
			cameraSettings["moveState"] = "freeMode"
			
			promptDialog = {
				["state"] = false,
				["itemName"] = "",
				["itemPrice"] = 0
			}
			
			panelState = true
			toggleAllControls(false)
			setPlayerHudComponentVisible("all", false)
			showChat(false)
			showCursor(true)
		end
	end
end)

addEventHandler("tuning->HideMenu", root, function()
	if enteredVehicle and panelState then
		panelState = false
		toggleAllControls(true)
		setPlayerHudComponentVisible("all", false)
		showChat(true)
		enteredVehicle = nil
		destroyFonts()
		setCameraTarget(localPlayer)
		showCursor(false)
		
		triggerServerEvent("tuning->ResetMarker", root, localPlayer)
	end
end)

addEventHandler("onClientVehicleDamage", root, function(_, _, _, _, _, _, tyre) -- Bulletproof tires
	if getElementData(source, "tuning.bulletProofTires") then
		if tyre == 0 or tyre == 1 or tyre == 2 or tyre == 3 then
			cancelEvent()
		end
	end
end)

function moneyChange(amount)
    triggerServerEvent("paraKes",localPlayer,loopTable[hoveredCategory]["tuningPrice"])
	giveNotification("success", getLocalizedText("notification.success.purchased"))
	playSoundEffect("moneychange.wav")
	
	if amount > 0 then
		moneyChangeTable = {
			["tick"] = getTickCount() + 5000,
			["amount"] = amount
		}
	end
end

function createFonts()
	availableFonts = {
		chalet = dxCreateFont("files/fonts/chalet.ttf", 22 * scaleFactor, false, "antialiased"),
		icons = dxCreateFont("files/fonts/icons.ttf", 11 * scaleFactor, false, "antialiased")
	}
end

function destroyFonts()
	if availableFonts then
		for fontName, fontElement in pairs(availableFonts) do
			destroyElement(fontElement)
			availableFonts[fontName] = nil
		end
		
		availableFonts = nil
	end
end

function drawTextWithBorder(text, offset, x, y, w, h, borderColor, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
	for offsetX = -offset, offset do
		for offsetY = -offset, offset do
			dxDrawText(text:gsub("#%x%x%x%x%x%x", ""), x + offsetX, y + offsetY, w + offsetX, h + offsetY, borderColor, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
		end
	end
	
	dxDrawText(text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, subPixelPositioning, fRotation, fRotationCenterX, fRotationCenterY)
end

function giveNotification(type, text)
	type = type or "info"
	
	if noticeData["timer"] then
		if isTimer(noticeData["timer"]) then
			killTimer(noticeData["timer"])
		end
	end
	
	noticeData = {
		["text"] = text,
		["type"] = type,
		["tick"] = getTickCount(),
		["state"] = "showNotice",
		["height"] = 0,
		["timer"] = nil
	}
	
	playSoundEffect("notification.mp3")
end

function getNavbarWidth()
	local barOffsetX = 0
		
	for _, row in ipairs(navigationBar) do
		local textLength = dxGetTextWidth(row[1], 0.5, availableFonts["chalet"]) + 20
		local navWidth = 0
		
		for id, icon in ipairs(row[2]) do
			local buttonWidth = 0
			
			if type(row[3]) == "string" and row[3] == "image" then
				buttonWidth = row[4]
			elseif type(row[3]) == "boolean" and row[3] then
				buttonWidth = dxGetTextWidth(availableIcons[icon], 1.0, availableFonts["icons"]) + 20
			elseif type(row[3]) == "boolean" and not row[3] then
				buttonWidth = dxGetTextWidth(icon, 0.5, availableFonts["chalet"]) + 10
			end
			
			navWidth = navWidth + buttonWidth + 10
		end
		
		barOffsetX = barOffsetX + (navWidth + textLength)
	end
	
	return barOffsetX
end

function hasPlayerMoney(money)
	if getElementData(localPlayer, 'money') >= money then
		return true
	end
	
	return false
end

function drawRoundedRectangle(x, y, w, h, rounding, borderColor, bgColor, postGUI)
	borderColor = borderColor or tocolor(0, 0, 0, 200)
	bgColor = bgColor or borderColor
	rounding = rounding or 2
	
	dxDrawRectangle(x, y, w, h, bgColor, postGUI)
	dxDrawRectangle(x + rounding, y - 1, w - (rounding * 2), 1, borderColor, postGUI)
	dxDrawRectangle(x + rounding, y + h, w - (rounding * 2), 1, borderColor, postGUI)
	dxDrawRectangle(x - 1, y + rounding, 1, h - (rounding * 2), borderColor, postGUI)
	dxDrawRectangle(x + w, y + rounding, 1, h - (rounding * 2), borderColor, postGUI)
end

function showDefaultOpticalUpgrade()
	if panelState then
		if enteredVehicle then
			if equippedTuning ~= 0 then
				removeVehicleUpgrade(enteredVehicle, equippedTuning)
			elseif equippedTuning == 0 then
				removeVehicleUpgrade(enteredVehicle, compatibleOpticalUpgrades[hoveredCategory])
			end
		end
	end
end

function showNextOpticalUpgrade()
	if panelState then
		if enteredVehicle then
			addVehicleUpgrade(enteredVehicle, compatibleOpticalUpgrades[hoveredCategory - 1])
		end
	end
end

function resetOpticalUpgrade()
	if panelState then
		if enteredVehicle then
			if equippedTuning ~= 0 then
				addVehicleUpgrade(enteredVehicle, equippedTuning)
			else
				if hoveredCategory - 1 == 0 then
					removeVehicleUpgrade(enteredVehicle, compatibleOpticalUpgrades[hoveredCategory])
				else
					removeVehicleUpgrade(enteredVehicle, compatibleOpticalUpgrades[hoveredCategory - 1])
				end
			end
		end
	end
end

function formatNumber(amount, spacer)
	if not spacer then
		spacer = ","
	end
	
	amount = math.floor(amount)
	
	local left, num, right = string.match(tostring(amount), "^([^%d]*%d)(%d*)(.-)$")
	return left .. (num:reverse():gsub("(%d%d%d)", "%1" .. spacer):reverse()) .. right
end

function playSoundEffect(soundFile)
	if soundFile then
		local soundEffect = playSound("files/sounds/" .. soundFile, false)
		
		setSoundVolume(soundEffect, 0.5)
	end
end

function getPositionFromElementOffset(element, offsetX, offsetY, offsetZ)
	local elementMatrix = getElementMatrix(element)
    local elementX = offsetX * elementMatrix[1][1] + offsetY * elementMatrix[2][1] + offsetZ * elementMatrix[3][1] + elementMatrix[4][1]
    local elementY = offsetX * elementMatrix[1][2] + offsetY * elementMatrix[2][2] + offsetZ * elementMatrix[3][2] + elementMatrix[4][2]
    local elementZ = offsetX * elementMatrix[1][3] + offsetY * elementMatrix[2][3] + offsetZ * elementMatrix[3][3] + elementMatrix[4][3]
	
    return elementX, elementY, elementZ
end

function getVehicleOffroadAbility(vehicle)
	if vehicle then
		local flags = getVehicleHandling(vehicle)["handlingFlags"]
		
		for name, flag in pairs(availableOffroadAbilities) do
			if isFlagSet(flags, flag[1]) then
				return flag[2]
			end
		end
		
		return 1
	end
end

function getVehicleWheelSize(vehicle, side)
	if vehicle and side then
		local flags = getVehicleHandling(vehicle)["handlingFlags"]
		
		for name, flag in pairs(availableWheelSizes[side]) do
			if isFlagSet(flags, flag[1]) then
				return flag[2]
			end
		end
		
		return 3
	end
end

function isGTAUpgradeSlot(slot)
	if slot then
		for i = 0, 16 do
			if slot == i then
				return true
			end
		end
	end
	
	return false
end

function isFlagSet(val, flag)
	return (bitAnd(val, flag) == flag)
end

function moveCameraToComponent(component, offsetX, offsetZ, zoom)
	if component then
		local _, _, vehicleRotation = getElementRotation(enteredVehicle)
		
		offsetX = offsetX or cameraSettings["defaultX"]
		offsetZ = offsetZ or 15
		zoom = zoom or 9
		
		local cameraRotation = vehicleRotation + offsetX
		
		cameraSettings["moveState"] = "moveToElement"
		cameraSettings["moveTick"] = getTickCount()
		cameraSettings["viewingElement"] = component
		cameraSettings["currentX"] = math.rad(cameraRotation)
		cameraSettings["currentY"] = math.rad(cameraRotation)
		cameraSettings["currentZ"] = math.rad(offsetZ)
		cameraSettings["distance"] = zoom
	end
end

function moveCameraToDefaultPosition()
	cameraSettings["moveState"] = "backToVehicle"
	cameraSettings["moveTick"] = getTickCount()
	cameraSettings["viewingElement"] = enteredVehicle
	
	cameraSettings["currentX"] = cameraSettings["defaultX"]
	cameraSettings["currentY"] = cameraSettings["defaultX"]
	cameraSettings["currentZ"] = math.rad(15)
	cameraSettings["distance"] = 9
end

function _getCameraPosition(element)
	if element == "component" then
		local componentX, componentY, componentZ = getVehicleComponentPosition(enteredVehicle, cameraSettings["viewingElement"])
		local elementX, elementY, elementZ = getPositionFromElementOffset(enteredVehicle, componentX, componentY, componentZ)
		local elementZ = elementZ + 0.2
		
		local cameraX = elementX + math.cos(cameraSettings["currentX"]) * cameraSettings["distance"]
		local cameraY = elementY + math.sin(cameraSettings["currentY"]) * cameraSettings["distance"]
		local cameraZ = elementZ + math.sin(cameraSettings["currentZ"]) * cameraSettings["distance"]
		
		return cameraX, cameraY, cameraZ, elementX, elementY, elementZ
	elseif element == "vehicle" then
		local elementX, elementY, elementZ = getElementPosition(enteredVehicle)
		local elementZ = elementZ + 0.2
		
		local cameraX = elementX + math.cos(cameraSettings["currentX"]) * cameraSettings["distance"]
		local cameraY = elementY + math.sin(cameraSettings["currentY"]) * cameraSettings["distance"]
		local cameraZ = elementZ + math.sin(cameraSettings["currentZ"]) * cameraSettings["distance"]
		
		return cameraX, cameraY, cameraZ, elementX, elementY, elementZ
	elseif element == "both" then
		if type(cameraSettings["viewingElement"]) == "string" then
			local componentX, componentY, componentZ = getVehicleComponentPosition(enteredVehicle, cameraSettings["viewingElement"])
			
			elementX, elementY, elementZ = getPositionFromElementOffset(enteredVehicle, componentX, componentY, componentZ)
		else
			elementX, elementY, elementZ = getElementPosition(enteredVehicle)
		end
		
		local elementZ = elementZ + 0.2
		
		local cameraX = elementX + math.cos(cameraSettings["currentX"]) * cameraSettings["distance"]
		local cameraY = elementY + math.sin(cameraSettings["currentY"]) * cameraSettings["distance"]
		local cameraZ = elementZ + math.sin(cameraSettings["currentZ"]) * cameraSettings["distance"]
		
		return cameraX, cameraY, cameraZ, elementX, elementY, elementZ
	end
end

function isValidComponent(vehicle, componentName)
	if vehicle and componentName then
		for component in pairs(getVehicleComponents(vehicle)) do
			if componentName == component then
				return true
			end
		end
	end
	
	return false
end

function setVehicleColorsToDefault()
	local vehicleColor = savedVehicleColors["all"]
	local vehicleLightColor = savedVehicleColors["headlight"]
	
	setVehicleColor(enteredVehicle, vehicleColor[1], vehicleColor[2], vehicleColor[3], vehicleColor[4], vehicleColor[5], vehicleColor[6], vehicleColor[7], vehicleColor[8], vehicleColor[9])
	setVehicleHeadLightColor(enteredVehicle, vehicleLightColor[1], vehicleLightColor[2], vehicleLightColor[3])
end

function setCameraAndComponentVisible()
	if getVehicleType(enteredVehicle) == "Automobile" then
		if loopTable[hoveredCategory]["cameraSettings"] then
			local cameraSetting = loopTable[hoveredCategory]["cameraSettings"]
		
			if isValidComponent(enteredVehicle, cameraSetting[1]) then
				moveCameraToComponent(cameraSetting[1], cameraSetting[2], cameraSetting[3], cameraSetting[4])
			end
			
			if cameraSetting[5] then
				setVehicleComponentVisible(enteredVehicle, cameraSetting[1], false)
			end
		end
	end
end

function generateString(len)
	if tonumber(len) then
		local allowed = {{48, 57}, {97, 122}}
		
		math.randomseed(getTickCount())

		local str = ""
		
		for i = 1, len do
			local charlist = allowed[math.random(1, 2)]
			
			if i == 4 then
				str = str .. " "
			else
				str = str .. string.char(math.random(charlist[1], charlist[2]))
			end
		end

		return utf8.upper(str)
	end

	return false
end

function isComponentCompatible(vehicle, vehicleType)
	if vehicle and vehicleType then
		if type(vehicleType) == "string" then
			if getVehicleType(vehicle) == vehicleType then
				return true
			else
				giveNotification("error", getLocalizedText("notification.error.notCompatible", loopTable[hoveredCategory]["categoryName"]))
			end
		elseif type(vehicleType) == "table" then
			local typeFounded = false
			
			for _, modelType in pairs(vehicleType) do
				if modelType == getVehicleType(vehicle) then
					typeFounded = true
				end
			end
			
			if typeFounded then
				return true
			else
				giveNotification("error", getLocalizedText("notification.error.notCompatible", loopTable[hoveredCategory]["categoryName"]))
			end
		end
	end
	
	return false
end

function drawBorder(x, y, w, h, size, color, postGUI)
	size = size or 2
	
	dxDrawRectangle(x - size, y, size, h, color or tocolor(0, 0, 0, 200), postGUI)
	dxDrawRectangle(x + w, y, size, h, color or tocolor(0, 0, 0, 200), postGUI)
	dxDrawRectangle(x - size, y - size, w + (size * 2), size, color or tocolor(0, 0, 0, 200), postGUI)
	dxDrawRectangle(x - size, y + h, w + (size * 2), size, color or tocolor(0, 0, 0, 200), postGUI)
end

function drawBorderedRectangle(x, y, w, h, borderSize, borderColor, bgColor, postGUI)
	borderSize = borderSize or 2
	borderColor = borderColor or tocolor(0, 0, 0, 200)
	bgColor = bgColor or borderColor
	
	dxDrawRectangle(x, y, w, h, bgColor, postGUI)
	drawBorder(x, y, w, h, borderSize, borderColor, postGUI)
end

addCommandHandler("markerpos", function()
	if getPedOccupiedVehicle(localPlayer) then
		local x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local _, _, rotation = getElementRotation(getPedOccupiedVehicle(localPlayer))
		
		setClipboard(x .. ", " .. y .. ", " .. z .. ", " .. rotation)
	else
		local x, y, z = getElementPosition(localPlayer)
		local rotation = getPedRotation(localPlayer)
		
		setClipboard(x .. ", " .. y .. ", " .. z .. ", " .. rotation)
	end
	
	outputDebugString("[TUNING]: Marker position set to Clipboard. Use [CTRL + V] to paste it.", 0, 2, 168, 255)
end)