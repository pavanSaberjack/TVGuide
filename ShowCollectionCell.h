//
//  ShowCollectionCell.h
//  TVGuideDemo
//
//  Created by pavan on 1/24/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowCollectionCell : UICollectionViewCell
@property (nonatomic, weak) UILabel *showLabel;

- (void)configureWithData:(id)data;
- (void)updateTheContentsForRect:(CGRect)parentVisibleRect;
@end
