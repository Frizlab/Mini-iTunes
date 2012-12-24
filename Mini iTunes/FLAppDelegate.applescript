--
-- FLAppDelegate.applescript
-- Mini iTunes
--
-- Created by François LAMBOLEY on 12/9/12.
-- Copyright (c) 2012 Frost Land. All rights reserved.
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
	property FLUtils: class "FLUtils"
	
	-- Constants
	property FL_UDK_LAUNCH_ITUNES: "FL Launch iTunes"
	property FL_UDK_QUIT_WITH_ITUNES: "FL Quit With iTunes"
	property FL_UDK_ITUNES_CHECK_INTERVAL: "FL Interval Between Update"
	
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
	
	on initialize()
		parent's initialize()
		
		-- Registering the defaults
		set defaultValues to NSMutableDictionary's dictionary()
		
		defaultValues's setValue_forKey_(true, FL_UDK_LAUNCH_ITUNES)
		defaultValues's setValue_forKey_(true, FL_UDK_QUIT_WITH_ITUNES)
		defaultValues's setValue_forKey_(0.5, FL_UDK_ITUNES_CHECK_INTERVAL)
		
		standardUserDefaults's registerDefaults_(defaultValues)
	end initialize
	
	-- -- Private Methods -- --
	
	on iTunesStatusUpdate_(timer)
		-- mainWindowController's dumpInfos()
		
		if FLUtils's isiTunesLaunched() is false then
			if timer is missing value and standardUserDefaults's boolForKey_(FL_UDK_LAUNCH_ITUNES) then
				-- We're at first launch of the app and we should launch iTunes
				tell application id "com.apple.iTunes"
					activate
				end tell
				return
			else
				if (standardUserDefaults's boolForKey_(FL_UDK_QUIT_WITH_ITUNES)) then
					NSApplication's sharedApplication's terminate_(missing value)
				end if
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
				set mainWindowController's trackLength to 0
				set mainWindowController's playPosition to 0
				set mainWindowController's curTrackName to missing value
				set mainWindowController's curTrackAlbum to missing value
				set mainWindowController's curTrackArtist to missing value
			end if
		end tell
	end iTunesStatusUpdate_

	-- -- Application Delegate Implementation -- --
	
	on applicationWillFinishLaunching_(aNotification)
		-- Creating the main window controller and showing its window
		set mainWindowController to FLMainWindowController's alloc()'s initWithWindowNibName_("FLMainWindow")
		my showMainWindow_(me)
		
		-- Setting up iTunes Status Update timer
		my iTunesStatusUpdate_(missing value)
		NSTimer's scheduledTimerWithTimeInterval_target_selector_userInfo_repeats_(standardUserDefaults's floatForKey_(FL_UDK_ITUNES_CHECK_INTERVAL), me, "iTunesStatusUpdate:", null, 1)
	end applicationWillFinishLaunching_

	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
	on applicationShouldTerminateAfterLastWindowClosed_(sender)
		return yes
	end applicationShouldTerminateAfterLastWindowClosed_
	
end script
