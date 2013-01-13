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
    UIImageView *mainbg, *logo, *tooltipSlider;
    UIButton *connectBtn, *saveBtn, *editBtn, *disconnetBtn;
    UITextField *inputHostField, *inputPortField, *inputNameField,
                *upField, *rightField, *downField, *leftField;
    UILabel *secondsLabel, *secondsNote;
    UIView *sliderView;
                                
    BOOL connected;
    int errorCounter, secondsValue;
    
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
}

@property (nonatomic, retain) UIScrollView *mainScrollView;
@property (nonatomic, retain) UIView *sliderView;
@property (nonatomic, retain) UIImageView *mainbg, *logo, *tooltipSlider;
@property (nonatomic, retain) UIButton *connectBtn, *saveBtn, *editBtn, *disconnetBtn;
@property (nonatomic, retain) UITextField *inputHostField, *inputPortField, *inputNameField,
                                *upField, *rightField, *downField, *leftField;
@property (nonatomic, retain) UILabel *secondsLabel, *secondsNote;

@property (nonatomic, retain) NSInputStream *inputStream;
@property (nonatomic, retain) NSOutputStream *outputStream;

-(IBAction) scrollToSection1;
-(IBAction) scrollToSection2;
-(IBAction) scrollToSection3;
-(IBAction)connectToHost;
@end
