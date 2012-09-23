//
//  DragImage.m
//  TelnetApp
//
//  Created by ROBERT TILTON on 9/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DragImage.h"

@implementation DragImage


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        touching = FALSE;
        sendTouchPoint = CGPointMake(0, 0);
    }
    return self;
}


- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    // Retrieve the touch point
    CGPoint pt = [[touches anyObject] locationInView:self];
    startPoint = pt;
    [[self superview] bringSubviewToFront:self];
    
    touching = TRUE;
    NSLog(@"%@", (touching ? @"YES" : @"NO"));
    sendTouchPoint = startPoint;
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    // Move relative to the original touch point
    CGPoint pt = [[touches anyObject] locationInView:self];
    CGRect frame = [self frame];
    frame.origin.x += pt.x - startPoint.x;
    frame.origin.y += pt.y - startPoint.y;
    [self setFrame:frame];
    
    sendTouchPoint = frame.origin;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    CGRect frame = [self frame];
    frame.origin.x = [UIScreen mainScreen].bounds.size.width/2-25;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height/2-61;
    [self setFrame:frame];
    
    touching = FALSE;
    NSLog(@"%@", (touching ? @"YES" : @"NO"));
    sendTouchPoint = CGPointMake(0, 0);
}



-(CGPoint)getTouchPoint{
    if(touching){
        return sendTouchPoint;
    }else{
        return CGPointMake(0, 0);
    }
    
}




@end
