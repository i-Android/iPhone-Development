//
//  DragBox.m
//  SimpleDragging
//
//  Created by Alex Nichol on 11/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DragBox.h"


@implementation DragBox

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

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
