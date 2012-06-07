//
//  DMGridButton.m
//  tictactoe
//
//  Created by Dennis Wilkins on 5/27/12.
//  Copyright (c) 2012 Delicious Morsel LLC. All rights reserved.
//

#import "DMGridButton.h"

@implementation DMGridButton
- (id)init {
	self = [super init];
	[self setBackgroundColor:[UIColor colorWithRed:0.7294 green:0.8515625 blue:0.333 alpha:1]];
	[self.layer setBorderColor:[[UIColor blackColor] CGColor]];
	[self.layer setBorderWidth:2.0f];
	
	return self;
}
- (void) setFrame:(CGRect)frame	{
	
	[super setFrame:frame];
	self.titleLabel.font = [UIFont boldSystemFontOfSize: self.frame.size.height];
}
- (void)reset {
	[self setTitle:@"" forState:UIControlStateNormal];
	[self setUserInteractionEnabled: YES];
}

- (void)setPlayer: (NSNumber *) player {
	if ([player intValue] == 1) {
		[self setTitle:@"x" forState:UIControlStateNormal];
	} else {
		[self setTitle:@"o" forState:UIControlStateNormal];
	}
	[self setUserInteractionEnabled: NO];
}

@end
