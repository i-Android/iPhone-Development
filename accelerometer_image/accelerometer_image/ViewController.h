//
//  ViewController.h
//  accelerometer_image
//
//  Created by ROBERT TILTON on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAccelerometerDelegate>{
    UIImageView * ball;
    CGPoint delta; //the change that occurs in the balls location
    
    float rotate;
}

@property (nonatomic, retain)IBOutlet UIImageView * ball;
@property CGPoint delta;
@property float rotate;

@end
