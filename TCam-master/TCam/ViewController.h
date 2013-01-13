#import <UIKit/UIKit.h>
////social sharing
//#import <Twitter/Twitter.h>
//#import <Social/Social.h>
//#import <Accounts/Accounts.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    CIContext *context; 
    NSMutableArray *filters; 
    CIImage *beginImage; 
    UIScrollView *filtersScrollView; 
    UIView *selectedFilterView; 
    UIImage *finalImage;
    
//    SLComposeViewController *mySLComposerSheet;
}

-(IBAction) saveButtonTouched:(id) sender;
//-(IBAction) tweetButtonTouched:(id) sender;

@property (nonatomic,weak) IBOutlet UIImageView *imageView; 
@property (nonatomic,weak) IBOutlet UIToolbar *toolbar;

@end
