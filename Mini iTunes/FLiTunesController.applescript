--
-- FLiTunesController.applescript
-- Mini iTunes
--
-- Created by François LAMBOLEY on 12/18/12.
-- Copyright (c) 2012 Frost Land. All rights reserved.
--

script FLiTunesController
	property parent: class "NSObject"
	
	-- -- -- Properties -- -- --
	
	-- Class "imports"
	property FLUtils: class "FLUtils"
	
	-- Constants
	
	-- Actual Properties
	
	-- -- -- Methods -- -- --
	
	on playpause()
		if FLUtils's isiTunesLaunched() is false then return
		
		tell application id "com.apple.iTunes" to playpause
	end playpause
	
	on playNext()
		if FLUtils's isiTunesLaunched() is false then return
		
		tell application id "com.apple.iTunes" to next track
	end playNext
	
	on playPrevious()
		if FLUtils's isiTunesLaunched() is false then return
		
		tell application id "com.apple.iTunes" to previous track
	end playPrevious
	
	-- -- Class Methods -- --
	
	-- -- Private Methods -- --
	
end script
