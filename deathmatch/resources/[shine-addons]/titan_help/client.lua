local font1 = exports['titan_fonts']:getFont('Roboto',10)
local font2 = exports['titan_fonts']:getFont('FontAwesome',12)
local font3 = exports['titan_fonts']:getFont('FontAwesome',10)

renderTimers = {}

function creatscaleder(id, func)
    if not isTimer(renderTimers[id]) then
        renderTimers[id] = setTimer(func, 7, 0)
    end
end

function destroyRender(id)
    if isTimer(renderTimers[id]) then
        killTimer(renderTimers[id])
        renderTimers[id] = nil
        collectgarbage("collect")
    end
end

tiklama = 0
settings = {
[1] = { -- // Tablar
		{"Meslekler"},
		{"Komutlar"},
		{"Sosyal Medya"}
	},
[2] = { -- // Meslekler içi yazılar
{
"Meslekler Ve Kazançları\n \nİçki Kaçakçılığı 70500₺\n \nSigara Kaçakçılığı 65000₺\n \nSiparis Mesleği: 27500₺"}
	},
[3] = { -- // Komutlar içi yazılar
		{"Yükleniyor.."}, 
	},
[4] = { -- // Sosyal Medya içi yazılar
		{"Discord: Tıkla", "https://discord.gg/gtxFahHZvJ"}, 
		-- {" "," "},
		{"Bakiye yüklemek için: www.Salvoroleplay.com/ucp","www.Salvoroleplay.com/ucp"}
	},
}
scale = 149
scale2 = 302
target = 1
function helppanel ()
	if panel then
	sX,sY = guiGetScreenSize()
	g,u = 450, 450
	x,y,w,h = sX/2-g/2,sY/2-u/2,g,u
	roundedRectangle(x,y,w,h,tocolor(124,124,124,170))
	w, h = w-4, h-4
	x, y = x+2, y+2
	-- // Arka Plan // --
	
	roundedRectangle(x,y,w,h,tocolor(24,24,24,80))
	roundedRectangle(x,y,w,25,tocolor(214,214,214,170))
	dxDrawText("SalvoMTA - Yardım Arayüzü",x,y+5,w+x-15,h+y+4,tocolor(10,10,10,215),1,exports['titan_fonts']:getFont('RobotoB',11),"center","top")
	dxDrawText("",x,y+30,w+x-15,h+y+4,tocolor(50,50,50,145),1,exports['titan_fonts']:getFont('FontAwesome',350),"center","top")
	
	for i,v in ipairs(settings[1]) do
		if isInBox(x+(i*scale)-scale,y+400,w/3,25) then
			if getKeyState("mouse1") and tiklama+200 <= getTickCount() then
				tiklama = getTickCount()
				target = i
			end
			dxDrawRectangle(x+(i*scale)-scale,y+400,w/3-1,25,tocolor(154, 154, 154,255))
			dxDrawText(v[1],x+(i*scale2)-scale2,y+405,w/3+x,h+y+4,tocolor(10,10,10),1,font3,"center","top")
		else
			if i == target then
				dxDrawRectangle(x+(i*scale)-scale,y+400,w/3-1,25,tocolor(154, 154, 154,255))
				dxDrawText(v[1],x+(i*scale2)-scale2,y+405,w/3+x,h+y+4,tocolor(10,10,10),1,font3,"center","top")
			else
				dxDrawRectangle(x+(i*scale)-scale,y+400,w/3,25,tocolor(154, 154, 154,255))
				dxDrawText(v[1],x+(i*scale2)-scale2,y+405,w/3+x,h+y+4,tocolor(10,10,10),1,font3,"center","top")
			end
			for k,v in ipairs(settings[(target+1)]) do
				if (target+1) == 4 then
					if isInBox(x,y+150+(k*20)-20,w,16) then
						if getKeyState("mouse1") and tiklama+200 <= getTickCount() then
							if v[2] ~= " " then
							tiklama = getTickCount()
							exports["titan_infobox"]:addBox("info","Başarıyla adresi kopyaladınız. '"..v[2].."'")
							setClipboard(v[2])
							end
						end
						dxDrawText(v[1],x+15,y+150+(k*20)-20,w/3+x,h+y+4,tocolor(130,130,130),1,exports['titan_fonts']:getFont('Roboto',10),"left","top")
					else
						dxDrawText(v[1],x+15,y+150+(k*20)-20,w/3+x,h+y+4,tocolor(200,200,200),1,exports['titan_fonts']:getFont('Roboto',10),"left","top")
					end
				else
				dxDrawText(v[1],x+20,y+150,w/3+x,h+y+4,tocolor(200,200,200),1,font1,"left","top")
				end
			end
		end
	end
	end
end

bindKey("F1","down",function()
 if (localPlayer:getData("loggedin") or 0 ) == 1 then 
	if not panel then
		panel = true
		creatscaleder("help:panel",helppanel)
	else
		panel = nil
		destroyRender("help:panel")
	end
end
end)

function isInBox(xS,yS,wS,hS)
	if(isCursorShowing()) then
		local cursorX, cursorY = getCursorPosition()
		sX,sY = guiGetScreenSize()
		cursorX, cursorY = cursorX*sX, cursorY*sY
		if(cursorX >= xS and cursorX <= xS+wS and cursorY >= yS and cursorY <= yS+hS) then
			return true
		else
			return false
		end
	end	
end

function dxDrawLinedRectangle( x, y, width, height, color, _width, postGUI )
	_width = _width or 1
	dxDrawLine ( x, y, x+width, y, color, _width, postGUI ) -- Top
	dxDrawLine ( x, y, x, y+height, color, _width, postGUI ) -- Left
	dxDrawLine ( x, y+height, x+width, y+height, color, _width, postGUI ) -- Bottom
	return dxDrawLine ( x+width, y, x+width, y+height, color, _width, postGUI ) -- Right
end

function dxDrawOuterBorder(x, y, w, h, borderSize, borderColor, postGUI)
	borderSize = borderSize or 2
	borderColor = borderColor or tocolor(0, 0, 0, 255)
	
	dxDrawRectangle(x - borderSize, y - borderSize, w + (borderSize * 2), borderSize, borderColor, postGUI)
	dxDrawRectangle(x, y + h, w, borderSize, borderColor, postGUI)
	dxDrawRectangle(x - borderSize, y, borderSize, h + borderSize, borderColor, postGUI)
	dxDrawRectangle(x + w, y, borderSize, h + borderSize, borderColor, postGUI)
end

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