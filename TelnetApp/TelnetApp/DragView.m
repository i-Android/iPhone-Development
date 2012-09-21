//
//  DragView.m
//  TelnetApp
//
//  Created by ROBERT TILTON on 9/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DragView.h"

@implementation DragView


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	startPoint = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	CGPoint newPoint = [[touches anyObject] locationInView:self.superview];
	newPoint.x -= startPoint.x;
	newPoint.y -= startPoint.y;
	CGRect frm = [self frame];
	frm.origin = newPoint;
	[self setFrame:frm];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
