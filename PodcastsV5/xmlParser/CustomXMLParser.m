//
//  CustomXMLParser.m
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "CustomXMLParser.h"

//#import "KPIItem+CoreDataClass.h"
#import "KPIItem+AddSingleItem.h"

#import "NSDate+dateWithStringFromRSS.h"
#import "NSString+trimmingOfDataFromRss.h"

static NSString* href = @"href";
static NSString* url = @"url";

@interface CustomXMLParser()

@property (nonatomic) BOOL inItemElement;
@property (nonatomic) BOOL waitingForSourseName;
@property (nonatomic) NSMutableString *capturedCharacters;
@property (nonatomic) NSMutableString* currentSourceType;

@property (nonatomic)NSMutableDictionary* itemFromRSS;

@property (nonatomic) NSString* currentElementName;

@property (nonatomic) MyTags* tags;

@property(nonatomic) NSManagedObjectContext* context;


@end

@implementation CustomXMLParser

-(id) init{
    if ((self = [super init])) {
        _tags = [[MyTags alloc] init];
    }
    return self;
}

-(void) startWithDataAndParse:(NSData*) data withContext:(NSManagedObjectContext*)context{
    self.parser = [[NSXMLParser alloc] initWithData:data];
    self.context = context;
    [self parseXML];
}

-(void) parseXML{
    [_parser setDelegate:self];
    
    if (![self.parser parse])
    {
        NSLog (@"An error occurred in the parsing");
    }
}

-(void) parserDidStartDocument:(NSXMLParser *)parser{
    self.inItemElement = NO;
}

-(void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    
    if ( !self.waitingForSourseName && !self.inItemElement && [elementName isEqualToString:self.tags.MysourceType]) {
        self.waitingForSourseName = YES;
        return;
    }
    
    if ([elementName isEqualToString:_tags.item]) {
        self.inItemElement = YES;
        self.itemFromRSS = [NSMutableDictionary dictionary];
        return;
    }
    
    if (self.inItemElement && [_tags.setOfTags containsObject:elementName])
    {
        
        self.capturedCharacters = [NSMutableString string];
        self.currentElementName = [NSString stringWithString:elementName];
        
        if ([elementName isEqualToString:self.tags.imageWebURL]) {
            
            [self.itemFromRSS setObject:[attributeDict objectForKey:href] forKey:elementName];
            return;
        }
        if ([elementName isEqualToString:self.tags.contentWebURL]) {
            [self.itemFromRSS setObject: [attributeDict objectForKey:url] forKey:elementName];
            return;
        }
        
    }
}


-(void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
    if (self.inItemElement) {
        NSString* string = [NSString trimmingOfDataFromRss:CDATABlock];
        [self.itemFromRSS setObject:string forKey:_tags.details];
    }
    
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if (self.waitingForSourseName) {
        self.currentSourceType = [NSMutableString string];
        [self.currentSourceType  appendString:string];
        self.waitingForSourseName = NO;
    }
    
    if (self.inItemElement && self.capturedCharacters) {
        [self.capturedCharacters appendString:string];
        
        if ([self.currentElementName isEqualToString:self.tags.publicationDate]) {
            
            NSDate *date = [NSDate dateWithStringFromRSS:string];
            
            [self.itemFromRSS setObject:date forKey:self.tags.publicationDate];
            return;
        }
        
        string = [NSString preapreforSaving:string and:self.currentElementName];
        
        [self.itemFromRSS setObject:string forKey:self.currentElementName];
    }
}



- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if (self.inItemElement && [_tags.setOfTags containsObject:elementName])
    {
        
        self.capturedCharacters = nil;
        self.currentElementName = nil;
        
    }
    if ([elementName isEqualToString:self.tags.item]) {
        [self saveElement];
    }
}

-(void)saveElement{
    [self.itemFromRSS setObject:self.currentSourceType forKey:self.tags.MysourceType];
    
    KPIItem* coreDataitem = [KPIItem  itemWithRSSItem:self.itemFromRSS inManagedObjectContext:self.context];
   
    self.itemFromRSS = nil;
    coreDataitem = nil;
    self.inItemElement = NO;
}



@end
