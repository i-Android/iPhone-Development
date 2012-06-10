//
//  ViewController.h
//  shake
//
//  Created by ROBERT TILTON on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAccelerometerDelegate>{
    IBOutlet UILabel *label;
    
    IBOutlet UIImageView *bottle, *ketchup, *shadow, *bg;
    CGPoint delta; //the change that occurs in the ketchup
    BOOL shake; //see if user is shaking app
    
    CFTimeInterval thisFrameStartTime, prevFrameStartTime; //shake speed interval
}

@property (nonatomic, retain) UIImageView * bottle, *ketchup, *shadow, *bg;
@property BOOL shake;
@property CGPoint delta;
@property CFTimeInterval thisFrameStartTime, prevFrameStartTime;

@end
