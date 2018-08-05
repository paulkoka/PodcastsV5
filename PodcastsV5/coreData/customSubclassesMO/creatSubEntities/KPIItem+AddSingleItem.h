//
//  KPIItem+AddSingleItem.h
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "KPIItem+CoreDataClass.h"

@interface KPIItem (AddSingleItem)

+(KPIItem*) itemWithRSSItem:(NSDictionary*) itemDictionary
     inManagedObjectContext: (NSManagedObjectContext*) context;

@end
