//
//  KPIContent+addName.h
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "KPIContent+CoreDataClass.h"

@interface KPIContent (addName)
+(KPIContent*) addName:(NSString*) path inManagedObjectContext:(NSManagedObjectContext*) context;
@end
