local streamedOut = {}
local voicePlayers = {}
local font = exports["titan_fonts"]:getFont("FontAwesome",9)

local screenX, screenY = guiGetScreenSize()

setTimer(
	function()
        local players = getElementsByType("player")
        local playerVoiceMode = localPlayer:getData("currentVoice") or 1
        local playerCallingTarget = localPlayer:getData("callTarget") or false
        local playerChannel = tonumber(localPlayer:getData("voiceChannel")) or false
        local playerVehicle = localPlayer.vehicle
        for k, v in ipairs(players) do
            local fPlayerChannel = tonumber(v:getData("voiceChannel")) or false
            if voicePlayers[v] then
                local vecSoundPos = v.position
                local vecCamPos = Camera.position
            
                local fMaxVol = v:getData("maxVol") or 5
                local fVoiceMode = v:getData("currentVoice") or 1
                local fMinDistance = v:getData("minDist") or 5
                local fMaxDistance = v:getData("maxDist") or 25
                local fVehicle = v.vehicle
                local skipSight = false
				fMaxVol = 8
                if fVoiceMode == playerVoiceMode and playerVoiceMode == 3 and playerCallingTarget == v then
                    fMaxDistance = 5000
                    fMaxDistance = 5000
                    vecSoundPos = localPlayer.position
                    skipSight = true
                end

                if fVoiceMode == playerVoiceMode and playerVoiceMode == 4 and playerChannel == fPlayerChannel then
                    fMaxDistance = 5000
                    fMaxDistance = 5000
                    vecSoundPos = localPlayer.position
                    skipSight = true
                end

                local fDistance = (vecSoundPos - vecCamPos).length
                
                local fPanSharpness = 1.0
                if (fMinDistance ~= fMinDistance * 2) then
                    fPanSharpness = math.max(0, math.min(1, (fDistance - fMinDistance) / ((fMinDistance * 2) - fMinDistance)))
                end

                local fPanLimit = (0.65 * fPanSharpness + 0.35)

                -- Pan
                local vecLook = Camera.matrix.forward.normalized
                local vecSound = (vecSoundPos - vecCamPos).normalized
                local cross = vecLook:cross(vecSound)
                local fPan = math.max(-fPanLimit, math.min(-cross.z, fPanLimit))

                local fDistDiff = fMaxDistance - fMinDistance;

                -- Transform e^-x to suit our sound
                local fVolume
                if (fDistance <= fMinDistance) then
                    fVolume = fMaxVol
                elseif (fDistance >= fMaxDistance) then
                    fVolume = 0.0
                else
                    fVolume = math.exp(-(fDistance - fMinDistance) * (5.0 / fDistDiff)) * fMaxVol
                end
                setSoundPan(v, fPan)

                
                if (isLineOfSightClear(localPlayer.position, vecSoundPos, true, true, false, true, false, true, true, localPlayer) or skipSight) then
                    setSoundVolume(v, fVolume)
                    setSoundEffectEnabled(v, "compressor", false)
                else
                    local fVolume = fVolume * 5.5
                    local fVolume = fVolume < 0.01 and 0 or fVolume
                    setSoundVolume(v, fVolume)
                    setSoundEffectEnabled(v, "compressor", true)
                end
            else
                if getSoundVolume(v) ~= 0 then
                    setSoundVolume(v, 0)
                end
            end
        end

    end
, 1000, 0)

setTimer(
	function()
		
        local lowerY = 0
        for player in pairs(voicePlayers) do
      			local distance = getDistanceBetweenPoints3D(localPlayer.position, player.position)
      			if distance < 15 then
              local color = tocolor(getPlayerNametagColor(player))
              local playerName = player.name:gsub("_", " ")
              local w, h = dxGetTextWidth(playerName, 1, "default-bold"), 25
              local x, y = screenX - w, screenY - 260 - lowerY 
              dxDrawText(" - "..playerName, 5, y, w, h, color, 0.9, font, "left", "top")
              lowerY = lowerY - h - 2
      			end
        end
	end,
0, 0)

addEventHandler("onClientResourceStart", resourceRoot,
    function ()
        triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, getElementsByType("player"))
        for i, player in ipairs(getElementsByType("player")) do
            setSoundVolume(player, 0)
        end
    end
)

addEventHandler("onClientPlayerJoin", root,
  function()
    triggerServerEvent("proximity-voice::broadcastUpdate", localPlayer, getElementsByType("player"))
    setSoundVolume(source, 0)
  end
)

addEventHandler("onClientPlayerVoiceStart", root,
    function()
      if not source:getData("loggedin") == 1 then
      	if source == localPlayer then
        	outputChatBox("[-]#ffffff Sunucuya giriş yapmadan mikrofon basamazsın.", 255, 79, 79, true)
      	end
        cancelEvent()
        return
      end		

		if source:getData("loggedin") == 1 and source:getData("adminjailed") then
			if source == localPlayer then
				outputChatBox("[-] #ffffffOOC Jaildeyken mikrofon basamazsın.", 255, 0, 0, true)
			end
			cancelEvent()
			return
		end
      if source:getData("loggedin") == 1 and source:getData("voicemute") then
      	if source == localPlayer then
        	outputChatBox("[-]#ffffff Bir yetkili tarafından susturulmuşsun.", 255, 79, 79, true)
        end
        cancelEvent()
        return
      end
      if source:getData("loggedin") == 1 and source:getData("bantli") then
      	if source == localPlayer then
        	outputChatBox("[-]#ffffff Ağzın bantlı olduğu için konuşamazsın.", 255, 79, 79, true)
        end
        cancelEvent()
        return
      end	  
	  		source:setData("onvoice", true)

	local distance = getDistanceBetweenPoints3D(localPlayer.position, source.position)
      local callTarget = localPlayer:getData("callTarget")
      local playerChannel = tonumber(localPlayer:getData("voiceChannel"))
      local targetChannel = tonumber(source:getData("voiceChannel"))
      if distance < 10 or callTarget == source or playerChannel == targetChannel then
      	voicePlayers[source] = true
      end
	end
)

addEventHandler("onClientPlayerVoiceStop", root,
	function()
		source:setData("onvoice", nil)
		voicePlayers[source] = nil
	end
)

function getPlayerTalking(plr)
	return voicePlayers[plr]
end

addEventHandler("onClientPlayerQuit", root,
	function()
		voicePlayers[source] = nil
	end
)