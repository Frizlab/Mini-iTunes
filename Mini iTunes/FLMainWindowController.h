/*
 * FLMainWindowController.h
 * Mini iTunes
 *
 * Created by François LAMBOLEY on 12/9/12.
 * Copyright (c) 2012 Frost Land. All rights reserved.
 */

#import <Cocoa/Cocoa.h>

@interface FLMainWindowController : NSWindowController <NSWindowDelegate>

@property(retain) IBOutlet NSSlider *sliderVolume;

@property(retain) IBOutlet NSButton *buttonPrevious;

@property(assign, setter = setiTunesLaunched:) BOOL iTunesLaunched;

/* Between 0. and 1. */
@property(assign) CGFloat volume;
@property(assign) BOOL playing;
/* Between 0. and 1. */
@property(assign) CGFloat playPosition;

@property(retain) NSString *curTrackName;
@property(retain) NSString *curTrackAlbum;
@property(retain) NSString *curTrackArtist;
@property(retain, readonly) NSString *curTrackInfos;

@end
