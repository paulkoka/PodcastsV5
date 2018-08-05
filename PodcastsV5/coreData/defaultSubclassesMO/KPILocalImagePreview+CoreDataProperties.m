//
//  KPILocalImagePreview+CoreDataProperties.m
//  finalPodcasts
//
//  Created by Pavel Koka on 8/5/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//
//

#import "KPILocalImagePreview+CoreDataProperties.h"

@implementation KPILocalImagePreview (CoreDataProperties)

+ (NSFetchRequest<KPILocalImagePreview *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"KPILocalImagePreview"];
}

@dynamic image;
@dynamic name;
@dynamic toItem;

@end
