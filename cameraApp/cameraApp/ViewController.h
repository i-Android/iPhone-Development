//
//  ViewController.h
//  cameraApp
//
//  Created by ROBERT TILTON on 12/11/12.
//  Copyright (c) 2012 ROBERT TILTON. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,retain)IBOutlet UIImageView *imageView;

-(IBAction)showCameraAction:(id)sender;
-(IBAction)saveImageAction:(id)sender;
-(void)showCamera;
@end