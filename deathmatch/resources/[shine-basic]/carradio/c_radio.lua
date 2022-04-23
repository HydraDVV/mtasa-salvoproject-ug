radio = 0
song = ""
lawVehicles = { [416]=true, [433]=true, [427]=true, [528]=true, [407]=true, [544]=true, [523]=true, [598]=true, [596]=true, [597]=true, [599]=true, [432]=true, [601]=true, [509]=true, [481]=true, [510]=true, [462]=true, [448]=true, [581]=true, [522]=true, [461]=true, [521]=true, [523]=true, [463]=true, [586]=true, [468]=true, [471]=true }
local soundElement = nil
local soundElementsOutside = { }

function setVolume(commandname, val)
	if tonumber(val) then
		val = tonumber(val)
		if (val >= 0 and val <= 100) then
			triggerServerEvent("car:radio:vol", getLocalPlayer(), val)
			return
		end
	end
	outputChatBox ( "* ERROR: /setvol 0 - 100", 255, 0, 0, false )
end
addCommandHandler("setvol", setVolume)

function saveRadio(station)
	if getElementData(localPlayer, "streams") == "0" then
		cancelEvent()
		return false
	end

	local radios = 0
	if (station == 0) then
		return
	end

	if exports.titan_playerboard:isVisible() then
		cancelEvent()
		return
	end

	local vehicle = getPedOccupiedVehicle(getLocalPlayer())

	if (vehicle) then
		if not getVehicleEngineState(vehicle) then
			cancelEvent()
			return
		end
		if getVehicleOccupant(vehicle) == getLocalPlayer() or getVehicleOccupant(vehicle, 1) == getLocalPlayer() then
			if getVehicleType(vehicle) ~= 'BMX' and getVehicleType(vehicle) ~= 'Bike' and getVehicleType(vehicle) ~= 'Quad' then
			--if not (lawVehicles[getElementModel(vehicle)]) then
				if (station == 12) then
					if (radio == 0) then
						radio = #streams + 1
					end

					if (streams[radio-1]) then
						radio = radio-1
					else
						radio = 0
					end
				elseif (station == 1) then
					if (streams[radio+1]) then
						radio = radio+1
					else
						radio = 0
					end
				end
				triggerServerEvent("car:radio:sync", getLocalPlayer(), radio)
			end
		end
		cancelEvent()
	end
end
addEventHandler("onClientPlayerRadioSwitch", getLocalPlayer(), saveRadio)

addEventHandler("onClientPlayerVehicleEnter", getLocalPlayer(),
	function(theVehicle)
		if getElementData(localPlayer, "streams") == "0" then
			return false
		end
		stopStupidRadio()
		radio = getElementData(theVehicle, "vehicle:radio") or 0
		updateLoudness(theVehicle)
	end
)

addEventHandler("onClientPlayerVehicleExit", getLocalPlayer(),
	function(theVehicle)
		stopStupidRadio()
		radio = getElementData(theVehicle, "vehicle:radio") or 0
		updateLoudness(theVehicle)
	end
)

function stopStupidRadio()
	removeEventHandler("onClientPlayerRadioSwitch", getLocalPlayer(), saveRadio)
	setRadioChannel(0)
	addEventHandler("onClientPlayerRadioSwitch", getLocalPlayer(), saveRadio)
end

addEventHandler ( "onClientElementDataChange", getRootElement(),
	function ( dataName )
		if getElementType ( source ) == "vehicle" and dataName == "vehicle:radio" then
			local newStation =  getElementData(source, "vehicle:radio")  or 0
			if (isElementStreamedIn (source)) then
				if newStation ~= 0 then
					if isElement ( soundElementsOutside[source]) then
						stopSound(soundElementsOutside[source])
					end

					local x, y, z = getElementPosition(source)
					local newSoundElement = playSound3D(streams[newStation][2], x, y, z, true)
					soundElementsOutside[source] = newSoundElement
					updateLoudness(source)
					setElementDimension(newSoundElement, getElementDimension(source))
					setElementDimension(newSoundElement, getElementDimension(source))
				else
					if (soundElementsOutside[source]) then
						stopSound(soundElementsOutside[source])
						soundElementsOutside[source] = nil
					end
				end
			end
		elseif getElementType(source) == "vehicle" and dataName == "vehicle:windowstat" then
			if (isElementStreamedIn (source)) then
				if (soundElementsOutside[source]) then
					updateLoudness(source)
				end
			end
		elseif getElementType(source) == "vehicle" and dataName == "vehicle:radio:volume" then
			if (isElementStreamedIn (source)) then
				if (soundElementsOutside[source]) then
					updateLoudness(source)
				end
			end
		end

		--
	end
)

addEventHandler( "onClientPreRender", getRootElement(),
	function()
		if soundElementsOutside ~= nil then
			for element, sound in pairs(soundElementsOutside) do
				if (isElement(sound) and isElement(element)) then
					local x, y, z = getElementPosition(element)
					setElementPosition(sound, x, y, z)
					setElementInterior(sound, getElementInterior(element))
					getElementDimension(sound, getElementDimension(element))
				end
			end
		end
	end
)

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
	function()
		local vehicles = getElementsByType("vehicle")
		for _, theVehicle in ipairs(vehicles) do
			if (isElementStreamedIn(theVehicle)) then
				spawnSound(theVehicle)
			end
		end
	end
)

function spawnSound(theVehicle)
	if getElementData(localPlayer, "streams") == "0" then
		return false
	end

    if getElementType( theVehicle ) == "vehicle" then
		local radioStation = getElementData(theVehicle, "vehicle:radio") or 0
		if radioStation ~= 0 and streams[radioStation] then
			if (soundElementsOutside[theVehicle]) then
				stopSound(soundElementsOutside[theVehicle])
			end
			local x, y, z = getElementPosition(theVehicle)
			local newSoundElement = playSound3D(streams[radioStation][2], x, y, z, true)
			soundElementsOutside[theVehicle] = newSoundElement
			setElementDimension(newSoundElement, getElementDimension(theVehicle))
			setElementDimension(newSoundElement, getElementDimension(theVehicle))
			updateLoudness(theVehicle)
		end
    end
end

function updateLoudness(theVehicle)

	local windowState = getElementData(theVehicle, "vehicle:windowstat") or 1
	local carVolume = getElementData(theVehicle, "vehicle:radio:volume") or 60

	if getElementData(localPlayer, "streams") == "0" then
		carVolume = 0
	else
		carVolume = carVolume / 100
	end


	if isElement ( soundElementsOutside[theVehicle] ) then

		--  ped is inside
		if (getPedOccupiedVehicle( getLocalPlayer() ) == theVehicle) then
			setSoundMinDistance(soundElementsOutside[theVehicle], 25)
			setSoundMaxDistance(soundElementsOutside[theVehicle], 70)
			setSoundVolume(soundElementsOutside[theVehicle], 1*carVolume)
		elseif (windowState == 1) then -- window is open, ped outside
			setSoundMinDistance(soundElementsOutside[theVehicle], 1)
			setSoundMaxDistance(soundElementsOutside[theVehicle], 1)
			setSoundVolume(soundElementsOutside[theVehicle], 0*carVolume)
		else -- outside with closed windows
			setSoundMinDistance(soundElementsOutside[theVehicle], 1)
			setSoundMaxDistance(soundElementsOutside[theVehicle], 1)
			setSoundVolume(soundElementsOutside[theVehicle], 0*carVolume)
		end

	end

end

addEventHandler( "onClientElementStreamIn", getRootElement( ),
    function ( )
		spawnSound(source)
    end
)

addEventHandler( "onClientElementStreamOut", getRootElement( ),
    function ( )
        if getElementType( source ) == "vehicle" then
			if (soundElementsOutside[source]) then
				stopSound(soundElementsOutside[source])
				soundElementsOutside[source] = nil
			end
        end
    end
)

-- Shmorf ( 27/7/2013 21:41 )
local sw, sh = guiGetScreenSize ( )
local mp3Station = nil
local mp3Sound = nil
local BizNoteFont20 = dxCreateFont ( ":resources/BizNote.ttf" , 20 )
local dijital_font = exports.titan_fonts:getFont("FontAwesome",9)
local widthToDraw, widthToDraw2 = 0, 0
local heightToDraw, heightToDraw2 = 50, 50
local mp3_w = 200
local mp3_h = 300
local mp3_x = math.floor(sw * 0.0215) - 10
local mp3_y = sh * 0.89 - 10 - mp3_h

addEventHandler ( "onClientRender", root,
function ( )
	local left = math.floor(sw * 0.0215)
	local top = sh - 100
	if isPedInVehicle ( localPlayer ) then
		if getElementData(localPlayer, "streams") == "0" then
			return false
		end
		local vehicle = getPedOccupiedVehicle ( localPlayer )

		if not vehicle then return end

		local radioID = getElementData ( vehicle, "vehicle:radio" )

		if radioID and radioID >= 0 and streams[radioID] and getVehicleType(vehicle) ~= 'BMX' and getVehicleType(vehicle) ~= 'Bike' and getVehicleType(vehicle) ~= 'Quad' then
			local text = "           - " .. streams[radioID][1]
				dxDrawText ( text,-25, sh-245, sw, sh, tocolor ( 255, 255, 255, 155 ), 1, dijital_font, "left", "top", true, true, true, true )
			end
		end
end)
function updateCarRadio()
	local state = getElementData(localPlayer, "streams")
	if (state == "0") then
		setRadioChannel(0)

		-- kill all readio channels
		for _, value in pairs(soundElementsOutside) do
			stopSound(value)
		end
		soundElementsOutside = {}

		-- kill the mp3 player
		if mp3Sound then
			stopSound(mp3Sound)
			mp3Sound = nil
			mp3Station = nil
		end
	else
		-- repopulate all radio channels
		local vehicles = getElementsByType("vehicle")
		for _, theVehicle in ipairs(vehicles) do
			if (isElementStreamedIn(theVehicle)) then
				spawnSound(theVehicle)
			end
		end
	end
addEvent("accounts:settings:updateCarRadio", false)
addEventHandler("accounts:settings:updateCarRadio", getRootElement(), updateCarRadio)
end