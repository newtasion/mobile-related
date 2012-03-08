//
//  TemplateViewController.m
//  PicStory
//
//  Created by zanli on 10/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TemplateViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RowData.h"
#import "RowsData.h"
#import "Const.h"

@implementation TemplateViewController
@synthesize OneColsCell;
@synthesize TwoColsCell;
@synthesize TreColsCell;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = @"Choose A Template";
	
	OneColsCell.layer.masksToBounds=YES;
	OneColsCell.layer.borderWidth=1;
	OneColsCell.layer.borderColor=[[UIColor blackColor]CGColor];
	TwoColsCell.layer.masksToBounds=YES;
	TwoColsCell.layer.borderWidth=1;
	TwoColsCell.layer.borderColor=[[UIColor blackColor]CGColor];
	TreColsCell.layer.masksToBounds=YES;
	TreColsCell.layer.borderWidth=1;
	TreColsCell.layer.borderColor=[[UIColor blackColor]CGColor];
	
	OneColsCell.tag = 0 ;
	TwoColsCell.tag = 1 ;
	TreColsCell.tag = 2 ;
	
	UITapGestureRecognizer *singleTap_OneColsCell = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
	[OneColsCell addGestureRecognizer:singleTap_OneColsCell];
	
	UITapGestureRecognizer *singleTap_TwoColsCell = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
	[TwoColsCell addGestureRecognizer:singleTap_TwoColsCell];
	
	UITapGestureRecognizer *singleTap_TreColsCell = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
	[TreColsCell addGestureRecognizer:singleTap_TreColsCell];
	
	[singleTap_OneColsCell release] ;
	[singleTap_TwoColsCell release] ;
	[singleTap_TreColsCell release] ;
	
	currentSelelectedObj = nil ;
}


- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
	// single tap does nothing for now
	//gestureRecognizer.view.tag
	
	if (currentSelelectedObj) {
		currentSelelectedObj.layer.masksToBounds=YES;
		currentSelelectedObj.layer.borderWidth=1;
		currentSelelectedObj.layer.borderColor=[[UIColor blackColor]CGColor];
	}
	
	NSLog(@"tag is %d", gestureRecognizer.view.tag);
	gestureRecognizer.view.layer.masksToBounds=YES;
	gestureRecognizer.view.layer.borderWidth=8;
	gestureRecognizer.view.layer.borderColor=[[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:0.5]CGColor];
	currentSelelectedObj = gestureRecognizer.view; 
	
	NSInteger rType = ((UIImageView *)currentSelelectedObj).tag ;
	NSString *typeStr = @TWOCOLSCELL ;
	if (rType == 0){
		typeStr = @ONECOLSCELL ;
		RowData *rd = [[RowData alloc] initWithDefault:@ONECOLSCELL];
		[[RowsData myRowsDatas] addRow:rd];
		[rd release] ;
		
	}
	else if(rType == 1) {
		typeStr = @TWOCOLSCELL ;
		RowData *rd = [[RowData alloc] initWithDefault:@TWOCOLSCELL];
		[[RowsData myRowsDatas] addRow:rd];
		[rd release];
		
	}
	else {
		typeStr = @TWOCOLSCELL ;
		RowData *rd = [[RowData alloc] initWithDefault:@TWOCOLSCELL];
		[[RowsData myRowsDatas] addRow:rd];
		[rd release];
		
	}

	[self.navigationController popViewControllerAnimated: YES];
	
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


- (void)dealloc {
    [super dealloc];
}


@end
