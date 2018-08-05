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



@end
