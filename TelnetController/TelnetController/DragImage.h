//
//  DragImage.h
//  TelnetController
//
//  Created by ROBERT TILTON on 1/15/13.
//  Copyright (c) 2013 ROBERT TILTON. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DragImage : UIImageView{
@public
    CGPoint startPoint;
    BOOL touching;
    CGPoint sendTouchPoint;
}

-(CGPoint)getTouchPoint;

@end
