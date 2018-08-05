//
//  downlodDataFromWeb.h
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPIItem+CoreDataClass.h"

@interface downlodDataFromWeb : NSObject

-(void) downloadDataForKPIItem:(KPIItem*)item;
@end
