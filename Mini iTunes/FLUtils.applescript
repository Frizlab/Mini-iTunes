--
-- FLUtils.applescript
-- Mini iTunes
--
-- Created by François LAMBOLEY on 12/18/12.
-- Copyright (c) 2012 Frost Land. All rights reserved.
--

script FLUtils
	property parent: class "NSObject"
	
	-- -- -- Properties -- -- --
	
	-- Class "imports"
	
	-- Constants
	
	-- Actual Properties
	
	-- -- -- Methods -- -- --
	
	-- -- Class Methods -- --
	
	on isiTunesLaunched()
		tell application "System Events" to return (exists (some process whose name is "iTunes"))
	end isiTunesLaunched
	
	-- -- Private Methods -- --
	
end script
