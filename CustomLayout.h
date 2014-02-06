//
//  CustomLayout.h
//  TVGuideDemo
//
//  Created by pavan on 2/4/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLayout : UICollectionViewLayout
@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;
@end
