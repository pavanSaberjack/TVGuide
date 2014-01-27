//
//  CustomCollectionView.m
//  TVGuideDemo
//
//  Created by pavan on 1/27/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import "CustomCollectionView.h"
#import "ShowCollectionCell.h"

@interface CustomCollectionView()<UICollectionViewDelegate>
@property (nonatomic, strong) id<UICollectionViewDelegate>externalDelegate; // Delegate which implements datasource and other tableview methods except scroll delegates
@end

@implementation CustomCollectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setDelegate:(id<UICollectionViewDelegate>)delegate
{
    super.delegate = self;
    self.externalDelegate = delegate;
}

- (id<UICollectionViewDelegate>)delegate
{
    return self.externalDelegate;
}

- (void)reloadData
{
    NSLog(@"reloadData");
    [super reloadData];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([self respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:self];
    }
    else if ([self.externalDelegate respondsToSelector:[anInvocation selector]])
    {
        [anInvocation invokeWithTarget:self.externalDelegate];
    }
    else
    {
        [super forwardInvocation:anInvocation];
    }
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"'scrollViewDidScroll' Delegate called in custom class");
    
    
    
//    CGRect scrollVisibleRect = CGRectZero;
//    scrollVisibleRect.origin = scrollView.contentOffset;
//    scrollVisibleRect.size = scrollView.frame.size;
//    
//    // get the visible cells for collection cells
//    NSArray *visibleShows = [self visibleCells];
//    for (ShowCollectionCell *cell in visibleShows) {
//        [cell updateTheContentsForRect:scrollVisibleRect];
//    }

    [self.externalDelegate scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"'scrollViewDidEndDragging' Delegate called in custom class");
    [self.externalDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self.externalDelegate scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.externalDelegate scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.externalDelegate scrollViewDidEndDecelerating:scrollView];
}

@end
