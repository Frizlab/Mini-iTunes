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
		self.volume = 0.;
		self.iTunesLaunched = NO;
		self.playerState = FLPlayerStateStopped;
		
		[self addObserver:self forKeyPath:@"curTrackAlbum" options:NSKeyValueObservingOptionPrior context:NULL];
		[self addObserver:self forKeyPath:@"curTrackArtist" options:NSKeyValueObservingOptionPrior context:NULL];
	}
	
	return self;
}

- (void)dealloc
{
	self.sliderVolume = nil;
	self.buttonPrevious = nil;
	
	[self removeObserver:self forKeyPath:@"curTrackAlbum"];
	[self removeObserver:self forKeyPath:@"curTrackArtist"];
	
	self.curTrackName = nil;
	self.curTrackAlbum = nil;
	self.curTrackArtist = nil;
	
	[super dealloc];
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
	NSLog(@"   Has Player Position? %d", self.hasPlayerPosition);
	NSLog(@"   Volume = %g", self.volume);
	NSLog(@"   Current Track Name = %@", self.curTrackName);
}

#pragma mark Overridden Properties

- (BOOL)hasPlayerPosition
{
	return (self.playerState != FLPlayerStateStopped);
}

- (NSString *)curTrackInfos
{
	if (!self.hasPlayerPosition) return nil;
	return [NSString stringWithFormat:@"%@%@%@", self.curTrackArtist, (self.curTrackArtist.length > 0 && self.curTrackAlbum.length > 0)? @" — ": @"", self.curTrackAlbum];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue]) [self willChangeValueForKey:@"curTrackInfos"];
	else                                                                          [self didChangeValueForKey:@"curTrackInfos"];
}

@end
