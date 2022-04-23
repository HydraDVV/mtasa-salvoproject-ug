function getPositionInFrontOfElement(element, vehicle, action) 
	local matrix = getElementMatrix ( element )
	local offX = 0 * matrix[1][1] + 1.3 * matrix[2][1] + 0 * matrix[3][1] + 1 * matrix[4][1]
	local offY = 0 * matrix[1][2] + 1.3 * matrix[2][2] + 0 * matrix[3][2] + 1 * matrix[4][2]
	local offZ = 0 * matrix[1][3] + 1.3 * matrix[2][3] + 0 * matrix[3][3] + 1 * matrix[4][3]
	triggerServerEvent ( "stretcher:getPositionInFrontOfElement", getLocalPlayer(), element, offX, offY, offZ, vehicle, action ) 
end
addEvent( "stretcher:getPositionInFrontOfElement", true )
addEventHandler( "stretcher:getPositionInFrontOfElement", getRootElement( ), getPositionInFrontOfElement )

silahlar = {
4,
22,
23,
24,
25,
26,
27,
28,
29,
30,
31,
32,
33,
34,
35,
36
}

function yaralanma( Atak, w)
			if getElementData(source,'paintball') then  return end
	for i,v in ipairs(silahlar) do
		if w == v then
			if (getElementData(localPlayer, "yaralanma") or 0) == 0 then
				setElementData(localPlayer, "yaralanma", 1)
				triggerServerEvent('db:yaralanma',getLocalPlayer(),getLocalPlayer())
			end
			break -- quick fix by ozulus
		end
    end
end
addEventHandler("onClientPlayerDamage", getLocalPlayer(), yaralanma)

function OyuncuYaralandi()
	if getElementData(getLocalPlayer(), "yaralanma") == 1 then
		if getElementHealth(getLocalPlayer()) > 25 then
			setElementHealth(getLocalPlayer(), math.floor(getElementHealth(getLocalPlayer()) - math.random(13,18)))
		end
	end
end
setTimer(OyuncuYaralandi, 300000, 0)