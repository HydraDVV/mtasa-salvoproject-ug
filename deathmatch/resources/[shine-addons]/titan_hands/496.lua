
addEventHandler("onPlayerVehicleEnter",getRootElement(),
function(veh)
if (getElementModel(veh) == 496) then
        setVehicleHandling (veh, "mass", 1400)
        setVehicleHandling(veh, "turnMass", 3851.4)
        setVehicleHandling(veh, "dragCoeff", 2.0 )
        setVehicleHandling(veh, "percentSubmerged", 75)
        setVehicleHandling(veh, "tractionMultiplier", 0.8)
        setVehicleHandling(veh, "tractionLoss", 0.90)
        setVehicleHandling(veh, "tractionBias", 0.51)
        setVehicleHandling(veh, "numberOfGears", 5)
        setVehicleHandling(veh, "maxVelocity", 500)
        setVehicleHandling(veh, "engineAcceleration", 35 )
        setVehicleHandling(veh, "engineInertia", 8)
        setVehicleHandling(veh, "driveType", "awd")
        setVehicleHandling(veh, "engineType", "petrol")
        setVehicleHandling(veh, "brakeDeceleration", 5)
        setVehicleHandling(veh, "brakeBias", 0.62)
	    setVehicleHandling(veh, "ABS", true)
        setVehicleHandling(veh, "steeringLock", 30)
       setVehicleHandling(veh, "seatOffsetDistance", 0.20)
        setVehicleHandling(veh, "collisionDamageMultiplier", 0.56)
        setVehicleHandling(veh, "monetary", 35000)
        setVehicleHandling(veh, "modelFlags", 0x40000000)
        setVehicleHandling(veh, "handlingFlags", 0x10200008 )
        setVehicleHandling(veh, "headLight", 1)
        setVehicleHandling(veh, "tailLight", 1)
        setVehicleHandling(veh, "animGroup", 0)
end
end)
 
 
 --<handling tailLight="1" engineType="p" tractionMultiplier="0.8" handlingFlags="4004402" brakeDeceleration="5" modelFlags="20002000" driveType="4" mass="1400" maxVelocity="320" engineAcceleration="18" animGroup="0" suspensionForceLevel="1.3"