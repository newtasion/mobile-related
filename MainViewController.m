//
//  MainViewController.m
//  picStory11
//
//  Created by zanli on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"
#import "PicStoryAppDelegate.h"


@implementation MainViewController

@synthesize editorViewController ;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		editorViewController = nil ;
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



#pragma mark -
#pragma mark Actions

- (IBAction)showEditorView:(id)sender {
    PicStoryAppDelegate *appDelegate = (PicStoryAppDelegate *)[[UIApplication sharedApplication] delegate];
	//NSString *x = @"dfdf";
    [appDelegate toggleViewController:appDelegate.navigationController];
}

- (void)dealloc {
    [super dealloc];
}





@end
