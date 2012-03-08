//
//  OneColsCell.h
//
//  Created by zanli on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RowData.h"
#import "BaseCell.h"


@interface OneColsCell : BaseCell {
	UIImageView *imageView1 ;
	UILabel *label1 ;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView1 ;
@property (nonatomic, retain) IBOutlet UILabel *label1 ;

- (BOOL)deployRowData:(RowData *)rData;

@end
