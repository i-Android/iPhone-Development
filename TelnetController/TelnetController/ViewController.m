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
@synthesize mainScrollView, sliderView, mainbg, logo, tooltipSlider, statusImage, statusReflecImg, consoleImage, consoleReflecImg,
            connectBtn, saveBtn, editBtn, disconnetBtn, sendBtn,
            inputHostField, inputPortField, inputNameField, upField, rightField, downField, leftField, inputConsoleField, secondsLabel, secondsNote, statusLabel,
            inputStream, outputStream, serverResponses,
            consoleFont, tView;

- (void)viewDidLoad{

    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:YES];
    
    connected = FALSE; //start connected as false
    errorCounter = 0;

    //allocate array for response messages from server
    serverResponses = [[NSMutableArray alloc] init];
    

    //add a UIScroller where all the content will reside
    mainScrollView = [[UIScrollView alloc] initWithFrame: self.view.frame];
    [mainScrollView setContentSize:CGSizeMake(320, 1704)];
    [mainScrollView setFrame:CGRectMake(0, 0, 320, 568)];
    [mainScrollView setScrollEnabled:NO];
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
    UIImage *editBtnImg = [UIImage imageNamed:@"edit-btn.png"];
    [editBtn setBackgroundImage:editBtnImg forState:UIControlStateNormal];
    editBtn.frame = CGRectMake(265.0, 1415, 32, 51.5);
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
    secondsNote.text = @"The joypad will send the server data every 0.1 seconds";
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
    secondsLabel.text = @"0.1";
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
    
    
    //UIView to capture touches on edit screen
    sliderView = [[UIView alloc] initWithFrame: self.view.frame];
    [sliderView setFrame:CGRectMake(15, 180, 290, 73)];
    //[sliderView setBackgroundColor:[UIColor redColor]];
    
    //add status window
    UIImage * serverStatusImg = [UIImage imageNamed:@"serverstatus.png"];
    statusImage = [[UIImageView alloc] initWithImage:serverStatusImg];
    statusImage.frame = CGRectMake(28, 1150,264,83);
    [self.mainScrollView addSubview:statusImage];
    
    //add console font
    //NSLog(@"%@", [UIFont familyNames]);
    consoleFont = [UIFont fontWithName:@"Electronic Highway Sign" size:15];


    //add status label
    statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(43, 1181.5, 242, 40)];
    statusLabel.font = consoleFont;
    statusLabel.text = [NSString stringWithFormat:@"SERVER CONNECTED\r%@", inputHostField.text];
    statusLabel.numberOfLines = 2;
    statusLabel.textColor = [UIColor colorWithRed:(0.0/255.f) green:(186.0/255.f) blue:(255.0/255.f) alpha:1.0];
    statusLabel.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [self.mainScrollView addSubview:statusLabel];
    
    //add reflection to status window
    UIImage * statusReflectionImg = [UIImage imageNamed:@"reflection.png"];
    statusReflecImg = [[UIImageView alloc] initWithImage:statusReflectionImg];
    statusReflecImg.frame = CGRectMake(28, 1150,264,83);
    [self.mainScrollView addSubview:statusReflecImg];
    
    //add disconnect button
    disconnetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [disconnetBtn addTarget:self action:@selector(scrollToSection1) forControlEvents:UIControlEventTouchDown];
    disconnetBtn.frame = CGRectMake(28, 1150, 264, 83);
    disconnetBtn.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    [self.mainScrollView addSubview:disconnetBtn];
    
    //add console window
    UIImage * serverConsoleImg = [UIImage imageNamed:@"console.png"];
    consoleImage = [[UIImageView alloc] initWithImage:serverConsoleImg];
    consoleImage.frame = CGRectMake(28, 1240,264,158);
    [self.mainScrollView addSubview:consoleImage];
    
    //add table view where console messages will be placed
    tView = [[UITableView alloc] initWithFrame:CGRectMake(38, 1271, 243, 86) style:UITableViewStyleGrouped];
    self->tView.delegate = self;
    self->tView.dataSource = self;
    tView.separatorColor = [UIColor clearColor];
//    tView.sectionIndexColor = [UIColor clearColor];
    UIView *clearView = [[UIView alloc] initWithFrame:[tView bounds]];
    tView.backgroundView = clearView;
    [self.mainScrollView addSubview:tView];
    
    //add reflection to console window
    consoleReflecImg = [[UIImageView alloc] initWithImage:statusReflectionImg];
    consoleReflecImg.frame = CGRectMake(28, 1240,264,83);
    [self.mainScrollView addSubview:consoleReflecImg];

    //add send button
    sendBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [sendBtn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchDown];
    UIImage *sendBtnImg = [UIImage imageNamed:@"send-btn.png"];
    [sendBtn setBackgroundImage:sendBtnImg forState:UIControlStateNormal];
    sendBtn.frame = CGRectMake(208, 1353, 81.5, 43.5);
    [self.mainScrollView addSubview:sendBtn];
    
    //add text field for console
    inputConsoleField = [[UITextField alloc] initWithFrame:CGRectMake(46, 1358, 160, 33)];
    inputConsoleField.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
    inputConsoleField.placeholder = @"Insert console message";
    inputConsoleField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    inputConsoleField.autocorrectionType = UITextAutocorrectionTypeNo;
    inputConsoleField.keyboardType = UIKeyboardTypeDefault;
    inputConsoleField.returnKeyType = UIReturnKeyDone;
    //inputConsoleField.backgroundColor = [UIColor purpleColor];
    inputConsoleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.mainScrollView addSubview:inputConsoleField];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) scrollToSection1{
    [inputHostField becomeFirstResponder]; //make this field immediately editable
    CGPoint bottomOffset = CGPointMake(0, 0);
    [mainScrollView setContentOffset:bottomOffset animated:YES];
    //NSLog(@"%f",[mainScrollView contentSize].height);
}

- (IBAction) scrollToSection2{
    //add the touch area on slider
    [self.view addSubview:sliderView];
    
    [upField becomeFirstResponder]; //make this field immediately editable
    
    CGPoint bottomOffset = CGPointMake(0, 568);
    [mainScrollView setContentOffset:bottomOffset animated:YES];
}

- (IBAction) scrollToSection3{
    [self.view bringSubviewToFront:sliderView];
    [sliderView removeFromSuperview];
    [self.view endEditing:YES];//hide keyboard
    
    CGPoint bottomOffset = CGPointMake(0, 1136);
    [mainScrollView setContentOffset:bottomOffset animated:YES];
}


//console table code
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ChatCellIdentifier";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    // Add text to rows
    NSString *s = (NSString *) [serverResponses objectAtIndex:indexPath.row];
    cell.textLabel.text = s;
    cell.textLabel.font = consoleFont;
    cell.textLabel.textColor = [UIColor colorWithRed:(0.0/255.f) green:(186.0/255.f) blue:(255.0/255.f) alpha:1.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];

	return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return serverResponses.count;
}



-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    
    //map x position between 0.1 and 1.0
    float outVal, value, inputMin, inputMax, outputMin, outputMax;
    value = location.x;
    inputMin = 15;
    inputMax = 282;
    outputMin = 0.0;
    outputMax = 1.0;
    
	outVal = ((value - inputMin) / (inputMax - inputMin) * (outputMax - outputMin) + outputMin);
	if(outVal >  outputMax){
		outVal = outputMax;
	}
	if(outVal <  outputMin){
		outVal = outputMin;
	}

    //move tooltip and adjust numbers accordingly
    if(location.x > 37.75 && location.x < 282.25){
        [tooltipSlider setCenter:CGPointMake(location.x, 789)];
        [secondsLabel setCenter:CGPointMake(location.x, 761)];
        secondsLabel.text = [NSString stringWithFormat:@"%0.1f", outVal];
        secondsNote.text = [NSString stringWithFormat:@"The joypad will send the server data every %0.1f seconds", outVal];
    }
    
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


//console send message function
- (IBAction)sendMessage {
    //[self.view endEditing:YES];//hide keyboard if open
    
    if([inputConsoleField.text length] > 0){
        NSString *response  = [NSString stringWithFormat: @"%@\n", inputConsoleField.text];
        NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
        [outputStream write:[data bytes] maxLength:[data length]];
        [self messageSent:response]; //add resposne to array
    }
}


////store the string response in array and place it into table
//- (void) messageReceived:(NSString *)message {
//	[serverResponses addObject:message];
//	[self->tableView reloadData];
//    
//    //add scrolling to table
//    NSIndexPath *topIndexPath =
//    [NSIndexPath indexPathForRow:serverResponses.count-1
//                       inSection:0];
//    [self->tableView scrollToRowAtIndexPath:topIndexPath
//                       atScrollPosition:UITableViewScrollPositionMiddle
//                               animated:YES];
//    
//    [tableView setContentOffset:CGPointMake(0, self->tableView.contentSize.height- self->tableView.frame.size.height)]; //autoscrolls table
//}

- (void) messageSent:(NSString *)message {
    NSMutableString *userMessage = [NSMutableString stringWithString: @"> "];
    [userMessage appendString: message];
    
	[serverResponses addObject:userMessage];
	[self->tView reloadData];
    [tView setContentOffset:CGPointMake(0, self->tView.contentSize.height- self->tView.frame.size.height)]; //autoscrolls table
}

@end
