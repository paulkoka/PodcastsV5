//
//  KPiLocalImageFull+CoreDataProperties.m
//  finalPodcasts
//
//  Created by Pavel Koka on 8/5/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//
//

#import "KPiLocalImageFull+CoreDataProperties.h"

@implementation KPiLocalImageFull (CoreDataProperties)

+ (NSFetchRequest<KPiLocalImageFull *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"KPiLocalImageFull"];
}

@dynamic image;
@dynamic name;
@dynamic toItem;

@end
