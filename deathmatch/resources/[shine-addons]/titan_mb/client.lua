-- loading --
local sx,sy = guiGetScreenSize()
local alpha = 200
local rot = 0
local loadingText = "Salvo verileri yükleniyor."
function renderGTAVLoading()
	if alphaState == "down" then
		alpha = alpha - 2
		if alpha <= 100 then
			alphaState = "up"
			if changeTextTo then
				loadingText = changeTextTo
			end
		end
	else
		alpha = alpha + 2
		if alpha >= 200 then
			alphaState = "down"
		end
	end
	dxDrawText(loadingText,150,480,sx,sy,tocolor(55,55,55,alpha),2,"beckett","center","center")
	if rot > 360 then rot = 0 end
	rot = rot + 5
	local minusX = dxGetTextWidth(loadingText)
	dxDrawImage(sx/2-minusX/2-180,sy/2-16+235,48,48,"dosyalar/resimler/yukleniyor.png",rot)
end


addEventHandler("onClientResourceStart",resourceRoot, function()
	addEventHandler("onClientRender", root, render)
	changeTextTo = "Salvo:world version yukleniyor . . ."
	addEventHandler("onClientRender", root, renderGTAVLoading)
end)


function render()
	if not getElementData(localPlayer, "loggedin") == 1 then
      	if source == localPlayer then
        	outputChatBox("", 255, 79, 79, true)
      	end
        cancelEvent()
        return
      end	
	if isTransferBoxActive() then -- eğer mb kutucuğu varsa
		dxDrawImage(0,0,sx,sy,"dosyalar/resimler/1.png")	
		showChat(false)
	else
	removeEventHandler("onClientRender", root, render)
	--showChat(true)
	removeEventHandler("onClientRender", root, renderGTAVLoading)
	end
end

