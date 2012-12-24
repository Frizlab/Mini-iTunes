/*
 * FLiTunesControllerProxy.m
 * Mini iTunes
 *
 * Created by François LAMBOLEY on 12/18/12.
 * Copyright (c) 2012 Frost Land. All rights reserved.
 */

#import "FLiTunesControllerProxy.h"



@implementation FLiTunesControllerProxy

- (id)init
{
	if ((self = [super init]) != nil) {
		iTunesControllerInstance = [NSClassFromString(@"FLiTunesController") new];
	}
	
	return self;
}

- (void)dealloc
{
	[iTunesControllerInstance release];
	
	[super dealloc];
}

- (void)playpause
{
	[iTunesControllerInstance playpause];
}

- (void)playNext
{
	[iTunesControllerInstance playNext];
}

- (void)playPrevious
{
	[iTunesControllerInstance playPrevious];
}

- (void)setPlayHeadPosition: (NSNumber*) value
{
	[iTunesControllerInstance setPlayHeadPosition: value];
}

- (void)setiTunesVolume: (NSNumber*) value
{
	[iTunesControllerInstance setiTunesVolume: value];
}

- (void)deiconizeiTunes
{
	[iTunesControllerInstance deiconizeiTunes];
}



@end
