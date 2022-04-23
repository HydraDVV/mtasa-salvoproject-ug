wPedRightClick = nil
bTalkToPed, bClosePedMenu = nil
ax, ay = nil
closing = nil
sent=false

function pedDamage()
	cancelEvent()
end
addEventHandler("onClientPedDamage", getRootElement(), pedDamage)

function clickPed(button, state, absX, absY, wx, wy, wz, element)
	if getElementData(getLocalPlayer(), "exclusiveGUI") then
		return
	end
	if (element) and (getElementType(element)=="object") and (button=="right") and (state=="down") and (sent==false) and (element~=getLocalPlayer()) then
		local gatekeeper = getElementData(element, "type")
		local sahip = getElementData(element, "author") or ""
		if (gatekeeper == "marijuana") then
			--if sahip == getPlayerName(getLocalPlayer()) then
				local x, y, z = getElementPosition(getLocalPlayer())		
				if (getDistanceBetweenPoints3D(x, y, z, wx, wy, wz)<=3) then
					exports["rightclick"]:create("Sahip: "..sahip)
					local row = exports["rightclick"]:addRow("Topla")
					addEventHandler("onClientGUIClick", row,  function (button, state)
							triggerServerEvent ( "saksi:Check", getLocalPlayer(), element)
						end, true)
				end
			--else
			--	outputChatBox("#A63A3A[!] #ffffffBu saksıdan sadece sahibi hasat toplayabilir.",255,255,255, true)
			--end
		end
	end
end
addEventHandler("onClientClick", getRootElement(), clickPed, true)
local otlar = { }
function showInformationText()
	local saksi_mik = 0
	local x,y,z = 0,0,0
	local cx,cy,cz = 0,0,0
	local saksi_yazi = ""
	local objeTip = ""
	local px,py,pz = 0,0,0
	for index, saksi in ipairs( getElementsByType("object", resourceRoot) ) do
		if isElement(saksi) then
			x,y,z = getElementPosition(saksi)			
			cx,cy,cz = getCameraMatrix()
			objeTip = getElementData(saksi, "tip")
			if objeTip == "saksi" then
				if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 10 then
					px,py,pz = getScreenFromWorldPosition(x,y,z+0.5,0.05)
					if px then
						saksi_yazi = getElementData(saksi, "text")
						dxDrawFramedText(" "..saksi_yazi, px, py, px, py, tocolor(255, 225, 255, 255), 1.2, "default-bold", "center", "center", true, true)
						-- destroyElement(otlar[index])
						-- otlar[index] = createObject ( 728, x, y, z+0.1, 0, 0, 0 )
						-- setObjectScale(otlar[index], getElementData(saksi, "hasat")/100*0.2)
					end
				end
			end
		else
			-- destroyElement(otlar[index])
		end
	end
end
setTimer(showInformationText, 0,0)
-- addEventHandler("onClientRender", getRootElement(), showInformationText)

local x, y, z =  1424.115234375, -1319.2080078125, 13.5546875 
createPickup(x, y, z, 3, 1279, 0)
createMarker ( x, y, z-1, "cylinder", 1.5, 255, 50, 50, 50 )
createBlip( x, y, z, 16, 0, 0, 0, 255 )
function tohum_render()
	local cx,cy,cz = getCameraMatrix()
	if getDistanceBetweenPoints3D(cx, cy, cz,x, y, z) <= 30 then
		local px,py,pz = getScreenFromWorldPosition(x, y, z+0.5,0.05)
		if px then
			dxDrawFramedText("Marijuana tohumu almak için '/tohumal' komutunu kullanın.", px, py, px, py, tocolor(255, 225, 50, 255), 1.2, "default-bold", "center", "center", true, true)
		end
	end
end
setTimer(tohum_render, 0,0)
-- addEventHandler("onClientRender", getRootElement(), tohum_render)

local tohum_pos = createColSphere ( x, y, z, 5)
local tohum_fiyat = 20000
function tohum_al(cmd)
    if (isElementWithinColShape(localPlayer, tohum_pos)) then
	    if getElementData(localPlayer, "karakter_tip") == 2 then outputChatBox("#cc0000[!]#ffffff Bu sistemden sadece illegal kişiler yararlanabilir.", 255, 0, 0, true ) return end
		local oyuncuBirlik = getPlayerTeam(localPlayer)
		local onay = getElementData (oyuncuBirlik, "onay") or 0
		if onay == 1 then
			outputChatBox("#cc0000[!]#ffffff Bu sistemi sadece onaylı birlikler kullanabilir.", 255, 0, 0, true )
			return
		end
		if not exports.global:hasMoney(localPlayer, tohum_fiyat) then outputChatBox("#cc0000[!]#ffffff Marijuana tohumu satın almak için "..tohum_fiyat.." TL'ye ihtiyacın var.", 255, 0, 0, true ) return end
		if tonumber(getElementData(localPlayer, "level")) < 1 then outputChatBox("#cc0000[!]#ffffff Bu sistemi kullanabilmek için 3. seviye ve üstü olmanız gerekmektedir.", 255, 0, 0, true ) return end
		triggerServerEvent("tohum:satinal", localPlayer, localPlayer, tohum_fiyat)
	else	
	    outputChatBox("#cc0000[!]#ffffff Burada marijuana tohumu satılmıyor.", 255, 0, 0, true )
	end
end
addCommandHandler("tohumal", tohum_al)

function dxDrawFramedText ( message , left , top , width , height , color , scale , font , alignX , alignY , clip , wordBreak , postGUI , colorCoded , subPixel )
    dxDrawText ( message , left + 1 , top + 1.2 , width + 1 , height + 1 , tocolor ( 0 , 0 , 0 , 255 ) , scale , font , alignX , alignY , clip , wordBreak , postGUI, true )
    dxDrawText ( message , left + 1 , top - 1.5 , width + 1 , height - 1 , tocolor ( 0 , 0 , 0 , 255 ) , scale , font , alignX , alignY , clip , wordBreak , postGUI, true )
    dxDrawText ( message , left - 1 , top + 1.2 , width - 1 , height + 1 , tocolor ( 0 , 0 , 0 , 255 ) , scale , font , alignX , alignY , clip , wordBreak , postGUI, true )
    dxDrawText ( message , left - 1 , top - 1.2 , width - 1 , height - 1 , tocolor ( 0 , 0 , 0 , 255 ) , scale , font , alignX , alignY , clip , wordBreak , postGUI, true)
    dxDrawText ( message , left , top, width, height, color , scale , font , alignX , alignY , clip , wordBreak , postGUI, true)
end