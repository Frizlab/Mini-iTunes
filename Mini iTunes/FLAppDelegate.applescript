--
--  FLAppDelegate.applescript
--  Mini iTunes
--
--  Created by François LAMBOLEY on 12/9/12.
--  Copyright (c) 2012 Frost Land. All rights reserved.
--

script FLAppDelegate
	property parent : class "NSObject"
	
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened 
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script