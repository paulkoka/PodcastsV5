//
//  KPiLocalImageFull+CoreDataProperties.h
//  finalPodcasts
//
//  Created by Pavel Koka on 8/5/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//
//

#import "KPiLocalImageFull+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface KPiLocalImageFull (CoreDataProperties)

+ (NSFetchRequest<KPiLocalImageFull *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSData *image;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) KPIItem *toItem;

@end

NS_ASSUME_NONNULL_END
