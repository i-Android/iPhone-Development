//
//  ViewController.m
//  shake
//
//  Created by ROBERT TILTON on 6/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (BOOL)canBecomeFirstResponder{
    return YES;
}

//app is shaken
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    if(event.subtype == UIEventSubtypeMotionShake){
        label.text = @"NICE JOB!";
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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
