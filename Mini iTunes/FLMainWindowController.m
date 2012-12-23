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

@synthesize sliderVolume;
@synthesize buttonPrevious;
@synthesize iTunesLaunched;
@synthesize volume, playerState, hasPlayerPosition, imagePlayButton;
@synthesize playPosition, trackLength;
@synthesize curTrackName, curTrackAlbum, curTrackArtist, curTrackInfos;

- (id)initWithWindow:(NSWindow *)window
{
	if ((self = [super initWithWindow:window]) != nil) {
		iTunesController = [FLiTunesControllerProxy new];
		
		self.volume = 0.;
		self.iTunesLaunched = NO;
		self.playerState = FLPlayerStateStopped;
		
		keyPathComputation = [[NSDictionary dictionaryWithObjectsAndKeys:
									  [NSArray arrayWithObject:@"curTrackInfos"], @"curTrackAlbum",
									  [NSArray arrayWithObject:@"curTrackArtist"], @"curTrackAlbum",
									  [NSArray arrayWithObject:@"imagePlayButton"], @"playerState", nil
									  ] retain];
		for (NSString *key in keyPathComputation.allKeys)
			[self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionPrior context:NULL];
	}
	
	return self;
}

- (void)dealloc
{
	for (NSString *key in keyPathComputation.allKeys)
		[self removeObserver:self forKeyPath:key];
	
	[keyPathComputation release];
	
	
	self.sliderVolume = nil;
	self.buttonPrevious = nil;
	
	self.curTrackName = nil;
	self.curTrackAlbum = nil;
	self.curTrackArtist = nil;
	
	[iTunesController release];
	
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

#pragma mark - Actions

- (IBAction)playpauseAction:(id)sender
{
	[iTunesController playpause];
}

- (IBAction)previousAction:(id)sender
{
	[iTunesController playPrevious];
}

- (IBAction)nextAction:(id)sender
{
	[iTunesController playNext];
}

#pragma mark - Overridden Properties

- (NSImage *)imagePlayButton
{
	switch (self.playerState) {
		case FLPlayerStatePlaying: /* No Break */
		case FLPlayerStateFastForwarding: /* No Break */
		case FLPlayerStateRewinding: /* No Break */
			return [NSImage imageNamed:@"pause"];
		case FLPlayerStateStopped:
		case FLPlayerStatePaused:
			return [NSImage imageNamed:@"play"];
		default:
			NSLog(@"*** Warning: Unknown player state %d", (int)self.playerState);
			return nil;
	}
}

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
	if ([[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue]) {
		for (NSString *key in [keyPathComputation objectForKey:keyPath])
			[self willChangeValueForKey:key];
	} else {
		for (NSString *key in [keyPathComputation objectForKey:keyPath])
			[self didChangeValueForKey:key];
	}
}

@end
