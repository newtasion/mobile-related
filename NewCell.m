//
//  NewCell.m
//  PicStory
//
//  Created by zanli on 10/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewCell.h"
#import "Const.h"
#import "PicStoryAppDelegate.h"
#import <QuartzCore/QuartzCore.h>


@implementation NewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		PicStoryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[button setTitle:@"Add A New Row..." forState:UIControlStateNormal];
		[button addTarget: appDelegate.editorViewController action: @selector(addNewRow:)forControlEvents: UIControlEventTouchUpInside];
		
		// center and size
		//button.frame = CGRectMake((self.contentView.bounds.size.width - INSERTCELLBTNWIDTH)/2.0,
//								  (self.contentView.bounds.size.height - INSERTCELLBTNHEIGHT)/2.0,
//								  INSERTCELLBTNWIDTH, INSERTCELLBTNHEIGHT);
		button.frame = CGRectMake(40, 20, 200, 70);
		button.backgroundColor = [UIColor clearColor];
		// add it, centered
		[self.contentView addSubview:button];		
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
