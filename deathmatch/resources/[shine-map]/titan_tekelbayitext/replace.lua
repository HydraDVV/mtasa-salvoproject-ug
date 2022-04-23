function replaceModel()
txd_palco = engineLoadTXD ( "punchbag2.txd" )
engineImportTXD ( txd_palco, 4117 )


end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)
addCommandHandler ( "recarregar", replaceModel )