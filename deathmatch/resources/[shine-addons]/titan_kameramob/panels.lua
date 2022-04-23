local bolge = createColSphere(1579.8662109375, -1635.640625, 13.560392379761,5)


function _mobeseler(thePlayer)
if not isElementWithinColShape(thePlayer,bolge) then outputChatBox("[!]#FFFFFF Kamera'yı açmak için gerekli bölgede değilsin.",thePlayer,255,0,0,true) return end
if getElementData(thePlayer, "faction") == 1 then
	triggerClientEvent(thePlayer, "kamera:izle", thePlayer)
end	
end
addCommandHandler("kamera", _mobeseler)

function mobese_izle(ID,x,y,z,rot)
	
	x1 = x + ( ( math.cos ( math.rad ( rot+90 ) ) ) * 5 )
	y1 = y + ( ( math.sin ( math.rad ( rot+90 ) ) ) * 5 )
	setCameraMatrix(source,x, y, z+6,x1, y1, z+6)
end
addEvent("mobese:izle", true)
addEventHandler("mobese:izle", root, mobese_izle)
