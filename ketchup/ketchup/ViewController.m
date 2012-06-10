//
//  ViewController.m
//  shake
//
//  Created by ROBERT TILTON on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController
@synthesize bottle, ketchup, shadow, bg, delta, shake, thisFrameStartTime, prevFrameStartTime;

- (BOOL)canBecomeFirstResponder{
    return YES;
}

//app is shaken
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    if(event.subtype == UIEventSubtypeMotionShake){
        shake = YES;
        prevFrameStartTime = CFAbsoluteTimeGetCurrent();
    }else{
        shake = NO;
    }
    
}


- (void)viewDidAppear:(BOOL)animated{
    
    [self becomeFirstResponder];
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self resignFirstResponder];
    
    [super viewWillDisappear:animated];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    //code to declare an image without Interface Builder
    UIImage * image4 = [UIImage imageNamed:@"bg.png"];
    bg = [[UIImageView alloc] initWithImage:image4];
    bg.frame = CGRectMake(0, 0, 320, 460);
    [self.view addSubview:bg];
    [bg release];
    
    UIImage * image3 = [UIImage imageNamed:@"shadow.png"];
    shadow = [[UIImageView alloc] initWithImage:image3];
    shadow.frame = CGRectMake(55,360, 206, 94);
    [self.view addSubview:shadow];
    [shadow release];
    
    UIImage * image2 = [UIImage imageNamed:@"ketchup.png"];
    ketchup = [[UIImageView alloc] initWithImage:image2];
    ketchup.frame = CGRectMake(130, 70, 49, 350);
    [self.view addSubview:ketchup];
    [ketchup release];
    
    UIImage * image1 = [UIImage imageNamed:@"bottle.png"];
    bottle = [[UIImageView alloc] initWithImage:image1];
    bottle.frame = CGRectMake(98, 35,119,384);
    [self.view addSubview:bottle];
    [bottle release];
    
    //accelerometer data
    UIAccelerometer * accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1.0f / 60.0f; //get data 60 frames per second
}


- (void)accelerometer:(UIAccelerometer *)accelerometer 
        didAccelerate:(UIAcceleration *)acceleration{
    
    //NSLog(@"x: %g", acceleration.x); //prints x of acceleration
    //NSLog(@"y: %g", acceleration.y); //prints y of acceleration
    //NSLog(@"z: %g", acceleration.z); //prints z of acceleration
    //NSLog(@"BOOL = %@\n", (shake ? @"YES" : @"NO"));
    
    thisFrameStartTime = CFAbsoluteTimeGetCurrent();
    

    if(shake){
        delta.y = acceleration.y;
    
        if(thisFrameStartTime >= prevFrameStartTime + 1){
            shake = NO;
        }
    }else {
        delta.y = acceleration.y * 0.3;
    }
    
    
    if(delta.y > 0){
        ketchup.center = CGPointMake(158, ketchup.center.y - delta.y);
    }else {
        ketchup.center = CGPointMake(158, ketchup.center.y - (delta.y*.2));//reversing is slower
    }
    
    NSLog(@"center: %g", ketchup.center.y);
    if(ketchup.center.y < -138){
        ketchup.center = CGPointMake(158, -138);
    }
    if(ketchup.center.y > 244){
        ketchup.center = CGPointMake(158, 244);
    }
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
