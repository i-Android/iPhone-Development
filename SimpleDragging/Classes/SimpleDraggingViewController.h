//
//  SimpleDraggingViewController.h
//  SimpleDragging
//
//  Created by Alex Nichol on 11/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DragBox.h"

@interface SimpleDraggingViewController : UIViewController {
	IBOutlet UIView * myView;
	IBOutlet DragBox * myDrag;
}

@end

