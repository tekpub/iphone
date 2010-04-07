//
//  SquaresAppDelegate.m
//  Squares
//
//  Created by Ben Scheirman on 3/5/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "SquaresAppDelegate.h"
#import "SquaresViewController.h"

@implementation SquaresAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
