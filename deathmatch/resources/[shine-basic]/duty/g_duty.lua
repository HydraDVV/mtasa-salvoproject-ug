function createDutyColShape(posX, posY, posZ, size, interior, dimension) 
	tempShape = createColSphere(posX, posY, posZ, size)
	--exports.pool:allocateElement(tempShape)
	setElementDimension(tempShape, dimension)
	setElementInterior(tempShape, interior)
	return tempShape
end
-------- x: y: z:                                    X               Y             Z       ColSize        INT        Dim
local policeColShapes = { }

table.insert(policeColShapes, createDutyColShape(266.759765625, 118.5283203125, 1004.6171875, 10, 3) ) -- PD Pershing square

local swatVehicles = { [427] = true }
	
local spdColShapes = { }
table.insert(spdColShapes, createDutyColShape( 265.21484375, 116.681640625, 1004.6171875, 10, 10, 655) ) -- Los Santos Army Duty Room.  

local police1ColShapes = { }
table.insert(police1ColShapes, createDutyColShape( 263.1337890625, 1246.302734375, 1084.2578125, 10, 9, 956) ) -- Los Santos Militan

local lsesColShapes = { }
table.insert(lsesColShapes, createDutyColShape( 1579.4919433594, 1789.6885986328, 2083.376953125, 10, 4, 0) ) -- EMS County general room

local lsfdColShapes = { }
table.insert(lsfdColShapes, createDutyColShape( 359.6083984375, 207.12109375, 1008.3828125, 6,  3, 2) ) -- LSFD duty room

local lagmColShapes = { }
table.insert(lagmColShapes, createDutyColShape(1809.576171875, -2455.4716796875, 13.5546875, 231, 3, 332) ) -- Lucca

local hexColShapes = { }				
table.insert(hexColShapes, createDutyColShape(256.609375, -41.6103515625, 1002.0234375, 15, 14, 26) ) -- Hex weapon room

local tollsColShapes = { }				
table.insert(tollsColShapes, createDutyColShape(273.5068359375, 119.392578125, 1004.6171875, 5, 10, 187) ) -- Tolls weapon room

local sanColShapes = { }				
table.insert(sanColShapes, createDutyColShape( 2143.4892578125, -1423.267578125, 293.73748779297, 2, 933, 750) ) -- San

local zbtColShapes = { }				
table.insert(zbtColShapes, createDutyColShape(254.169921875, 77.0224609375, 1003.640625, 10, 6, 969) ) -- San

local groveColShapes = { }				
table.insert(groveColShapes, createDutyColShape(256.40247, -41.49548, 1002.02344, 100, 0, 0) ) -- Grove weapon room

local lsctColShapes = { }				
table.insert(lsctColShapes, createDutyColShape(256.609375, -41.6103515625, 1002.0234375, 100, 14, 26) ) -- LSCT Duty

factionDuty = {
	{ 
		factionID = 1,
		
		packages = {
			{
				packageName = 'İstanbul - Polis Memuru',
				grantID = 1,
				forceSkinChange = true,
				skins = { 211, 265, 266, 280, 281, 284},
				colShape = policeColShapes,
				items =	{
					{ -3, 1, false }, -- Nitestick
					{ -24, 50, false }, -- MPW/Deagle
					{ 45, 1, false }, -- Handcuffs
					{ -100, 100, false }, -- Kevlar
				}
			}, 
			
						{
				packageName = 'İstanbul - Polis Memuru + 2',
				grantID = 79,
				forceSkinChange = true,
				skins = { 211, 265, 266, 280, 281, 284},
				colShape = policeColShapes,
				items =	{
					{ -3, 1, false }, -- Nitestick
		           	{ -29, 100, false }, -- MP5
					{ -24, 50, false }, -- MPW/Deagle
					{ 45, 1, false }, -- Handcuffs
					{ -100, 100, false }, -- Kevlar
				}
			}, 
			
			{
				packageName = 'İstanbul - Özel Harakat',
				grantID = 2,
				forceSkinChange = true,
				skins = { 285 },
				colShape = policeColShapes,
				vehicle = swatVehicles,
				items =	{
					{ -24, 50, false }, -- MPW/Deagle
					{ -27, 20, 1 }, -- Shotgun
					{ -29, 100, false }, -- MP5
					{ -31, 200, 1 }, -- M4
					{ -34, 10, false }, -- Sniper
					{ -17, 1, 2 }, -- Tear Gas
					{ -100, 100, false }, -- Kevlar
					{ 26, 1, false }, -- Gas Mask
					{ 27, 1, 2 }, -- Flashbang
					{ 113, 5, false }, -- Pack of glowsticks
					{ 45, 1, false } -- Handcuffs
				}
			}, 
			
					
			    {
				packageName = 'İstanbul - Sivil Polis',
				grantID = 84,
				forceSkinChange = true,
				skins = { 30 },
				colShape = policeColShapes,
				vehicle = swatVehicles,
				items =	{
			        { -23, 300, false }, -- Colt-45
					{ 45, 1, false } -- Handcuffs
				}
			},
                
				{
				packageName = 'Hex - Mechanic',
				grantID = 12,
				forceSkinChange = true,
				colShape = policeColShapes,
				skins = { 50, 305, 211 },
				items =	{
					{ -41, 1500, false }, -- Spraycan/Pepperspray
					{ 26, 1, false }, -- Gas mask
					{ 70, 2, false } -- First Aid Kit
				}
			},	
			
			    {
				packageName = 'İstanbul - Trafik Şube',
				grantID = 3,
				forceSkinChange = true,
	            skins = { 280 },
				colShape = policeColShapes,
				items =	{
					{ -24, 50, false }, -- MPW/Deagle
					{ -43, 250, false }, -- Digital camera
					{ 45, 1, false }, -- Handcuffs
					{ 71, 50, false } -- Notepad
				}
			}, 	
				
			{
				packageName = 'İstanbul - Stajer',
				grantID = 4,
				forceSkinChange = true,
				skins = { 71, 211 },
				colShape = policeColShapes,
				items =	{
					{ -3, 50, false }, -- Nightstick
					{ -24, 35, false }, -- MPW/Deagle
					{ -41, 1200, false }, -- Pepperspray
					{ 45, 1, false }, -- Handcuffs
					{ 45, 1, false } -- Handcuffs
				}
			} 
		}
	},
	{ 
		factionID = 2,
		
		packages = {
			{
				packageName = 'İBB - Acil',
				grantID = 8,
				forceSkinChange = true,
				skins = { 274, 275, 276, 211, 70 },
				colShape = lsesColShapes,
				items =	{
					{ -41, 1500, false }, -- Spraycan/Pepperspray
					{ 70, 5, false }, -- First Aid Kit
					{ -3, 50, false } -- First Aid Kit
				}
			}, 
		}
	},
	{ 
		factionID = 3,
		
		packages = {
			{
				packageName = 'Belediye - Güvenlik',
				grantID = 15,
				forceSkinChange = true,
				skins = { 163, 164, 165, 211},
				colShape = lsfdColShapes,
				items =	{
					{ -24, 35, false }, -- MPW/Deagle
					{ 71, 25, false }, -- Notepad
					{ -41, 1500, false }, -- Spraycan/Pepperspray
				}
			},
			{
				packageName = 'Belediye - Memur',
				grantID = 16,
				forceSkinChange = false,
				colShape = lsfdColShapes,
				items =	{
				 { 71, 25, false }, -- Notepad
				}
			}, 	
		}
	},
	{ 
		factionID = 4,
		
		packages = {
			{
				packageName = 'TSK - ER/UzmanER',
				grantID = 1,
				forceSkinChange = true,
				skins = { 287 },
				colShape = lagmColShapes,
				items =	{
					{ -3, 1, false }, -- Nitestick
					{ -24, 50, false }, -- MPW/Deagle
					{ 45, 1, false }, -- Handcuffs
					{ 26, 1, false }, -- Gas Mask
					{ 27, 1, 2 }, -- Flashbang
					{ 113, 5, false }, -- Pack of glowsticks
				}
			}, 
			
						{
				packageName = 'TSK - Uzman Çavuş',
				grantID = 79,
				forceSkinChange = true,
				skins = { 287 },
				colShape = lagmColShapes,
				items =	{
		           	{ -29, 100, false }, -- MP5
					{ -24, 50, false }, -- MPW/Deagle
					{ 26, 1, false }, -- Gas Mask
					{ 27, 1, 2 }, -- Flashbang
					{ 113, 5, false }, -- Pack of glowsticks
					{ 45, 1, false }, -- Handcuffs
				}
			}, 
			
			{
				packageName = 'TSK - Astsubay/Üstsubay',
				grantID = 2,
				forceSkinChange = true,
				skins = { 285 },
				colShape = lagmColShapes,
				vehicle = swatVehicles,
				items =	{
					{ -23, 50, false }, -- Silenced
					{ -31, 200, 1 }, -- M4
					{ -100, 100, false }, -- Kevlar
					{ 26, 1, false }, -- Gas Mask
					{ 27, 1, 2 }, -- Flashbang
					{ 113, 5, false }, -- Pack of glowsticks
					{ 45, 1, false } -- Handcuffs
				}
			}, 
			
					
			{
				packageName = 'TSK - Özel Harekat',
				grantID = 84,
				forceSkinChange = true,
				skins = { 287 },
				colShape = lagmColShapes,
				vehicle = swatVehicles,
				items =	{
			     	{ -24, 50, false }, -- MPW/Deagle
					{ -31, 200, 1 }, -- M4
					{ 45, 1, false }, -- Handcuffs
					{ -100, 100, false }, -- Kevlar
					{ 26, 1, false }, -- Gas Mask
					{ 27, 1, 2 }, -- Flashbang
					{ 113, 5, false }, -- Pack of glowsticks
				}
			}, 
				
			{
				packageName = 'KULLANMAYIN',
				grantID = 4,
				forceSkinChange = true,
				skins = { 287},
				colShape = lagmColShapes,
				items =	{
					{ -3, 50, false }, -- Nightstick

				}
			} 
		}
	},
	{ 
		factionID = 4,
		
		packages = {
			{
				packageName = 'Er',
				grantID = 10,
				forceSkinChange = false,
				skins = { 287 },
				colShape = groveColShapes,
				items =	{
					{ -24, 50, false }, -- MPW/Deagle
					{ 45, 1, false }, -- Handcuffs

				}
			}, 
		}
	},
	{ 
		factionID = 6,
		
		packages = {
			{
				packageName = 'Rank- 1',
				grantID = 10,
				forceSkinChange = true,
				skins = { 69, 7, 240 },
				colShape = sanColShapes,
				items =	{
					--{ -22, 120, 1 }, -- Notes
					{ -41, 1500, 1 }, -- Photo
				}
			},
			{
				packageName = 'Rank- Editor',
				grantID = 92,
				forceSkinChange = false,
				skins = { 29, 187, 228 },
				colShape = sanColShapes,
				items =	{
					--{ -22, 120, 1 }, -- Notes
					{ -41, 1500, 1 }, -- Photo
				}
			}
		}
	},
	{ 
		factionID = 110,
		
		packages = {
			{
				packageName = 'Askeriye - Er ve üzeri',
				grantID = 5,
				forceSkinChange = true,
				skins = { 287, 285, 191, 179, 73 },
				colShape = spdColShapes,
				items =	{
				    { -22, 100, false }, -- Colt-45
					{ -25, 100, false }, -- Shotgun
					{ -29, 120, false }, -- MP5
					{ -41, 1500, false }, -- Spraycan/Pepperspray
					{ 45, 1, false }, -- Handcuffs
					{ 45, 1, 1 }, -- Handcuffs
					{ -100, 100, false }, -- Kevlar
					{ 53, 1, 1 } -- Breathalizer
				}
			}, 
			
			
			{
				packageName = 'Askeriye - Sniper',
				grantID = 6,
				forceSkinChange = false,
				colShape = spdColShapes,
				skins = { 287, 285, 191, 179, 73 },
				items =	{
					{ -23, 100, 1 }, -- Silenced 9mm
					{ -34, 50, false }, -- Sniper
					{ -43, 250, false }, -- Digital camera
					{ 45, 1, false }, -- Handcuffs
					{ 71, 50, false }, -- Notepad
					{ 113, 5, false }, -- Pack of glowsticks
					{ -17, 1, 1 }, -- Tear Gas
					{ 26, 1, false }, -- Gas Mask
				}
			}, 		
				
			{
				packageName = 'Askeriye - Özel Harekat ',
				grantID = 7,
				forceSkinChange = true,
				skins = { 287, 285, 191, 179, 73 },
				colShape = spdColShapes,
				items =	{
					{ -24, 35, false }, -- MPW/Deagle
					{ -29, 120, 3 }, -- MP5
					{ -31, 150, 3 }, -- M4
					{ -17, 1, 1 }, -- Tear Gas
					{ 45, 1, false }, -- Handcuffs
					{ 27, 1, 1 }, -- Flashbang
					{ 27, 1, 2 }, -- Flashbang
					{ 26, 1, false }, -- Gas Mask
					{ -46, 1, false }, -- Parasute
				}
			}, 
			
			{
				packageName = 'Askeriye - Pilot',
				grantID = 11,
				forceSkinChange = true,
				skins = { 287, 285, 191, 179, 73 },
				colShape = spdColShapes,
				items =	{
					{ -22, 50, 1 }, -- Colt-45
					{ 45, 1, false }, -- Handcuffs
					{ -41, 1500, false }, -- Spraycan/Pepperspray
					{ 26, 1, false }, -- Gas Mask
					{ -46, 1, false }, -- Parasute
				}
			} 
		}
	},
		{ 
		factionID = 149,
		
		packages = {
			{
				packageName = 'TLS - Normal Duty',
				grantID = 10,
				forceSkinChange = false,
				skins = { 71 },
				colShape = tollsColShapes,
				items =	{
					{ -100, 49, false }, -- 49% Armour
					{ 45, 1, false }, -- Handcuffs
					{ -24, 50, false }, -- MPW/Deagle
				}
			},
			{
				packageName = 'TLS - Force',
				grantID = 13,
				forceSkinChange = true,
				skins = { 286 },
				colShape = tollsColShapes,
				items =	{
					{ -100, 49, false }, -- 49% Armour
					{ 45, 1, false }, -- Handcuffs
					{ -24, 50, false }, -- MPW/Deagle
					{ -29, 100, false }, -- MP5
				}
			},	
			{
				packageName = 'TLS - Security',
				grantID = 14,
				forceSkinChange = true,
				skins = { 71 },
				colShape = tollsColShapes,
				items =	{
					{ -100, 49, false }, -- 49% Armour
					{ 45, 1, false }, -- Handcuffs
					{ -24, 50, false }, -- MPW/Deagle
					{ -41, 1500, false }, -- Spraycan/Pepperspray
				}
			}				
		}
	},
	{ 
		factionID = 200,
		
		packages = {
			{
				packageName = 'Militann',
				grantID = 2,
				forceSkinChange = true,
				skins = { 264 },
				colShape = police1ColShapes,
				items =	{
					{ -30, 150, 3 }, -- M4
					{ 45, 1, false }, -- Handcuffs
					{ 27, 1, 2 }, -- Flashbang
					{ 26, 1, false }, -- Gas Mask
					{ -100, 100, false }, -- 100% Armour
					{ 45, 1, 1 }, -- Handcuffs
					{ 53, 1, 1 } -- Breathalizer
				}
			} 
		}
	}
}

-- -------------------------- --
-- General checking functions --
-- -------------------------- --

function isPlayerInFaction(targetPlayer, factionID)
	return tonumber( getElementData(targetPlayer, "faction") ) == factionID
end

function fetchAvailablePackages( targetPlayer )
	local availablePackages = { }
	
	for index, factionTable in ipairs ( factionDuty ) do	-- Loop all the factions
		if isPlayerInFaction(targetPlayer, factionTable["factionID"]) then
			for index, factionPackage in ipairs ( factionTable["packages"] ) do -- Loop all the faction packages
				local found = false
				for index, packageColShape in ipairs ( factionPackage["colShape"] ) do -- Loop all the colshapes of the factionpackage
					if isElementWithinColShape( targetPlayer, packageColShape ) then
						found = true
						break  -- We found this package already, no need to search the other colshapes
					end
				end
				
				if factionPackage.vehicle and getPedOccupiedVehicle( targetPlayer ) and factionPackage.vehicle[ getElementModel( getPedOccupiedVehicle( targetPlayer ) ) ] then
					found = true
				end
				
				if found and canPlayerUseDutyPackage(targetPlayer, factionPackage) then
					table.insert(availablePackages, factionPackage)
				end
			end
		end
	end
	
	return availablePackages
end

function fetchAllPackages( )
	local availablePackages = { }
	
	for index, factionTable in ipairs ( factionDuty ) do	-- Loop all the factions
		table.insert(availablePackages, factionPackage)
	end
	
	return availablePackages
end

function canPlayerUseDutyPackage(targetPlayer, factionPackage)
	local playerPackagePermission = getElementData(targetPlayer, "factionPackages")
	if playerPackagePermission then
		for index, permissionID in ipairs(playerPackagePermission) do
			if (permissionID == factionPackage["grantID"]) then
				return true
			end
		end
	end
	return false
end

function getFactionPackages( factionID )
	if not factionID or not tonumber( factionID ) then
		return factionDuty
	end
	
	for index, factionTable in ipairs ( factionDuty ) do	-- Loop all the factions
		if tonumber(factionTable["factionID"]) == tonumber( factionID ) then
			return factionTable["packages"]
		end
	end
	
	return {}	
end

addEvent("onPlayerDuty", true)