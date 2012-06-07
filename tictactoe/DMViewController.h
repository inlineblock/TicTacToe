//
//  DMViewController.h
//  tictactoe
//
//  Created by Dennis Wilkins on 5/26/12.
//  Copyright (c) 2012 Delicious Morsel LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <stdlib.h>
#import "DMGridView.h"
#import "DMGridModel.h"
#import "DMMinimax.h"

@interface DMViewController : UIViewController {
	IBOutlet UILabel *_gameLabel;
	IBOutlet UIButton *_endGameButton;
	DMGridModel *_gridModel;
	DMGridView *_gridView;
	NSNumber *_currentPlayer;
}


@property (retain , nonatomic) IBOutlet UILabel *_gameLabel;
@property (retain , nonatomic) IBOutlet UIButton *_endGameButton;
@property (retain , nonatomic) DMGridModel *_gridModel;
@property (retain , nonatomic) DMGridView *_gridView;
@property (retain , nonatomic) NSNumber *_currentPlayer;

- (void)viewDidLoad;
- (void)setupGame;
- (void)resetGame;
- (void)startGame;
- (void)updateGridView;
- (void)setGridViewFrame;
- (void)userClickedGridButton: (NSNumber *)buttonNumber;
- (void)endPlayerTurn;
- (void)nextPlayerTurn;
- (void)startComputersTurn;
- (void)finishComputersTurnWithMove: (NSNumber *)move;
- (void)viewDidUnload;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
