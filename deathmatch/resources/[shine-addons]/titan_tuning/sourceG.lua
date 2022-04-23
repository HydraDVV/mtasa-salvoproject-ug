availableTuningMarkers = {
	--X, Y, Z, Vehicle Rotation (Use /markerpos to get perfect position and rotation (The command in sourceC.lua last row))
--	{2631.181640625, -2104.0966796875, 13.546875, 270},-- Sf Garage 
	{2885.794921875, -1905.8359375, 11.115623474121, 182},-- Sf Garage 
	{2893.4091796875, -1905.46875, 11.115623474121,183},-- Sf Garage 
	{2901.2822265625, -1905.0458984375, 11.115623474121, 179},-- Sf Garage 
	{2909.0234375, -1904.599609375, 11.115623474121, 182},-- Sf Garage 
}

tuningMenu = {
	[1] = {
		["categoryName"] = getLocalizedText("menu.performance"),
		["subMenu"] = {
			[1] = {
				["categoryName"] = getLocalizedText("menu.performance.engine"),
				["cameraSettings"] = {"bonnet_dummy", 110, 15, 6, true}, -- component, offsetX, offsetZ, zoom, hide component
				["upgradeData"] = "engine",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"engineAcceleration"}, {"maxVelocity"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 100, ["tuningData"] = {{"engineAcceleration", 2}, {"maxVelocity", 10}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 300, ["tuningData"] = {{"engineAcceleration", 6}, {"maxVelocity", 20}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 600, ["tuningData"] = {{"engineAcceleration", 8}, {"maxVelocity", 30}}}
				}
			},
			[2] = {
				["categoryName"] = getLocalizedText("menu.performance.turbo"),
				["cameraSettings"] = {"bonnet_dummy", 110, 15, 6, true},
				["upgradeData"] = "turbo",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"engineInertia"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 600, ["tuningData"] = {{"engineInertia", -10}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 1200, ["tuningData"] = {{"engineInertia", -20}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 1800, ["tuningData"] = {{"engineInertia", -30}}}
				}
			},
			[3] = {
				["categoryName"] = getLocalizedText("menu.performance.nitro"),
				["cameraSettings"] = {"boot_dummy", -65, 15, 6, true},
				["upgradeData"] = "nitro",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.remove"), ["tuningPrice"] = 0, ["tuningData"] = 0},
					[2] = {["categoryName"] = "25%", ["tuningPrice"] = 100, ["tuningData"] = 25},
					[3] = {["categoryName"] = "50%", ["tuningPrice"] = 100, ["tuningData"] = 50},
					[4] = {["categoryName"] = "75%", ["tuningPrice"] = 200, ["tuningData"] = 75},
					[5] = {["categoryName"] = "100%", ["tuningPrice"] = 300, ["tuningData"] = 100}
				}
			},
			[4] = {
				["categoryName"] = getLocalizedText("menu.performance.tires"),
				["cameraSettings"] = {"wheel_rb_dummy", 60, 10, 4},
				["upgradeData"] = "tires",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"tractionMultiplier"}, {"tractionLoss"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 400, ["tuningData"] = {{"tractionMultiplier", 0.05}, {"tractionLoss", 0.02}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 900, ["tuningData"] = {{"tractionMultiplier", 0.1}, {"tractionLoss", 0.03}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 120, ["tuningData"] = {{"tractionMultiplier", 0.15}, {"tractionLoss", 0.04}}}
				}
			},
			[5] = {
				["categoryName"] = getLocalizedText("menu.performance.brakes"),
				["cameraSettings"] = {"wheel_rf_dummy", 35, 5, 2, true},
				["upgradeData"] = "brakes",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"brakeDeceleration"}, {"brakeBias"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 400, ["tuningData"] = {{"brakeDeceleration", 0.05}, {"brakeBias", 0.1}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 900, ["tuningData"] = {{"brakeDeceleration", 0.1}, {"brakeBias", 0.175}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 120, ["tuningData"] = {{"brakeDeceleration", 0.15}, {"brakeBias", 0.25}}}
				}
			},
			[6] = {
				["categoryName"] = getLocalizedText("menu.performance.weightReduction"),
				["upgradeData"] = "weightreduction",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = {{"mass"}}},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.1"), ["tuningPrice"] = 450, ["tuningData"] = {{"mass", -100}}},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.2"), ["tuningPrice"] = 700, ["tuningData"] = {{"mass", -200}}},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.3"), ["tuningPrice"] = 1000, ["tuningData"] = {{"mass", -300}}}
				}
			}
		}
	},
	
	[2] = {
		["categoryName"] = getLocalizedText("menu.optical"),
		["availableUpgrades"] = {}, -- automatic getting optical upgrades to selected category
		["subMenu"] = {
			[1] = {["categoryName"] = getLocalizedText("menu.optical.frontBumper"), ["upgradeSlot"] = 14, ["tuningPrice"] = 100, ["cameraSettings"] = {"bump_front_dummy", 130, 10, 6}},
			[2] = {["categoryName"] = getLocalizedText("menu.optical.rearBumper"), ["upgradeSlot"] = 15, ["tuningPrice"] = 100, ["cameraSettings"] = {"door_lf_dummy", -65, 3, 8}},
			[3] = {["categoryName"] = getLocalizedText("menu.optical.hood"), ["upgradeSlot"] = 0, ["tuningPrice"] = 100},
			[4] = {["categoryName"] = getLocalizedText("menu.optical.exhaust"), ["upgradeSlot"] = 13, ["tuningPrice"] = 200, ["cameraSettings"] = {"door_lf_dummy", -65, 3, 8}},
			[5] = {["categoryName"] = getLocalizedText("menu.optical.spoiler"), ["upgradeSlot"] = 2, ["tuningPrice"] = 150, ["cameraSettings"] = {"boot_dummy", -65, 3, 8}},
			[6] = {["categoryName"] = getLocalizedText("menu.optical.wheels"), ["upgradeSlot"] = 12, ["tuningPrice"] = 500},
			[7] = {["categoryName"] = getLocalizedText("menu.optical.sideSkirt"), ["upgradeSlot"] = 3, ["tuningPrice"] = 100, ["cameraSettings"] = {"ug_wing_right", 65, 3, 4}},
			[8] = {["categoryName"] = getLocalizedText("menu.optical.roofScoop"), ["upgradeSlot"] = 7, ["tuningPrice"] = 100},
			[9] = {["categoryName"] = getLocalizedText("menu.optical.hidraulics"), ["upgradeSlot"] = 9, ["tuningPrice"] = 1500},
			[10] = { -- custom optical item
				["categoryName"] = "Air-Ride",
				["cameraSettings"] = {"wheel_rf_dummy", 35, 5, 2, true},
				["upgradeSlot"] = 17,
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.remove"), ["tuningPrice"] = 0, ["tuningData"] = false},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.install"), ["tuningPrice"] = 2000, ["tuningData"] = true}
				}
			},
			[11] = { -- custom optical item
				["categoryName"] = getLocalizedText("menu.optical.lampColor"),
				["cameraSettings"] = {"bonnet_dummy", 90, 3, 13},
				["upgradeSlot"] = 18,
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("menu.optical.lampColor"), ["tuningPrice"] = 2500, ["tuningData"] = "headlight"},
				}
			},
			[12] = { -- custom optical item
				["categoryName"] = "Neon",
				["cameraSettings"] = {"chassis_dummy", 0, 3, 10},
				["upgradeSlot"] = 19,
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.remove"), ["tuningPrice"] = 0, ["tuningData"] = false},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.1"), ["tuningPrice"] = 500, ["tuningData"] = "white"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.2"), ["tuningPrice"] = 500, ["tuningData"] = "blue"},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.3"), ["tuningPrice"] = 500, ["tuningData"] = "green"},
					[5] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.4"), ["tuningPrice"] = 500, ["tuningData"] = "red"},
					[6] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.5"), ["tuningPrice"] = 500, ["tuningData"] = "yellow"},
					[7] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.6"), ["tuningPrice"] = 500, ["tuningData"] = "pink"},
					[8] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.7"), ["tuningPrice"] = 500, ["tuningData"] = "orange"},
					[9] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.8"), ["tuningPrice"] = 500, ["tuningData"] = "lightblue"},
					[10] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.9"), ["tuningPrice"] = 500, ["tuningData"] = "rasta"},
					[11] = {["categoryName"] = getLocalizedText("tuningPack.optical.neon.10"), ["tuningPrice"] = 500, ["tuningData"] = "ice"},
				}
			},
		}
	},
	
	[3] = {
		["categoryName"] = getLocalizedText("menu.extras"),
		["subMenu"] = {
			[1] = {
				["categoryName"] = getLocalizedText("menu.extras.frontWheelSize"),
				["cameraSettings"] = {"bump_front_dummy", 105, 5, 5, true},
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.veryNarrow"), ["tuningPrice"] = 2000, ["tuningData"] = "verynarrow"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.narrow"), ["tuningPrice"] = 1000, ["tuningData"] = "narrow"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 500, ["tuningData"] = "default"},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.wide"), ["tuningPrice"] = 1000, ["tuningData"] = "wide"},
					[5] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.veryWide"), ["tuningPrice"] = 2000, ["tuningData"] = "verywide"}
				}
			},
			[2] = {
				["categoryName"] = getLocalizedText("menu.extras.rearWheelSize"),
				["cameraSettings"] = {"bump_rear_dummy", -90, 5, 5, true},
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.veryNarrow"), ["tuningPrice"] = 2000, ["tuningData"] = "verynarrow"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.narrow"), ["tuningPrice"] = 1000, ["tuningData"] = "narrow"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 500, ["tuningData"] = "default"},
					[4] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.wide"), ["tuningPrice"] = 1000, ["tuningData"] = "wide"},
					[5] = {["categoryName"] = getLocalizedText("tuningPack.wheelSize.veryWide"), ["tuningPrice"] = 2000, ["tuningData"] = "verywide"}
				}
			},
			[3] = {
				["categoryName"] = getLocalizedText("menu.extras.offroad"),
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 250, ["tuningData"] = "default"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.offroad.dirt"), ["tuningPrice"] = 500, ["tuningData"] = "dirt"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.offroad.sand"), ["tuningPrice"] = 500, ["tuningData"] = "sand"}
				}
			},
			[4] = {
				["categoryName"] = getLocalizedText("menu.extras.driveType"),
				["propertyName"] = "driveType",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.driveType.front"), ["tuningPrice"] = 1000, ["tuningData"] = "fwd"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.driveType.all"), ["tuningPrice"] = 1000, ["tuningData"] = "awd"},
					[3] = {["categoryName"] = getLocalizedText("tuningPack.driveType.rear"), ["tuningPrice"] = 1000, ["tuningData"] = "rwd"}
				}
			},
			[5] = {
				["categoryName"] = getLocalizedText("menu.extras.bulletproofTires"),
				["cameraSettings"] = {"wheel_rb_dummy", 60, 10, 4},
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = false},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.bulletproofTires"), ["tuningPrice"] = 8500, ["tuningData"] = true}
				}
			},
			[6] = {
				["categoryName"] = getLocalizedText("menu.extras.lsdDoor"),
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 0, ["tuningData"] = false},
					[2] = {["categoryName"] = getLocalizedText("menu.extras.lsdDoor"), ["tuningPrice"] = 3500, ["tuningData"] = true}
				}
			},
			[7] = {
				["categoryName"] = getLocalizedText("menu.extras.steeringLock"),
				["propertyName"] = "steeringLock",
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.0"), ["tuningPrice"] = 750, ["tuningData"] = false},
					[2] = {["categoryName"] = "30°", ["tuningPrice"] = 750, ["tuningData"] = 30},
					[3] = {["categoryName"] = "40°", ["tuningPrice"] = 750, ["tuningData"] = 40},
					[4] = {["categoryName"] = "50°", ["tuningPrice"] = 750, ["tuningData"] = 50},
					[5] = {["categoryName"] = "60°", ["tuningPrice"] = 750, ["tuningData"] = 60}
				}
			},
			[8] = {
				["categoryName"] = getLocalizedText("menu.extras.numberplate"),
				["cameraSettings"] = {"wheel_lb_dummy", -65, 4, 5},
				["subMenu"] = {
					[1] = {["categoryName"] = getLocalizedText("tuningPack.numberplate.random"), ["tuningPrice"] = 7500, ["tuningData"] = "random"},
					[2] = {["categoryName"] = getLocalizedText("tuningPack.numberplate.custom"), ["tuningPrice"] = 1500, ["tuningData"] = "custom"}
				}
			},
		}
	},
	[4] = {
		["categoryName"] = getLocalizedText("menu.color"),
		["subMenu"] = {}
	}
}

function getMainCategoryIDByName(name)
	if name then
		for categoryID, row in ipairs(tuningMenu) do
			if name == row["categoryName"] then
				return categoryID
			end
		end
	end
	
	return -1
end