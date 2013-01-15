//
//  ViewController.h
//  TelnetController
//
//  Created by ROBERT TILTON on 1/12/13.
//  Copyright (c) 2013 ROBERT TILTON. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
                            <NSStreamDelegate, UITableViewDelegate, UITableViewDataSource>{
                
    UIScrollView *mainScrollView;
    UIImageView *mainbg, *logo, *tooltipSlider, *statusImage, *statusReflecImg, *consoleImage, *consoleReflecImg;
    UIButton *connectBtn, *saveBtn, *editBtn, *disconnetBtn, *sendBtn;
    UITextField *inputHostField, *inputPortField, *inputNameField,
                *upField, *rightField, *downField, *leftField, *inputConsoleField;
    UILabel *secondsLabel, *secondsNote, *statusLabel;
    UIView *sliderView;
                                
    BOOL connected;
    int errorCounter, secondsValue;
    
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    NSMutableArray * serverResponses;
                                
    UIFont *consoleFont;
    UITableView * tView;
}

@property (nonatomic, retain) UIScrollView *mainScrollView;
@property (nonatomic, retain) UIView *sliderView;
@property (nonatomic, retain) UIImageView *mainbg, *logo, *tooltipSlider, *statusImage,
                                *statusReflecImg, *consoleImage, *consoleReflecImg;
@property (nonatomic, retain) UIButton *connectBtn, *saveBtn, *editBtn, *disconnetBtn, *sendBtn;
@property (nonatomic, retain) UITextField *inputHostField, *inputPortField, *inputNameField,
                                *upField, *rightField, *downField, *leftField, *inputConsoleField;
@property (nonatomic, retain) UILabel *secondsLabel, *secondsNote, *statusLabel;

@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;
@property (nonatomic, retain) NSMutableArray * serverResponses;

@property (nonatomic, retain) UIFont *consoleFont;
@property (nonatomic, retain) UITableView * tView;

-(IBAction) scrollToSection1;
-(IBAction) scrollToSection2;
-(IBAction) scrollToSection3;
-(IBAction)connectToHost;

- (IBAction)sendMessage; //send message in console
//- (void) messageReceived:(NSString *)message; //messages received in console
- (void) messageSent:(NSString *)message; //messages sent in console
@end
