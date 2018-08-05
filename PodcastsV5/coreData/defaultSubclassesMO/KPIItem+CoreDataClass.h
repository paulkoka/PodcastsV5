//
//  KPIItem+CoreDataClass.h
//  finalPodcasts
//
//  Created by Pavel Koka on 8/5/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class KPIContent, KPILocalImagePreview, KPiLocalImageFull;

NS_ASSUME_NONNULL_BEGIN

@interface KPIItem : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "KPIItem+CoreDataProperties.h"
