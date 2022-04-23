function replaceModel()
  txd = engineLoadTXD("em.txd", 2926 )
  engineImportTXD(txd, 2926)
  dff = engineLoadDFF("em.dff", 2926 )
  engineReplaceModel(dff, 2926)
  col= engineLoadCOL ( "em.col" )
  engineReplaceCOL ( col, 2926 )
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)