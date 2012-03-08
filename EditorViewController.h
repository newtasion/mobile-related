//
//  SimpleTableViewController.h
//  SimpleTable
//
//  Created by Adeem on 17/05/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "ASIFormDataRequest.h"
#import "ColorPickerViewController.h"
#import "FontPickerViewController.h"

@interface EditorViewController : UIViewController 
<UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UITextFieldDelegate, 
UIAlertViewDelegate, UINavigationControllerDelegate, ColorPickerViewControllerDelegate, FontPickerViewControllerDelegate>{
	UIToolbar *toolbar;
	UITableView *editorTable;
	UIImageView *bgImageView ;
	BaseCell *tblCell ;
	
	NSInteger currentRowIndex ;	
	UIView *currentSelelectedObj ;
		
	NSMutableArray *imageProcessingBtns ;
	NSMutableArray *labelProcessingBtns ;
	
	NSString *tempText ; 
	UITextField *textFieldForDescription ;
	
	//for twitter accout
	UITextField *textfieldName;
	UITextField *textfieldPassword;

}
@property (nonatomic, retain) IBOutlet UITableView *editorTable ;
@property (nonatomic, retain) IBOutlet UIImageView *bgImageView ;
@property (nonatomic, retain) IBOutlet BaseCell *tblCell ;



- (IBAction) EditTable:(id)sender;
- (void) changeImages: (UIBarButtonItem*) sender;
- (void)segmentAction:(id)sender ;

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer ;
- (void) processImage: (UIButton*) sender ;
- (void)createToolbarButtons ;
-(void)toggleToolbarMode ;

-(void)resetTableView ;
-(void)saveTableViewAsImage ;
- (UIImage *)getTableViewAsImage  ;
-(void) uploadTableViewAsImageToTwitter ;

- (IBAction) chooseImage:(id)sender ;
- (void) promptTheInput:(id)sender ;
- (void) formatLabelText:(id)sender ;
- (void) colorLabelText:(id)sender ;
- (void) addNewRow: (UIButton*) sender ;

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
				  editingInfo:(NSDictionary *)editingInfo;
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;

- (NSInteger) whichRowTheViewIn:(UIView*)theView ;




-(void)uploadTableViewAsImageToTwitter ;
- (void)requestFinished:(ASIHTTPRequest *)request ;
- (void)requestFailed:(ASIHTTPRequest *)request ;



- (UIImage *)captureView: (UIView *)view inSize: (CGSize)size ;

@end

