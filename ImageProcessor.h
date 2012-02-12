//
//  ImageProcessor.h
//  PicStory
//
//  Created by zanli on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageProcessor : NSObject {

}


//+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)targetSize;
//+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSize:(CGSize)newSize;
+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize;

+ (UIImage *)joinImages:(NSMutableArray *)imageList ;

@end
