//
//  KPIItem+CoreDataClass.m
//  finalPodcasts
//
//  Created by Pavel Koka on 8/5/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//
//

#import "KPIItem+CoreDataClass.h"

@implementation KPIItem

-(void)awakeFromInsert{
    [super awakeFromInsert];
    NSLog(@"awakeFromInsert");
}

-(void)awakeFromFetch{
    [super awakeFromFetch];
    NSLog(@"awakeFromFetch");
}

@end
