//
//  SquaresViewController.h
//  Squares
//
//  Created by Ben Scheirman on 3/5/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquaresViewController : UIViewController {
	NSMutableArray *squares;
}

-(IBAction)addTapped;
-(IBAction)randomizeTapped;
-(IBAction)removeTapped;

@end

