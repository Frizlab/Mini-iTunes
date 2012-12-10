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
			-- Don't set the var using:
			--   mainWindowController's setiTunesLaunched_(0)
			-- for the bindings to work. Even though the setter is re-defined
			-- in the Main Window Controller to setiTunesLaunched:, the binding
			-- will only work if one calls setITunesLaunched:
			set mainWindowController's iTunesLaunched to 0
			return
		end if
		set mainWindowController's iTunesLaunched to 1
		
		-- We can communicate with iTunes here
		tell application id "com.apple.iTunes"
			set is_paused to (player state is paused)
			set is_playing to (player state is playing)
			
			-- Don't set the var using:
			--   set mainWindowController's playing to is_playing
			-- If you do, you'll get a compilation error because the compiler
			-- won't understand you're trying to set the playing property
			-- of the Main Window Controller and will try to get the playing
			-- property of the iTunes app and fail
			mainWindowController's setPlaying_(is_playing)
			
			if (is_playing) then
				set mainWindowController's playPosition to 1
			else
				set mainWindowController's playPosition to 0
			end if
		end tell
	end iTunesStatusUpdate_
	
	-- -- Application Delegate Implementation -- --
	
	on applicationWillFinishLaunching_(aNotification)
		-- Creating the main window controller and showing its window
		set mainWindowController to FLMainWindowController's alloc()'s initWithWindowNibName_("FLMainWindow")
		mainWindowController's showWindow_(null)
		
		-- Setting up iTunes Status Update timer
		my iTunesStatusUpdate_(null)
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
