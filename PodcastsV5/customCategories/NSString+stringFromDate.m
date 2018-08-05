//
//  NSString+stringFromDate.m
//  Podcasts
//
//  Created by Pavel Koka on 7/31/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "NSString+stringFromDate.h"

@implementation NSString (stringFromDate)
+ (NSString *)getStringFromDate:(NSDate *) date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"E, dd MMM yyyy";
    
    return [formatter stringFromDate:date];
}
@end
