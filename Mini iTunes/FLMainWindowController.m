/*
 * FLMainWindowController.m
 * Mini iTunes
 *
 * Created by François LAMBOLEY on 12/9/12.
 * Copyright (c) 2012 Frost Land. All rights reserved.
 */

#import "FLMainWindowController.h"
#import "FLSecondsToHMSTransformer.h"
#import "FLConstants.h"


@interface FLMainWindowController ()

@end


@implementation FLMainWindowController
 
@synthesize sliderVolume;
@synthesize buttonPrevious;
@synthesize buttonTimeDisplay;
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
									  [NSArray arrayWithObject:@"curTrackInfos"], @"curTrackArtist",
									  [NSArray arrayWithObject:@"imagePlayButton"], @"playerState",
									  [NSArray arrayWithObject:@"trackTimeDisplay"], @"playPosition",
									  [NSArray arrayWithObject:@"trackTimeDisplay"], @"trackLength",
									  nil] retain];
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
	[buttonTimeDisplay bind:@"title"
						toObject:self
					withKeyPath:@"trackTimeDisplay"
						 options:[NSDictionary dictionaryWithObject:[[FLSecondsToHMSTransformer new] autorelease] forKey:NSValueTransformerBindingOption]];
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

- (IBAction)toggleTime:(id)sender
{
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
	[self willChangeValueForKey:@"trackTimeDisplay"];
	[ud setBool:![ud boolForKey:FL_UDK_SHOW_REMAINING_TIME] forKey:FL_UDK_SHOW_REMAINING_TIME];
	[self didChangeValueForKey:@"trackTimeDisplay"];
}


- (IBAction)playHeadPositionChanged:(id)sender
{
	[iTunesController setPlayHeadPosition:[NSNumber numberWithFloat: [sender floatValue]]];
}

- (IBAction)volumeChanged:(id)sender
{
	[iTunesController setiTunesVolume:[NSNumber numberWithFloat: [sender floatValue]*100]];
}


#pragma mark - NSWindow Delegate
- (BOOL) windowShouldZoom:(NSWindow *)window toFrame:(NSRect)newFrame
{
	[iTunesController deiconizeiTunes];
	return NO;
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

- (CGFloat)trackTimeDisplay
{
	if ([[NSUserDefaults standardUserDefaults] boolForKey:FL_UDK_SHOW_REMAINING_TIME])
		return playPosition-trackLength;
	return trackLength;
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
