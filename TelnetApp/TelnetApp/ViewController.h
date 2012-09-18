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
    IBOutlet UITextField *inputPortField;
    IBOutlet UITextField *inputNameField;
    IBOutlet UIButton *joinHost;
    IBOutlet UIButton *addName;
    BOOL connected;
    
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
}

@property UIView *joinView;
@property UITextField *inputHostField;
@property UITextField *inputPortField;
@property UITextField *inputNameField;
@property UIButton *joinHost;
@property UIButton *addName;
@property BOOL connected;


@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;
- (IBAction)joinHost:(id)sender; //connect to host button action
- (IBAction)addName:(id)sender; //add name button action
@end


//@interface ChatClientViewController : UIViewController <NSStreamDelegate>{
    
//}

//@end
