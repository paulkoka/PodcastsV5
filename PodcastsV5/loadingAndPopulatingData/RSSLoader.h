//
//  RSSLoader.h
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSSLoader : NSObject <NSURLSessionDownloadDelegate>

-(id) init;
-(void)startProcessing;
@end
