//
//  ViewController.h
//  helloWorld
//
//  Created by ROBERT TILTON on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{

    UILabel * textLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *textLabel;

- (IBAction)changeTheTextOfTheLabel;

@end
