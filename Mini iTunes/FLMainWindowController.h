/*
 * FLMainWindowController.h
 * Mini iTunes
 *
 * Created by François LAMBOLEY on 12/9/12.
 * Copyright (c) 2012 Frost Land. All rights reserved.
 */

#import <Cocoa/Cocoa.h>

@interface FLMainWindowController : NSWindowController <NSWindowDelegate>

@property(retain) IBOutlet NSButton *buttonPrevious;

/* Between 0. and 1. */
- (void)setVolume:(CGFloat)volume;

@end
