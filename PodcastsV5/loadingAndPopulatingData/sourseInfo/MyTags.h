//
//  MyTags.h
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyTags : NSObject

@property(nonatomic, readonly) NSSet* setOfTags;

@property(nonatomic, readonly) NSString* item;
@property(nonatomic, readonly) NSString* title;
@property(nonatomic, readonly) NSString* author;
@property(nonatomic, readonly) NSString* gUID;
@property(nonatomic, readonly) NSString* publicationDate;
@property(nonatomic, readonly) NSString* duration;
@property(nonatomic, readonly) NSString* contentWebURL;
@property(nonatomic, readonly) NSString* imageWebURL;
@property(nonatomic, readonly) NSString* MysourceType;
@property(nonatomic, readonly) NSString* details;

-(id) init;

@end
