//
//  ViewController.m
//  PageConrol-UIPaging
//
//  Created by ROBERT TILTON on 6/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

@synthesize scrollView, pageControl;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
    //set the delegate of the scroll view to self (this can be done in IB as well)
	[self.scrollView setDelegate:self];
    
    pageControlBeingUsed = NO;
    
    
    //create content
	NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
	for (int i = 0; i < colors.count; i++) {
		CGRect frame;
		frame.origin.x = self.scrollView.frame.size.width * i;
		frame.origin.y = 0;
		frame.size = self.scrollView.frame.size;
		
		UIView *subview = [[UIView alloc] initWithFrame:frame];
		subview.backgroundColor = [colors objectAtIndex:i];
		[self.scrollView addSubview:subview];
		[subview release];
	}
	
	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * colors.count, self.scrollView.frame.size.height);
	
	self.pageControl.currentPage = 0;
	self.pageControl.numberOfPages = colors.count;
}


- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (!pageControlBeingUsed) {
        // Switch the indicator when more than 50% of the previous/next page is visible
        CGFloat pageWidth = self.scrollView.frame.size.width;
        int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = NO;
}

- (IBAction)changePage {
	// Update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = self.scrollView.frame.size.width * self.pageControl.currentPage;
	frame.origin.y = 0;
	frame.size = self.scrollView.frame.size;
	[self.scrollView scrollRectToVisible:frame animated:YES];
	
	pageControlBeingUsed = YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.scrollView = nil;
	self.pageControl = nil;
}


- (void)dealloc {
	[scrollView release];
	[pageControl release];
    [super dealloc];
}

@end
