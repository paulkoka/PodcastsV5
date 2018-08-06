//
//  CheckForOldHanselman.m
//  PodcastsV5
//
//  Created by Pavel Koka on 8/6/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "CheckForOldHanselman.h"
#import "NSDate+dateWithStringFromRSS.h"

@implementation CheckForOldHanselman

-(BOOL) checkForOldHanselman:(KPIItem*)item{
    
    return ([item.sourceType isEqualToString:@"Scott Hanselman"] && ([item.publicationDate earlierDate: [NSDate dateWithStringFromRSS:@"Thu, 14 Dec 2017 20:00:00 -0800"]] == item.publicationDate));
}

@end
