//
//  DMGridView.h
//  tictactoe
//
//  Created by Dennis Wilkins on 5/26/12.
//  Copyright (c) 2012 Delicious Morsel LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMGridButton.h"

@interface DMGridView : UIView {
	id delegate;
	NSMutableArray *_buttons;
	NSNumber *_gridSize;
}

@property (nonatomic , retain) id delegate;
@property (nonatomic , retain) NSMutableArray *_buttons;
@property (nonatomic , retain) NSNumber *_gridSize;

- (id)initWithFrame:(CGRect)frame;
- (void)buildGrid:(NSNumber *)size;
- (void)buildGridPanels;
- (void)resetButtons;
- (void)updateGridButton: (NSNumber *)gridButton withPlayer: (NSNumber *) player;
- (void)onGridButtonTouch: (UIButton *)btn;
- (void)viewRotated;

@end
