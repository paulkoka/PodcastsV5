//
//  DetailViewController.h
//  PodcastsV5
//
//  Created by Pavel Koka on 8/5/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PodcastsV5+CoreDataModel.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Event *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

