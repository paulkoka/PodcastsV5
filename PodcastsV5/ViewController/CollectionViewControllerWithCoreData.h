//
//  CollectionViewControllerWithCoreData.h
//  Podcasts
//
//  Created by Pavel Koka on 7/30/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
@interface CollectionViewControllerWithCoreData : UICollectionViewController

@property (nonatomic) NSManagedObjectContext* managedObjectContext;
@property (nonatomic) NSFetchedResultsController* fetchedResultsController;
@property (nonatomic) BOOL debug;
@end
