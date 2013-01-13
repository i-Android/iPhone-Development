//
//  ViewController.m
//  TelnetController
//
//  Created by ROBERT TILTON on 1/12/13.
//  Copyright (c) 2013 ROBERT TILTON. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController
@synthesize mainScrollView, mainbg, logo, tooltipSlider,
            connectBtn, saveBtn, editBtn, disconnetBtn,
            inputHostField, inputPortField, inputNameField, upField, rightField, downField, leftField, secondsLabel, secondsNote,
            inputStream, outputStream;

- (void)viewDidLoad{
    
    connected = FALSE; //start connected as false
    errorCounter = 0;
    
    //add a UIScroller where all the content will reside
    mainScrollView = [[UIScrollView alloc] initWithFrame: self.view.frame];
    [mainScrollView setContentSize:CGSizeMake(320, 1704)];
    [mainScrollView setFrame:CGRectMake(0, 0, 320, 568)];
    [mainScrollView setScrollEnabled:NO];
    mainScrollView.delaysContentTouches = FALSE;
    mainScrollView.canCancelContentTouches = NO;
    [mainScrollView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:mainScrollView];
    
    //add the main background image
    UIImage * image0 = [UIImage imageNamed:@"main-bg.jpg"];
    mainbg = [[UIImageView alloc] initWithImage:image0];
    mainbg.frame = CGRectMake(0, 0,320,1704);
    [self.mainScrollView addSubview:mainbg];
    
    //add logo image
    UIImage * image1 = [UIImage imageNamed:@"logo.png"];
    logo = [[UIImageView alloc] initWithImage:image1];
    logo.frame = CGRectMake(70, 79,180.5,28.0);
    [self.mainScrollView addSubview:logo];
    
    //add connect button
    connectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [connectBtn addTarget:self action:@selector(connectToHost) forControlEvents:UIControlEventTouchDown];
    UIImage *connectBtnImg = [UIImage imageNamed:@"connect-btn.png"];
    [connectBtn setBackgroundImage:connectBtnImg forState:UIControlStateNormal];
    connectBtn.frame = CGRectMake(100.0, 246.0, 121.5, 70.0);
    [self.mainScrollView addSubview:connectBtn];
    
    //add save button
    editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editBtn addTarget:self action:@selector(scrollToSection2) forControlEvents:UIControlEventTouchDown];
    [editBtn setTitle:@"Edit" forState:UIControlStateNormal];
    editBtn.frame = CGRectMake(80.0, 1450.0, 40.0, 40.0);
    [self.mainScrollView addSubview:editBtn];
    
    //add disconnect button
    editBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [editBtn addTarget:self action:@selector(scrollToSection1) forControlEvents:UIControlEventTouchDown];
    [editBtn setTitle:@"Disconnect" forState:UIControlStateNormal];
    editBtn.frame = CGRectMake(10.0, 1250.0, 240.0, 140.0);
    [self.mainScrollView addSubview:editBtn];
    
    
    //add text field for host IP address
    inputHostField = [[UITextField alloc] initWithFrame:CGRectMake(44, 170, 165, 40)];
    inputHostField.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    inputHostField.placeholder = @"Insert host IP name";
    //inputHostField.backgroundColor = [UIColor purpleColor];
    inputHostField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    inputHostField.autocorrectionType = UITextAutocorrectionTypeNo;
    inputHostField.keyboardType = UIKeyboardTypeDefault;
    inputHostField.returnKeyType = UIReturnKeyDone;
    inputHostField.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputHostField.text = @"128.122.151.169";
    [self.mainScrollView addSubview:inputHostField];
    [inputHostField becomeFirstResponder]; //make this field immediately editable
    
    //add text field for port
    inputPortField = [[UITextField alloc] initWithFrame:CGRectMake(225, 170, 65, 40)];
    inputPortField.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    inputPortField.placeholder = @"Port";
    //inputPortField.backgroundColor = [UIColor purpleColor];
    inputPortField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    inputPortField.autocorrectionType = UITextAutocorrectionTypeNo;
    inputPortField.keyboardType = UIKeyboardTypeDefault;
    inputPortField.returnKeyType = UIReturnKeyDone;
    inputPortField.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputPortField.text = @"8080";
    [self.mainScrollView addSubview:inputPortField];
    
    //text fields for arrow controls
    upField = [[UITextField alloc] initWithFrame:CGRectMake(96, 594, 195, 36)];
    upField.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    upField.placeholder = @"Insert value to send";
    upField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    upField.autocorrectionType = UITextAutocorrectionTypeNo;
    upField.keyboardType = UIKeyboardTypeDefault;
    upField.returnKeyType = UIReturnKeyDone;
    upField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.mainScrollView addSubview:upField];
    
    rightField = [[UITextField alloc] initWithFrame:CGRectMake(96, 630, 195, 36)];
    rightField.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    rightField.placeholder = @"Insert value to send";
    rightField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    rightField.autocorrectionType = UITextAutocorrectionTypeNo;
    rightField.keyboardType = UIKeyboardTypeDefault;
    rightField.returnKeyType = UIReturnKeyDone;
    rightField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.mainScrollView addSubview:rightField];
    
    downField = [[UITextField alloc] initWithFrame:CGRectMake(96, 666, 195, 36)];
    downField.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    downField.placeholder = @"Insert value to send";
    downField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    downField.autocorrectionType = UITextAutocorrectionTypeNo;
    downField.keyboardType = UIKeyboardTypeDefault;
    downField.returnKeyType = UIReturnKeyDone;
    downField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.mainScrollView addSubview:downField];
    
    leftField = [[UITextField alloc] initWithFrame:CGRectMake(96, 702, 195, 36)];
    leftField.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    leftField.placeholder = @"Insert value to send";
    leftField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    leftField.autocorrectionType = UITextAutocorrectionTypeNo;
    leftField.keyboardType = UIKeyboardTypeDefault;
    leftField.returnKeyType = UIReturnKeyDone;
    leftField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.mainScrollView addSubview:leftField];
    
    //the text under the slider
    secondsNote = [[UILabel alloc] initWithFrame:CGRectMake(25, 798, 270, 36)];
    secondsNote.font = [UIFont fontWithName:@"Helvetica Neue" size:11];
    secondsNote.text = @"The joypad will send the server data every 0.3 seconds";
    secondsNote.textColor = [UIColor colorWithRed:(109.0/255.f) green:(111.0/255.f) blue:(114.0/255.f) alpha:1.0];
    secondsNote.shadowColor = [UIColor whiteColor];
    secondsNote.shadowOffset = CGSizeMake(0.0, 1.0);
    secondsNote.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    secondsNote.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:secondsNote];
    
    //add slider image
    UIImage * secondSliderImg = [UIImage imageNamed:@"tooltip-slider-btn.png"];
    tooltipSlider = [[UIImageView alloc] initWithImage:secondSliderImg];
    tooltipSlider.frame = CGRectMake(15, 748, 45.5, 82.0);
    [self.mainScrollView addSubview:tooltipSlider];
    
    //seconds text number in tooltip
    secondsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 743, 36, 36)];
    secondsLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    //secondsLabel.backgroundColor = [UIColor purpleColor];
    secondsLabel.text = @"0.3";
    secondsLabel.textColor = [UIColor colorWithRed:(109.0/255.f) green:(111.0/255.f) blue:(114.0/255.f) alpha:1.0];
    secondsLabel.shadowColor = [UIColor whiteColor];
    secondsLabel.shadowOffset = CGSizeMake(0.0, 1.0);
    secondsLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    secondsLabel.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:secondsLabel];

    //add save button
    saveBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveBtn addTarget:self action:@selector(scrollToSection3) forControlEvents:UIControlEventTouchDown];
    UIImage *saveBtnImg = [UIImage imageNamed:@"save-btn.png"];
    [saveBtn setBackgroundImage:saveBtnImg forState:UIControlStateNormal];
    saveBtn.frame = CGRectMake(100.0, 840.0, 121.5, 70.0);
    [self.mainScrollView addSubview:saveBtn];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) scrollToSection1{
    CGPoint bottomOffset = CGPointMake(0, 0);
    [mainScrollView setContentOffset:bottomOffset animated:YES];
    //NSLog(@"%f",[mainScrollView contentSize].height);
}

- (IBAction) scrollToSection2{
    CGPoint bottomOffset = CGPointMake(0, 568);
    [mainScrollView setContentOffset:bottomOffset animated:YES];
}

- (IBAction) scrollToSection3{
    CGPoint bottomOffset = CGPointMake(0, 1156);
    [mainScrollView setContentOffset:bottomOffset animated:YES];
}



-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"moved");
    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    [tooltipSlider setCenter:touchPoint];
}

//this creates a telnet connection to the server
- (IBAction)connectToHost {

    if(!connected){
        NSLog(@"%@", inputHostField.text);
        CFReadStreamRef readStream;
        CFWriteStreamRef writeStream;
        CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)inputHostField.text, [inputPortField.text intValue], &readStream, &writeStream);
        inputStream = (__bridge NSInputStream *)readStream;
        outputStream = (__bridge NSOutputStream *)writeStream;
        
        [inputStream setDelegate:self];
        [outputStream setDelegate:self];
        
        //schedule our input streams to have processing in the run loop
        [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        
        [inputStream open];
        [outputStream open];
        
        connected = TRUE;
    }
    
}


- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    NSLog(@"stream event %i", streamEvent);
    //error logging if connection has issues
    //NSError* error = [theStream streamError];
    //NSString* errorMessage = [NSString stringWithFormat:@"%@ (Code = %d)", [error localizedDescription], [error code]];
    
	switch (streamEvent) {
            
		case NSStreamEventOpenCompleted:
			NSLog(@"Stream opened");
            [self scrollToSection2];
			break;
            
		case NSStreamEventHasBytesAvailable:
            //read bytes from the stream,collect them in a buffer,transform the buffer in a string,add the string to the array of messages,tell the table to reload messages from the array
            if (theStream == inputStream) {
                
                uint8_t buffer[1024];
                int len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        
                        if (nil != output) {
                            NSLog(@"server said: %@", output);
                            //[self messageReceived:output]; //call function
                        }
                    }
                }
            }
			break;
            
		case NSStreamEventErrorOccurred:
			NSLog(@"Can not connect to the host!");
            
            //pop-up alert view - using 'errorCounter as a workaround to fix double alert bug
            errorCounter++;
            if(errorCounter >= 2){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry there was a problem!" message:@"Can not connect to host..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Try Again",nil];
                [alert show];
            }
            
            connected = FALSE;
			break;
            
		case NSStreamEventEndEncountered:
            //close the stream if someone disconnects
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            
            connected = FALSE;
            break;
            
		default:
			NSLog(@"Unknown event");
	}
    
}


//cant connect alert box - try again or cancel
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    errorCounter = 0;//reset error counter
    if (buttonIndex == 0) {
        NSLog(@"Cancel Tapped.");
    }
    else if (buttonIndex == 1) {
        NSLog(@"Try again is tapped");
        [self connectToHost];
    }
}

@end
