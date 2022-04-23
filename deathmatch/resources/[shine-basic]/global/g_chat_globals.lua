function getNearbyElements(root, type, distance)
	local x, y, z = getElementPosition(root)
	local elements = {}
	
	if getElementType(root) == "player" and exports['freecam']:isPlayerFreecamEnabled(root) then return elements end
	
	for index, nearbyElement in ipairs(getElementsByType(type)) do
		if isElement(nearbyElement) and getDistanceBetweenPoints3D(x, y, z, getElementPosition(nearbyElement)) < ( distance or 20 ) then
			if getElementDimension(root) == getElementDimension(nearbyElement) then
				table.insert( elements, nearbyElement )
			end
		end
	end
	return elements
end

local gpn = getPlayerName
function getPlayerName(p)
	local name = getElementData(p, "fakename") or gpn(p) or getElementData(p, "name")
	return string.gsub(name, "_", " ")
end