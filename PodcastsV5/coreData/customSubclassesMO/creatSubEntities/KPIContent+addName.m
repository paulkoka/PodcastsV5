//
//  KPIContent+addName.m
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "KPIContent+addName.h"

static NSString* entityNameImg = @"KPIContent";

@implementation KPIContent (addName)

+(KPIContent*) addName:(NSString*) path inManagedObjectContext:(NSManagedObjectContext*) context{
    
    KPIContent* image = nil;
    
    if (path.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityNameImg];
        
        NSString* name = [path lastPathComponent];
        
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
