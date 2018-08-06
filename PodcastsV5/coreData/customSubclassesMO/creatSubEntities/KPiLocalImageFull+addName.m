//
//  KPiLocalImageFull+addName.m
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "KPiLocalImageFull+addName.h"
#import <UIKit/UIKit.h>

static NSString* entityNameImg = @"KPiLocalImageFull";

@implementation KPiLocalImageFull (addName)

+(KPiLocalImageFull*) addName:(NSString*) path inManagedObjectContext:(NSManagedObjectContext*) context{

KPiLocalImageFull* image = nil;

if (path.length) {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityNameImg];
    
    NSString* name = [path lastPathComponent];
    
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    
    NSError *error;
    
    NSArray* matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || matches.count > 1) {
        NSLog(@"KPIPicture+addPictureURL.h smth wrong");
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
