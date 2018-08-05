//
//  KPIItem+AddSingleItem.m
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "KPIItem+AddSingleItem.h"
#import "MyTags.h"

#import "KPIContent+addName.h"
#import "KPILocalImagePreview+addName.h"
#import "KPiLocalImageFull+addName.h"

#import "NSDate+dateWithStringFromRSS.h"

static NSString *MyEntityName = @"KPIItem";

@implementation KPIItem (AddSingleItem)


+(KPIItem*) itemWithRSSItem:(NSDictionary*) itemDictionary
     inManagedObjectContext: (NSManagedObjectContext*) context{
    MyTags* tags = [[MyTags alloc] init];
    KPIItem* item = nil;
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:MyEntityName];
    request.predicate = [NSPredicate predicateWithFormat:@"gUID = %@", [itemDictionary objectForKey:tags.gUID]];
    
    NSError *error;
    NSArray* matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error || matches.count > 1) {
        NSLog(@"%@", error);
        NSLog(@"KPIItem+AddSingleItem.h error");
    } else if ([matches count]){
        item = [matches firstObject];
    }
    else{
        item = [NSEntityDescription insertNewObjectForEntityForName:MyEntityName inManagedObjectContext:context];
        item.author = [itemDictionary objectForKey:tags.author];
        item.title = [itemDictionary objectForKey:tags.title];
        item.duration = [itemDictionary objectForKey:tags.duration];
        item.details = [itemDictionary objectForKey:tags.details];
        item.gUID = [itemDictionary objectForKey:tags.gUID];
        item.sourceType = [itemDictionary objectForKey:tags.MysourceType];
        item.publicationDate =[itemDictionary objectForKey:tags.publicationDate];
        item.imageWebURL = [itemDictionary objectForKey:tags.imageWebURL];
        
        item.mediaContentWebURL = [itemDictionary objectForKey:tags.contentWebURL];
        
        item.imagePreview = [KPILocalImagePreview addName:[itemDictionary objectForKey:tags.imageWebURL] inManagedObjectContext:context];
        
       item.imageFull = [KPiLocalImageFull addName:[itemDictionary objectForKey:tags.imageWebURL] inManagedObjectContext:context];
        item.content = [KPIContent addName:[itemDictionary objectForKey:tags.contentWebURL] inManagedObjectContext:context];
    }
     return item;
}
@end
