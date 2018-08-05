//
//  NSDate+dateWithStringFromRSS.m
//  Podcasts
//
//  Created by Pavel Koka on 7/31/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "NSDate+dateWithStringFromRSS.h"

@implementation NSDate (dateWithStringFromRSS)


+(NSDate*) dateWithStringFromRSS:(NSString*) string{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"E, dd MMM yyyy HH:mm:ss Z";

    return  [formatter dateFromString:string];;
}

@end
