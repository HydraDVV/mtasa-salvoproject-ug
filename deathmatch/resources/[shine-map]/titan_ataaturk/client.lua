txd = engineLoadTXD ( "mm/p.txd" ) --Coloque o nome do TXD
engineImportTXD ( txd, 1906 ) --Coloque o ID do objeto que você quer modificar
col = engineLoadCOL ( "mm/p.col" ) --Coloque o nome do arquivo COL
engineReplaceCOL ( col, 1906 ) --Coloque o ID do objeto que você quer modificar
dff = engineLoadDFF ( "mm/p.dff", 0 ) --Coloque o nome do DFF e não mexa nesse 0
engineReplaceModel ( dff, 1906 ) --Coloque o ID do objeto que você quer modificar
engineSetModelLODDistance(1906, 500) --ID do objeto e a distância que ele irá carregar - distancia está como 500
