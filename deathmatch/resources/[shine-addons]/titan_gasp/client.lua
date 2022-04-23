
p,t = nil,nil
addEvent("gasp:panel",true)
addEventHandler("gasp:panel",root,function(p,t,f)
	if isElement(window) then return end
	p,t = p,t
	window = guiCreateWindow(0,0,550,100,getPlayerName(p).."'den Gaps isteği!",false)
	guiWindowSetSizable(window, false)
	showCursor(true)
	text = guiCreateLabel(5,25,550,16*2,getPlayerName(p).." isimli şahıs sizi gasp etmek istiyor. Eğer üzerinizde "..exports.global:formatMoney(f).." varsa hepsini alır.\n"..exports.global:formatMoney(f).." yoksa üzerinizde bulunanı alır.",false,window)
	guiLabelSetHorizontalAlign(text,"center")
	text:setFont("default-bold")
	exports.global:centerWindow(window)
	
	confirm = guiCreateButton(0,65,550/2-10,25, "Gasp Edilmeyi Onaylıyorum", false, window)
	Cancel = guiCreateButton(290,65,550/2-10,25, "Gasp Edilmeyi Reddediyorum", false, window)
end)

function destroywindow()
	if isElement(window) then
		destroyElement(window)
		showCursor(false)
	end
end

addEventHandler("onClientGUIClick", root,
	function()
		if source == confirm then
			triggerServerEvent("gasp:confirm", localPlayer, "yes")
			destroywindow()
		elseif source == Cancel then
			triggerServerEvent("gasp:confirm", localPlayer, "no")
			destroywindow()
		end
	end
)