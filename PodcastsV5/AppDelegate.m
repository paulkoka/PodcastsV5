//
//  AppDelegate.m
//  PodcastsV5
//
//  Created by Pavel Koka on 8/5/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "AppDelegate.h"
#import "CollectionViewControllerWithCoreData.h"
#import "DetailViewController.h"
#import "SplitController.h"
#import "RSSLoader.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    RSSLoader* loader = [[RSSLoader alloc] init];
    [loader startProcessing];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    CollectionViewControllerWithCoreData *master = [[CollectionViewControllerWithCoreData alloc] initWithCollectionViewLayout:flow];
    
    master.managedObjectContext = self.persistentContainer.viewContext;
    
    DetailViewController * detail = [[DetailViewController alloc] init];
    
    UINavigationController * nav =[[UINavigationController alloc]  initWithRootViewController:master];
    
    UINavigationController * navDetail = [[UINavigationController alloc] initWithRootViewController:detail];
    
    
    SplitController* splitViewController = [[SplitController alloc] init];
    [splitViewController setViewControllers:@[nav,navDetail]];
    [splitViewController setPreferredDisplayMode:UISplitViewControllerDisplayModeAllVisible];
    
    detail.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    detail.navigationItem.leftItemsSupplementBackButton = YES;
    
    
    [self.window setRootViewController:splitViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}



#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {

    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"KPIpodcasterV2frAug03"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {

        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
