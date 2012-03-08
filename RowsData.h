//
//  RowsData.h
//  PicStory
//
//  Created by zanli on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
// Design pattern: Singleton

#import <Foundation/Foundation.h>
#import "RowData.h"


@interface RowsData : NSObject {
	NSMutableArray *rowsDataArray;
}

@property (nonatomic, retain) NSMutableArray *rowsDataArray;


+(RowsData*)myRowsDatas;

- (NSUInteger) getCount ;
- (RowData*) getRowAtIndex: (NSUInteger)index ;
- (void) removeRowAtIndex: (NSUInteger)index ;
- (void)removeRow:(RowData*)object;
- (void)insertRow:(RowData*)anObject atIndex:(NSUInteger)index;
- (void)addRow:(RowData*)anObject;
- (void)removeAllRows ;
@end
