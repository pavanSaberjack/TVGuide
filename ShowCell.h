//
//  ShowCell.h
//  TVGuideDemo
//
//  Created by pavan on 1/23/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShowCellDelegate;
@interface ShowCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) id<ShowCellDelegate>delegate;

- (void)addScrollingDelegates;
- (void)removeScrollingDelegates;
@end

@protocol ShowCellDelegate <NSObject>
- (void)showCell:(ShowCell *)cell collectionViewDidScrollBegin:(UIScrollView *)scrollView;
- (void)showCell:(ShowCell *)cell collectionViewDidScroll:(UIScrollView *)scrollView;
- (void)showCell:(ShowCell *)cell collectionViewDidEndScroll:(UIScrollView *)scrollView;
- (void)showCell:(ShowCell *)cell collectionViewDidEndScrollAnimation:(UIScrollView *)scrollView;
- (void)showCell:(ShowCell *)cell collectionViewDidScrollDeaccelerate:(UIScrollView *)scrollView;
@end