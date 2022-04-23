wRightClick = nil
bInventory = nil
bCloseMenu = nil
ax, ay = nil
localPlayer = getLocalPlayer()
vehicle = nil
dbid = nil

function requestInventory(button)
    if button=="left" and not getElementData(localPlayer, "exclusiveGUI") then
        if isVehicleLocked(vehicle) and vehicle ~= getPedOccupiedVehicle(localPlayer) then
            triggerServerEvent("onVehicleRemoteAlarm", vehicle)
            outputChatBox("#FF0000#FFFFFFBu araç kilitli.", 0, 0, 0, true)
        elseif type(getElementData(vehicle, "Impounded")) == "number" and isVehicleImpounded(vehicle) and not exports.global:hasItem(localPlayer, 3, getElementData(vehicle, "dbid")) then
            outputChatBox("Bu aracı aramak için alete ihtiyacınız var.", 255, 0, 0)
        else
            triggerServerEvent( "openFreakinInventory", localPlayer, vehicle, ax, ay )
        end
        hideVehicleMenu()
    end
end

function clickVehicle(button, state, absX, absY, wx, wy, wz, element)
    if getElementData(getLocalPlayer(), "exclusiveGUI") then
        return
    end
    if (element) and (getElementType(element)=="vehicle") and (button=="right") and (state=="down") and not (wInventory) then
        local x, y, z = getElementPosition(localPlayer)
        
        if (getDistanceBetweenPoints3D(x, y, z, wx, wy, wz)<=3) then
            if (wRightClick) then
                hideVehicleMenu()
            end
            showCursor(true)
            ax = absX
            ay = absY
            vehicle = element
            dbid = getElementData(vehicle, "dbid")
            showVehicleMenu()
        end
    end
end
addEventHandler("onClientClick", getRootElement(), clickVehicle, true)

--Needs to be redone to run better
function isNotAllowedV(theVehicle)
    --[[local vmodel = getElementModel(theVehicle)
    if (getVehicleType(vmodel) == "Plane") then
        return true
    end
    if (getVehicleType(vmodel) == "Helicopter") then
        return true
    end
    if (getVehicleType(vmodel) == "Boat") then
        return true
    end
    if (getVehicleType(vmodel) == "Train") then
        return true
    end
    if (getVehicleType(vmodel) == "Trailer") then
        return true
    end]]
    return false
end

function showVehicleMenu()
    local y = 0.10
    wRightClick = guiCreateWindow(ax, ay, 150, 250, getVehicleName(vehicle), false)
    
    if exports['vehicle-system']:hasVehiclePlates(vehicle) then
        lPlate = guiCreateLabel(0.05, y, 0.87, 0.1, "Plaka: " .. getVehiclePlateText(vehicle), true, wRightClick)
        guiSetFont(lPlate, "default-bold-small")
        y = y + 0.1
    end

    if (isVehicleImpounded(vehicle)) then
        local days = getRealTime().yearday-getElementData(vehicle, "Impounded")
        lImpounded = guiCreateLabel(0.05, y, 0.87, 0.1, "Haciz: " .. days .. " gün", true, wRightClick)
        guiSetFont(lImpounded, "default-bold-small")
        y = y + 0.1
    end
    
    if (hasVehicleWindows(vehicle)) then
        local windowState = isVehicleWindowUp(vehicle, true) and "Kapat" or "Aç"
        lWindows = guiCreateLabel(0.05, y, 0.87, 0.1, "Pencere " .. windowState , true, wRightClick)
        guiSetFont(lWindows, "default-bold-small")
        y = y + 0.1
    end
    
    if ( getPedSimplestTask(localPlayer) == "TASK_SIMPLE_CAR_DRIVE" and getPedOccupiedVehicle(localPlayer) == vehicle ) or exports.global:hasItem(localPlayer, 3, getElementData(vehicle, "dbid")) or (getElementData(localPlayer, "faction") > 0 and getElementData(localPlayer, "faction") == getElementData(vehicle, "faction")) then
        bInventory = guiCreateButton(0.05, y, 0.87, 0.1, "Envanter", true, wRightClick)
        addEventHandler("onClientGUIClick", bInventory, requestInventory, false)
        y = y + 0.14
    
        bLockUnlock = guiCreateButton(0.05, y, 0.87, 0.1, "Kitle/Aç", true, wRightClick)
        addEventHandler("onClientGUIClick", bLockUnlock, lockUnlock, false)
        y = y + 0.14
        --[[if exports['item-system']:hasItem(vehicle, 117) then
            bRamp = guiCreateButton(0.05, y, 0.87, 0.1, "Toggle Ramp", true, wRightClick)
            addEventHandler("onClientGUIClick", bRamp, toggleRamp, false)
            y = y + 0.14
        end]]
    end
    
        if exports['item-system']:hasItem(vehicle, 117) or getElementModel(vehicle) == 611 then
            bRamp = guiCreateButton(0.05, y, 0.87, 0.1, "Rampayı Aç", true, wRightClick)
            addEventHandler("onClientGUIClick", bRamp, toggleRamp, false)
            y = y + 0.14
        end

    --if not isNotAllowedV(vehicle)  then
        if not ( getPedSimplestTask(localPlayer) == "TASK_SIMPLE_CAR_DRIVE" ) then
            if getElementData(localPlayer, "job") == 5 or getElementData(localPlayer, "faction") == 30 then -- Mechanic or BTR
                bFix = guiCreateButton(0.05, y, 0.87, 0.1, "Tamir/Modif", true, wRightClick)
                addEventHandler("onClientGUIClick", bFix, openMechanicWindow, false)
                y = y + 0.14
            end
        end
    --end
    
    local vx,vy,vz = getElementVelocity(vehicle)
    if vx < 0.05 and vy < 0.05 and vz < 0.05 and not getPedOccupiedVehicle(localPlayer) and not isVehicleLocked(vehicle) then -- completely stopped
        local trailers = { [606] = true, [607] = true, [610] = true, [590] = true, [569] = true, [611] = true, [584] = true, [608] = true, [435] = true, [450] = true, [591] = true }
        if trailers[ getElementModel( vehicle ) ] then
            if exports.global:hasItem(localPlayer, 3, getElementData(vehicle, "dbid")) then
                bPark = guiCreateButton(0.05, y, 0.87, 0.1, "Park", true, wRightClick)
                addEventHandler("onClientGUIClick", bPark, parkTrailer, false)
                y = y + 0.14
            end
        else
            if exports.global:hasItem(localPlayer, 57) then -- FUEL CAN
                bFill = guiCreateButton(0.05, y, 0.87, 0.1, "Doldur", true, wRightClick)
                addEventHandler("onClientGUIClick", bFill, fillFuelTank, false)
                y = y + 0.14
            end
        end
    end
    
    if (getElementModel(vehicle)==497) then -- HELICOPTER
        local players = getElementData(vehicle, "players")
        local found = false
        
        if (players) then
            for key, value in ipairs(players) do
                if (value==localPlayer) then
                    found = true
                end
            end
        end
        
        if not (found) then
            bSit = guiCreateButton(0.05, y, 0.87, 0.1, "Otur", true, wRightClick)
            addEventHandler("onClientGUIClick", bSit, sitInHelicopter, false)
        else
            bSit = guiCreateButton(0.05, y, 0.87, 0.1, "Kalk", true, wRightClick)
            addEventHandler("onClientGUIClick", bSit, unsitInHelicopter, false)
        end
        y = y + 0.14
    end
    
    local entrance = getElementData( vehicle, "entrance" )
    if entrance and not isPedInVehicle( localPlayer ) then
        bEnter = guiCreateButton(0.05, y, 0.87, 0.1, "İçine Gir", true, wRightClick)
        addEventHandler("onClientGUIClick", bEnter, enterInterior, false)
        y = y + 0.14

        bKnock = guiCreateButton(0.05, y, 0.87, 0.1, "Kapıyı Çal", true, wRightClick)
        addEventHandler("onClientGUIClick", bKnock, knockVehicle, false)
        y = y + 0.14
    end
    
    if not (isVehicleLocked(vehicle)) then
        local seat = -1
        if vehicle == getPedOccupiedVehicle(localPlayer) then
            for i = 0, (getVehicleMaxPassengers(vehicle) or 0) do
                if getVehicleOccupant(vehicle, i) == localPlayer then
                    seat = i
                    break
                end
            end
        end
        if #getDoorsFor(getElementModel(vehicle), seat) > 0 then
            bDoorControl = guiCreateButton(0.05, y, 0.87, 0.1, "Kapı Kontrolleri", true, wRightClick)
            addEventHandler("onClientGUIClick", bDoorControl, fDoorControl, false)
            y = y + 0.14
        elseif getVehicleType(vehicle) == "Trailer" then -- this is a trailer, zomg. But getVehicleType returns "" CLIENT-SIDE. Fine on the server.
            bHandbrake = guiCreateButton(0.05, y, 0.87, 0.1, "El Freni", true, wRightClick)
            addEventHandler("onClientGUIClick", bHandbrake, handbrakeVehicle, false)
            y = y + 0.14
        end
        
        if (getElementModel(vehicle) == 416) then
            bStretcher = guiCreateButton(0.05, y, 0.87, 0.1, "Sedye", true, wRightClick)
            addEventHandler("onClientGUIClick", bStretcher, fStretcher, false)
            y = y + 0.14
        end
        
        if getElementData(vehicle, "dbid") and exports['item-system']:hasItem(localPlayer, 3, dbid) and not isVehicleLocked(vehicle) and getVehicleType(vehicle) ~= "Trailer"  then
            bDescription = guiCreateButton(0.05, y, 0.87, 0.1, "Notu Düzle", true, wRightClick)
            addEventHandler("onClientGUIClick", bDescription, fDescription, false)
            y = y + 0.14
        end
    end
    
    bCloseMenu = guiCreateButton(0.05, y, 0.87, 0.1, "Kapat", true, wRightClick)
    addEventHandler("onClientGUIClick", bCloseMenu, hideVehicleMenu, false)
end

function lockUnlock(button, state)
    if (button=="left") then
        if getPedSimplestTask(localPlayer) == "TASK_SIMPLE_CAR_DRIVE" and getPedOccupiedVehicle(localPlayer) == vehicle then
            triggerServerEvent("lockUnlockInsideVehicle", localPlayer, vehicle)
        elseif exports.global:hasItem(localPlayer, 3, getElementData(vehicle, "dbid")) or (getElementData(localPlayer, "faction") > 0 and getElementData(localPlayer, "faction") == getElementData(vehicle, "faction")) then
            triggerServerEvent("lockUnlockOutsideVehicle", localPlayer, vehicle)
        end
        hideVehicleMenu()
    end
end

function fStretcher(button, state)
    if (button=="left") then
        if not (isVehicleLocked(vehicle)) then
            triggerServerEvent("stretcher:createStretcher", getLocalPlayer())
            hideVehicleMenu()
        end
    end
end

function centerWindow(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

local descWnd = nil
local descB = {}
function fDescription(button, state)
    if button == "left" --[[and not guiGetVisible(descWnd)]] then
        descs = {}
        hideVehicleMenu()
        descWnd = guiCreateWindow(854,512,465,229,"Araç Notunu Düzenle",false)
        guiSetAlpha(descWnd,0.77)
        descSave = guiCreateButton(9,192,199,25,"Kaydet",false,descWnd)
        descHelp = guiCreateButton(218,191,29,26,"?",false,descWnd)
        descB[1] = guiCreateEdit(9,22,445,24,"",false,descWnd)
        descB[2] = guiCreateEdit(9,56,445,24,"",false,descWnd)
        descB[3] = guiCreateEdit(9,90,445,24,"",false,descWnd)
        descB[4] = guiCreateEdit(9,124,445,24,"",false,descWnd)
        descB[5] = guiCreateEdit(9,158,445,24,"",false,descWnd)
        descCancel = guiCreateButton(255,192,199,25,"İptal",false,descWnd)
        guiEditSetMaxLength(descB[1],150)
        guiEditSetMaxLength(descB[2],150)
        guiEditSetMaxLength(descB[3],150)
        guiEditSetMaxLength(descB[4],150)
        guiEditSetMaxLength(descB[5],150)
        guiWindowSetSizable(descWnd,false)
        showCursor(true)
        guiSetInputEnabled(true)
        centerWindow(descWnd)
        triggerServerEvent("server:setDescriptionText", localPlayer, dbid)
        addEventHandler("onClientGUIClick", descWnd,
        function(button, state)
            if button == "left" then
                if source == descCancel then
                    descs = nil
                    guiSetInputEnabled(false)
                    showCursor(false)
                    destroyElement(descWnd)
                elseif source == descSave then
                    for i = 1, 5 do
                        local text = guiGetText(descB[i])
                        triggerServerEvent("server:saveVehDescription", localPlayer, i, text, dbid, descs, vehicle)
                    end
                    descs = nil
                    guiSetInputEnabled(false)
                    showCursor(false)
                    destroyElement(descWnd)
                elseif source == descHelp then
                    outputChatBox("Buradan aracınıza 4 satırlık not ekleyebilirsiniz.", 255, 255, 255, false)
                end
            end
        end)
    end
end

addEvent("client:updateDescriptionText", true)
addEventHandler("client:updateDescriptionText", root,
function(dTable)
    local d1, d2, d3, d4, d5 = unpack(dTable)
    guiSetText(descB[1], d1)
    guiSetText(descB[2], d2)
    guiSetText(descB[3], d3)
    guiSetText(descB[4], d4)
    guiSetText(descB[5], d5)
end)

function fDoorControl(button, state)
    if (button=="left") then
        openVehicleDoorGUI( vehicle )
        hideVehicleMenu()
    end
end

function parkTrailer(button, state)
    if (button=="left") then
        triggerServerEvent("parkVehicle", localPlayer, vehicle)
        hideVehicleMenu()
    end
end

function fillFuelTank(button, state)
    if (button=="left") then
        local _,_, value = exports.global:hasItem(localPlayer, 57)
        if value > 0 then
            triggerServerEvent("fillFuelTankVehicle", localPlayer, vehicle, value)
            hideVehicleMenu()
        else
            outputChatBox("This fuel can is empty...", 255, 0, 0)
        end
    end
end

function openMechanicWindow(button, state)
    if (button=="left") then
        triggerEvent("openMechanicFixWindow", localPlayer, vehicle)
        hideVehicleMenu()
    end
end

function toggleRamp(button)
    if (button=="left") then
        triggerServerEvent("vehicle:control:ramp", localPlayer, vehicle)
        hideVehicleMenu()
    end
end

function sitInHelicopter(button, state)
    if (button=="left") then
        triggerServerEvent("sitInHelicopter", localPlayer, vehicle)
        hideVehicleMenu()
    end
end

function unsitInHelicopter(button, state)
    if (button=="left") then
        triggerServerEvent("unsitInHelicopter", localPlayer, vehicle)
        hideVehicleMenu()
    end
end

function hideVehicleMenu()
    if (isElement(bCloseMenu)) then
        destroyElement(bCloseMenu)
    end
    bCloseMenu = nil

    if (isElement(wRightClick)) then
        destroyElement(wRightClick)
    end
    wRightClick = nil
    
    ax = nil
    ay = nil

    --vehicle = nil
    --dbid =

    showCursor(false)
    triggerEvent("cursorHide", getLocalPlayer())
end

function enterInterior()
    triggerServerEvent( "enterVehicleInterior", getLocalPlayer(), vehicle )
    hideVehicleMenu()
end

function knockVehicle()
    triggerServerEvent("onVehicleKnocking", getLocalPlayer(), vehicle)
    hideVehicleMenu()
end

function handbrakeVehicle()
    triggerServerEvent("vehicle:handbrake", localPlayer, localPlayer, vehicle )
    hideVehicleMenu()
end






