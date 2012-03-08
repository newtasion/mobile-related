//
//  RowData.m
//  SimpleTable
//
//  Created by zanli on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
// 

#import "RowData.h"
#import "Const.h"



@implementation RowData

@synthesize rowType;
@synthesize imageList;
@synthesize labelList;



- (id)initWithDefault:(NSString*)rType{
	
	if (self = [super init]) {
        
		if ([rType isEqualToString:@TWOCOLSCELL]){
			self.rowType = @TWOCOLSCELL;
			self.imageList = [[NSMutableArray alloc] init];
			self.labelList = [[NSMutableArray alloc] init]; 
			for(int i = 0; i < IMGNUMFORTCC; i++) {
				[self.imageList addObject:[UIImage imageNamed:@TWOCOLSDEFAULTIMAGE]] ;
				NSString *x = @TWOCOLSDEFAULTIMAGE ;
				[self.labelList addObject:@DEFAULTLABEL] ;
			}
			
		}
		else if ([rType isEqualToString:@ONECOLSCELL]){
			self.rowType = @ONECOLSCELL;
			self.imageList = [[NSMutableArray alloc] init];
			self.labelList = [[NSMutableArray alloc] init]; 
			for(int i = 0; i < IMGNUMFOROCC; i++) {				
				[self.imageList addObject:[UIImage imageNamed:@ONECOLSDEFAULTIMAGE]] ;
				[self.labelList addObject:@DEFAULTLABEL] ;
			}
			
		}
		
    }
    return self;
}





@end
