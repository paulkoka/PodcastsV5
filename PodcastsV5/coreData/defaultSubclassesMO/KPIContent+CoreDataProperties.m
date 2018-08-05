//
//  KPIContent+CoreDataProperties.m
//  finalPodcasts
//
//  Created by Pavel Koka on 8/5/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//
//

#import "KPIContent+CoreDataProperties.h"

@implementation KPIContent (CoreDataProperties)

+ (NSFetchRequest<KPIContent *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"KPIContent"];
}

@dynamic content;
@dynamic name;
@dynamic toItem;

@end
