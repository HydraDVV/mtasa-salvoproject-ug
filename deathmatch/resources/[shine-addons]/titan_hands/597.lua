addEventHandler("onPlayerVehicleEnter",getRootElement(),
function(veh)
if (getElementModel(veh) == 597) then
        setVehicleHandling (veh, "mass", 1400)
        setVehicleHandling(veh, "turnMass", 3851.4)
        setVehicleHandling(veh, "maxVelocity", 260)
        setVehicleHandling(veh, "engineAcceleration", 31 )
		setVehicleHandling(veh, "driveType", "awd")
		setVehicleHandling(veh, "suspensionLowerLimit", -0.07)
       
end
end)
 
 
 --<handling tailLight="1" engineType="p" tractionMultiplier="0.8" handlingFlags="4004402" brakeDeceleration="5" modelFlags="20002000" driveType="4" mass="1400" maxVelocity="320" engineAcceleration="18" animGroup="0" suspensionForceLevel="1.3"