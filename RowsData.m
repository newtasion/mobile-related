//
//  RowsData.m
//  PicStory
//
//  Created by zanli on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RowsData.h"


@implementation RowsData

@synthesize rowsDataArray;

static RowsData* _myRowsDatas = nil;

+(RowsData*)myRowsDatas
{
	@synchronized([RowsData class])
	{
		if (!_myRowsDatas)
			[[self alloc] init];
		
		return _myRowsDatas;
	}
	
	return nil;
}

+(id)alloc
{
	@synchronized([RowsData class])
	{
		NSAssert(_myRowsDatas == nil, @"Attempted to allocate a second instance of a singleton.");
		_myRowsDatas = [super alloc];
		return _myRowsDatas;
	}
	
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
		NSMutableArray *rData = [[NSMutableArray alloc] init];
		self.rowsDataArray = rData;
		[rData release];
	}
	
	return self;
}


- (NSUInteger) getCount {
	return [self.rowsDataArray count] ;
}

- (RowData*) getRowAtIndex: (NSUInteger)index {
	return [self.rowsDataArray objectAtIndex:index];
}


- (void) removeRowAtIndex: (NSUInteger)index {
	[self.rowsDataArray removeObjectAtIndex:index];
}

- (void)removeRow:(RowData*)object {
	[self.rowsDataArray removeObject:object] ;
}

- (void)insertRow:(RowData*)anObject atIndex:(NSUInteger)index {
	[self.rowsDataArray insertObject:anObject atIndex:index];
}

- (void)addRow:(RowData*)anObject {
	[self.rowsDataArray addObject:anObject] ;	
}

- (void)removeAllRows {
	[self.rowsDataArray removeAllObjects] ;
}

@end
