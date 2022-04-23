alivefa = createPed(70, 293.93359375, 181.9794921875, 1007.171875, 145)
setElementInterior(alivefa, 3)
setElementDimension(alivefa, 74)
setElementData(alivefa, "talk", 1)
setElementData(alivefa, "name", "Doktor Ali Vefa")

function pointguif()
arkaplan = guiCreateStaticImage(508, 271, 807, 455, "images/arkaplan.png", false)

imzalabutt1 = guiCreateStaticImage(12, 306, 186, 49, "images/imzalabutt.png", false, arkaplan)
imzalabutt2 = guiCreateStaticImage(594, 306, 186, 49, "images/imzalabutt.png", false, arkaplan)

addEventHandler("onClientGUIClick", getRootElement(), function()

if source == imzalabutt1 then
 if getElementData(getLocalPlayer(), "imzalabutt:vazgec") then return end

 setTimer(function()
 setTimer(function()
 triggerEvent("vazgec:gui", getLocalPlayer())
 destroyElement(arkaplan)
 setElementData(getLocalPlayer(),"imzalabutt:vazgec", false)
 stopSound(kalemsesi)
 end, 500, 1)
 guiSetVisible(imzalabutt1, true)
 end, 100, 1)

 setElementInterior(kalemsesi, 3)
 setElementDimension(kalemsesi, 23)
 kalemsesi = playSound("soundFX/Kalem.mp3")
 guiSetVisible(imzalabutt1, false)
 setElementData(getLocalPlayer(),"imzalabutt:vazgec", true)
end

if source == imzalabutt2 then
 if getElementData(getLocalPlayer(), "sakin:data") then outputChatBox("[!] #ffffffŞuanda içeride biri tedavi oluyor.", 255, 0, 0, true) return end
 if getElementData(getLocalPlayer(), "imzalabutt:tedaviol") then return end
 if getElementData(getLocalPlayer(), "money") < 2500 then
    triggerServerEvent("-paratedavi:event", getLocalPlayer())
    destroyElement(arkaplan)
 return end

 if getElementHealth(getLocalPlayer()) == 100 then
    triggerServerEvent("health:yazievent", getLocalPlayer())
    destroyElement(arkaplan)
 return end



    setTimer(function()
    setTimer(function()
    setTimer(function()
    setTimer(function()
    triggerServerEvent("tedavi:devam", getLocalPlayer())
    end, 10000, 1)
    triggerServerEvent("tedaviol:gui", getLocalPlayer())
    destroyElement(tedaviolarkaplan)
    exports.global:fadeFromBlack()
    end, 1000, 1)
    tedaviolarkaplan = guiCreateStaticImage(508, 271, 807, 455, "images/arkaplan2.png", false)
    destroyElement(arkaplan)
    setElementData(getLocalPlayer(),"imzalabutt:tedaviol", false)
    stopSound(kalemsesi)
    exports.global:fadeToBlack()
    end, 500, 1)
    guiSetVisible(imzalabutt2, true)
    end, 100, 1)
    setElementInterior(kalemsesi, 3)
    setElementDimension(kalemsesi, 23)
    kalemsesi = playSound("soundFX/Kalem.mp3")
    guiSetVisible(imzalabutt2, false)
    setElementData(getLocalPlayer(),"imzalabutt:tedaviol", true)

end



end)
end
addEvent("tedavigui:event", true)
addEventHandler("tedavigui:event", getRootElement(), pointguif)