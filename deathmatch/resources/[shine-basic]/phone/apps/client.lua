appNames = {
	["history"] = "Geçmiş",
		["twitter"] = "Twitter",
	["settings"] = "Ayarlar",
	["appstore"] = "App Store",
	["emails"] = "E-posta",
	["safari"] = "Safari",
	["flappy-bird"] = "F. Bird",
	["spotify"] = "Spotify",
	["contacts"] = "Rehber",	

}

guiApps = {}
local maxAppsPerRow = 3
local appsMaxRows = 4
local iconSize = 60
local iconSpacing = 15
local btnAlpha = 0

function drawAllPaneOfApps(xoffset, yoffset)
	drawApps = true
end

function togglePanesOfApps(state)
	drawApps = state
end

function convertString(_name)
	return appNames[_name]
end