//
//  SquaresAppDelegate.h
//  Squares
//
//  Created by Ben Scheirman on 3/5/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SquaresViewController;

@interface SquaresAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SquaresViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SquaresViewController *viewController;

@end

