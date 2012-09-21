//
//  SimpleDraggingAppDelegate.h
//  SimpleDragging
//
//  Created by Alex Nichol on 11/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimpleDraggingViewController;

@interface SimpleDraggingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SimpleDraggingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SimpleDraggingViewController *viewController;

@end

