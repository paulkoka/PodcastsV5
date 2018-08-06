//
//  KPiLocalImageFull+addName.h
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "KPiLocalImageFull+CoreDataClass.h"

static NSString* hanselmanOld = @"hanselmanOld";

@interface KPiLocalImageFull (addName)



+(KPiLocalImageFull*) addName:(NSString*) path inManagedObjectContext:(NSManagedObjectContext*) context;

@end
