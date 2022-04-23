masa = createObject(3383, 340.4775390625, 163.916015625, 1018.984375, 0, 0, 90)
setElementInterior(masa, 3)
setElementDimension(masa, 74)
function tedaviolguif()
fermanhoca = createPed(70, 339.29296875, 163.7080078125, 1019.984375, 270) -- doktor rotası
bizimped = createPed(tonumber(getElementModel(source)),  340.7734375, 163.587890625, 1021.039855957) -- Bizim skine sahip ped'i ışınlama rotası
yasak = createObject(10149,  1811.3851318359, -1752.4683837891, 1111.3122558594, 0, 0, 90)
yasak2 = createObject(9093, 1812.4866943359, -1757.2681884766, 1111.3101806641)
yasak3 = createObject(9093, 1812.1585693359, -1748.8385009766, 1111.3123779297)
-------------------------------------------------------------------------------------------
setTimer(function()
destroyElement(fermanhoca)
destroyElement(bizimped)
destroyElement(yasak)
destroyElement(yasak2)
destroyElement(yasak3)
end, 10000, 1)
setElementAlpha(yasak3, 0)
setElementAlpha(yasak2, 0)
setElementAlpha(yasak, 0)
setElementAlpha(source, 0)
outputChatBox("[+] #ffffffFerman hoca tarafından tedavi oluyorsun.", source, 0, 255, 0, true)
setPedAnimation(fermanhoca, "int_shop", "shop_pay", -1, true, false, false)
setElementDimension(fermanhoca, 74)
setElementInterior(fermanhoca, 3)
setPedAnimation(bizimped, "crack", "crckidle1", -1, true, false, false)
toggleControl(source, "jump", false)
toggleControl(source, "sprint", false)
toggleControl(source, "backwards", false)
toggleControl(source, "walk", false)
toggleControl(source, "forwards", false)
toggleControl(source, "fire", false)
toggleControl(source, "left", false)
toggleControl(source, "right", false)
toggleControl(source, "crouch", false)
setElementDimension(yasak3, 74)
setElementInterior(yasak3, 3)
setElementDimension(yasak2, 74)
setElementInterior(yasak2, 3)
setElementDimension(yasak, 74)
setElementInterior(yasak, 3)
setElementDimension(kamera, 74)
setElementInterior(kamera, 3)
kamera = setCameraMatrix(source, 337.2080078125, 160.130859375, 1019.984375, 339.29296875, 163.7080078125, 1019.984375) -- Kamera Pozisyonu
setElementDimension(bizimped, 74)
setElementInterior(bizimped, 3)
setElementVisibleTo(source, getRootElement(), false)
setElementPosition(source, 232.974609375, 150.6669921875, 1012.2389526367)
-------------------------------------------------------------------------------------------
for i, _ in ipairs(getElementsByType('player')) do
    setElementData(_, "sakin:data", true)
end --- sakin data true

end
addEvent("tedaviol:gui", true)
addEventHandler("tedaviol:gui", getRootElement(), tedaviolguif)

addCommandHandler("tedavifix", function(p)
    if getElementData(p, "account:username") == "point" or getElementData(p, "account:username") == "REMAJOR" then
    setElementData(root, "sakin:data", false)
    setElementData(root,"imzalabutt:tedaviol", false)
    setElementData(root,"imzalabutt:vazgec", false)
    
    outputChatBox("Datalar False", p)
    end
end)

addEvent("sakin:yazievent", true)
addEventHandler("sakin:yazievent", getRootElement(), function()
outputChatBox("[!] #ffffffİçeride biri tedavi oluyor.", source, 255, 0, 0, true)
end)

addEvent("health:yazievent", true)
addEventHandler("health:yazievent", getRootElement(), function()
outputChatBox("[!] #ffffffGayet sağlıklısın turp gibisin tedavi olamazsın.", source, 255, 0, 0, true)
end)

addEvent("-paratedavi:event", true)
addEventHandler("-paratedavi:event", getRootElement(), function()
outputChatBox("[!] #ffffffParanız yeterli değil.", source, 255, 0, 0, true)
end)

addEventHandler("onPlayerJoin", root, function()
    setElementData(source, "sakin:data", false)
    setElementData(source,"imzalabutt:tedaviol", false)
    setElementData(source,"imzalabutt:vazgec", false)
end)

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), function()
    setElementData(root, "sakin:data", false)
    setElementData(root,"imzalabutt:tedaviol", false)
    setElementData(root,"imzalabutt:vazgec", false)
end)