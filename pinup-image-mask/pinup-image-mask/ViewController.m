#import "ViewController.h"

@implementation ViewController
@synthesize delta, dress ,dressHeight;


- (void)viewDidLoad{
    UIAccelerometer * accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1.0f / 60.0f; //get data 60 frames per second

    //code to declare an image without Interface Builder
    UIImage * image1 = [UIImage imageNamed:@"dress.png"];
    dress = [[UIImageView alloc] initWithImage:image1];
    dress.contentMode = UIViewContentModeBottom;
    dress.frame = CGRectMake(120, 194,90,114);
    [self.view addSubview:dress];
    [dress release];
    
    dressHeight = 114;
    
    [super viewDidLoad];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer 
        didAccelerate:(UIAcceleration *)acceleration{
    
    //NSLog(@"x: %g", acceleration.x); //prints x of acceleration
    //NSLog(@"y: %g", acceleration.y); //prints y of acceleration
    //NSLog(@"z: %g", acceleration.z); //prints z of acceleration
    
    delta.y = acceleration.y * 5;
    
    dressHeight+= delta.y * -1;
    //NSLog(@"dress: %g", dressHeight);
    
    if(dressHeight > 114){
        dressHeight=114;
    }
    if(dressHeight < 0){
        dressHeight = 0;
    }

    dress.contentMode = UIViewContentModeTop;
    dress.clipsToBounds = YES;
    dress.frame = CGRectMake(120, 194, 90, dressHeight);
   
}

- (void)dealloc{
    [super dealloc];
    
}
@end