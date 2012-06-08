#import "ViewController.h"

@implementation ViewController
@synthesize ball, delta, rotate;

- (void)viewDidLoad{
    UIAccelerometer * accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1.0f / 60.0f; //get data 60 frames per second
    
    [super viewDidLoad];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer 
        didAccelerate:(UIAcceleration *)acceleration{
    
    //NSLog(@"x: %g", acceleration.x); //prints x of acceleration
    //NSLog(@"y: %g", acceleration.y); //prints y of acceleration
    //NSLog(@"z: %g", acceleration.z); //prints z of acceleration
    
    delta.x = acceleration.x * 10;
    delta.y = acceleration.y * 10;
    
    ball.center = CGPointMake(ball.center.x + delta.x, ball.center.y + (delta.y * -1));
    ball.transform = CGAffineTransformRotate(ball.transform, rotate);
    rotate+= (2.0f * ((float)rand() / (float)RAND_MAX) - 1.0f) * .01; //random number between -1, 1
    
    //Right
    if(ball.center.x < 0){
        ball.center = CGPointMake(320, ball.center.y);
    }
    
    //Left
    if(ball.center.x > 320){
        ball.center = CGPointMake(0, ball.center.y);
    }
    
    //Top
    if(ball.center.y < 0){
        ball.center = CGPointMake(ball.center.x, 460);
    }
    
    //Top
    if(ball.center.y > 460){
        ball.center = CGPointMake(ball.center.x, 0);
    }
}

- (void)dealloc{
    [super dealloc];
    
}
@end