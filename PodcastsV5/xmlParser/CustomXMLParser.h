//
//  CustomXMLParser.h
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


#import "MyTags.h"

@interface CustomXMLParser : NSObject <NSXMLParserDelegate>

@property (nonatomic) NSXMLParser* parser;

-(void) startWithDataAndParse:(NSData*) data withContext:(NSManagedObjectContext*)context;

@end
