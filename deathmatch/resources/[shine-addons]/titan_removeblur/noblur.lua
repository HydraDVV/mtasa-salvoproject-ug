function changeBlurLevel()
    setPlayerBlurLevel ( source, 0 )
end
addEventHandler ( "onPlayerJoin", getRootElement(), changeBlurLevel )

function scriptStart()
    setPlayerBlurLevel ( getRootElement(), 0)
end
addEventHandler ("onResourceStart",getResourceRootElement(getThisResource()),scriptStart)

function scriptRestart()
	setTimer ( scriptStart, 4000, 1 )
end
addEventHandler("onResourceStart",getRootElement(),scriptRestart)