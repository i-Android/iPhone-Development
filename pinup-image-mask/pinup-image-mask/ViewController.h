//
//  ViewController.h
//  accelerometer_image
//
//  Created by ROBERT TILTON on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAccelerometerDelegate>{
    CGPoint delta; //the change that occurs in the balls location

    IBOutlet UIImageView * dress;
    CGFloat dressHeight;
}

@property CGPoint delta;
@property CGFloat dressHeight;
@property UIImageView * dress;
@end