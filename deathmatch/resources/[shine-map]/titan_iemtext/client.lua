--By Enkanet
function texreplace()
	myShader = dxCreateShader( "texreplace.fx" )
	local tex = dxCreateTexture ( "textures/lspd.png")
	engineApplyShaderToWorldTexture( myShader, "lasbevcit99" )
	dxSetShaderValue ( myShader, "gTexture", tex )
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), texreplace)

function texreplace2()
	myShader2 = dxCreateShader( "texreplace2.fx" )
	local tex = dxCreateTexture ( "textures/lspd3.png")
	engineApplyShaderToWorldTexture( myShader2, "lasbevcit3" )
	dxSetShaderValue ( myShader2, "gTexture", tex )
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), texreplace2)

function texreplace3()
	myShader3 = dxCreateShader( "texreplace3.fx" )
	local tex = dxCreateTexture ( "textures/lspd2.png")
	engineApplyShaderToWorldTexture( myShader3, "lasbevcit1" )
	dxSetShaderValue ( myShader3, "gTexture", tex )
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), texreplace3)

function texreplace4()
	myShader4 = dxCreateShader( "texreplace4.fx" )
	local tex = dxCreateTexture ( "textures/lspd3.png")
	engineApplyShaderToWorldTexture( myShader4, "lasbevcit2" )
	dxSetShaderValue ( myShader4, "gTexture", tex )
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), texreplace4)
--By Enkanet