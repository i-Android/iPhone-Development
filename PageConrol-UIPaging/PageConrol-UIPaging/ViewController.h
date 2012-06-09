//
//  ViewController.h
//  PageConrol-UIPaging
//
//  Created by ROBERT TILTON on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewDelegate> {
	UIScrollView* scrollView;
	UIPageControl* pageControl;
	
    BOOL pageControlBeingUsed;
}

@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIPageControl* pageControl;

- (IBAction)changePage;

@end