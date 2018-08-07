//
//  NSString+trimmingOfDataFromRss.m
//  Podcasts
//
//  Created by Pavel Koka on 7/31/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "NSString+trimmingOfDataFromRss.h"

@implementation NSString (trimmingOfDataFromRss)

+(NSString*) trimmingOfDataFromRss :(NSData*)CDATABlock{
    
NSString* string = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
if ([string containsString:@"<p>"] )
{
    NSCharacterSet* set = [NSCharacterSet  characterSetWithCharactersInString:@"</p>"];
    
    string = [string stringByTrimmingCharactersInSet:set];
    
    NSRange range = [string rangeOfString:@"</p>"];
    
    if (NSNotFound != range.location) {
        string = [string substringToIndex: (range.location)];
    
    }
 }
    
    
    return string;
}

+(NSString*)preapreforSaving:(NSString*)string1 and:(NSString*) string2{
    if ([string2 isEqualToString:@"title"]) {
        if ([string2 containsString:@" | "]) {
            NSRange range = [string1 rangeOfString:@" | "];
            if (NSNotFound != range.location) {
                string1 = [string1 substringToIndex:(range.location)];
            }
        }
    }
    return string1;
}


@end
