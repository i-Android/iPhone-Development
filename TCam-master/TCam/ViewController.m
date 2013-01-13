//
//  ViewController.m
//  TCam
//
//  Created by Mohammad Azam on 5/27/12.
//  Copyright (c) 2012 HighOnCoding. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Filter.h" 
#import "UIImage+Extensions.h" 

@implementation ViewController

static const int FILTER_LABEL = 001; 
    
@synthesize imageView,toolbar; 

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setup];    
}

-(void) setup {
    [self takePicture:(0)]; //auto take picture on app load
    [self setupAppearance];
    [self initializeFilterContext];
    //[self loadFiltersForImage:[UIImage imageNamed:@"biscus_small.png"]];
}


-(IBAction) saveButtonTouched:(id)sender{
    UIImageWriteToSavedPhotosAlbum(finalImage, self, nil, nil);
    
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                       message:@"The image has been stored in your photo album"
                                      delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];

    [alert show];

}


//-(IBAction) tweetButtonTouched:(id)sender{
//    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) //check if Facebook Account is linked
//    {
//        mySLComposerSheet = [[SLComposeViewController alloc] init]; //initiate the Social Controller
//        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook]; //Tell him with what social plattform to use it, e.g. facebook or twitter
//        [mySLComposerSheet setInitialText:[NSString stringWithFormat:@"Test",mySLComposerSheet.serviceType]]; //the message you want to post
//        [mySLComposerSheet addImage:finalImage]; //an image you could post
//        //for more instance methodes, go here:https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Reference/SLComposeViewController_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40012205
//        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
//    }
//    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
//        NSString *output;
//        switch (result) {
//            case SLComposeViewControllerResultCancelled:
//                output = @"Action Cancelled";
//                break;
//            case SLComposeViewControllerResultDone:
//                output = @"Post Successfull";
//                break;
//            default:
//                break;
//        } //check if everythink worked properly. Give out a message on the state.
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [alert show];
//    }];
//}

-(void) initializeFilterContext {
    context = [CIContext contextWithOptions:nil];
}

-(void) setupAppearance {
    filtersScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 90)];

    [filtersScrollView setScrollEnabled:YES];
    [filtersScrollView setShowsVerticalScrollIndicator:NO];
    filtersScrollView.showsHorizontalScrollIndicator = NO; 

    UIBarButtonItem *cameraBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicture:)];
    
    [[self navigationItem] setRightBarButtonItem:cameraBarButtonItem];
    
    [self.view addSubview:filtersScrollView];    
    
}

-(void) applyGesturesToFilterPreviewImageView:(UIView *) view {
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applyFilter:)];

    singleTapGestureRecognizer.numberOfTapsRequired = 1; 

    [view addGestureRecognizer:singleTapGestureRecognizer];        
}


-(void) applyFilter:(id) sender {
        selectedFilterView.layer.shadowRadius = 0.0f; 
        selectedFilterView.layer.shadowOpacity = 0.0f;
    
        selectedFilterView = [(UITapGestureRecognizer *) sender view];
    
        selectedFilterView.layer.shadowColor = [UIColor yellowColor].CGColor;
        selectedFilterView.layer.shadowRadius = 3.0f; 
        selectedFilterView.layer.shadowOpacity = 0.9f;
        selectedFilterView.layer.shadowOffset = CGSizeZero;
        selectedFilterView.layer.masksToBounds = NO;
    
        int filterIndex = selectedFilterView.tag; 
        Filter *filter = [filters objectAtIndex:filterIndex];
    
        CIImage *outputImage = [filter.filter outputImage];
        
        CGImageRef cgimg = 
        [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        finalImage = [UIImage imageWithCGImage:cgimg];
        
        finalImage = [finalImage imageRotatedByDegrees:90];  
    
        [self.imageView setImage:finalImage];
    
        CGImageRelease(cgimg);
    
}

-(void) createPreviewViewsForFilters{
    int offsetX = 10; 

    for(int index = 0; index < [filters count]; index++)
    {
        UIView *filterView = [[UIView alloc] initWithFrame:CGRectMake(offsetX, 0, 60, 60)];
        
        
        filterView.tag = index; 
        
        // create a label to display the name 
        UILabel *filterNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, filterView.bounds.size.width, 8)];
        
        filterNameLabel.center = CGPointMake(filterView.bounds.size.width/2, filterView.bounds.size.height + filterNameLabel.bounds.size.height); 
        
        Filter *filter = (Filter *) [filters objectAtIndex:index];
        
        filterNameLabel.text =  filter.name;
        filterNameLabel.backgroundColor = [UIColor clearColor];
        filterNameLabel.textColor = [UIColor whiteColor];
        filterNameLabel.font = [UIFont fontWithName:@"AppleColorEmoji" size:10];
        filterNameLabel.textAlignment = NSTextAlignmentCenter;

        CIImage *outputImage = [filter.filter outputImage];
        
        CGImageRef cgimg = 
        [context createCGImage:outputImage fromRect:[outputImage extent]];

        UIImage *smallImage =  [UIImage imageWithCGImage:cgimg];
        
        if(smallImage.imageOrientation == UIImageOrientationUp) 
        {
            smallImage = [smallImage imageRotatedByDegrees:90];
        }

        // create filter preview image views 
        UIImageView *filterPreviewImageView = [[UIImageView alloc] initWithImage:smallImage];
        
        [filterView setUserInteractionEnabled:YES];
        
        filterPreviewImageView.layer.cornerRadius = 15;  
        filterPreviewImageView.opaque = NO;
        filterPreviewImageView.backgroundColor = [UIColor clearColor];
        filterPreviewImageView.layer.masksToBounds = YES;        
        filterPreviewImageView.frame = CGRectMake(0, 0, 60, 60);
        
        filterView.tag = index; 

        [self applyGesturesToFilterPreviewImageView:filterView];
        
        [filterView addSubview:filterPreviewImageView];
        [filterView addSubview:filterNameLabel];
        
        [filtersScrollView addSubview:filterView];
        
        offsetX += filterView.bounds.size.width + 10;
        
    }
    
     [filtersScrollView setContentSize:CGSizeMake(400, 90)]; 
}

-(void) loadFiltersForImage:(UIImage *) image{
 
    CIImage *filterPreviewImage = [[CIImage alloc] initWithImage:image]; 
    
    CIFilter *sepiaFilter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey,filterPreviewImage,
                             @"inputIntensity",[NSNumber numberWithFloat:0.8],nil];
        
    
    CIFilter *colorMonochrome = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues:kCIInputImageKey,filterPreviewImage,
                                @"inputColor",[CIColor colorWithString:@"Red"],
                                 @"inputIntensity",[NSNumber numberWithFloat:0.8], nil];
    
    filters = [[NSMutableArray alloc] init];
    

    [filters addObjectsFromArray:[NSArray arrayWithObjects:
                                  [[Filter alloc] initWithNameAndFilter:@"Sepia" filter:sepiaFilter],
                                  [[Filter alloc] initWithNameAndFilter:@"Mono" filter:colorMonochrome]
                
                                  , nil]];
    
    
    [self createPreviewViewsForFilters];
}

-(void) takePicture:(id) sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) 
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else 
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];

    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    finalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.imageView setImage:finalImage];
    
    //this will save image to photo album
    //UIImageWriteToSavedPhotosAlbum(finalImage, self, nil, nil);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // load the filters again 
    
    [self loadFiltersForImage:finalImage];
}

- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
