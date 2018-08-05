//
//  MyTags.m
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "MyTags.h"

static NSString* item = @"item";

static NSString* title = @"title";
static NSString* author = @"itunes:author";
static NSString* gUID = @"guid";
static NSString* publicationDate = @"pubDate";
static NSString* duration = @"itunes:duration";
static NSString* contentWebURL = @"enclosure";
static NSString* imageWebURL = @"itunes:image";

static NSString* details = @"details";


static NSString* MysourceType = @"copyright";



@implementation MyTags

-(id)init{
    if (self = [super init]) {
        _item = item;
        _title = title;
        _author = author;
        _gUID = gUID;
        _publicationDate = publicationDate;
        _duration = duration;
        _contentWebURL = contentWebURL;
        _imageWebURL = imageWebURL;
        _MysourceType = MysourceType;
        _details = details;
        _setOfTags = [NSSet setWithObjects:title, author, gUID, publicationDate, duration, contentWebURL, imageWebURL, nil];
    }
    return  self;
}

@end
