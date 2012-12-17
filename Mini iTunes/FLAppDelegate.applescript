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
	property NSApplication: class "NSApplication"
	property NSUserDefaults: class "NSUserDefaults"
	property NSMutableDictionary: class "NSMutableDictionary"
	property FLMainWindowController: class "FLMainWindowController"
	property FLPreferencesWindowController: class "FLPreferencesWindowController"
	
	-- Constants
	property FL_UDK_LAUNCH_ITUNES: "FL Launch iTunes"
	property FL_UDK_QUIT_WITH_ITUNES: "FL Quit With iTunes"
	
	-- Actual Properties
	property standardUserDefaults: NSUserDefaults's standardUserDefaults
	property mainWindowController: missing value
	property preferencesWindowController: missing value
	
	-- -- -- Methods -- -- --
	
	on showMainWindow_(sender)
		mainWindowController's showWindow_(null)
	end showMainWindow_
	
	on showPrefs_(sender)
		-- Creating the pref window controller if needed and showing its window
		if preferencesWindowController = missing value then
			set preferencesWindowController to FLPreferencesWindowController's alloc()'s initWithWindowNibName_("FLPreferencesWindow")
		end if
		preferencesWindowController's showWindow_(null)
	end showPrefs_
	
	-- -- Class Methods -- --
	
	-- -- Private Methods -- --
	on isiTunesLaunched()
		tell application "System Events" to return (exists (some process whose name is "iTunes"))
	end isiTunesLaunched
	
	on iTunesStatusUpdate_(timer)
		-- mainWindowController's dumpInfos()
		
		if isiTunesLaunched() is false then
			if (standardUserDefaults's boolForKey_(FL_UDK_QUIT_WITH_ITUNES))
				NSApplication's sharedApplication's terminate_(missing value)
			end if
			
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
			-- Setting iTunes Volume
			set mainWindowController's volume to sound volume / 100
			
			-- Setting Player State
			if (player state is stopped)
				set mainWindowController's playerState to 0
			else if (player state is playing)
				set mainWindowController's playerState to 1
			else if (player state is paused)
				set mainWindowController's playerState to 2
			else if (player state is fast forwarding)
				set mainWindowController's playerState to 3
			else if (player state is rewinding)
				set mainWindowController's playerState to 4
			else
				log "*** Warning: Got unknown player state"
				set mainWindowController's playerState to 0
			end if
			
			if (mainWindowController's hasPlayerPosition) then
				set mainWindowController's playPosition to player position
				set mainWindowController's trackLength to duration of current track
				set mainWindowController's curTrackName to name of current track
				set mainWindowController's curTrackAlbum to album of current track
				set mainWindowController's curTrackArtist to artist of current track
			else
				-- nil in Obj-C --> missing value in AppleScript
				set mainWindowController's curTrackName to missing value
				set mainWindowController's curTrackAlbum to missing value
				set mainWindowController's curTrackArtist to missing value
			end if
		end tell
	end iTunesStatusUpdate_

	-- -- Application Delegate Implementation -- --
	
	on applicationWillFinishLaunching_(aNotification)
		-- Registering the defaults
		set defaultValues to NSMutableDictionary's dictionary()
		
		defaultValues's setValue_forKey_(true, FL_UDK_LAUNCH_ITUNES)
		defaultValues's setValue_forKey_(true, FL_UDK_QUIT_WITH_ITUNES)
		
		standardUserDefaults's registerDefaults_(defaultValues)
		
		-- Creating the main window controller and showing its window
		set mainWindowController to FLMainWindowController's alloc()'s initWithWindowNibName_("FLMainWindow")
		my showMainWindow_(me)
		
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
