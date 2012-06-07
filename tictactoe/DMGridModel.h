//
//  DMGridModel.h
//  tictactoe
//
//  Created by Dennis Wilkins on 5/26/12.
//  Copyright (c) 2012 Delicious Morsel LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMGridModel : NSObject {
	NSMutableArray *_grid;
	NSMutableArray *_solves;
	NSNumber *_size;
}

@property (nonatomic , retain) NSMutableArray *_grid;
@property (nonatomic , retain) NSMutableArray *_solves;
@property (nonatomic , retain) NSNumber *_size;

- (id)init;
- (id)initWithSize:(NSNumber *) gridSize;
- (void)resetGrid;
- (BOOL)setPlayer: (NSNumber *)player atGridLocation: (NSNumber *)location;
- (void)createSolvables;
- (NSNumber *)getWinner;

@end
