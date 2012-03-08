//
//  RowData.h
//  SimpleTable
//
//  Created by zanli on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RowData : NSObject {
	NSString *rowType;
	NSMutableArray *imageList;
	NSMutableArray *labelList;
}

@property (nonatomic, retain) NSString *rowType;
@property (nonatomic, retain) NSMutableArray *imageList;
@property (nonatomic, retain) NSMutableArray *labelList;


- (id)initWithDefault:(NSString*)rType;




@end
