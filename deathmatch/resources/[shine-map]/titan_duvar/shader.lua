
addEventHandler('onClientResourceStart', resourceRoot,
function()
shader = dxCreateShader('shader.fx')
terrain = dxCreateTexture('img/dverkofe.jpg')
dxSetShaderValue(shader, 'gTexture', terrain)
engineApplyShaderToWorldTexture(shader, 'cj_wooddoor2')
engineApplyShaderToWorldTexture(shader, '')
end
)
addEventHandler('onClientResourceStart', resourceRoot,
function()
shader = dxCreateShader('shader.fx')
terrain = dxCreateTexture('img/oknosolon.png')
dxSetShaderValue(shader, 'gTexture', terrain)
engineApplyShaderToWorldTexture(shader, 'ws_carshowwin1')
end
)
addEventHandler('onClientResourceStart', resourceRoot,
function()
shader = dxCreateShader('shader.fx')
terrain = dxCreateTexture('img/stena1.jpg')
dxSetShaderValue(shader, 'gTexture', terrain)
engineApplyShaderToWorldTexture(shader, 'ws_altz_wall5')
engineApplyShaderToWorldTexture(shader, 'badhousewallc02_128')
end
)
addEventHandler('onClientResourceStart', resourceRoot,
function()
shader = dxCreateShader('shader.fx')
terrain = dxCreateTexture('img/stena.jpg')
dxSetShaderValue(shader, 'gTexture', terrain)
engineApplyShaderToWorldTexture(shader, 'sam_camo')
engineApplyShaderToWorldTexture(shader, '')
end
)
addEventHandler('onClientResourceStart', resourceRoot,
function()
shader = dxCreateShader('shader.fx')
terrain = dxCreateTexture('img/pol.jpg')
dxSetShaderValue(shader, 'gTexture', terrain)
engineApplyShaderToWorldTexture(shader, 'lastrk6')
engineApplyShaderToWorldTexture(shader, '')
end
)
addEventHandler('onClientResourceStart', resourceRoot,
function()
shader = dxCreateShader('shader.fx')
terrain = dxCreateTexture('img/stenka.jpg')
dxSetShaderValue(shader, 'gTexture', terrain)
engineApplyShaderToWorldTexture(shader, 'bonyrd_skin2')
engineApplyShaderToWorldTexture(shader, '')
end
)

addEventHandler('onClientResourceStart', resourceRoot,
function()
shader = dxCreateShader('shader.fx')
terrain = dxCreateTexture('img/pizza.jpg')
dxSetShaderValue(shader, 'gTexture', terrain)
engineApplyShaderToWorldTexture(shader, 'cj_bobo')
engineApplyShaderToWorldTexture(shader, '')
end
)

addEventHandler('onClientResourceStart', resourceRoot,
function()
shader = dxCreateShader('shader.fx')
terrain = dxCreateTexture('img/pizza2.jpg')
dxSetShaderValue(shader, 'gTexture', terrain)
engineApplyShaderToWorldTexture(shader, 'cj_heat1')
engineApplyShaderToWorldTexture(shader, '')
end
)
