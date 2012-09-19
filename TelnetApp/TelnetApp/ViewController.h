//
//  ViewController.h
//  TelnetApp
//
//  Created by ROBERT TILTON on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController 
                            <NSStreamDelegate, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate> {
    
                        
    //nav
    IBOutlet UITabBar *tabBar;
                                
    //settings variables
    IBOutlet UIView *joinView;
    IBOutlet UITextField *inputHostField;
    IBOutlet UITextField *inputPortField;
    IBOutlet UITextField *inputNameField;
    IBOutlet UIButton *joinHost;
    IBOutlet UIButton *addName;
    BOOL connected;
    
    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    
    //console variables
    IBOutlet UIView *consoleView;
    NSMutableArray * serverResponses;
    IBOutlet UITextField *inputMessageField;
    IBOutlet UITableView *tView;
    IBOutlet UIButton *sendMessage;
    
}

@property IBOutlet UITabBar *tabBar;

@property UIView *joinView;
@property UITextField *inputHostField;
@property UITextField *inputPortField;
@property UITextField *inputNameField;
@property UIButton *joinHost;
@property UIButton *addName;
@property BOOL connected;


@property NSInputStream *inputStream;
@property NSOutputStream *outputStream;

//consolve variables
@property UIView *consoleView;
@property NSMutableArray * serverResponses;
@property UITextField *inputMessageField;
@property IBOutlet UITableView *tView;
@property IBOutlet UIButton *sendMessage;

- (IBAction)joinHost:(id)sender; //connect to host button action
- (IBAction)addName:(id)sender; //add name button action
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
@end


//@interface ChatClientViewController : UIViewController <NSStreamDelegate>{
    
//}

//@end
