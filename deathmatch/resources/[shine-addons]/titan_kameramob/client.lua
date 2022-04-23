function mobeseObj(mobese)
    local txd = engineLoadTXD ('assets/mobese.txd')
    engineImportTXD(txd,893)
    local dff = engineLoadDFF('assets/mobese.dff',893)
    engineReplaceModel(dff,893)
end
addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()),mobeseObj)

local mobeseler = { }
function showNearbyInformationIconsInformation()
	for index, informationicon in ipairs( getElementsByType("object", resourceRoot) ) do
			mobeseler[index] = informationicon
	end
	showInformationText()
end
addEventHandler("onClientRender", getRootElement(), showNearbyInformationIconsInformation)

function showInformationText()
	for i = 1, #mobeseler, 1 do
	if isElement(mobeseler[i]) then
    	local x,y,z = getElementPosition(mobeseler[i])			
        local cx,cy,cz = getCameraMatrix()
		local objeTip = getElementData(mobeseler[i], "tip")
		if objeTip == "mobese" then
			if getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 10 then
				local px,py,pz = getScreenFromWorldPosition(x,y,z+5,0.05)
				if px then
					local mobeseID = getElementData(mobeseler[i], "id")
				    dxDrawFramedText(mobeseID, px, py, px, py, tocolor(255, 225, 255, 255), 1, "default-bold", "center", "center", false, false)
				end
			end
		end
	end
	end
end
addEventHandler("onResourceStart", getRootElement(), showInformationText)
function dxDrawFramedText ( message , left , top , width , height , color , scale , font , alignX , alignY , clip , wordBreak , postGUI , colorCoded , subPixel )
    dxDrawText ( "Mobese (ID: #".. message ..")" , left + 1 , top + 1.2 , width + 1 , height + 1 , tocolor ( 0 , 0 , 0 , 255 ) , scale , font , alignX , alignY , clip , wordBreak , postGUI )
    dxDrawText ( "Mobese (ID: #".. message ..")" , left + 1 , top - 1.5 , width + 1 , height - 1 , tocolor ( 0 , 0 , 0 , 255 ) , scale , font , alignX , alignY , clip , wordBreak , postGUI )
    dxDrawText ( "Mobese (ID: #".. message ..")" , left - 1 , top + 1.2 , width - 1 , height + 1 , tocolor ( 0 , 0 , 0 , 255 ) , scale , font , alignX , alignY , clip , wordBreak , postGUI )
    dxDrawText ( "Mobese (ID: #".. message ..")", left - 1 , top - 1.2 , width - 1 , height - 1 , tocolor ( 0 , 0 , 0 , 255 ) , scale , font , alignX , alignY , clip , wordBreak , postGUI)
    dxDrawText ( "Mobese (ID: #".. message ..")" , left , top, width, height, tocolor ( 255 , 255 , 0 , 255 ) , scale , font , alignX , alignY , clip , wordBreak , postGUI)
end
local dist = 12
local tik = 0
function ceza_fonk()
	if isPedInVehicle(localPlayer) then
		local px, py, pz = getElementPosition(getLocalPlayer())
		for i = 1, #mobeseler, 1 do
			if isElement(mobeseler[i]) then
				local x,y,z = getElementPosition(mobeseler[i])	
				local rot = getElementData(mobeseler[i], "rot")
				local id = getElementData(mobeseler[i], "id")
				local hizlimit = tonumber(getElementData(mobeseler[i], "hizlimit"))
				local objeTip = getElementData(mobeseler[i], "tip")
				local veh = getPedOccupiedVehicle(localPlayer)
				if objeTip == "mobese" then
					if getDistanceBetweenPoints3D(px, py, pz, x, y, z) <= dist then
						if getElementData(veh, "faction") == 1 or getElementData(veh, "plate") == "_" then
						else
							if getVehicleSpeed() > hizlimit then
								if getVehicleController(getPedOccupiedVehicle(localPlayer)) == getLocalPlayer() then
									if not getElementData(localPlayer, "ceza_durum") then
										setElementData(getLocalPlayer(),"ceza_durum", true)
										triggerServerEvent("paraKesTRAFIK", localPlayer, localPlayer)
										fadeCamera(false, 0.5,255,255,255)
										--createEffect("camflash", x,y,z+6)
										--playSound("assets/ceza_ef.mp3")
										setTimer (function () 
											fadeCamera(true, 0.5)
										end,400,1)
									end
								end
							end
						end	
					end
				end
			end
		end
	end
end
addEventHandler ( "onClientRender", getRootElement(), ceza_fonk )
setTimer(function()
	setElementData(getLocalPlayer(),"ceza_durum", false)
end,10000,0)