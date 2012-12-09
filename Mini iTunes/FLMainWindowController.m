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

@synthesize buttonPrevious;

- (id)initWithWindow:(NSWindow *)window
{
	if ((self = [super initWithWindow:window]) != nil) {
	}
	
	return self;
}

- (void)windowDidLoad
{
	[super windowDidLoad];
	
	/* Let's init the UI */
}

- (void)toto
{
	NSLog(@"ok");
}

@end
