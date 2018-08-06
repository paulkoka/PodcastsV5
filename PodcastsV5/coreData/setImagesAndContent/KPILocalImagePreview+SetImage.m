//
//  KPILocalImagePreview+SetImage.m
//  KPIpodcasterV2frAug03
//
//  Created by Pavel Koka on 8/3/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "KPILocalImagePreview+SetImage.h"
#import "downlodDataFromWeb.h"
#import "CheckForOldHanselman.h"


@implementation KPILocalImagePreview (SetImage)



- (void)awakeFromFetch{
    
    [super awakeFromFetch];
    [self setupImage];
    
};

-(void) setupImage{
    if (!self.image) {
        CheckForOldHanselman* check = [[CheckForOldHanselman alloc]init];
        if (![check checkForOldHanselman:self.toItem]) {
            downlodDataFromWeb* downloader = [[downlodDataFromWeb alloc] init];
            [downloader downloadDataForKPIItem:self.toItem];
        }

    }
        
}

@end
