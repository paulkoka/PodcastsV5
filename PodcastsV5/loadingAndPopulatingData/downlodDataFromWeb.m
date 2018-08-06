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
#import "CheckForOldHanselman.h"

@interface downlodDataFromWeb()<NSURLSessionDownloadDelegate>

@property (atomic) KPIItem* item;

@end


@implementation downlodDataFromWeb

-(void) downloadDataForKPIItem:(KPIItem*)item{
 
    self.item = item;
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.waitsForConnectivity = YES;
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    [queue setQualityOfService:NSQualityOfServiceUtility];
    queue.maxConcurrentOperationCount = 1;//to sync queue
    
    
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:queue];
    
    NSURLSessionDownloadTask* task = [session downloadTaskWithURL:[NSURL URLWithString:item.imageWebURL]];
    
    [task resume];
    
    [session finishTasksAndInvalidate];

}


-(void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
  //  __weak typeof(self) weakself = self;
    
    CheckForOldHanselman* old = [[CheckForOldHanselman alloc] init];
    
    BOOL check = [old checkForOldHanselman:self.item];
    if (!check) {
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
}

@end
