//
//  UIImage+Compression.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "UIImage+Compression.h"

@implementation UIImage (Compression)

+ (NSData *)imageWithImage:(UIImage *)image compressedWithFactor:(float)compressFactor {
    CGSize newSize = CGSizeMake(image.size.width * compressFactor, image.size.height * compressFactor);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(newImage, 0.3);
    return imageData;
}

@end
