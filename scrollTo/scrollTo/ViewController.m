//
//  ViewController.m
//  scrollTo
//
//  Created by ROBERT TILTON on 10/5/12.
//  Copyright (c) 2012 ROBERT TILTON. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize scroller, page1, page2;

- (void)viewDidLoad{
    //change background size
    [scroller setBackgroundColor:[UIColor purpleColor]];
    [scroller setContentSize:CGSizeMake(640,2000)];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) scrollDown{    
//    CGPoint bottomOffset = CGPointMake(0, [scroller contentSize].height);
    CGPoint bottomOffset = CGPointMake(0, 550);
    [scroller setContentOffset:bottomOffset animated:YES];
    NSLog(@"%f",[scroller contentSize].height);
}
@end
