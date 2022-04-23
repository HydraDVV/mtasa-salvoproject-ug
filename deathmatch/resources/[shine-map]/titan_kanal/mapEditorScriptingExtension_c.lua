--Winchester Scripting.
function requestLODsClient()
	triggerServerEvent("requestLODsClient", resourceRoot)
	
	for i = 2, 4 do
    setInteriorFurnitureEnabled(i, false)
end
end
addEventHandler("onClientResourceStart", resourceRoot, requestLODsClient)

function setLODsClient(lodTbl)
	for i, model in ipairs(lodTbl) do
		engineSetModelLODDistance(model, 300)
	end
end
addEvent("setLODsClient", true)
addEventHandler("setLODsClient", resourceRoot, setLODsClient)

function applyBreakableState()
	for k, obj in pairs(getElementsByType("object", resourceRoot)) do
		local breakable = getElementData(obj, "breakable")
		if breakable then
			setObjectBreakable(obj, breakable == "true")
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, applyBreakableState)

function thaResourceStarting( )
-- water = createWater ( southWest_X, southWest_Y, height, southEast_X, southEast_Y, height, northWest_X, northWest_Y, height, northEast_X, northEast_Y, height )
    water = createWater ( 1353, -1648, 9, 1416, -1648, 9, 1353, -1250, 9, 1416, -1250, 9 )
    water = createWater ( 1351, -1845, 9, 1387, -1845, 9, 1351, -1648, 9, 1387, -1648, 9 )
	water = createWater ( 1387, -1724, 9, 1415, -1724, 7, 1387, -1700, 9, 1415, -1700, 7 )
    water = createWater ( 1415, -1743, 7, 1497, -1743, 7, 1415, -1708, 7, 1497, -1708, 7 )
	water = createWater ( 1497, -1762, 7, 1582, -1762, 5, 1497, -1727, 7, 1582, -1727, 5 )
	water = createWater ( 1582, -1806, 5, 1760, -1806, 5, 1582, -1744, 5, 1760, -1744, 5 )
	water = createWater ( 1612, -1744, 5, 1628, -1744, 5, 1612, -1691, 5, 1628, -1691, 5 )
	water = createWater ( 1628, -1857, 5, 1987, -1857, 5, 1628, -1787, 5, 1987, -1787, 5 )
	water = createWater ( 1960, -1889, 9.2665, 1987, -1889, 9.2665, 1960, -1857, 5, 1987, -1857, 5 )
	water = createWater ( 1987, -1888, 9, 2014, -1888, 9, 1987, -1862, 5.533, 2014, -1862, 5.533 )
	water = createWater ( 1986, -1900, 8.6, 2026, -1900, 8.6, 1986, -1888, 9, 2026, -1888, 9 )
	water = createWater ( 1997, -2014, 8.6, 2138, -2014, 8.6, 1997, -1900, 8.6, 2138, -1900, 8.6 )
	water = createWater ( 2114, -2118, 8.6, 2238, -2118, 8.6, 2114, -2014, 8.6, 2238, -2014, 8.6 )
	water = createWater ( 2212, -2194, 6.5, 2334, -2194, 6.5, 2212, -2118, 8.6, 2334, -2118, 8.6 )
	water = createWater ( 2280, -2284, 5.1, 2409, -2284, 5.1, 2280, -2194, 6.5, 2409, -2194, 6.5 )
	water = createWater ( 2371, -2302, 5.1, 2390, -2302, 5.1, 2371, -2284, 5.1, 2390, -2284, 5.1 )
	water = createWater ( 1987, -1861, 5, 2168, -1861, 5, 1987, -1834, 5, 2168, -1834, 5 )
	water = createWater ( 2168, -1870, 5, 2236, -1870, 2, 2168, -1836, 5, 2236, -1836, 2 )
	water = createWater ( 2236, -1879, 2, 2358, -1879, 3, 2236, -1822, 2, 2358, -1822, 3 )
	water = createWater ( 2358, -1879, 3, 2493, -1879, 3, 2358, -1822, 3, 2493, -1822, 3 )
	water = createWater ( 2493, -1879, 3, 2535, -1879, 4, 2493, -1822, 3, 2535, -1822, 4 ) --stūris
	water = createWater ( 2535, -1879, 4, 2549, -1879, 5, 2535, -1822, 4, 2549, -1822, 5 ) --stur2
	water = createWater ( 2573, -1506, 16, 2628, -1506, 16, 2573, -1454, 16, 2628, -1454, 16 )
	water = createWater ( 2628, -1499, 16, 2645, -1499, 15, 2628, -1434, 16, 2645, -1434, 15 ) --caurums
	water = createWater ( 2547, -1529, 14.5, 2626, -1529, 14.5, 2547, -1506, 16, 2626, -1506, 16 )
	water = createWater ( 2547, -1581, 7, 2626, -1581, 7, 2547, -1529, 14.5, 2626, -1529, 14.5 )
	water = createWater ( 2547, -1635, 5, 2626, -1635, 5, 2547, -1581, 7, 2626, -1581, 7 )
	water = createWater ( 2549, -1906, 5, 2626, -1906, 5, 2549, -1635, 5, 2626, -1635, 5 )
	water = createWater ( 2540, -1921, 4.3, 2626, -1921, 4.3, 2540, -1906, 5, 2626, -1906, 5 ) --Tilta sākums
	water = createWater ( 2540, -2248, 0, 2626, -2248, 0, 2540, -2138, 1, 2626, -2138, 1 ) --d
	water = createWater ( 2530, -2065, 5, 2626, -2065, 5, 2530, -1955, 5, 2626, -1955, 5 )
	water = createWater ( 2530, -2138, 1, 2626, -2138, 1, 2530, -2065, 5, 2626, -2065, 5 )
	water = createWater ( 2530, -1955, 5, 2626, -1955, 5, 2530, -1942, 4.3, 2626, -1942, 4.3 )
	water = createWater ( 2530, -1942, 4.3, 2626, -1942, 4.3, 2530, -1921, 4.3, 2626, -1921, 4.3 )
	
	

end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), thaResourceStarting)

--Winchester Scripting.