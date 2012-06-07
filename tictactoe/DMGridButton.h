//
//  DMGridButton.h
//  tictactoe
//
//  Created by Dennis Wilkins on 5/27/12.
//  Copyright (c) 2012 Delicious Morsel LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>



@interface DMGridButton : UIButton

- (id)init;
- (void) setFrame:(CGRect)frame;
- (void)reset;
- (void)setPlayer: (NSNumber *) player;

@end
