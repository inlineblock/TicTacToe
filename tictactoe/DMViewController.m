//
//  DMViewController.m
//  tictactoe
//
//  Created by Dennis Wilkins on 5/26/12.
//  Copyright (c) 2012 Delicious Morsel LLC. All rights reserved.
//

#import "DMViewController.h"

@implementation DMViewController
@synthesize _gameLabel = gameLabel , _gridView = gridView , _gridModel = gridModel , _currentPlayer = currentPlayer , _endGameButton = endGameButton;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self setupGame];
	[self startGame];
}

- (void)setupGame {
	[self._endGameButton addTarget:self action:@selector(resetGame) forControlEvents:UIControlEventTouchUpInside];
	self._gridModel = [[[DMGridModel alloc] init] autorelease];
	self._gridView = [[DMGridView alloc] init];
	[self setGridViewFrame];
	[self._gridView setDelegate: self];
	[self.view addSubview: self._gridView];
	[self._gridView buildGrid: self._gridModel._size];
}

- (void)resetGame {
	[self._gridView resetButtons];
	[self._gridModel resetGrid];
	[self startGame];
}

- (void)startGame {
	[self._endGameButton setTitle:@"" forState: UIControlStateNormal];
	[self._endGameButton setHidden:YES];
	self._currentPlayer = [NSNumber numberWithInt: 1 + (arc4random() % 2)];
	[self nextPlayerTurn];
}

- (void)updateGridView {
	[self setGridViewFrame];
	[self._gridView viewRotated];
}

- (void)setGridViewFrame {
	float availableX = self.view.bounds.size.width;
	float availableY = self.view.bounds.size.height;
	float tooltipBottom = self._gameLabel.bounds.origin.y + self._gameLabel.bounds.size.height;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		
	}
	
	CGRect frame = CGRectMake(0, tooltipBottom, availableX, availableY - tooltipBottom);
	[self._gridView setFrame: frame];
}

- (void)userClickedGridButton: (NSNumber *)buttonNumber {	if ([self._currentPlayer intValue] == 2) { 
		if ([self._gridModel setPlayer:[NSNumber numberWithInt:2] atGridLocation:buttonNumber]) {
			[self._gridView updateGridButton: buttonNumber withPlayer: [NSNumber numberWithInt:2]];
			[self endPlayerTurn];
		}
	}
}

- (void)endPlayerTurn {
	NSNumber *winner = [self._gridModel getWinner];
	if ([winner intValue] >= 0) { // game is over
		if ([winner intValue] == 1) {
			[self._endGameButton setTitle:@"You lose, play again?" forState:UIControlStateNormal];
		} else if ([winner intValue] == 2) {
			[self._endGameButton setTitle:@"You win, play again?" forState:UIControlStateNormal];
		} else {
			[self._endGameButton setTitle:@"DRAW, play again?" forState:UIControlStateNormal];
		}
		self._currentPlayer = [NSNumber numberWithInt:0]; // no ones turn.
		[self._endGameButton setHidden:NO];
		[self.view bringSubviewToFront:self._endGameButton];
		[self._gameLabel setText:@"Game Over!"];
	} else {
		[self nextPlayerTurn];
	}
	
}

- (void)nextPlayerTurn {
	if ([self._currentPlayer intValue] == 1) {
		self._currentPlayer = [NSNumber numberWithInt: [self._currentPlayer intValue] + 1];
		[self._gameLabel setText:@"Your turn."];
	} else {
		self._currentPlayer = [NSNumber numberWithInt: [self._currentPlayer intValue] - 1];
		[self._gameLabel setText:@"Thinking..."];
		[NSThread detachNewThreadSelector:@selector(startComputersTurn) toTarget:self withObject:nil];
	}
}

- (void)startComputersTurn {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	NSArray *bestMove = [DMMinimax getBestMoveForGrid: self._gridModel AndPlayer: [NSNumber numberWithInt:1] WithDepth: [NSNumber numberWithInt:0]];
	NSNumber *move = [bestMove objectAtIndex:0];
	if ([move intValue] < 0) {
		move = [self._gridModel getNextOpenSpot];
	}
	[self performSelectorOnMainThread:@selector(finishComputersTurnWithMove:) withObject:move waitUntilDone:YES];
	[pool release];
}

- (void)finishComputersTurnWithMove: (NSNumber *)move {
	
	[self._gridModel setPlayer:[NSNumber numberWithInt:1] atGridLocation:move];
	[self._gridView updateGridButton: move withPlayer: [NSNumber numberWithInt:1]];
	[self endPlayerTurn];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	[self updateGridView];
	return YES;
}

@end
