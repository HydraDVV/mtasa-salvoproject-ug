function playtelsiz()
local telsiz = playSound("telsiz2.mp3",false)
setSoundVolume(telsiz, 0.9)
end
addEvent("telsiz2",true)
addEventHandler("telsiz2",getRootElement(),playtelsiz)

