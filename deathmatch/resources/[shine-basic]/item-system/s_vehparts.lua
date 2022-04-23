--[[ 

Parts Types:

1. Shocks/Springs
2. Drivetrain
3. Braking Setup
4. Tyres
5. Exhaust System
6. Headers
7. Induction System
8. Fuel System
9. Camshafts
10. Pistons
11. Crankshaft
12. Transmission

]]
--[[
vehParts = { 
  --[0] = { "Parts Name", partsType, IGNORETHIS},
	[1] = { "RWD Drivetrain Setup", 2, "rwd" }, 
	[2] = { "AWD Drivetrain Setup", 2, "awd" }, 
	[3] = { "FWD Drivetrain Setup", 2, "fwd" }, 
} 

function vehTuning(thePlayer)
	for _, items in ipairs(getItems(source)) do 
		if (items[1] == 151) then
				local itemValue = items[2]
				local vehPart = vehParts[itemValue]
				local partName = vehPart[1]
				local partType = vehPart[2]
				local partValue = vehPart[3]
				
				handlingTable = getVehicleHandling(source)
				
				if partType == 1 then
					local lowerLimit = handlingTable["suspensionLowerLimit"]
					setVehicleHandling(source, "suspensionLowerLimit", lowerLimit + vehPart[3])
					
				end
				if partType == 2 then
					setVehicleHandling(source, "driveType", vehPart[3])
					
				end
				if partType == 3 then
					setVehicleHandling(source, "brakeDeceleration", vehPart[3])
					
				end
				if partType == 4 then
					setVehicleHandling(source, "tractionMultiplier", vehPart[3])
					
				end
				if partType == 5 then
					setVehicleHandling(source, "maxVelocity", vehPart[3])
					
				end
				if partType == 6 then
					setVehicleHandling(source, "maxVelocity", vehPart[3])
					
				end
				if partType == 7 then
					setVehicleHandling(source, "engineAcceleration", vehPart[3])
					
				end
				if partType == 8 then
					setVehicleHandling(source, "maxVelocity", vehPart[3])
					
				end
				if partType == 9 then
					setVehicleHandling(source, "engineAcceleration", vehPart[3])
					
				end
				if partType == 10 then
					setVehicleHandling(source, "maxVelocity", vehPart[3])
					
				end
				if partType == 11 then
					setVehicleHandling(source, "maxVelocity", vehPart[3])
					
				end
				if partType == 12 then
					setVehicleHandling(source, "engineAcceleration", vehPart[3])
					
				end
		end
	end
end
addEventHandler("onVehicleEnter", getRootElement(), vehTuning)]]







--[[ 

Parts Types:

1. Shocks/Springs
2. Drivetrain
3. Braking Setup
4. Tyres
5. Exhaust System
6. Headers
7. Induction System
8. Fuel System
9. Camshafts
10. Pistons
11. Crankshaft
12. Transmission

]]

--[[vehParts = { 
  --[0] = { "Parts Name", partsType, IGNORETHIS},
 [1] = { "RWD Drivetrain Setup", 2, "rwd" }, 
 [2] = { "AWD Drivetrain Setup", 2, "awd" }, 
 [3] = { "FWD Drivetrain Setup", 2, "fwd" }, 
 [4] = { "Stiff Shocks/Springs Setup", 1, "-" }, 
 [5] = { "Moderate Shocks/Springs Setup", 1, "-" }, 
 [6] = { "Soft Shocks/Springs Setup ", 1, "-" }, 
 [7] = { "Premium Racing Disc Brakes", 3, "-" },
 [8] = { "Average Disc Brakes", 3, "-" },
 [9] = { "Low Quality Drum Brakes", 3, "-" },
 [10] = { "Oversized Off Roading Tires", 4, "-" },
 [11] = { "Racing Grade Road Tires", 4, "-" },
 [12] = { "Flat-Tread Drag Racing Tires", 4, "-" },
 [13] = { "Average Street Tires", 4, "-" },
 [14] = { "Premium Drifting Tires", 4, "-" },
 [15] = { "3 Inch Straight Pipe Exhaust", 5, "-" },
 [16] = { "2 Inch Cat Back Exhaust", 5, "-" },
 [17] = { "Standard Muffler Exhaust", 5, "-" },
 [18] = { "Loud Open Headers Setup", 6, "-" },
 [19] = { "Standard Headers Setup", 6, "-" },
 [20] = { "Cold Air Intake Setup", 7, "-" },
 [21] = { "Cold Air Intake with Welded on Single Turbo", 7, "-" },
 [22] = { "Cold Air Intake with Welded on Dual Turbo", 7, "-" },
 [23] = { "Stock Plastic Intake Setup", 7, "-" },
 [24] = { "Fuel Injected Setup", 8, "-" },
 [25] = { "Carburated with Overhead Air filter Setup", 8, "-" },
 [26] = { "Single Over Head Cam Setup", 9, "-" },
 [27] = { "Dual Over Head Cam Setup", 9, "-" },
 [28] = { "Quad Over Head Cam Setup", 9, "-" },
 [29] = { "Stock Pressurized Pistons", 10, "-" },
 [30] = { "Moderately Pressurized Pistons (80PSI)", 10, "-" },
 [31] = { "Reinforced Crankshaft Setup", 11, "-" },
 [32] = { "Stock Crankshaft Setup", 11, "-" },
 [33] = { "6 Speed Automatic Transmission", 12, "-" },
 [34] = { "5 Speed Automatic Transmission", 12, "-" },
 [35] = { "4 Speed Manual Transmission", 12, "-" },
 [36] = { "5 Speed Manual Transmission", 12, "-" },
 [37] = { "6 Speed Manual Transmission", 12, "-" },]]