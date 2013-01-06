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
	if (theEvent.type == NSKeyDown) {
		if ([theEvent modifierFlags] & NSNumericPadKeyMask) { // arrow keys have this mask
			NSString *theArrow = [theEvent charactersIgnoringModifiers];
			unichar keyChar = 0;
			if ( [theArrow length] == 1 ) {
            keyChar = [theArrow characterAtIndex:0];
            if ( keyChar == NSLeftArrowFunctionKey ) {
					FLiTunesControllerProxy *proxy = [FLiTunesControllerProxy new];
					[proxy setRelativePlayHeadPosition: [NSNumber numberWithInt:-10]];
					[proxy release];
					return;
            }
            if ( keyChar == NSRightArrowFunctionKey ) {
					if ([theEvent modifierFlags] & NSCommandKeyMask) {
						FLiTunesControllerProxy *proxy = [FLiTunesControllerProxy new];
						[proxy setPlayHeadPositionToEnd];
						[proxy release];
						return;
					} else {
						FLiTunesControllerProxy *proxy = [FLiTunesControllerProxy new];
						[proxy setRelativePlayHeadPosition: [NSNumber numberWithInt:+10]];
						[proxy release];
						return;
					}
            }
            if ( keyChar == NSUpArrowFunctionKey ) {
					// maybe something here one day
					// return;
            }
            if ( keyChar == NSDownArrowFunctionKey ) {
					// maybe something here one day
					// return;
            }
			}
		}
	}
	[super sendEvent:theEvent];
}


@end
