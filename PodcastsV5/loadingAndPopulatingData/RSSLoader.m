//
//  RSSLoader.m
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "RSSLoader.h"
#import "AppDelegate.h"
#import "SourseURLforRead.h"
#import "CustomXMLParser.h"


@interface RSSLoader()

@property (nonatomic) AppDelegate* appDelegate;

@end

@implementation RSSLoader

-(id) init{
    if ((self = [super init])) {

        _appDelegate = ((AppDelegate*) UIApplication.sharedApplication.delegate);
    }
    return self;
};

-(void)startProcessing{
    [self downloadRSSwithURL];

}


- (void)downloadRSSwithURL {
    SourseURLforRead* urls = [[SourseURLforRead alloc] init];
    NSURLSessionConfiguration* myConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    myConfig.waitsForConnectivity = YES;
    
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    [queue setQualityOfService:NSQualityOfServiceUtility];
    queue.maxConcurrentOperationCount = 1;//to sync queue
    NSURLSession* sessionForDownloadingRSS = [NSURLSession sessionWithConfiguration:myConfig delegate:self delegateQueue:queue];
    
    for (NSURL* url in urls.URLs) {
        NSURLSessionDownloadTask* task = [sessionForDownloadingRSS downloadTaskWithURL:url];
        [task resume];
    }
    [sessionForDownloadingRSS finishTasksAndInvalidate];
}

- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    
    NSData* data = [NSData dataWithContentsOfURL:location];
    [self parseRSSWithData:data];
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error) {
        NSLog(@"error: %@ - %@", task, error);
    }
}

-(void)parseRSSWithData:(NSData*)data{

    NSManagedObjectContext* context = [self.appDelegate.persistentContainer newBackgroundContext];
    
    [context performBlockAndWait:^{
        CustomXMLParser *parser = [[CustomXMLParser alloc] init];
        [parser startWithDataAndParse:data withContext:context];
    }];
    
    NSError* error;
    [context save:&error];

}


@end
