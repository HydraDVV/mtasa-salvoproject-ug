local hasarlartablo = {}
local hasarsayi = 0
local bekleyen = nil
local gosterPanel = nil



local screenW, screenH = guiGetScreenSize()
        panel = guiCreateWindow((screenW - 596) / 2, (screenH - 334) / 2, 596, 334, "Hasar Kontrol Sistemi", false)
        guiWindowSetSizable(panel, false)
        guiSetVisible(panel, false)
        liste = guiCreateGridList(19, 31, 559, 250, false, panel)
        guiGridListAddColumn(liste, "ID", 0.1)
        guiGridListAddColumn(liste, "Hasar", 0.1)
        guiGridListAddColumn(liste, "AD", 0.25)
        guiGridListAddColumn(liste, "Yer", 0.2)
        guiGridListAddColumn(liste, "Tarih", 0.25)
         kapat = guiCreateButton(455, 290, 125, 32, "Kapat", false, panel)
		 

function islev()
 if ( guiGetVisible ( panel ) == true ) then               
                guiSetVisible ( panel, false )
				showCursor(false)
				removeEventHandler("onClientGUIClick", kapat, kapatislev, false)
        else              
                guiSetVisible ( panel, true )
				showCursor(true)
				addEventHandler("onClientGUIClick", kapat, kapatislev, false)
        end
end
addCommandHandler("hasarlar", islev)

function kapatislev()
 if ( guiGetVisible ( panel ) == true ) then               
                guiSetVisible ( panel, false )
				showCursor(false)
				removeEventHandler("onClientGUIClick", kapat, kapatislev, false)
        else              
                guiSetVisible ( panel, true )
				showCursor(true)
				addEventHandler("onClientGUIClick", kapat, kapatislev, false)
        end
end

function hasarAlindi(saldirgan, silah, yer, kayip)
if isElement(saldirgan) and getElementType ( saldirgan ) == "player" then
if not bekleyen then
 ad = getPlayerName(saldirgan)
 if yer == 3 then
 yer = "Gövde"
 elseif yer == 4 then
 yer = "Sırt"
 elseif yer == 5 then
 yer = "Sol Kol"
 elseif yer == 6 then
 yer = "Sağ Kol"
 elseif yer == 7 then
 yer = "Sol Bacak"
 elseif yer == 8 then
 yer = "Sağ Bacak"
 elseif yer == 9 then
  yer = "Kafa"
 end
 local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second

        local monthday = time.monthday
	local month = time.month
	local year = time.year
	 tarih = string.format("%04d-%02d-%02d %02d:%02d:%02d", year+1900, month + 1, monthday, hours, minutes, seconds)
 guiGridListAddRow(liste)
 guiGridListSetItemText(liste, hasarsayi, 1, ""..hasarsayi.."", false, false)
 guiGridListSetItemText(liste, hasarsayi, 2, ""..math.floor(kayip).."", false, false)
 guiGridListSetItemText(liste, hasarsayi, 3, ""..ad.."", false, false)
 guiGridListSetItemText(liste, hasarsayi, 4, ""..yer.."", false, false)
 guiGridListSetItemText(liste, hasarsayi, 5, ""..tarih.."", false, false)
 hasarsayi = hasarsayi+1
 bekleyen = true
 setTimer ( bekleyenindir, 5000, 1)
end
end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), hasarAlindi )

function bekleyenindir()
bekleyen = nil
end

function asd()
guiGridListClear ( liste )
end
addEvent( "sifirlaGridlist", true )
addEventHandler( "sifirlaGridlist", localPlayer, asd )