//
//  DMMinimax.h
//  tictactoe
//
//  Created by Dennis Wilkins on 5/27/12.
//  Copyright (c) 2012 Delicious Morsel LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMGridModel.h"
@interface DMMinimax : NSObject
+ (NSArray *)getBestMoveForGrid: (DMGridModel *)gridModel AndPlayer: (NSNumber *)player WithDepth: (NSNumber *)depth;
@end
