	local ped = createPed(47, 2165.7368164062, -2172.1853027344, 13.62343788147)
	setElementFrozen(ped, true)
	setElementRotation(ped, 0, 0, 47.761047363281)

	setElementData(ped, 'name', 'Galerici Şahin', false)
	setElementData(ped, "talk", 1, true)

local screenW, screenH = guiGetScreenSize()
local x, y = (screenW/1366), (screenH/768)
local page = nil
Veiculo = {}

local dxfont0_icons = dxCreateFont("font/icons.ttf", x*12)

local components = { "weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted", "radar" }
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function ()
	for _, component in ipairs( components ) do
		setPlayerHudComponentVisible( component, false )
	end
end)

function clientSide()
    page = "Galeri Açık Gardaşım"
    roundedRectangle(screenW * 0.7725, screenH * 0.1978, screenW * 0.2181, screenH * 0.7189, tocolor(50, 50, 50, 180),tocolor(50, 50, 50, 180), false)
    roundedRectangle(screenW * 0.7725, screenH * 0.1978, screenW * 0.2181, screenH * 0.1578, tocolor(50, 50, 50, 180),tocolor(50, 50, 50, 180), false)
    dxDrawImage(screenW * 0.7725, screenH * 0.1978, screenW * 0.2181, screenH * 0.1578, "images/logo.png", 0, 0, 0, tocolor(255,255,255, 255), false)

    if isCursorOnElement(screenW * 0.7788, screenH * 0.8567, screenW * 0.10065, screenH * 0.0522) then
        dxDrawImage(screenW * 0.7788, screenH * 0.8567, screenW * 0.10065, screenH * 0.0522, "images/botao.png", 0, 0, 0, tocolor(35,35,35, 215), false)
    else
        dxDrawImage(screenW * 0.7788, screenH * 0.8567, screenW * 0.10065, screenH * 0.0522, "images/botao.png", 0, 0, 0, tocolor(35,35,35, 120), false)
    end

    if isCursorOnElement(screenW * 0.8850, screenH * 0.8567, screenW * 0.10065, screenH * 0.0522) then
        dxDrawImage(screenW * 0.8850, screenH * 0.8567, screenW * 0.10065, screenH * 0.0522, "images/botao.png", 0, 0, 0, tocolor(35,35,35, 215), false)
    else
        dxDrawImage(screenW * 0.8850, screenH * 0.8567, screenW * 0.10065, screenH * 0.0522, "images/botao.png", 0, 0, 0, tocolor(35,35,35, 120), false)
    end

    dxDrawText("Satın Al", screenW * 0.6750, screenH * 0.8667, screenW * 0.9800, screenH * 0.8989, tocolor(255, 255, 255, 255), 1.00, dxfont0_icons, "center", "center", false, false, false, false, false)
    dxDrawText("Kapat", screenW * 0.8930, screenH * 0.8667, screenW * 0.9800, screenH * 0.8989, tocolor(255, 255, 255, 255), 1.00, dxfont0_icons, "center", "center", false, false, false, false, false)
end

function roundedRectangle(x, y, w, h, borderColor, bgColor, postGUI)
	if (x and y and w and h) then
		if (not borderColor) then
			borderColor = tocolor(50,50,50, 180)
		end
		if (not bgColor) then
			bgColor = borderColor
		end
		dxDrawRectangle(x, y, w, h, bgColor, postGUI);
		dxDrawRectangle(x + 2, y - 1, w - 4, 1, borderColor, postGUI);
		dxDrawRectangle(x + 2, y + h, w - 4, 1, borderColor, postGUI);
		dxDrawRectangle(x - 1, y + 2, 1, h - 4, borderColor, postGUI);
		dxDrawRectangle(x + w, y + 2, 1, h - 4, borderColor, postGUI);
        
        dxDrawRectangle(x + 0.5, y + 0.5, 1, 2, borderColor, postGUI);
        dxDrawRectangle(x + 0.5, y + h - 1.5, 1, 2, borderColor, postGUI);
        dxDrawRectangle(x + w - 0.5, y + 0.5, 1, 2, borderColor, postGUI);
        dxDrawRectangle(x + w - 0.5, y + h - 1.5, 1, 2, borderColor, postGUI);
	end
end

addEventHandler("onClientResourceStart", resourceRoot,
function ()
Gridlist = dxGridW:Create(1240, 330, 340, 430)
Gridlist:AddColumn("Araç İsmi", 180)
Gridlist:AddColumn("Fiyatı", 150)
Gridlist:AddColumn("ID", 250)
Gridlist:AddColumn("Fiyat", 250)
Gridlist:SetVisible(false)

for i, Veiculos in ipairs (VeiculosAVenda) do 
    Gridlist:AddItem(1, Veiculos[2].."") -- araç ismi
    Gridlist:AddItem(2, ""..exports.global:formatMoney(Veiculos[3]).."") -- araç fiyatı
    Gridlist:AddItem(3, ""..Veiculos[1].."") -- vehlib
    Gridlist:AddItem(4, ""..Veiculos[3].."") -- vehlib
  end
end)

Timer = {}
function click ( _,state )
local gridItem = Gridlist:GetSelectedItem()
if state == "down" then 
    if isCursorOnElement(screenW * 0.7788, screenH * 0.8567, screenW * 0.10065, screenH * 0.0522) and page == "Galeri Açık Gardaşım" then 
        playSound("sounds/bubble.mp3")

        if gridItem == -1 then
            outputChatBox("lütfen bir araç seçiniz.")
        return end
        if gridItem then
        local carName = Gridlist:GetItemDetails(1, gridItem, 1) 
        local carID = Gridlist:GetItemDetails(3, gridItem, 3) 
        local carPrice = Gridlist:GetItemDetails(4, gridItem, 4) 
        triggerServerEvent("serverSide",localPlayer,localPlayer,carName, carPrice, carID)
        closeGallery()
        setCameraTarget (localPlayer)
        end
    elseif isCursorOnElement(screenW * 0.8850, screenH * 0.8567, screenW * 0.10065, screenH * 0.0522) and page == "Galeri Açık Gardaşım" then 
        setCameraTarget (localPlayer)
        closeGallery()
		playSound("sounds/bubble.mp3")
    elseif isCursorOnElement(screenW * 0.7850, screenH * 0.40,screenW * 0.2, screenH * 0.44) and page == "Galeri Açık Gardaşım" then 
        if isElement(Veiculo[localPlayer]) then destroyElement(Veiculo[localPlayer]) end
                if gridItem then
                    local IDDoCarro = Gridlist:GetItemDetails(3, gridItem, 3) 
                        if isTimer(Timer[localPlayer]) then killTimer(Timer[localPlayer]) end
                            Veiculo[localPlayer] = createVehicle(IDDoCarro, 2146.7001953125, -2189.087890625, 13.554370880127) -- Satın Alma Ekranında Aracın Prewiev olduğu ekran'da spawn pointi
                            setCameraMatrix(2145.2001953125, -2175.8076171875, 15.054383277893,2148.1201171875, -2197.04296875, 13.554370880127) --- kamera açıs
                            Loop(localPlayer)
                        end
                end
        end
end
addEventHandler ( "onClientClick", root, click )

function startClient()
    if page == "Galeri Açık Gardaşım" then return end
        -- if getDistanceBetweenPoints3D(1775.5992431641, -1372.2066650391, 23.643749237061, getElementPosition(localPlayer)) < 3 then
            addEventHandler('onClientPreRender', root, clientSide)
            Gridlist:SetVisible(true)
            showCursor(true)
			playSound("ses.mp3")
        -- end
end
addEvent("galeri:panel", true)
addEventHandler("galeri:panel", root, startClient)
function closeGallery()
    if page == "Galeri Açık Gardaşım" then 
        removeEventHandler('onClientPreRender', root, clientSide)
        Gridlist:SetVisible(false)
        showCursor(false)
        if isElement(Veiculo[localPlayer]) then destroyElement(Veiculo[localPlayer]) end
        page = nil
    end
end

function Loop(source)
    Timer[source] = setTimer(function()
      if not isElement(Veiculo[source]) then return end
      local Rot1, Rot2, Rot3 = getElementRotation(Veiculo[source])
        setElementRotation(Veiculo[source], Rot1 , Rot2, Rot3+1)
    end ,20, 0)
end 
