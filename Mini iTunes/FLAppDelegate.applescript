--
--  FLAppDelegate.applescript
--  Mini iTunes
--
--  Created by François LAMBOLEY on 12/9/12.
--  Copyright (c) 2012 Frost Land. All rights reserved.
--

script FLAppDelegate
	property parent: class "NSObject"
	
	-- -- -- Properties -- -- --
	
	-- Class "imports"
	property NSTimer: class "NSTimer"
	property FLMainWindowController: class "FLMainWindowController"
	
	-- Actual Properties
	property mainWindowController: null
	
	-- -- -- Methods -- -- --
	
	-- -- Private Methods -- --
	to isiTunesLaunched()
		tell application "System Events" to return (exists (some process whose name is "iTunes"))
	end isiTunesLaunched

	on iTunesStatusUpdate_(timer)
		if my isiTunesLaunched() is false then
			return
		end if
		
		-- We can communicate with iTunes here
		tell application id "com.apple.iTunes"
			mainWindowController's toto()
		end tell
	end iTunesStatusUpdate_
	
	-- -- Application Delegate Implementation -- --
	
	on applicationWillFinishLaunching_(aNotification)
		-- Creating the main window controller and showing its window
		set mainWindowController to FLMainWindowController's alloc()'s initWithWindowNibName_("FLMainWindow")
		mainWindowController's showWindow_(null)
		
		-- Setting up iTunes Status Update timer
		NSTimer's scheduledTimerWithTimeInterval_target_selector_userInfo_repeats_(.25, me, "iTunesStatusUpdate:", null, 1)
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
	on applicationShouldTerminateAfterLastWindowClosed_(sender)
		return yes
	end applicationShouldTerminateAfterLastWindowClosed_
	
end script
