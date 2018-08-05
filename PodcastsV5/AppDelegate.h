//
//  AppDelegate.h
//  PodcastsV5
//
//  Created by Pavel Koka on 8/5/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

