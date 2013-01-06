/*
 * FLSecondsToHMSTransformer.m
 * Mini iTunes
 *
 * Created by François LAMBOLEY on 12/18/12.
 * Copyright (c) 2012 Frost Land. All rights reserved.
 */

#import "FLSecondsToHMSTransformer.h"

@implementation FLSecondsToHMSTransformer

+ (BOOL)allowsReverseTransformation
{
	return NO;
}

- (id)transformedValue:(id)value
{
	if (![value respondsToSelector:@selector(floatValue)])
		[NSException raise:@"Invalid Value" format:@"Got value \"%@\" to transform into HMS. Cannot do that as value does not respond to floatValue", value];
	
	float seconds = [value floatValue];
	BOOL minus = (seconds < 0);
	if (minus) seconds = -seconds;
	
	unsigned h = (unsigned)(seconds / 3600.);
	seconds -= h * 3600;
	unsigned m = (unsigned)(seconds / 60.);
	seconds -= m * 60;
	unsigned s = (unsigned)seconds;
	if (h==0)
		return [NSString stringWithFormat:@"%@%02u:%02u", minus? @"-": @"", m, s];
	return [NSString stringWithFormat:@"%@%02u:%02u:%02u", minus? @"-": @"", h, m, s];
}

@end
