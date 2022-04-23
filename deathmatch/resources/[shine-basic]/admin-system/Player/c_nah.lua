local nah = false
function nahShow()
	local w, h = guiGetScreenSize()
	nah = guiCreateStaticImage((w - 750) /2, (h - 600)/2, 750, 600, ":admin-system/images/nah.png", false)
end
addEvent("admin:nahShow", true)
addEventHandler("admin:nahShow", root, nahShow)

function noNah()
	if nah then
		destroyElement(nah)
		nah = false
	end
end
addEvent("admin:noNah", true)
addEventHandler("admin:noNah", root, noNah)

function nudgeNoise()
   local sound = playSound("Player/nudge.wav")   
   setSoundVolume(sound, 0.5) -- set the sound volume to 50%
end
addEvent("playNudgeSound", true)
addEventHandler("playNudgeSound", getLocalPlayer(), nudgeNoise)
addCommandHandler("playthenoise", nudgeNoise)

function babaPatlat2()
   local sound = playSound("ahlayanSesi.mp3")   
   setSoundVolume(sound, 1) -- set the sound volume to 50%
end
addEvent("ahlayanSesi", true)
addEventHandler("ahlayanSesi", getLocalPlayer(), babaPatlat2)
