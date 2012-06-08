//
//  AppDelegate.h
//  pageControl
//
//  Created by ROBERT TILTON on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : NSObject {
    
    UIWindow * window;
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    NSMutableArray * viewControllers;
    
    BOOL pageControlUsed;
    
}



@property (nonatomic, retain) IBOutlet UIWindow * window;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;

-(IBAction)changePage:(id)sender;


@end

//
//@interface AppDelegate : UIResponder <UIApplicationDelegate>
//
//@property (strong, nonatomic) UIWindow *window;
//
//@end
