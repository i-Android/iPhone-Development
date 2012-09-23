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
    
    //delegate for table view
    self->tView.delegate = self;
	self->tView.dataSource = self;
    

    

    
    //allocation/initilization of object
    //joybtn = [[DragImage alloc] init];
    [joybtn setUserInteractionEnabled:YES];
    joybtn.center = joypadView.center; // center view;
    //NSLog(@"%f, %f", joypadView.center.x, joypadView.center.y);
    joybtn->touching = FALSE;
    joybtn->sendTouchPoint = CGPointMake(160, 205.5); //center of touchpad
}

-(void) showActivity{
    CGPoint touchPoint = CGPointMake(joybtn->sendTouchPoint.x,joybtn->sendTouchPoint.y);
    CGPoint center = CGPointMake(joypadView.center.x, joypadView.center.y);
    touchPoint.x = touchPoint.x-center.x;
    touchPoint.y = touchPoint.y-center.y;
    
    float length = sqrt( touchPoint.x * touchPoint.x + touchPoint.y * touchPoint.y);
    //NSLog(@"%f", length);
    
    if(length > 40){
        CGPoint normal;
        normal.x = touchPoint.x/length;
        normal.y = touchPoint.y/length;
        //NSLog(@"%f, %f", normal.x*50, normal.y*50);
        
        //calculate angle
        float angle = atan2(normal.x, normal.y);
        float degree = angle*(180/3.141592653589793238);
        NSLog(@"%f", degree);
        
        if(degree > -22.5 && degree < 22.5){
            //send paddle down
            [self joyPadSend:@"d"];
        }
        if(degree > 22.5 && degree < 67.5){
            //send paddle down and right
            [self joyPadSend:@"drd"];
        }
        if(degree > 67.5 && degree < 112.5){
            //send paddle right
            [self joyPadSend:@"r"];
        }
        if(degree > 112.5 && degree < 157.5){
            //send paddle up and right
            [self joyPadSend:@"uru"];
        }
        if(degree > 157.5){
            //send paddle up
            [self joyPadSend:@"u"];
        }
        if(degree < -157.5){
            //send paddle up
            [self joyPadSend:@"u"];
        }
        if(degree > -157.5 && degree < -112.5){
            //send paddle up and left
            [self joyPadSend:@"ulu"];
        }
        if(degree > -122.5 && degree < -67.5){
            //send paddle left
            [self joyPadSend:@"l"];
        }
        if(degree > -67.5 && degree < -22.5){
            //send paddle down and left
            [self joyPadSend:@"dld"];
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
    [self.view endEditing:YES];//hide keyboard if open
    
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
        [sender setTitle:@"Disconnect" forState:UIControlStateNormal];
        connected = TRUE;
    }else{
        //close connection by sending an x
        NSString *response  = [NSString stringWithFormat:@"x"];
        NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
        [outputStream write:[data bytes] maxLength:[data length]];
        printf("%s", [response UTF8String]);

        //change button to read connect
        [sender setTitle:@"Connect" forState:UIControlStateNormal];
        connected = FALSE;
    }
}


//button to add name
- (IBAction)addName:(id)sender {
    [self.view endEditing:YES];//hide keyboard if open

    //send name
	NSString *response  = [NSString stringWithFormat:@"n=%@\n", inputNameField.text];
	NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
	[outputStream write:[data bytes] maxLength:[data length]];
    printf("%s", [response UTF8String]);
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
            [joinHost setTitle:@"Connect" forState:UIControlStateNormal];
			break;
            
		case NSStreamEventEndEncountered:
            //close the stream if someone disconnects
            [theStream close];
            [theStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            
            connected = FALSE;
            [joinHost setTitle:@"Connect" forState:UIControlStateNormal];
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
        [self.view bringSubviewToFront:joinView];
        [timer invalidate];
    }
    if(item.tag == 1){
        [self.view bringSubviewToFront:joypadView];
        //create a looping timer that calls showActivity
        timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(showActivity) userInfo:nil repeats:YES];
    }
    if(item.tag == 2){
        [self.view bringSubviewToFront:consoleView];
        [timer invalidate];
    }
}



//console send message function
- (IBAction)sendMessage:(id)sender {
    [self.view endEditing:YES];//hide keyboard if open
    
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
