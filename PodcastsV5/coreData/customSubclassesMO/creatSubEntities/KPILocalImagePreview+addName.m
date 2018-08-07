//
//  KPILocalImagePreview+addName.m
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "KPILocalImagePreview+addName.h"
#import <UIKit/UIKit.h>
#import "UIImage+Compression.h"
static NSString* hanselmanOld = @"hanselmanOld";

static NSString* entityNameImg = @"KPILocalImagePreview";

@implementation KPILocalImagePreview (addName)

+(KPILocalImagePreview*) addName:(NSString*) path inManagedObjectContext:(NSManagedObjectContext*) context{
    
    KPILocalImagePreview* image = nil;
    
    if (path.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityNameImg];
        
        NSString* name = [NSString stringWithFormat:@"preview%@", [path lastPathComponent]];
        
        request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
        
        NSError *error;
        
        NSArray* matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || matches.count > 1) {
            NSLog(@"KPILocalImagePreview+addName.h smth wrong");
        } else if (!matches.count){
            image = [NSEntityDescription insertNewObjectForEntityForName:entityNameImg inManagedObjectContext:context];
            image.name = name;

        }
        else {
            image = [matches lastObject];
        }
        
    }
    
    return  image;
}
@end
