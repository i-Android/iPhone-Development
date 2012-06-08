//
//  ViewController.h
//  pageControl
//
//  Created by ROBERT TILTON on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{

    IBOutlet UILabel * pageNumberLabel;
    int pageNumber;
}

@property (nonatomic, retain) UILabel *pageNumberLabel;
- (id)initWithPageNumber:(int)page;

@end

