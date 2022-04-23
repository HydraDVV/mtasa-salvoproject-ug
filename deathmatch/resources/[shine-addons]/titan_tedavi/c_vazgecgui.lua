function vazgecguif()
vazgecarkaplan = guiCreateStaticImage(508, 271, 807, 455, "images/arkaplan3.png", false)
setTimer(function()
 destroyElement(vazgecarkaplan)
end, 1000, 1)
end
addEvent("vazgec:gui", true)
addEventHandler("vazgec:gui", getRootElement(), vazgecguif)