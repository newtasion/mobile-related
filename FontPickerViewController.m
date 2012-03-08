//
//  FontPickerViewController.m
//  PicStory
//
//  Created by zanli on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FontPickerViewController.h"

NSString *const FontCellIdentifier = @"FontCellIdentifier";

@implementation FontPickerViewController
@synthesize fontTable ;
@synthesize defaultFont ;
@synthesize delegate ;
@synthesize currFont ;
@synthesize currFontFamily ;
@synthesize currSize ;
@synthesize segmentedControl;



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
	self.currFont = [defaultFont familyName];
	self.currFontFamily = [defaultFont fontName] ;

	if ([defaultFont pointSize] == 22.0)
		self.currSize = 2 ;
	else if ([defaultFont pointSize] ==16.0)
		self.currSize = 1 ;
	else {
		self.currSize = 0 ;
	}
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[UIFont familyNames] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSString *familyName = [self fontFamilyForSection:section];
	return [[UIFont fontNamesForFamilyName:familyName] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [self fontFamilyForSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FontCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FontCellIdentifier] autorelease];
    }
    
    NSString *familyName = [self fontFamilyForSection:indexPath.section];
	NSString *fontName = [self fontNameForRow:indexPath.row inFamily:familyName];
	UIFont *font = [UIFont fontWithName:fontName size:[UIFont smallSystemFontSize]];
	
	cell.textLabel.text = fontName;
	cell.textLabel.font = font;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//NSLog("%d", indexPath.section) ;
	//NSLog("%d", indexPath.row) ;
	self.currFontFamily = [self fontFamilyForSection:indexPath.section];
	self.currFont = [self fontNameForRow:indexPath.row inFamily:currFontFamily];
	NSLog(self.currFont);
	NSLog(self.currFontFamily) ;
}



- (NSString *)fontFamilyForSection:(NSInteger)section {
	@try {
		return [[UIFont familyNames] objectAtIndex:section];
	}
	@catch (NSException * e) {
		// ignore
	}
	return nil;
}

- (NSString *)fontNameForRow:(NSInteger)row inFamily:(NSString *)family {
	@try {
		return [[UIFont fontNamesForFamilyName:family] objectAtIndex:row];
	}
	@catch (NSException * e) {
		// ignore
	}
	return nil;
}




- (IBAction) chooseSelectedFont {
	NSLog(@"Color: %s",self.currFont);
	UIFont *font = nil ;
	switch (self.currSize) {
		case 0:
			font = [UIFont fontWithName:self.currFont size:14.0];
			break;
		case 1:
			font = [UIFont fontWithName:self.currFont size:18.0];
			break;
		default:
			font = [UIFont fontWithName:self.currFont size:22.0];
			break;
	}
	//UIFont *font = [UIFont fontWithName:self.currFont size:[UIFont smallSystemFontSize]];
    [delegate fontPickerViewController:self didSelectFont:font];
}


- (IBAction) cancelFontSelection {
    [self dismissModalViewControllerAnimated:YES];
}


-(IBAction) segmentedControlIndexChanged{
	switch (self.segmentedControl.selectedSegmentIndex) {
		case 0:
			self.currSize = 0 ;
			break;
		case 1:
			self.currSize = 1 ;
			break;
		default:
			self.currSize = 2 ;
			break;
	}
}



@end
