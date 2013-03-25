/*
 * FLPreferencesWindowController.m
 * Mini iTunes
 *
 * Created by François LAMBOLEY on 12/17/12.
 * Copyright (c) 2012 Frost Land. All rights reserved.
 */

#import "FLPreferencesWindowController.h"



@interface FLPreferencesWindowController ()

@end



@implementation FLPreferencesWindowController

@synthesize numberFormatter;

- (id)initWithWindow:(NSWindow *)window
{
	if ((self = [super initWithWindow:window]) != nil) {
	}
	
	return self;
}

- (void)dealloc
{
	self.numberFormatter = nil;
	
	[super dealloc];
}

- (void)windowDidLoad
{
	[super windowDidLoad];
	
	numberFormatter.minimum = @.03;
}

@end
