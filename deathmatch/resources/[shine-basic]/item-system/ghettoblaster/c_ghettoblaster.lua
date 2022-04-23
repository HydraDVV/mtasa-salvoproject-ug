local sound = false
local made = false

blasters = { }

function startGB(blaster)
    local itemValue = tonumber( getElementData(blaster, "itemValue") ) or 1
    if itemValue > 0 then
        local x, y, z = getElementPosition(blaster)
        local int = getElementInterior(blaster)
        local dim = getElementDimension(blaster)
        local px, py, pz = getElementPosition(getLocalPlayer())
        if (getDistanceBetweenPoints3D(x, y, z, px, py, pz)<50) then
            local sound = playSound3D(streams[itemValue][2], x, y, z)
            setSoundMaxDistance(sound, 20)
            setElementDimension(sound, dim)
            setElementInterior(sound, int)
            attachElements ( sound, blaster )
            blasters[blaster] = { }
            blasters[blaster].sound = sound
            blasters[blaster].position = { x, y, z }
            blasters[blaster].itemValue = itemValue
            
            if (isPedInVehicle(getLocalPlayer())) then
                setSoundVolume(sound, 0.5)
			else
				setSoundVolume(sound, 1.0)
            end
        end
    end
end

function stopGB(blaster)
    if isElement ( blaster ) and getElementType(blaster) == "object" and blasters[blaster] then
        local sound = blasters[blaster].sound
        if isElement ( sound ) then
            stopSound(sound)
        end
        blasters[blaster] = nil
    end
end

function elementStreamIn()
    if (getElementType(source)=="object") then
        local model = getElementModel(source)
        if (model==2226) then
            startGB(source)
        end
    end
end
addEventHandler("onClientElementStreamIn", getRootElement(), elementStreamIn)

addEventHandler("onClientElementStreamOut", getRootElement(), function ( ) stopGB ( source ) end )
addEventHandler("onClientElementDestroy", getRootElement(), function ( ) stopGB ( source ) end )

function dampenSound(thePlayer)
    for key, value in pairs(blasters) do
        setSoundVolume(value.sound, 0.5)
    end
end
addEventHandler("onClientVehicleEnter", getRootElement(), dampenSound)

function boostSound(thePlayer)
    for key, value in pairs(blasters) do
        setSoundVolume(value.sound, 1.0)
    end
end
addEventHandler("onClientVehicleExit", getRootElement(), boostSound)

addEvent("toggleSound", true )
function toggleSound(item)
        if isElementStreamedIn(item) then
            local state = tonumber(getElementData(item, "itemValue")) or 1
            if state > 0 then
                stopGB(item)
                startGB(item)
            else
                stopGB(item)
            end
        end
end
addEventHandler("toggleSound", root, toggleSound)

-- Shmorf // 18-8-2013
addEventHandler ( "onClientResourceStart", resourceRoot,
    function ( )
        for i,v in ipairs ( getElementsByType ( "object" ) ) do
            if getElementModel ( v ) == 2226 then
                startGB(v)
            end
        end
    end )

addEventHandler ( "onClientPreRender", root,
    function ( )
        for i,v in pairs ( blasters ) do
            if not v.sound or getElementDimension ( localPlayer ) ~= getElementDimension ( v.sound ) then return end
            
            local x, y, z = getElementPosition ( v.sound )
            local px, py, pz = getElementPosition ( localPlayer )
            local distance = getDistanceBetweenPoints3D ( px, py, pz, x, y, z )
            local sx, sy = getScreenFromWorldPosition ( x, y, z + 0.7 )
            
            if sx and distance <= 10 then
                local itemValue = v.itemValue
                
                if isElement ( v.sound ) then
                    song = getSoundMetaTags ( v.sound )["stream_title"]
                end
                
                dxDrawText ( "#" .. itemValue .. " - " .. streams[itemValue][1], sx, sy, sx, sy, tocolor ( 255, 255, 255, 255 ), 0.85, "default-bold", "center" )
                
                if type ( song ) == "string" then
                    dxDrawText ( "Now playing: " .. song, sx, sy + 15, sx, sy, tocolor ( 255, 255, 255, 255 ), 0.85, "default-bold", "center" )
                end
            end
        end
    end )







