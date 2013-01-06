/*
 * main.m
 * Mini iTunes
 *
 * Created by François LAMBOLEY on 12/9/12.
 * Copyright (c) 2012 Frost Land. All rights reserved.
 */

#import <Cocoa/Cocoa.h>

#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, char *argv[])
{
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	[[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
	[pool drain];
	return NSApplicationMain(argc, (const char **)argv);
}
