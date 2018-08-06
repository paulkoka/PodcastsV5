//
//  CheckForOldHanselman.h
//  PodcastsV5
//
//  Created by Pavel Koka on 8/6/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPIItem+CoreDataClass.h"
#import "KPILocalImagePreview+CoreDataClass.h"
#import "KPiLocalImageFull+CoreDataClass.h"

@interface CheckForOldHanselman : NSObject
-(BOOL) checkForOldHanselman:(KPIItem*)item;
@end
