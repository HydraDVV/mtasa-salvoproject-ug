local maxDist = 25
local textHeight = 0.5
local fadeSpeed = 5

local alpha = 0
local fadeIn = false

platelessVeh = { [481]=true, [509]=true, [510]=true, [571]=true, [572]=true, [568]=true, [611]=true }

bindKey("lalt", "both",
function(key, state)
    if state == "down" then
        alpha = 0
        fadeIn = true
        addEventHandler("onClientRender", root, drawLicenseInfo)
    elseif state == "up" then
        fadeIn = false
        removeEventHandler("onClientRender", root, drawLicenseInfo)
    end
end)

function drawLicenseInfo()
    local x, y, z = getCameraMatrix()
    local dim = getElementDimension(localPlayer)
    for _, veh in ipairs(getElementsByType("vehicle")) do
        local vDim = getElementDimension(veh)
        if dim == vDim then
            local cx, cy, cz = getElementPosition(veh)
            local dist = getDistanceBetweenPoints3D(x, y, z, cx, cy, cz+textHeight)
            if dist <= maxDist and isLineOfSightClear(x, y, z, cx, cy, cz+textHeight, true, false, true, true, true, false, false, nil) then
                local wx, wy = getScreenFromWorldPosition(cx, cy, cz+textHeight)
                if wx then
                    local plateText = getVehiclePlateText(veh)
                    local dbid = getElementData(veh, "dbid")
                    local dText = getElementData(veh, "veh.desc") or ""
                    if dbid then
                    if not (platelessVeh[getElementModel(veh)]) then
                    --dxDrawFramedText("[ PLATE: "..plateText.." ]", wx, wy-19, wx, wy, tocolor(255, 255, 255, alpha), 1.2, "default-bold", "center", "top", false, false, false, true, true)
                    --dxDrawFramedText("[ VIN: "..dbid.." ]", wx, wy-2, wx, wy, tocolor(255, 255, 255, alpha), 1.1, "default-bold", "center", "top", false, false, false, true, true)
                    end
                    if (hiddenPlate == 1) then
                   -- dxDrawFramedText("[ NO PLATES ]", wx, wy-4, wx, wy, tocolor(255, 0, 0, alpha), 1.2, "default-bold", "center", "top", false, false, false, true, true)
                    end
                    for i = 1, 5 do
                        if dText[i] and dText[i] ~= "nil" and not string.find(dText[i]:lower(), "userdata", 0.6, true) then
                           -- wy = wy + 14
                           -- dxDrawText(dText[i], wx, wy, wx, wy, tocolor(255, 255, 255, alpha), 1, "default-bold", "center", "top", false, false, false, true, true)
                        end
                    end
                    end
                end
            end
        end
    end
    if fadeIn then alpha = alpha + fadeSpeed end
    if alpha >= 255 and fadeIn then alpha = 255 end
    if alpha <= 0 then return end
end

function dxDrawFramedText ( message , left , top , width , height , color , scale , font , alignX , alignY , clip , wordBreak , postGUI , colorCoded , subPixel )
    dxDrawText ( message , left + 1 , top + 1.2 , width + 1 , height + 1 , tocolor ( 0 , 0 , 0 , alpha ) , scale , font , alignX , alignY , clip , wordBreak , postGUI )
    dxDrawText ( message , left + 1 , top - 1.2 , width + 1 , height - 1 , tocolor ( 0 , 0 , 0 , alpha ) , scale , font , alignX , alignY , clip , wordBreak , postGUI )
    dxDrawText ( message , left - 1 , top + 1.2 , width - 1 , height + 1 , tocolor ( 0 , 0 , 0 , alpha ) , scale , font , alignX , alignY , clip , wordBreak , postGUI )
    dxDrawText ( message , left - 1 , top - 1.2 , width - 1 , height - 1 , tocolor ( 0 , 0 , 0 , alpha ) , scale , font , alignX , alignY , clip , wordBreak , postGUI )
    dxDrawText ( message , left , top , width , height , color , scale , font , alignX , alignY , clip , wordBreak , postGUI , colorCoded , subPixel )
end