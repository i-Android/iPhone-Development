//
//  ViewController.h
//  TelnetController
//
//  Created by ROBERT TILTON on 1/12/13.
//  Copyright (c) 2013 ROBERT TILTON. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DragImage.h"

@interface ViewController : UIViewController
                            <NSStreamDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
                
    UIScrollView *mainScrollView;
    UIImageView *mainbg, *logo, *tooltipSlider, *statusImage, *statusReflecImg, *consoleImage, *consoleReflecImg;
    UIButton *connectBtn, *saveBtn, *editBtn, *editBtn2, *disconnetBtn, *sendBtn;
    UITextField *inputHostField, *inputPortField, *inputNameField,
                *upField, *rightField, *downField, *leftField, *inputConsoleField;
    UILabel *secondsLabel, *secondsNote, *statusLabel;
    UIView *sliderView, *joystickView;
                                
    BOOL connected;
    int errorCounter, secondsValue, section;
    
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    NSMutableArray * serverResponses;
                                
    UIFont *consoleFont;
    UITableView * tView;
                                
    DragImage *joystick;
                                
    CGPoint startPoint;
}

@property (nonatomic, retain) UIScrollView *mainScrollView;
@property (nonatomic, retain) UIView *sliderView, *joystickView;
@property (nonatomic, retain) UIImageView *mainbg, *logo, *tooltipSlider, *statusImage,
                                *statusReflecImg, *consoleImage, *consoleReflecImg;
@property (nonatomic, retain) UIButton *connectBtn, *saveBtn, *editBtn, *editBtn2, *disconnetBtn, *sendBtn;
@property (nonatomic, retain) UITextField *inputHostField, *inputPortField, *inputNameField,
                                *upField, *rightField, *downField, *leftField, *inputConsoleField;
@property (nonatomic, retain) UILabel *secondsLabel, *secondsNote, *statusLabel;

@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;
@property (nonatomic, retain) NSMutableArray * serverResponses;

@property (nonatomic, retain) UIFont *consoleFont;
@property (nonatomic, retain) UITableView * tView;

@property (nonatomic, retain) DragImage *joystick;


-(IBAction) scrollToSection1;
-(IBAction) scrollToSection2;
-(IBAction) scrollToSection3;
-(IBAction)connectToHost;
-(IBAction)disconnectToHost;

- (IBAction)sendMessage; //send message in console
- (void) messageReceived:(NSString *)message; //messages received in console
- (void) messageSent:(NSString *)message; //messages sent in console
@end
