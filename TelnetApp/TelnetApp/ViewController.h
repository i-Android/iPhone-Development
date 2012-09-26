//
//  ViewController.h
//  TelnetApp
//
//  Created by ROBERT TILTON on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DragImage.h"
#import "DragView.h"

@interface ViewController : UIViewController 
                            <NSStreamDelegate, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate> {
                                
    //nav
    IBOutlet UITabBar *tabBar;
    IBOutlet UIImageView *tabImage;
    BOOL timerValid;
                                
    //settings variables
    IBOutlet UIView *joinView;
    IBOutlet UITextField *inputHostField;
    IBOutlet UITextField *inputPortField;
    IBOutlet UITextField *inputNameField;
    IBOutlet UIButton *joinHost;
    IBOutlet UIButton *addName;
    BOOL connected;
    int errorCounter;
    
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    
    //console variables
    IBOutlet UIView *consoleView;
    NSMutableArray * serverResponses;
    IBOutlet UITextField *inputMessageField;
    IBOutlet UITableView *tView;
    IBOutlet UIButton *sendMessage;
                                
    
    //joystick variables
    IBOutlet UIView *joypadView;
    IBOutlet DragImage *joybtn;
    NSTimer *timer;
//    CGPoint startPoint; 
//    BOOL touching;
    //IBOutlet UIImageView* joypad;
//    CGPoint touchPos;
//    float joybtnDistSquared,joybtnAngle;
//    BOOL isMovingJoybtn;
}



- (IBAction)joinHost:(id)sender; //connect to host button action
- (IBAction)addName:(id)sender; //add name button action
-(void)joyPadSend:(NSString *)moveAmount; //send left right up down commands
- (IBAction)sendMessage:(id)sender; //send message in console
- (void) messageReceived:(NSString *)message; //messages received in console
- (void) messageSent:(NSString *)message; //messages sent in console
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item; //function to toggle tabs

- (void)showActivity;
@end

