//
//  TemplateViewController.h
//  PicStory
//
//  Created by zanli on 10/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TemplateViewController : UIViewController {
	UIImageView *OneColsCell ;
	UIImageView *TwoColsCell ;
	UIImageView *TreColsCell ;
	
	UIView *currentSelelectedObj; 
}

@property (nonatomic, retain) IBOutlet UIImageView *OneColsCell;
@property (nonatomic, retain) IBOutlet UIImageView *TwoColsCell;
@property (nonatomic, retain) IBOutlet UIImageView *TreColsCell;

@end
