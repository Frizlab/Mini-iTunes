/*
 * FLMainWindowController.h
 * Mini iTunes
 *
 * Created by François LAMBOLEY on 12/9/12.
 * Copyright (c) 2012 Frost Land. All rights reserved.
 */

#import <Cocoa/Cocoa.h>

#import "FLiTunesControllerProxy.h"


typedef enum FLiTunesPlayerState {
	FLPlayerStateStopped = 0,
	FLPlayerStatePlaying = 1,
	FLPlayerStatePaused = 2,
	FLPlayerStateFastForwarding = 3,
	FLPlayerStateRewinding = 4
} FLiTunesPlayerState;


@interface FLMainWindowController : NSWindowController <NSWindowDelegate> {
	FLiTunesControllerProxy *iTunesController;
	
@private
	NSDictionary *keyPathComputation;
}

@property(retain) IBOutlet NSSlider *sliderVolume;

@property(retain) IBOutlet NSButton *buttonPrevious;

@property(assign, setter = setiTunesLaunched:) BOOL iTunesLaunched;

/* Between 0. and 1. */
@property(assign) CGFloat volume;
@property(assign) FLiTunesPlayerState playerState;
@property(readonly) BOOL hasPlayerPosition; /* Computed from playerState */
@property(retain, readonly) NSImage *imagePlayButton; /* Computed from playerState */

/* In seconds from the beginning of the track */
@property(assign) CGFloat playPosition;
/* In seconds */
@property(assign) CGFloat trackLength;

@property(retain) NSString *curTrackName;
@property(retain) NSString *curTrackAlbum;
@property(retain) NSString *curTrackArtist;
@property(retain, readonly) NSString *curTrackInfos;

- (IBAction)playpauseAction:(id)sender;
- (IBAction)previousAction:(id)sender;
- (IBAction)nextAction:(id)sender;
- (IBAction)playHeadPositionChanged:(id)sender;

@end
