txd = engineLoadTXD ( "object.txd" )
engineImportTXD ( txd, 1773 )
col = engineLoadCOL ( "object.col" )
engineReplaceCOL ( col, 1773 )
dff = engineLoadDFF ( "object.dff" )
engineReplaceModel ( dff, 1773 )
engineSetModelLODDistance(1773, 9000)