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
- (void)setPlayHeadPosition:(NSNumber *)value;
- (void)setiTunesVolume:(NSNumber *)value;
- (void)deiconizeiTunes;
- (void)setRelativePlayHeadPosition:(NSNumber *)value;

@end
