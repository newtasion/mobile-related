//
//  OneColsCell.m
//
//  Created by zanli on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OneColsCell.h"
#import "RowData.h"
#import "Const.h"
#import "PicStoryAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

static const NSInteger IMAGE1ORINGNX = 0;
static const NSInteger IMAGE1ORINGNY = 0;
static const float FONTSIZE = 22.0; 


@implementation OneColsCell

@synthesize imageView1 ;
@synthesize label1 ;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		PicStoryAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate] ;
		
		NSInteger imageWidth = ONECELLWIDTH;
		NSInteger imageHeight = ONECELLHEIGHT ;
		NSInteger labelWidth = imageWidth - 40 ;
		NSInteger labelHeight = 40 ;
		
		imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(IMAGE1ORINGNX, IMAGE1ORINGNY, imageWidth, imageHeight)];
		imageView1.tag = IMAGESTARTTAG ;
		imageView1.image = [UIImage imageNamed:@"gw1.jpeg"];
		imageView1.highlightedImage = [UIImage imageNamed:@"gw1.jpeg"];
		imageView1.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
		imageView1.userInteractionEnabled = YES;
		UITapGestureRecognizer *singleTap_imageView1 = [[[UITapGestureRecognizer alloc] initWithTarget:appDelegate.editorViewController action:@selector(handleSingleTap:)] autorelease];
		[imageView1 addGestureRecognizer:singleTap_imageView1];
		
		imageView1.layer.masksToBounds=YES;
		imageView1.layer.borderWidth=1;
		imageView1.layer.borderColor=[[UIColor whiteColor]CGColor];
		imageView1.contentMode = UIViewContentModeScaleAspectFit;
		
		label1 = [[UILabel alloc] initWithFrame:CGRectMake(IMAGE1ORINGNX, IMAGE1ORINGNY, labelWidth, labelHeight)];
		label1.tag = LABELSTARTTAG ;
		label1.adjustsFontSizeToFitWidth = YES;
		label1.backgroundColor = [UIColor clearColor];
		label1.textColor = [UIColor whiteColor];
		label1.textAlignment = UITextAlignmentCenter;
		label1.font = [UIFont boldSystemFontOfSize:FONTSIZE];
		label1.highlightedTextColor = [UIColor whiteColor];
		label1.userInteractionEnabled = YES;
		//single tab---selecting
		UITapGestureRecognizer *singleTap_label1 = [[[UITapGestureRecognizer alloc] initWithTarget:appDelegate.editorViewController action:@selector(handleSingleTap:)] autorelease];
		[label1 addGestureRecognizer:singleTap_label1];
		//drag the label
		UIPanGestureRecognizer *drag_label1 = [[[UIPanGestureRecognizer alloc] 
												initWithTarget:self 
												action:@selector(labelDragged:)] autorelease];
		[label1 addGestureRecognizer:drag_label1];
		
		
		[imageView1 addSubview:label1];
		[self.contentView addSubview:imageView1];
		
		[label1 release] ;
		[imageView1 release] ;		
    }
    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

	

- (BOOL)deployRowData:(RowData *)rData {
	if (![rData.rowType isEqualToString:@ONECOLSCELL]) 
		return FALSE ;
	
	self.rowData = rData;
	
	if ([self.rowData.imageList count] >= 1) {
		//NSString *imageName = (NSString *)[self.rowData.imageList objectAtIndex:0] ;
		//self.imageView1.image = [UIImage imageNamed:imageName];
		self.imageView1.image = [self.rowData.imageList objectAtIndex:0] ;
	}
	else {
		self.imageView1.image = [UIImage imageNamed:@ONECOLSDEFAULTIMAGE];
	}

	
	if ([self.rowData.labelList count] > 0) {
		self.label1.text = (NSString *)[self.rowData.labelList objectAtIndex:0];
	}
	else {
		self.label1.text = @DEFAULTLABEL ;
	}

	
    [self setNeedsDisplay];
	return TRUE ;
}





- (void)dealloc {
    [super dealloc];
}


@end
