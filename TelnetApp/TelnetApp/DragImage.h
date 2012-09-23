//
//  DragImage.h
//  TelnetApp
//
//  Created by ROBERT TILTON on 9/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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
