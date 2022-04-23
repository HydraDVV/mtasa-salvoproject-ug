resourceRoot = getResourceRootElement(getThisResource())
sx, sy = guiGetScreenSize()

files = {
	images = {
		color = "files/images/color.png",
		up = "files/images/up.png",
		down = "files/images/down.png",
		right = "files/images/right.png",
		left = "files/images/left.png",
	},
	sounds = {
		air = "files/sounds/air.mp3",
	},
	font = "files/fonts/font.ttf",
	fontBold = "files/fonts/fontBold.ttf",
}

colors = {
	"tl:AAFFFFFF tr:AAFFFFFF bl:AAFFFFFF br:AAFFFFFF",
	"tl:AA000000 tr:AA000000 bl:AA000000 br:AA000000",
	"tl:AA111111 tr:AA111111 bl:AA111111 br:AA111111",
	"tl:AAFF0000 tr:AAFF0000 bl:AAFF0000 br:AAFF0000",
	"tl:AA0055FF tr:AA0055FF bl:AA0055FF br:AA0055FF",
	"tl:AAEABF00 tr:AAEABF00 bl:AAEABF00 br:AAEABF00",
	"tl:AA222222 tr:AA222222 bl:AA222222 br:AA222222",
	"tl:AA555555 tr:AA555555 bl:AA555555 br:AA555555",
	"tl:FF0055FF tr:FF0055FF bl:FFFF0000 br:FFFF0000",
	"tl:aa00cc00 tr:aa00cc00 bl:aa00cc00 br:aa00cc00",
	"tl:FF111111 tr:FF111111 bl:FF111111 br:FF111111",
	"tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000",
	"tl:FF888888 tr:FF888888 bl:FF888888 br:FF888888",
}

fonts = {
	bold = guiCreateFont(files.fontBold, 10),
	small = guiCreateFont(files.font, 10),
	plus = guiCreateFont(files.fontBold, 15),
	boldPlus = guiCreateFont(files.fontBold, 20),
}

colors = {
	"tl:AAFFFFFF tr:AAFFFFFF bl:AAFFFFFF br:AAFFFFFF",
	"tl:AA000000 tr:AA000000 bl:AA000000 br:AA000000",
	"tl:AA111111 tr:AA111111 bl:AA111111 br:AA111111",
	"tl:AAFF0000 tr:AAFF0000 bl:AAFF0000 br:AAFF0000",
	"tl:AA0055FF tr:AA0055FF bl:AA0055FF br:AA0055FF",
	"tl:AAEABF00 tr:AAEABF00 bl:AAEABF00 br:AAEABF00",
	"tl:AA222222 tr:AA222222 bl:AA222222 br:AA222222",
	"tl:AA555555 tr:AA555555 bl:AA555555 br:AA555555",
	"tl:FF0055FF tr:FF0055FF bl:FFFF0000 br:FFFF0000",
	"tl:aa00cc00 tr:aa00cc00 bl:aa00cc00 br:aa00cc00",
	"tl:FF111111 tr:FF111111 bl:FF111111 br:FF111111",
	"tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000",
	"tl:FF888888 tr:FF888888 bl:FF888888 br:FF888888",
}

function centerElement(element)
	local w, h = guiGetSize(element, false)
	local x, y = (sx/2)-(w/2), (sy/2)-(h/2)
	guiSetPosition(element, x, y, false)
end

function leftElement(element)
	local w, h = guiGetSize(element, false)
	local x, y = 30, (sy/2)-(h/2)
	guiSetPosition(element, x, y, false)
end

function paste(element1, element2, type, spacex, spacey)
	if type == "left" then
		local x, y = guiGetPosition(element2, false)
		local w, h = guiGetSize(element2, false)
		guiSetPosition(element1, x-w-spacex, y+spaceye, false)
	elseif type == "right" then
		local x, y = guiGetPosition(element2, false)
		local w, h = guiGetSize(element2, false)
		guiSetPosition(element1, x+w+spacex, y+spacey, false)
	elseif type == "up" then
		local x, y = guiGetPosition(element2, false)
		local w, h = guiGetSize(element2, false)
		guiSetPosition(element1, x+spacex, y-h-spacey, false)
	elseif type == "down" then
		local x, y = guiGetPosition(element2, false)
		local w, h = guiGetSize(element2, false)
		guiSetPosition(element1, x+spacex, y+h+spacey, false)
	end
end

function multipleGUIElement(fonksiyon, tablo, type)
	for i, element in pairs(tablo) do
		fonksiyon(element, type)
	end
end

function cColor(elem, color)
	guiSetProperty(elem, "ImageColours", color)
end

images = {}
function cImage(x, y, w, h, file, colors, parent)
	local i = #images+1
	if not images[i] then images[i] = {} end
	images[i].back = guiCreateStaticImage(x, y, w+4, h+4, files.images.color, false, parent)
	images[i].menu = guiCreateStaticImage(1, 1, w+2, h+2, files.images.color, false, images[i].back)
	images[i].image = guiCreateStaticImage(1, 1, w, h, file, false, images[i].menu)
	cColor(images[i].back, colors[1])
	cColor(images[i].menu, colors[2])
	cColor(images[i].image, colors[3])
	addEventHandler("onClientMouseEnter", resourceRoot, function()
		if source == images[i].image then
			guiSetAlpha(images[i].back, 0.5)
		end
	end)
	addEventHandler("onClientMouseLeave", images[i].image, function()
		if source == images[i].image then
			guiSetAlpha(images[i].back, 1)
		end
	end)
	return images[i].back, images[i].image
end

-- SparroW MTA : https://sparrow-mta.blogspot.com
-- Facebook : https://www.facebook.com/sparrowgta/
-- İnstagram : https://www.instagram.com/sparrowmta/
-- Discord : https://discord.gg/DzgEcvy (+500 Kişi)