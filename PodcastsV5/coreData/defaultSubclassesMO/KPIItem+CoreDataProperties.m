//
//  KPIItem+CoreDataProperties.m
//  finalPodcasts
//
//  Created by Pavel Koka on 8/5/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//
//

#import "KPIItem+CoreDataProperties.h"

@implementation KPIItem (CoreDataProperties)

+ (NSFetchRequest<KPIItem *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"KPIItem"];
}

@dynamic author;
@dynamic details;
@dynamic duration;
@dynamic gUID;
@dynamic imageWebURL;
@dynamic mediaContentWebURL;
@dynamic publicationDate;
@dynamic sourceType;
@dynamic title;
@dynamic content;
@dynamic imageFull;
@dynamic imagePreview;

@end
