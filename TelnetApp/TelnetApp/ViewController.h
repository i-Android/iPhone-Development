//
//  ViewController.h
//  TelnetApp
//
//  Created by ROBERT TILTON on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    IBOutlet UIView *joinView;
    IBOutlet UITextField *inputHostField;
    IBOutlet UITextField *inputNameField;
    IBOutlet UIButton *joinHost;
    IBOutlet UIButton *joinChat;
    
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
}

@property UIView *joinView;
@property UITextField *inputHostField;
@property UITextField *inputNameField;
@property UIButton *joinHost;
@property UIButton *joinChat;


@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;
- (IBAction)joinChat:(id)sender;
- (IBAction)joinHost:(id)sender;
@end


@interface ChatClientViewController : UIViewController <NSStreamDelegate>{
    
}

@end
