//
//  FLApplication.m
//  Mini iTunes
//
//  Created by Papa on 06/01/13.
//  Copyright 2013 Frost Land. All rights reserved.
//

#import "FLApplication.h"
#import "FLiTunesControllerProxy.h"

@implementation FLApplication

- (void)sendEvent:(NSEvent *)theEvent
{
	if (theEvent.type == NSEventTypeKeyDown) {
		NSResponder *firstResponder = self.mainWindow.firstResponder;
		NSString *eventCharacters = [theEvent charactersIgnoringModifiers];
		if (firstResponder == self.mainWindow /* If the first responder is not the main window we probably won't want to intercept the keys */ &&
			 ([theEvent modifierFlags] & NSEventModifierFlagNumericPad /* Arrow keys */ || [eventCharacters isEqualToString:@" "])) {
			unichar keyChar = 0;
			if ([eventCharacters length] == 1) {
            keyChar = [eventCharacters characterAtIndex:0];
				switch (keyChar) {
					case NSLeftArrowFunctionKey: {
						FLiTunesControllerProxy *proxy = [FLiTunesControllerProxy new];
						[proxy setRelativePlayHeadPosition: [NSNumber numberWithInt:-10]];
						[proxy release];
						return;
					}
					case NSRightArrowFunctionKey: {
						FLiTunesControllerProxy *proxy = [FLiTunesControllerProxy new];
						if ([theEvent modifierFlags] & NSEventModifierFlagCommand) {
							[proxy setPlayHeadPositionToEnd];
						} else {
							[proxy setRelativePlayHeadPosition: [NSNumber numberWithInt:+10]];
						}
						[proxy release];
						return;
					}
					case NSUpArrowFunctionKey:   /* Nothing done currently */ break;
					case NSDownArrowFunctionKey: /* Nothing done currently */ break;
					case ' ': {
						FLiTunesControllerProxy *proxy = [FLiTunesControllerProxy new];
						[proxy playpause];
						[proxy release];
						return;
					}
				}
			}
		}
	}
	[super sendEvent:theEvent];
}


@end
