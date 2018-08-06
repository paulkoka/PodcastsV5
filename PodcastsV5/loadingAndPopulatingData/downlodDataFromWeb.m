//
//  downlodDataFromWeb.m
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "downlodDataFromWeb.h"
#import "UIImage+Compression.h"
#import "KPiLocalImageFull+CoreDataClass.h"
#import "KPILocalImagePreview+CoreDataClass.h"
#import <UIKit/UIKit.h>
#import "UIImage+Compression.h"


@interface downlodDataFromWeb()<NSURLSessionDownloadDelegate>

@property (atomic) KPIItem* item;

@end


@implementation downlodDataFromWeb

-(void) downloadDataForKPIItem:(KPIItem*)item{
 
    self.item = item;

 
    
    NSURLSessionDownloadTask* task = [[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:self.item.imageWebURL] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSManagedObjectContext* context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        
        [context setParentContext: self.item.managedObjectContext];
        
        NSData* data = [NSData dataWithContentsOfURL:location];
        UIImage* image = [UIImage imageWithData:data];
        self.item.imageFull.image =  UIImageJPEGRepresentation(image, 0.5);
        self.item.imagePreview.image = [UIImage imageWithImage:image compressedWithFactor:0.05];
        
        [context performBlock:^{
            
            NSError* error;
            [context save:&error];
        }];
        
        [self.item.managedObjectContext performBlock:^{
            NSError* error;
            [self.item.managedObjectContext save:&error];
        }];
    }];
    
    [task resume];
    
}


-(void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{

        NSManagedObjectContext* context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        
        [context setParentContext: self.item.managedObjectContext];
        
        NSData* data = [NSData dataWithContentsOfURL:location];
        UIImage* image = [UIImage imageWithData:data];
        self.item.imageFull.image =  UIImageJPEGRepresentation(image, 0.5);
        self.item.imagePreview.image = [UIImage imageWithImage:image compressedWithFactor:0.05];
        
        [context performBlock:^{
            
            NSError* error;
            [context save:&error];
        }];
        
        [self.item.managedObjectContext performBlock:^{
            NSError* error;
            [self.item.managedObjectContext save:&error];
        }];

}

@end
