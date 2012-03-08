//
//  FontPickerViewController.h
//  PicStory
//
//  Created by zanli on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FontPickerViewController;

@protocol FontPickerViewControllerDelegate <NSObject>

- (void)FontPickerViewController:(FontPickerViewController *)fontPicker didSelectFont:(UIFont *)font;

@end


@interface FontPickerViewController : UIViewController <UITableViewDelegate>{
	id<FontPickerViewControllerDelegate> delegate;
	
	UITableView *fontTable;
	
	NSString *currFontFamily ;
	NSString *currFont ;
	NSInteger currSize ;
	
	UIFont *defaultFont;
	
	UISegmentedControl *segmentedControl;
}


@property (nonatomic, retain) IBOutlet UITableView *fontTable ;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;

@property(nonatomic,assign)	id<FontPickerViewControllerDelegate> delegate;

@property(readwrite,nonatomic,retain) UIFont *defaultFont;
@property(readwrite,nonatomic,retain) NSString *currFontFamily ;
@property(readwrite,nonatomic,retain) NSString *currFont ;
@property(readwrite,nonatomic) NSInteger currSize ;



- (NSString *)fontFamilyForSection:(NSInteger)section;
- (NSString *)fontNameForRow:(NSInteger)row inFamily:(NSString *)family;


- (IBAction) chooseSelectedFont;
- (IBAction) cancelFontSelection;

-(IBAction) segmentedControlIndexChanged;

@end
