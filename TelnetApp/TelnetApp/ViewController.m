//
//  ViewController.m
//  TelnetApp
//
//  Created by ROBERT TILTON on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //call function to autoconnect to server
    //[self initNetworkCommunication];
    
    connected = FALSE; //start connected as false
    errorCounter = 0;
    
    //allocate array for response messages from server
    serverResponses = [[NSMutableArray alloc] init];
    
    
    //need to add this to get tab bar to realize touches
    tabBar.delegate = self;
    [self.view bringSubviewToFront:joinView]; //start at join view
    [inputHostField becomeFirstResponder];
    
    //delegate for table view
    self->tView.delegate = self;
	self->tView.dataSource = self;
    
    timerValid= FALSE;
    

    
    //allocation/initilization of object
    //joybtn = [[DragImage alloc] init];
    [joybtn setUserInteractionEnabled:YES];
    joybtn.center = CGPointMake(160, 254.5-50);//joypadView.center; // center view;
    //NSLog(@"center: %f, %f", joypadView.center.x, joypadView.center.y);
    joybtn->touching = FALSE;
    joybtn->sendTouchPoint = CGPointMake(160, 254.5); //center of touchpad
}

-(void) showActivity{
    CGPoint touchPoint = CGPointMake(joybtn->sendTouchPoint.x,joybtn->sendTouchPoint.y);
    CGPoint center = CGPointMake(joypadView.center.x, joypadView.center.y);
    touchPoint.x = touchPoint.x-center.x;
    touchPoint.y = touchPoint.y-center.y;
    
    float length = sqrt( touchPoint.x * touchPoint.x + touchPoint.y * touchPoint.y);
    //NSLog(@"%f", length);
    
    if(length > 35){
        CGPoint normal;
        normal.x = touchPoint.x/length;
        normal.y = touchPoint.y/length;
        //NSLog(@"%f, %f", normal.x*50, normal.y*50);
        
        //calculate angle
        float angle = atan2(normal.x, normal.y);
        float degree = angle*(180/3.141592653589793238);
        NSLog(@"%f", degree);
        
        if(degree > -45 && degree < 45){
            //send paddle down
            [self joyPadSend:@"dd"];
        }
        if(degree > 45 && degree < 135){
            //send paddle right
            [self joyPadSend:@"r"];
        }
        if(degree > 135){
            //send paddle up
            [self joyPadSend:@"uu"];
        }
        if(degree < -135){
            //send paddle up
            [self joyPadSend:@"uu"];
        }
        if(degree > -135 && degree < -45){
            //send paddle left
            [self joyPadSend:@"l"];
        }
   
    }
}

- (void)viewDidAppear:(BOOL)animated {
        [self.tabBarController setSelectedIndex:1];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    [tabBar release];
    [serverResponses release];
    
}


//AUTO-CONNECT IS TURNED OFF
//telnet into server 128.122.151.164 port 8080 autoconnect - set to not autoconnect right now
- (void)initNetworkCommunication {
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (CFStringRef)@"128.122.151.164", 8080, &readStream, &writeStream);
    inputStream = (__bridge NSInputStream *)readStream;
    outputStream = (__bridge NSOutputStream *)writeStream;
    
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
    //schedule our input streams to have processing in the run loop
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    [inputStream open];
    [outputStream open];
}


//manual connect - typing in server host and port number
- (IBAction)joinHost:(id)sender {
    //[self.view endEditing:YES];//hide keyboard if open
    
    //if not connected - connnect
    if(!connected){
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
        
        //change button to read disconnect
        [sender setTitle:@"DISCONNECT" forState:UIControlStateNormal];
        connected = TRUE;
    }else{
        //close connection by sending an x
        NSString *response  = [NSString stringWithFormat:@"x"];
        NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
        [outputStream write:[data bytes] maxLength:[data length]];
        printf("%s", [response UTF8String]);

        //change button to read connect
        [sender setTitle:@"CONNECT" forState:UIControlStateNormal];
        connected = FALSE;
    }
}


//button to add name
- (IBAction)addName:(id)sender {
    //[self.view endEditing:YES];//hide keyboard if open
   
    //send name
	NSString *response  = [NSString stringWithFormat:@"n=%@\n", inputNameField.text];
	NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
	[outputStream write:[data bytes] maxLength:[data length]];
    printf("%s", [response UTF8String]);
    
    //[self.view bringSubviewToFront:joypadView];
    //[self.view endEditing:YES];//hide keyboard if open
//    [UIView beginAnimations:@"fade" context:nil];
//    [UIView setAnimationDuration:0.5];
//    joinView.alpha = 0.0;
//    [UIView commitAnimations];
//    [self.view endEditing:YES];
    
}

//joypad sending controls
-(void)joyPadSend:(NSString *)moveAmount{
    NSString *response  = [NSString stringWithFormat: @"%@\n", moveAmount];
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
    [self messageSent:response]; //add resposne to array
}


- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    NSLog(@"stream event %i", streamEvent);
    
    
	switch (streamEvent) {
            
		case NSStreamEventOpenCompleted:
			NSLog(@"Stream opened");
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
                            [self messageReceived:output]; //call function
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
            [alert release];
            }
            
            connected = FALSE;
            [joinHost setTitle:@"CONNECT" forState:UIControlStateNormal];
			break;
            
		case NSStreamEventEndEncountered:
            //close the stream if someone disconnects
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            
            connected = FALSE;
            [joinHost setTitle:@"CONNECT" forState:UIControlStateNormal];
            break;
            
		default:
			NSLog(@"Unknown event");
	}
    
}


//store the string response in array and place it into table
- (void) messageReceived:(NSString *)message {
	[serverResponses addObject:message];
	[self->tView reloadData];
    
    //add scrolling to table
    NSIndexPath *topIndexPath = 
    [NSIndexPath indexPathForRow:serverResponses.count-1 
                       inSection:0];
    [self->tView scrollToRowAtIndexPath:topIndexPath 
                      atScrollPosition:UITableViewScrollPositionMiddle 
                              animated:YES];
    
    [tView setContentOffset:CGPointMake(0, self->tView.contentSize.height- self->tView.frame.size.height)]; //autoscrolls table
}

- (void) messageSent:(NSString *)message {
    NSMutableString *userMessage = [NSMutableString stringWithString: @"> "];
    [userMessage appendString: message];
    
	[serverResponses addObject:userMessage];
	[self->tView reloadData];  
    [tView setContentOffset:CGPointMake(0, self->tView.contentSize.height- self->tView.frame.size.height)]; //autoscrolls table
}


//console table code
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"ChatCellIdentifier";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    // Add text to rows
    NSString *s = (NSString *) [serverResponses objectAtIndex:indexPath.row];
    cell.textLabel.text = s;
    cell.textLabel.textColor = [UIColor greenColor];
	return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return serverResponses.count;
}


//tab navigation controller - tells which view to appear
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{  
    if(item.tag == 0){
        UIImage *tabImageHolder = [UIImage imageNamed:@"nav1.png"];
        [tabImage setImage:tabImageHolder];
        [tabImageHolder release];
        
        [self.view bringSubviewToFront:joinView];
        [self.view endEditing:YES];
        [inputHostField becomeFirstResponder]; //make input field active
        if(!timer){
            [timer invalidate];
            timerValid = TRUE;
        }
    }
    if(item.tag == 1){
        UIImage *tabImageHolder = [UIImage imageNamed:@"nav2.png"];
        [tabImage setImage:tabImageHolder];
        [tabImageHolder release];
        
        [self.view bringSubviewToFront:joypadView];
        [self.view endEditing:YES];
        //create a looping timer that calls showActivity
        timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showActivity) userInfo:nil repeats:YES];
        timerValid = FALSE;
    }
    if(item.tag == 2){
        UIImage *tabImageHolder = [UIImage imageNamed:@"nav3.png"];
        [tabImage setImage:tabImageHolder];
        [tabImageHolder release];
        
        [self.view bringSubviewToFront:consoleView];
        [self.view endEditing:YES];
        [inputMessageField becomeFirstResponder]; //make input field active
        if(!timer){
            [timer invalidate];
            timerValid = TRUE;
        }
    }
}



//console send message function
- (IBAction)sendMessage:(id)sender {
    //[self.view endEditing:YES];//hide keyboard if open
    
    if([inputMessageField.text length] > 0){
        NSString *response  = [NSString stringWithFormat: @"%@\n", inputMessageField.text];
        NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
        [outputStream write:[data bytes] maxLength:[data length]];
        [self messageSent:response]; //add resposne to array
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
        [self joinHost:nil];
    }
}



@end
