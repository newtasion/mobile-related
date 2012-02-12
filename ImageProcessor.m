//
//  ImageProcessor.m
//  PicStory
//
//  Created by zanli on 10/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

/*
convert the cells of UITableView to an image. An example is shown as following:

- (UIImage *)getTableViewAsImage {
	NSMutableArray *imageList = [[NSMutableArray alloc] init] ;
	for (int row = 0; row < [[RowsData myRowsDatas] getCount]; row++) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];		
		//animated must be no !!!!
		[self.editorTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
		UITableViewCell *cell = (UITableViewCell *)[editorTable cellForRowAtIndexPath:indexPath];		
		UIGraphicsBeginImageContext(cell.bounds.size);
		[cell.layer renderInContext:UIGraphicsGetCurrentContext()];
		UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();

		//wait , thread
		if (viewImage) {
			[imageList addObject:viewImage] ;			
			//UIImage *mergedImage = viewImage;
		}		
		UIGraphicsEndImageContext();		
	}
	
	UIImage *mergedImage = [ImageProcessor joinImages:imageList] ;
	return mergedImage ;
}

*/

#import "ImageProcessor.h"


@implementation ImageProcessor
static inline float radians(double degrees) { return degrees * 3.1416 / 180; }


/*
join multiple images to one image.
*/
+ (UIImage *)joinImages:(NSMutableArray *)imageList
{	
	//caculate the height after the join operation
	NSInteger height = 0 ;
	for (int i =0 ; i < [imageList count]; i++) {
		UIImage *currImage = (UIImage *)[imageList objectAtIndex:i];
		height += currImage.size.height ;
	}
	CGSize size = CGSizeMake(320, height);
	UIGraphicsBeginImageContext(size);
	
	//draw image
	NSInteger startHeight = 0;
	for (int i =0 ; i < [imageList count]; i++) {
		UIImage *currImage = (UIImage *)[imageList objectAtIndex:i];
		CGPoint image1Point = CGPointMake(0, startHeight);
		startHeight += currImage.size.height ;
		[currImage drawAtPoint:image1Point];
	}
	
	UIImage* finalImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return finalImage;
}



/*scale the image to the target size*/
+ (UIImage*)imageWithImage:(UIImage*)sourceImage scaledToSizeWithSameAspectRatio:(CGSize)targetSize;
{  
    CGPoint thumPoint = CGPointMake(0.0,0.0);
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    	
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
		
		//identify if to scale to fit width or height
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor; 
        }
        else {
            scaleFactor = heightFactor; 
        }
		
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
		
        if (widthFactor > heightFactor) {
            thumPoint.y = (targetHeight - scaledHeight) * 0.5; 
        }
        else if (widthFactor < heightFactor) {
            thumPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }     
	
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
	
    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }
	
    CGContextRef bitmap;
	
    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, 
        CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
		
    } else {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, 
        CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
		
    }   
	
    if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        thumPoint = CGPointMake(thumPoint.y, thumPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
		
        CGContextRotateCTM (bitmap, radians(90));
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
		
    } else if (sourceImage.imageOrientation == UIImageOrientationRight) {
        thumPoint = CGPointMake(thumPoint.y, thumPoint.x);
        CGFloat oldScaledWidth = scaledWidth;
        scaledWidth = scaledHeight;
        scaledHeight = oldScaledWidth;
		
        CGContextRotateCTM (bitmap, radians(-90));
        CGContextTranslateCTM (bitmap, -targetWidth, 0);
		
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        CGContextTranslateCTM (bitmap, targetWidth, targetHeight);
        CGContextRotateCTM (bitmap, radians(-180.));
    }
	
    CGContextDrawImage(bitmap, CGRectMake(thumPoint.x, thumbPoint.y, scaledWidth, scaledHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];
	
    CGContextRelease(bitmap);
    CGImageRelease(ref);
	
    return newImage; 
}




@end
