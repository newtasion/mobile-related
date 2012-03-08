//
//  SimpleTableViewController.m
//  SimpleTable
//
//  Created by Adeem on 17/05/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "EditorViewController.h"
#import "NextViewController.h"
#import "RowData.h"
#import "RowsData.h"
#import "Const.h"
#import "ELCImagePickerController.h"
#import "ELCAlbumPickerController.h"
#import "OneColsCell.h"
#import "TwoColsCell.h"
#import "NewCell.h" 
#import <QuartzCore/QuartzCore.h>
#import "TemplateViewController.h"
#import "FontPickerViewController.h"
#import "ColorPickerViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ImageProcessor.h"

#import "ASIFormDataRequest.h"



@implementation EditorViewController

@synthesize editorTable ;
@synthesize tblCell ;
@synthesize bgImageView ;




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	
	currentSelelectedObj =  nil ;
			
	self.title = @"Editor";
		
	
	// Change the properties of the imageView and tableView 
	editorTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	editorTable.separatorColor = [UIColor whiteColor] ;	
	editorTable.backgroundColor = [UIColor clearColor];
	//bgImageView.image = [UIImage imageNamed:@"mainViewBackground.png" ];		
	[self.view sendSubviewToBack:bgImageView] ;
	
	//---the left of navigationbar is a button
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Preview" style:UIBarButtonItemStyleBordered target:self action:@selector(EditTable:)];
	[self.navigationItem setLeftBarButtonItem:addButton];
	//---the right of navigationbar is a series of buttons
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
											[NSArray arrayWithObjects:
											 [UIImage imageNamed:@"reset.png"],
											 [UIImage imageNamed:@"format.png"],
											 [UIImage imageNamed:@"upload.png"],
											 nil]];
	[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
	segmentedControl.frame = CGRectMake(0, 0, 90, 35);
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.momentary = YES;
	
	UIBarButtonItem *segmentBarItem = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
	[segmentedControl release];
	
	self.navigationItem.rightBarButtonItem = segmentBarItem;
	[segmentBarItem release];
	
	
	
	//generate toolbar buttons
	[self createToolbarButtons];	
		
	[super setEditing:YES animated:YES]; 
	[editorTable setEditing:YES animated:YES];
	toolbar.frame = CGRectOffset(toolbar.frame, 0, +toolbar.frame.size.height);
	[self toggleToolbarMode] ;
	
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.editorTable reloadData] ;
}


- (void)createToolbarButtons {
	UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	/*-------------imageProcessingBtns-----------------------*/
	//allow use to choose image from photo library
	UIImage *photosButtonEnabledImage = [UIImage imageNamed:@"photos.png"];
	UIButton *photosButton = [UIButton buttonWithType:UIButtonTypeCustom];
	photosButton.adjustsImageWhenDisabled = YES;
	[photosButton setEnabled:YES];
	[photosButton setImage:photosButtonEnabledImage forState:UIControlStateNormal];	
	photosButton.frame = CGRectMake(5, 0, 50, 50);
	[photosButton addTarget: self action: @selector(chooseImage:)forControlEvents: UIControlEventTouchUpInside];
	UIBarButtonItem *photosBarItem = [[UIBarButtonItem alloc]	initWithCustomView:photosButton];
	
	//allow use to choose image from camera
	UIImage *cameraButtonEnabledImage = [UIImage imageNamed:@"camera.png"];
	UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
	cameraButton.adjustsImageWhenDisabled = YES;
	[cameraButton setEnabled:YES];
	[cameraButton setImage:cameraButtonEnabledImage forState:UIControlStateNormal];
	cameraButton.frame = CGRectMake(60, 0, 50, 50);
	[cameraButton addTarget: self action: @selector(chooseImage:)forControlEvents: UIControlEventTouchUpInside];
	UIBarButtonItem *cameraBarItem = [[UIBarButtonItem alloc]	initWithCustomView:cameraButton];
	
	
	/*-------------labelProcessingBtns-----------------------*/
	//allow user to edit the description
	UIImage *editButtonEnabledImage = [UIImage imageNamed:@"edit.png"];
	UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
	editButton.adjustsImageWhenDisabled = YES;
	[editButton setEnabled:YES];
	[editButton setImage:editButtonEnabledImage forState:UIControlStateNormal];	
	editButton.frame = CGRectMake(5, 0, 50, 50);
	[editButton addTarget: self action: @selector(promptTheInput:)forControlEvents: UIControlEventTouchUpInside];
	UIBarButtonItem *editBarItem = [[UIBarButtonItem alloc]	initWithCustomView:editButton];
	
	//allow user to choose font style
	UIImage *formatButtonEnabledImage = [UIImage imageNamed:@"format.png"];
	UIButton *formatButton = [UIButton buttonWithType:UIButtonTypeCustom];
	formatButton.adjustsImageWhenDisabled = YES;
	[formatButton setEnabled:YES];
	[formatButton setImage:formatButtonEnabledImage forState:UIControlStateNormal];
	formatButton.frame = CGRectMake(60, 0, 50, 50);
	[formatButton addTarget: self action: @selector(formatLabelText:)forControlEvents: UIControlEventTouchUpInside];
	UIBarButtonItem *formatBarItem = [[UIBarButtonItem alloc]	initWithCustomView:formatButton];
	
	
	//allow user to choose font style
	UIImage *colorButtonEnabledImage = [UIImage imageNamed:@"color.png"];
	UIButton *colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
	colorButton.adjustsImageWhenDisabled = YES;
	[colorButton setEnabled:YES];
	[colorButton setImage:colorButtonEnabledImage forState:UIControlStateNormal];
	colorButton.frame = CGRectMake(115, 0, 50, 50);
	[colorButton addTarget: self action: @selector(colorLabelText:)forControlEvents: UIControlEventTouchUpInside];
	UIBarButtonItem *colorBarItem = [[UIBarButtonItem alloc] initWithCustomView:colorButton];
	
	
	imageProcessingBtns = [NSMutableArray arrayWithObjects:photosBarItem,cameraBarItem, flexibleSpace, nil];
	[imageProcessingBtns retain];
	
	labelProcessingBtns = [NSMutableArray arrayWithObjects:editBarItem,formatBarItem,colorBarItem,flexibleSpace, nil];
	[labelProcessingBtns retain];
	
}

-(void)toggleToolbarMode
{
	BOOL toolbarHidden = self.editing ;
	[UIView beginAnimations:@"toolbar" context:nil];
	if (toolbarHidden) {
		toolbar.frame = CGRectOffset(toolbar.frame, 0, -toolbar.frame.size.height);
		toolbar.alpha = 1;
		toolbarHidden = NO;
	} else {
		toolbar.frame = CGRectOffset(toolbar.frame, 0, +toolbar.frame.size.height);
		toolbar.alpha = 0;
		toolbarHidden = YES;
	}
	[UIView commitAnimations];
	
	
	//toolbar.hidden = !self.editing;	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;	
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	int count = [[RowsData myRowsDatas] getCount];
	if(self.editing) 
		count++;
	return count; 
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row >= [[RowsData myRowsDatas] getCount])
		return INSERTCELLHEIGHT;
		
	RowData *rd = [[RowsData myRowsDatas] getRowAtIndex:indexPath.row]; 	
	
	if ([rd.rowType isEqualToString:@ONECOLSCELL]) 
	{
		return ONECELLHEIGHT ;
	} 
	else if ([rd.rowType isEqualToString:@TWOCOLSCELL]) {
		return TWOCELLHEIGHT ;
	}
	return INSERTCELLHEIGHT ;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *CellIdentifier = @"cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//		NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TableViewCell1" owner:self options:nil];
//		
//		for(id currentObject in topLevelObjects) {
//			if([currentObject isKindOfClass:[UITableViewCell class]]) {
//				cell = (TableViewCell1 *) currentObject;
//				break;
//			}
//		}
//		
//    }
	
	
	//the path of the row
	NSInteger index = indexPath.row ;
	
	//if the row is the last row, which is row indicating to insert a new row
	if(index == [[RowsData myRowsDatas] getCount] && self.editing){
		NewCell *newCell = (NewCell *)[tableView dequeueReusableCellWithIdentifier:@NEWCELL];
		if (newCell == nil) {
			newCell = [[[NewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@NEWCELL] autorelease] ;
		}
		return newCell;
	}
	
	RowData *rd = [[RowsData myRowsDatas] getRowAtIndex:index] ; 	
	BaseCell *cell = nil ;
	
	if ([rd.rowType isEqualToString:@ONECOLSCELL]) {
		cell = (OneColsCell *)[tableView dequeueReusableCellWithIdentifier:@ONECOLSCELL];
		if (cell == nil) {
			cell = [[[OneColsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@ONECOLSCELL] autorelease] ;
		}
		
	}
	else if ([rd.rowType isEqualToString:@TWOCOLSCELL]) {
		cell = (TwoColsCell *)[tableView dequeueReusableCellWithIdentifier:@TWOCOLSCELL];
		if (cell == nil) {
			cell = [[[TwoColsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@TWOCOLSCELL] autorelease] ;
		}
		
	}
	
	//cell.showsReorderControl = NO;
	//cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	[cell deployRowData:rd];

	return cell;

//	NSInteger count = 0;
//	if(self.editing && indexPath.section != 0)
//		count = 1;
	
	// Set up the cell...
//	cell.contentView.bounds
//	int x = cell.contentView.bounds.size.width;
//	int h = cell.contentView.bounds.size.height ;
//	
//	for(UIView *subview in cell.contentView.subviews) {
//		if([subview isKindOfClass:[UIImageView class]]) {
//			//[subview removeFromSuperview];
//		} else {
//			// Do nothing - not a UIButton or subclass instance
//		}
//	}
	
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//set the mask bounds
	
}



- (IBAction) EditTable:(id)sender{
	if(self.editing)
	{
		[super setEditing:NO animated:NO]; 
		[editorTable setEditing:NO animated:NO];
		[self toggleToolbarMode] ;
		[editorTable reloadData];
		[self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
		[self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
	}
	else
	{
		[super setEditing:YES animated:YES]; 
		[editorTable setEditing:YES animated:YES];
		[self toggleToolbarMode] ;
		[editorTable reloadData];
		[self.navigationItem.leftBarButtonItem setTitle:@"Preview"];
		[self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
	}
}


// The editing style for a row is the kind of button displayed to the left of the cell when in editing mode.
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    // No editing style if not editing or the index path is nil.
    if (self.editing == NO || !indexPath) return UITableViewCellEditingStyleNone;
	
    // Determine the editing style based on whether the cell is a placeholder for adding content or already 
    // existing content. Existing content can be deleted.    
    if (self.editing && indexPath.row == ([[RowsData myRowsDatas] getCount])) {
		return UITableViewCellEditingStyleInsert;
	} else {
		return UITableViewCellEditingStyleDelete;
	}
    return UITableViewCellEditingStyleNone;
}


// Update the data model according to edit actions delete or insert.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		[[RowsData myRowsDatas] removeRowAtIndex:indexPath.row];
		[editorTable reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
		[self addNewRow:nil];
    }
}


#pragma mark Row reordering
//Determine whether a given row is eligible for reordering or not.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == [[RowsData myRowsDatas] getCount]) 
		return FALSE ;
    return YES;
}

	
// Process the row move. This means updating the data model to correct the item indices.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath 
	  toIndexPath:(NSIndexPath *)toIndexPath {
	if (toIndexPath.row == [[RowsData myRowsDatas] getCount]) {
		[editorTable reloadData];
		return ;
	}
	
	RowData *item = [[[RowsData myRowsDatas] getRowAtIndex:fromIndexPath.row] retain];
	[[RowsData myRowsDatas] removeRow:item];
	[[RowsData myRowsDatas]	insertRow:item atIndex:toIndexPath.row] ;
	[item release];
	[editorTable reloadData];
}


#pragma mark Actions of Toolbar Buttons
- (void) changeImages: (UIBarButtonItem*) sender
{
	/* do what you want in response to section header tap */
	currentRowIndex = [sender tag];
	
	ELCAlbumPickerController *albumController = [[ELCAlbumPickerController alloc] initWithNibName:@"ELCAlbumPickerController" bundle:[NSBundle mainBundle]];    
	ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:albumController];
    [albumController setParent:elcPicker];
	[elcPicker setDelegate:self];
   
	[self presentModalViewController:elcPicker animated:YES];
    [elcPicker release];
    [albumController release];
}

//process the selected image using filters
- (void) processImage: (UIButton*) sender
{
	NextViewController *nextController = [[NextViewController alloc] initWithNibName:@"NextView" bundle:nil];
	[self.navigationController pushViewController:nextController animated:YES];
	
	//set detail View
	//[nextController changeProductText:[arryData objectAtIndex:indexPath.section]];
}


- (void)segmentAction:(id)sender{
	
	if([sender selectedSegmentIndex] == 0){
		//do something with segment 1
		NSLog(@"Segment 0 preesed");
		[self resetTableView] ;
	}
	else if([sender selectedSegmentIndex] == 1){
		//do something with segment 2
		NSLog(@"Segment 2 preesed");
		[self saveTableViewAsImage] ;
	}
	else {
		//do something with segment 3
		NSLog(@"Segment 3 preesed");
		[self uploadTableViewAsImageToTwitter] ;
	}

}



- (void) chooseImage:(id)sender {	
	UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = 
	UIImagePickerControllerSourceTypePhotoLibrary;
	
	[self presentModalViewController:imagePickerController animated:YES]; 
	[imagePickerController release] ;
}



- (void) promptTheInput:(id)sender {
	
	NSLog(@"promptTheInput");
	UIAlertView *inputDescForm = [[UIAlertView alloc] initWithTitle:@"Change Description" message:@"\n\n\n"
														   delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel",nil) otherButtonTitles:NSLocalizedString(@"OK",nil), nil];
	
	UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,40,260,25)];
	hintLabel.font = [UIFont systemFontOfSize:16];
	hintLabel.textColor = [UIColor whiteColor];
	hintLabel.backgroundColor = [UIColor clearColor];
	hintLabel.shadowColor = [UIColor blackColor];
	hintLabel.shadowOffset = CGSizeMake(0,-1);
	hintLabel.textAlignment = UITextAlignmentCenter;
	hintLabel.text = @"Input your new description here";
	[inputDescForm addSubview:hintLabel];
	
	UIImageView *hintImage = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"passwordfield" ofType:@"png"]]];
	hintImage.frame = CGRectMake(11,79,262,31);
	[inputDescForm addSubview:hintImage];
	
	UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(16,83,252,25)];
	inputField.font = [UIFont systemFontOfSize:18];
	inputField.backgroundColor = [UIColor whiteColor];
	inputField.secureTextEntry = NO;
	inputField.keyboardAppearance = UIKeyboardAppearanceAlert;
	inputField.delegate = self;
	[inputField becomeFirstResponder];
	[inputDescForm addSubview:inputField];
	
	textFieldForDescription = inputField ;
	
	[inputDescForm setTransform:CGAffineTransformMakeTranslation(0,40)];
	[inputDescForm show];
	[inputDescForm release];
	[inputField release];
	[hintImage release];
	[hintLabel release];
}

- (void) formatLabelText:(id)sender {
	
	if([currentSelelectedObj isKindOfClass:[UILabel class]]) {
		FontPickerViewController *fontPickerViewController = 
		[[FontPickerViewController alloc] initWithNibName:@"FontPickerViewController" bundle:nil];
		fontPickerViewController.delegate = self;
		
		fontPickerViewController.defaultFont = ((UILabel *)(currentSelelectedObj)).font ;
		
		[self presentModalViewController:fontPickerViewController animated:YES];
		[fontPickerViewController release];
	}
}

- (void)fontPickerViewController:(FontPickerViewController *)fontPicker didSelectFont:(UIFont *)font {

	if([currentSelelectedObj isKindOfClass:[UILabel class]]) {
		((UILabel *)(currentSelelectedObj)).font = font;
		[fontPicker dismissModalViewControllerAnimated:YES];
	}
}



- (void) colorLabelText:(id)sender {	
	
	if([currentSelelectedObj isKindOfClass:[UILabel class]]) {
		ColorPickerViewController *colorPickerViewController = 
		[[ColorPickerViewController alloc] initWithNibName:@"ColorPickerViewController" bundle:nil];
		colorPickerViewController.delegate = self;
	
		colorPickerViewController.defaultsColor = ((UILabel *)(currentSelelectedObj)).textColor ;	
		
		[self presentModalViewController:colorPickerViewController animated:YES];
		[colorPickerViewController release];
		
	}

}

- (void)colorPickerViewController:(ColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color {
    NSLog(@"Color: %d",color);
	
	if([currentSelelectedObj isKindOfClass:[UILabel class]]) {
		((UILabel *)(currentSelelectedObj)).textColor = color;
		[colorPicker dismissModalViewControllerAnimated:YES];
	}

}




- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 1)
	{
		NSLog(@"ok");
		if([currentSelelectedObj isKindOfClass:[UILabel class]]) {
			//how to deal with the old one .....???????
			((UILabel *)(currentSelelectedObj)).text = textFieldForDescription.text ;
			//modify data source
			
			int currentTag = currentSelelectedObj.tag ;
			int labelIndex = currentTag - LABELSTARTTAG ;
			 
			RowData *rd = [[RowsData myRowsDatas] getRowAtIndex:currentRowIndex] ;
			[rd.labelList replaceObjectAtIndex:labelIndex withObject:textFieldForDescription.text] ;
		}
	}
	else{
		
	}
}


- (void) addNewRow: (UIButton*) sender {	 
	TemplateViewController *templateViewController = [[TemplateViewController alloc] initWithNibName:@"TemplateViewController" bundle:nil];
	[self.navigationController pushViewController:templateViewController animated:YES];
	[templateViewController release];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{		
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];   
	if ([mediaType isEqualToString:@"public.image"]){
		CGSize targetSize = CGSizeMake(320, 240) ;
        UIImage *editedImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
		UIImage	*newImage = [ImageProcessor imageWithImage:editedImage scaledToSizeWithSameAspectRatio:targetSize] ;
		
		if([currentSelelectedObj isKindOfClass:[UIImageView class]]) {
			((UIImageView *)(currentSelelectedObj)).image = newImage ;
			
			int currentTag = currentSelelectedObj.tag ;
			int imageIndex = currentTag - IMAGESTARTTAG ;
			
			RowData *rd = [[RowsData myRowsDatas] getRowAtIndex:currentRowIndex] ;
			[rd.imageList replaceObjectAtIndex:imageIndex withObject:newImage] ;
		}
		
    }
		
	[picker dismissModalViewControllerAnimated:YES];

}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // Dismiss the image selection and close the program
    [picker dismissModalViewControllerAnimated:YES];
}




#pragma mark Show Toolbar Methods
- (NSInteger) whichRowTheViewIn:(UIView*)theView {
	for (UIView* next = [theView superview]; next; next = next.superview) {
		if ([next isKindOfClass:[UITableViewCell class]]) {
			NSIndexPath* pathOfTheCell = [editorTable indexPathForCell:((UITableViewCell*)next)] ;
			return [pathOfTheCell row] ;
		}
	}
	return -1 ;
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
	//gestureRecognizer.view.tag	
	if (currentSelelectedObj) {
		if([currentSelelectedObj isKindOfClass:[UIImageView class]]) {
			currentSelelectedObj.layer.masksToBounds=YES;
			currentSelelectedObj.layer.borderWidth=1;
			currentSelelectedObj.layer.borderColor=[[UIColor whiteColor]CGColor];
		}
		else if([currentSelelectedObj isKindOfClass:[UILabel class]]) {
			currentSelelectedObj.layer.masksToBounds=NO;
			currentSelelectedObj.layer.borderWidth=0;
		}
		
	}
	
	NSLog(@"tag is %d", gestureRecognizer.view.tag);
	gestureRecognizer.view.layer.masksToBounds=YES;
	gestureRecognizer.view.layer.borderWidth=8;
	gestureRecognizer.view.layer.borderColor=[[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:0.5]CGColor];
	currentSelelectedObj = gestureRecognizer.view; 
	
	//change toolbaritems
	if([currentSelelectedObj isKindOfClass:[UIImageView class]]) {
		[toolbar setItems:imageProcessingBtns] ;
	}
	else if([currentSelelectedObj isKindOfClass:[UILabel class]]) {
		[toolbar setItems:labelProcessingBtns] ;
	}
	
	currentRowIndex = [self whichRowTheViewIn:currentSelelectedObj] ;
	
	
	NSLog(@"sinlgeTap called");
	NSLog(@"row is %d", currentRowIndex) ;
}

- (UIImage *)captureView: (UIView *)view inSize: (CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGSize viewSize = view.frame.size;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM( context, size.width/viewSize.width, size.height/viewSize.height);	
    [view.layer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	NSData* pngData = UIImagePNGRepresentation(viewImage);	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *directory = [paths objectAtIndex:0];
	NSString *fullPath = [directory stringByAppendingPathComponent:@"temp.png"];
	[pngData writeToFile:fullPath atomically:YES] ;
    return viewImage;
}


- (UIImage *)getTableViewAsImage {
	NSMutableArray *imageList = [[NSMutableArray alloc] init] ;
	for (int row = 0; row < [[RowsData myRowsDatas] getCount]; row++) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];		
		//animated must be no !!!!
		[self.editorTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
		UITableViewCell *cell = (UITableViewCell *)[editorTable cellForRowAtIndexPath:indexPath];		
		UIGraphicsBeginImageContext(cell.bounds.size);
		[cell.layer renderInContext:UIGraphicsGetCurrentContext()];
		UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();

		//wait , thread
		
		if (viewImage) {
			[imageList addObject:viewImage] ;
			
			//UIImage *mergedImage = viewImage;
//			NSData* pngData = UIImagePNGRepresentation(mergedImage);	
//			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//			NSString *directory = [paths objectAtIndex:0];
//			NSString *x = [NSString stringWithFormat:@"viewImage%d.png", row] ;
//			NSString *fullPath = [directory stringByAppendingPathComponent:x];
//			[pngData writeToFile:fullPath atomically:YES] ;
			
		}		
		UIGraphicsEndImageContext();		
	}
	
	UIImage *mergedImage = [ImageProcessor joinImages:imageList] ;
	return mergedImage ;
}


-(void)resetTableView {
	[[RowsData myRowsDatas] removeAllRows] ;
	[editorTable reloadData];
	
}



-(void)saveTableViewAsImage {
	UIImage *mergedImage = [self getTableViewAsImage] ;
	NSData* pngData = UIImagePNGRepresentation(mergedImage);	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *directory = [paths objectAtIndex:0];
	NSString *fullPath = [directory stringByAppendingPathComponent:@"viewImage.png"];
	[pngData writeToFile:fullPath atomically:YES] ;
}

/*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// Clicked the Submit button
	if (buttonIndex != [alertView cancelButtonIndex])
	{
		NSLog(@"Name: %@", textfieldName.text);
		NSLog(@"Name: %@", textfieldPassword.text);
	}
}*/



-(void)uploadTableViewAsImageToTwitter {
	/*
	//-----------prompt the account dialog
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Login" message:@""
												   delegate:self cancelButtonTitle:@"Cancel"  otherButtonTitles:@"Submit", nil] ;
	[alert addTextFieldWithValue:@"" label:@"User Name"];
	[alert addTextFieldWithValue:@"" label:@"Password"];
	
	// Username
	textfieldName = [alert textFieldAtIndex:0];
	textfieldName.keyboardType = UIKeyboardTypeAlphabet;
	textfieldName.keyboardAppearance = UIKeyboardAppearanceAlert;
	textfieldName.autocorrectionType = UITextAutocorrectionTypeNo;
	
	// Password
	textfieldPassword = [alert textFieldAtIndex:1];
	textfieldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
	textfieldPassword.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
	textfieldPassword.keyboardAppearance = UIKeyboardAppearanceAlert;
	textfieldPassword.autocorrectionType = UITextAutocorrectionTypeNo;
	textfieldPassword.secureTextEntry = YES;
	
	[alert show];*/
	
	//-----------generate image and upload
	UIImage *viewImage = [self getTableViewAsImage];
	NSData* imageData = UIImagePNGRepresentation(viewImage);
		
	NSURL *twitpicURL = [NSURL URLWithString:@"http://twitpic.com/api/uploadAndPost"];
	ASIFormDataRequest *request = [[[ASIFormDataRequest alloc] initWithURL:twitpicURL] autorelease];
	
	[request setData:imageData forKey:@"media"];
	[request setPostValue:@"ezPicStory" forKey:@"username"];
	[request setPostValue:@"885988" forKey:@"password"];
	[request setPostValue:@"myMessage" forKey:@"message"];
	
	[request setDelegate:self];
	[request setDidFinishSelector:@selector(requestFinished:)];
	[request setDidFailSelector:@selector(requestFailed:)];
	
	//[request setUploadProgressDelegate:myProgressIndicator];
//	[request startSynchronous];
//	NSLog(@"Value: %f",[myProgressIndicator progress]);
//	
	[request start];
	
}


- (void)requestFinished:(ASIHTTPRequest *)request {
	NSLog(@"%@", [request responseString]);
	// do something with the data
	//if(delegate &amp;&amp; callback) {
//		if([delegate respondsToSelector:self.callback]) {
//			[delegate performSelector:self.callback withObject:receivedData];
//		} else {
//			NSLog(@"No response from delegate");
//		}
//	}
	// release the connection, and the data object
	[request release];
}


- (void)requestFailed:(ASIHTTPRequest *)request {
	NSError *error = [request error];
}



#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
	
	[self dismissModalViewControllerAnimated:YES];
	
//	CGRect workingFrame = scrollview.frame;
//	workingFrame.origin.x = 0;
//	
	for(NSDictionary *dict in info) {
		UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage] ;
		
	}
//		
//		UIImageView *imageview = [[UIImageView alloc] initWithImage:[dict objectForKey:UIImagePickerControllerOriginalImage]];
//		[imageview setContentMode:UIViewContentModeScaleAspectFit];
//		imageview.frame = workingFrame;
//		
//		[scrollview addSubview:imageview];
//		[imageview release];
//		
//		workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
//	}
//	
//	[scrollview setPagingEnabled:YES];
//	[scrollview setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
	
	[self dismissModalViewControllerAnimated:YES];
}




@end
