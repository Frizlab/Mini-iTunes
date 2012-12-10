/*
 * FLMainWindowController.m
 * Mini iTunes
 *
 * Created by François LAMBOLEY on 12/9/12.
 * Copyright (c) 2012 Frost Land. All rights reserved.
 */

#import "FLMainWindowController.h"



@interface FLMainWindowController ()

@end


@implementation FLMainWindowController

- (id)initWithWindow:(NSWindow *)window
{
	if ((self = [super initWithWindow:window]) != nil) {
		self.iTunesLaunched = NO;
		self.volume = 0.;
		self.playing = NO;
	}
	
	return self;
}

- (void)windowDidLoad
{
	[super windowDidLoad];
	
	/* Let's init the UI */
}

- (void)dumpInfos
{
	NSLog(@"Dumping Controller Infos:");
	NSLog(@"   iTunes Launched? %d", self.iTunesLaunched);
	NSLog(@"   Playing? %d", self.playing);
	NSLog(@"   Volume = %g", self.volume);
}

#pragma mark Overridden Properties

- (NSString *)curTrackInfos
{
	if (!self.playing) return nil;
	return @"The Track Infos";
}

@end
