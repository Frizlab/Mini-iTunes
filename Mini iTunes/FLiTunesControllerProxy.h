/*
 * FLiTunesControllerProxy.h
 * Mini iTunes
 *
 * Created by François LAMBOLEY on 12/18/12.
 * Copyright (c) 2012 Frost Land. All rights reserved.
 */

#import <Cocoa/Cocoa.h>



@interface FLiTunesControllerProxy : NSObject {
	id iTunesControllerInstance;
}

- (void)playpause;

- (void)playNext;
- (void)playPrevious;

@end
