//
//  NSString+trimmingOfDataFromRss.h
//  Podcasts
//
//  Created by Pavel Koka on 7/31/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (trimmingOfDataFromRss)

+(NSString*) trimmingOfDataFromRss :(NSData*)CDATABlock;

+(NSString*)preapreforSaving:(NSString*)string1 and:(NSString*) string2;

@end
