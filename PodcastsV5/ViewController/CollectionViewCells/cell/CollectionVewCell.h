//
//  CollectionVewCell.h
//  PadcastsApp
//
//  Created by Dzmitry Tarelkin on 7/25/18.
//  Copyright © 2018 Dzmitry Tarelkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPIItem+CoreDataClass.h"


@interface CollectionVewCell : UICollectionViewCell
-(void)setDataToLabelsFrom:(KPIItem*)item;

@end
