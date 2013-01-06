--
-- FLiTunesController.applescript
-- Mini iTunes
--
-- Created by François LAMBOLEY on 12/18/12.
-- Copyright (c) 2012 Frost Land. All rights reserved.
--

script FLiTunesController
	property parent : class "NSObject"
	
	-- -- -- Properties -- -- --
	
	-- Class "imports"
	property FLUtils : class "FLUtils"
	
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
	
	on setPlayHeadPosition_(value)
		if FLUtils's isiTunesLaunched() is false then return
		
		tell application id "com.apple.iTunes" to set player position to (value as real)
	end setPlayHeadPosition_
	
	on setiTunesVolume_(value)
		if FLUtils's isiTunesLaunched() is false then return
		
		tell application id "com.apple.iTunes" to set sound volume to (value as real)
	end setiTunesVolume_
	
	on deiconizeiTunes()
		if FLUtils's isiTunesLaunched() is false then return
		
		tell application id "com.apple.iTunes"
			set minimized of browser window 1 to false
			set visible of browser window 1 to true
			activate
		end tell
	end deiconizeiTunes
	
	on setRelativePlayHeadPosition_(value)
		if FLUtils's isiTunesLaunched() is false then return
		
		tell application id "com.apple.iTunes"
			set myPos to player position + (value as real)
			set myLen to duration of current track
			if myPos < 0 then set mypPos to 0
			if myPos > myLen then set myPos to myLen
			set player position to (myPos as real)
		end tell
	end setRelativePlayHeadPosition_
	
	on setPlayHeadPositionToEnd()
		if FLUtils's isiTunesLaunched() is false then return
		
		tell application id "com.apple.iTunes"
			set player position to (duration of current track as real)
		end tell
	end setPlayHeadPositionToEnd
	
	
	
	-- -- Class Methods -- --
	
	-- -- Private Methods -- --
	
end script