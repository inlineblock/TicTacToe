//
//  DMGridModel.m
//  tictactoe
//
//  Created by Dennis Wilkins on 5/26/12.
//  Copyright (c) 2012 Delicious Morsel LLC. All rights reserved.
//

#import "DMGridModel.h"

@implementation DMGridModel
@synthesize _grid = grid , _size = size , _solves = solves;

- (id)init {
	return [self initWithSize: [NSNumber numberWithUnsignedInt: 3]];
}

- (id)initWithSize:(NSNumber *) gridSize {
	self = [super init];
	self._size = gridSize;
	unsigned int fullSize = [gridSize unsignedIntValue] * [gridSize unsignedIntValue];
	self._grid = [NSMutableArray arrayWithCapacity: fullSize];
	for (int i = 0; i < fullSize; i++) {
		[self._grid insertObject:[NSNumber numberWithInt:0] atIndex:i];
	}
	[self createSolvables];
	
	return self;
}

- (void)resetGrid {
	for (int i = 0; i < [self._grid count]; i++) {
		[self._grid replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];
	}
}

- (BOOL)setPlayer: (NSNumber *)player atGridLocation: (NSNumber *)location {
	NSNumber *playerInSpace = [self._grid objectAtIndex: [location unsignedIntValue]];
	if ([playerInSpace isEqualToNumber: [NSNumber numberWithInt:0]]) {
		[self._grid replaceObjectAtIndex:[location unsignedIntValue] withObject:player];
		return YES;
	}
	return NO;
}

- (void)createSolvables {
	int gridSize = [self._size intValue];
	int solveSize = gridSize * 2 + 2;
	self._solves = [NSMutableArray arrayWithCapacity: solveSize];
	int y;
	int x;
	NSMutableArray *innerSolve; // solveable
	for(x=0; x < solveSize; x++) { // init them all up
		[self._solves addObject: [NSMutableArray arrayWithCapacity: gridSize]]; // pre init hte size, cause we know it.
	}
	for(x = 0; x < gridSize; x++) {
		for(y = 0; y < gridSize; y++) {
			
			innerSolve = [self._solves objectAtIndex:x];// X axis solves
			[innerSolve addObject: [NSNumber numberWithInt:(x * gridSize) + y]];
			
			innerSolve = [self._solves objectAtIndex: gridSize + y];// Y axis solves
			[innerSolve addObject: [NSNumber numberWithInt:(x * gridSize) + y]];
			
			if (x == y) {
				innerSolve = [self._solves objectAtIndex: gridSize * 2]; // top left going down diagnoally
				[innerSolve addObject: [NSNumber numberWithInt:(x * gridSize) + y]];
			}
			
			if ((x + y) == (gridSize - 1)) {
				innerSolve = [self._solves objectAtIndex: gridSize * 2 + 1]; // top right
				[innerSolve addObject: [NSNumber numberWithInt: x * gridSize + y]];
			}
		}
	}
}

- (NSNumber *)getWinner {
	int i;
	int j;
	NSMutableArray *solve;
	NSNumber *location;
	int player;
	int gridPlayer;
	NSNumber *gridLocationPlayer;
	for(i = 0; i < [self._solves count]; i++) {
		solve = [self._solves objectAtIndex:i];
		player = 0;
		for(j = 0; j < [solve count]; j++) {
			location = [solve objectAtIndex:j];
			gridLocationPlayer = [self._grid objectAtIndex: [location unsignedIntValue]];
			gridPlayer = [gridLocationPlayer intValue];
			if (gridPlayer == 0) {
				player = 0;
				break;
			}
			if (player > 0 && player != gridPlayer) {
				player = 0;
				break;
			} else {
				player = gridPlayer;
			}
		}
		
		if (player > 0) {
			return [NSNumber numberWithInt: player];
		}
	}
	/// check if its draw, or still in progress
	for (i = 0; i < [self._grid count]; i++) {
		if ([[self._grid objectAtIndex: i] intValue] == 0) {
			return [NSNumber numberWithInt: -1]; // -1 = in progress
		}
	}
	return [NSNumber numberWithInt: 0]; // 0 = draw
}

- (NSNumber *)getNextOpenSpot {
	int i = 0;
	int c = [self._grid count];
	NSNumber *playerAtGridLocation;
	for (i = 0; i < c; i++) {
		playerAtGridLocation = [self._grid objectAtIndex:i];
		if ([playerAtGridLocation intValue] == 0) {
			return [NSNumber numberWithInt:i];
		}
	}
	return [NSNumber numberWithInt:-1];
}

- (void)dealloc {
	self._grid = nil;
	self._size = nil;
	self._solves = nil;
}
@end
