//
//  ViewController.h
//  scrollTo
//
//  Created by ROBERT TILTON on 10/5/12.
//  Copyright (c) 2012 ROBERT TILTON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    IBOutlet UIScrollView *scroller;
    IBOutlet UITextField * page1, *page2;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scroller;
@property (nonatomic, retain) IBOutlet UITextField *page1, *page2;

-(IBAction) scrollDown;
@end
