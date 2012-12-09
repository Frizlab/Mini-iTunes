//
//  main.m
//  Mini iTunes
//
//  Created by François LAMBOLEY on 12/9/12.
//  Copyright (c) 2012 Frost Land. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, char *argv[])
{
	[[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
	return NSApplicationMain(argc, (const char **)argv);
}
