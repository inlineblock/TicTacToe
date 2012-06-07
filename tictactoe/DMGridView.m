//
//  DMGridView.m
//  tictactoe
//
//  Created by Dennis Wilkins on 5/26/12.
//  Copyright (c) 2012 Delicious Morsel LLC. All rights reserved.
//

#import "DMGridView.h"

@implementation DMGridView
@synthesize delegate , _buttons = buttons , _gridSize = gridSize;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)buildGrid:(NSNumber *)size {
	self._gridSize = size;
	int panelsCount = [size intValue] * [size intValue];
	int i;
	self._buttons = [NSMutableArray arrayWithCapacity:panelsCount];
	DMGridButton *btn;
	for (i = 0; i < panelsCount; i++) {
		btn = [[DMGridButton alloc] init];
		[btn addTarget:self action:@selector(onGridButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btn];
		[self._buttons addObject:btn];
		[btn release];
	}
	[self buildGridPanels];
}

- (void)buildGridPanels {
	float top;
	float left;
	float size;
	if (self.frame.size.height > self.frame.size.width) {
		left = 0;
		top = (self.frame.size.height / 2) - (self.frame.size.width / 2);
		size = self.frame.size.width;
	} else {
		top = 0;
		left = (self.frame.size.width / 2) - (self.frame.size.height / 2);
		size = self.frame.size.height;
	}
	int i;
	DMGridButton *btn;
	float btnSize = size / [self._gridSize floatValue];
	for(i = 0; i < [self._buttons count]; i++) {
		btn = [self._buttons objectAtIndex:i];
		[btn setFrame: CGRectMake((i % [self._gridSize intValue] * btnSize) + left, (floor(i / [self._gridSize floatValue]) * btnSize) + top, btnSize, btnSize)];
	}
}

- (void)resetButtons {
	int i;
	for (i = 0; i < [self._buttons count]; i++) {
		[[self._buttons objectAtIndex:i] reset];
	}
}

- (void)updateGridButton: (NSNumber *)gridButton withPlayer: (NSNumber *) player {
	[[self._buttons objectAtIndex:[gridButton unsignedIntValue]] setPlayer: player];
	
}

- (void)onGridButtonTouch: (UIButton *)btn {
	NSNumber *i = [NSNumber numberWithUnsignedInt: [self._buttons indexOfObject: btn]];
	
	if (self.delegate && [self.delegate respondsToSelector: @selector(userClickedGridButton:)]) {
		[self.delegate userClickedGridButton: i];
	}
}

- (void)viewRotated {
	if (self._buttons != [NSNull null]) {
		[self buildGridPanels];
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
