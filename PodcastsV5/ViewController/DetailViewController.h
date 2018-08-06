//
//  DetailViewController.h
//  PodcastsV5
//
//  Created by Pavel Koka on 8/5/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.

#import <UIKit/UIKit.h>
#import "KPIItem+CoreDataClass.h"


@interface DetailViewController : UIViewController
-(void)itemWasSelected:(KPIItem *)item;

@end
