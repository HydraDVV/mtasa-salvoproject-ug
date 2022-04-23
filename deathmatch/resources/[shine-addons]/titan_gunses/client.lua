local start = getTickCount ( )
local hitmarker = false
local _hitX, _hitY, _hitZ = 0, 0, 0

function weaponSounds_playWeaponSound ( weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement )
	local weaponName = getWeaponNameFromID ( weapon )
	
	if sounds[weaponName] then
		if getElementData ( source, 'silenced' ) then
			tail = sounds['Silenced']['tails'][math.random ( 1, #sounds['Silenced']['tails'] ) ]
			gunshot = sounds['Silenced']['files'][math.random ( 1, #sounds['Silenced']['files'] ) ]
		else
			if sounds[weaponName]['tails'] then
				tail = sounds[weaponName]['tails'][math.random ( 1, #sounds[weaponName]['tails'] ) ]
			end
			gunshot = sounds[weaponName]['files'][math.random ( 1, #sounds[weaponName]['files'] ) ]
		end
	
		local x, y, z = getElementPosition ( source )
		local sound = playSound3D(gunshot, x, y, z, false)
		
		setSoundMaxDistance ( sound, weapons[weaponName].soundDistance )
		setSoundVolume ( sound, 0.8 )
		
		if sounds[weaponName]['tails'] then
			setTimer ( function ( )
				local tailSound = playSound3D ( tail, x, y, z, false )
				
				setSoundMaxDistance ( tailSound, weapons[weaponName].soundDistance )
				setSoundVolume ( tailSound, 0.8 )
			end, 75, 1 )
		end
	end
	
	if hitElement and isElement ( hitElement ) and source == localPlayer then
		if getElementType ( hitElement ) == "player" or getElementType ( hitElement ) == "vehicle" then
			start = getTickCount ( )
			
			if not hitmarker then
				hitmarker = true
			end
		
			_hitX = hitX
			_hitY = hitY
			_hitZ = hitZ
		end
	end
end

function hitmarker_render ( )
	if hitmarker then
		local now = getTickCount ( ) - start
		local sx, sy, _ = getScreenFromWorldPosition ( _hitX, _hitY, _hitZ )
		
		if sx and now < 700 then
			dxDrawImage ( sx - 12.5, sy - 12.5, 25, 25, "files/hitmarker.dds" )
		elseif now >= 700 then
			hitmarker = false
		end
	end
end

addEventHandler ( "onClientRender", root, hitmarker_render )
addEventHandler ( "onClientPlayerWeaponFire", root, weaponSounds_playWeaponSound )