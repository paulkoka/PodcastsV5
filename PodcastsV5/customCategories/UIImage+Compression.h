//
//  UIImage+Compression.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/27/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compression)

+ (NSData *)imageWithImage:(UIImage *)image compressedWithFactor:(float)compressFactor;

@end
