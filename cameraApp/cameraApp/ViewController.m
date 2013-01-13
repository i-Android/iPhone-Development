//
//  ViewController.m
//  cameraApp
//
//  Created by ROBERT TILTON on 12/11/12.
//  Copyright (c) 2012 ROBERT TILTON. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize imageView;

#pragma mark - Show camera
-(IBAction)showCameraAction:(id)sender
{
    
    UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
    //You can use isSourceTypeAvailable to check
    imagePickController.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePickController.delegate=self;
    imagePickController.allowsEditing=YES;
//    imagePickController.showsCameraControls=NO;
	imagePickController.navigationBarHidden = YES;
	imagePickController.wantsFullScreenLayout = YES;
    //    imagePickController.cameraViewTransform = CGAffineTransformScale(imagePickController.cameraViewTransform, 1, 1.1);
    
    //This method inherit from UIView,show imagePicker with animation
    [self presentViewController:imagePickController animated:YES completion:nil];
    [imagePickController release];
}

#pragma mark - When Tap Save Button
-(IBAction)saveImageAction:(id)sender
{
    UIImage *image=imageView.image;
    //save photo to photoAlbum
    UIImageWriteToSavedPhotosAlbum(image,self, @selector(CheckedImage:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark - Check Save Image Error
- (void)CheckedImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    UIAlertView *alert;
    
    if (error) {
        alert = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                           message:[error description]
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                           message:@"The image has been stored in an album"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
    }
    
    [alert show];
    [alert release];
}

#pragma mark - When Finish Shoot

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *originalImage=[info objectForKey:UIImagePickerControllerOriginalImage];
    //Show OriginalImage size
   // NSLog(@"OriginalImage width:%f height:%f",image.size.width,image.size.height);
    imageView.image=originalImage;

    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - When Tap Cancel

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Release object

- (void)dealloc {
    [imageView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    return YES;
}

@end
