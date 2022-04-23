local wStats

addEvent( "admin:licenses", true )
addEventHandler( "admin:licenses", localPlayer,
	function( results )
		if wStats then
			destroyElement( wStats )
			wStats = nil
			
			showCursor( false )
		end
		
		local sx, sy = guiGetScreenSize()
		wStats = guiCreateWindow( sx / 2 - 200, sy / 2.3 - 250, 415, 600, "License Monitor", false )
		
		local gStats = guiCreateGridList( 0.03, 0.04, 0.94, 0.88, true, wStats )
		local colName = guiGridListAddColumn( gStats, "Name", 0.4 )
		local colTier1 = guiGridListAddColumn( gStats, "Tier 1", 0.10 )
		local colTier2 = guiGridListAddColumn( gStats, "Tier 2", 0.10 )
		local colOnline = guiGridListAddColumn( gStats, "Last Online", 0.3 )
		
		local oldLevel = false
		for _, res in pairs( results ) do
			
			local row = guiGridListAddRow( gStats )
			guiGridListSetItemText( gStats, row, colName, tostring( res[1] ), false, false )
			if tonumber(res[2]) == 1 then
			guiGridListSetItemText(gStats, row, colTier1, "Yes", false, true )
			guiGridListSetItemColor(gStats, row, colTier1, 127, 255, 127)
			else
			guiGridListSetItemText(gStats, row, colTier1, "No", false, true )
			guiGridListSetItemColor(gStats, row, colTier1, 255, 127, 127)
			end
			if tonumber(res[3]) == 1 then
			guiGridListSetItemText(gStats, row, colTier2, "Yes", false, true )
			guiGridListSetItemColor(gStats, row, colTier2, 127, 255, 127)
			else
			guiGridListSetItemText(gStats, row, colTier2, "No", false, true )
			guiGridListSetItemColor(gStats, row, colTier2, 255, 127, 127)
			end
			guiGridListSetItemText( gStats, row, colOnline, tostring( res[4] ), false, true )
		end
		
		bClose = guiCreateButton( 0.03, 0.93, 0.94, 0.07, "Close", true, wStats )
		addEventHandler( "onClientGUIClick", bClose,
			function( button, state )
				if button == "left" and state == "up" then
					destroyElement( wStats )
					wStats = nil
					
					showCursor( false )
				end
			end, false
		)
		
		showCursor( true )
	end
)