//
//  CustomCollectionView.m
//  TVGuideDemo
//
//  Created by pavan on 1/27/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import "CustomCollectionView.h"
#import "ShowCollectionCell.h"

//Restricting diagonal scrolling
typedef NS_ENUM(NSInteger, EGRIDVIEW_SCROLLDIRECTION) {
    eScrollLeft = 0,
    eScrollRight = 1,
    eScrollTop = 2,
    eScrollBottom = 3,
    eScrollNone = 4
};

@interface CustomCollectionView()<UICollectionViewDelegate>
{
    CGPoint mPreviousTouchPoint;
}
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

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    NSLog(@"'scrollViewDidEndDragging' Delegate called in custom class");
//    [self.externalDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
//}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self.externalDelegate scrollViewDidEndScrollingAnimation:scrollView];
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [self.externalDelegate scrollViewWillBeginDragging:scrollView];
//}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
////    [scrollView setContentOffset:scrollView.contentOffset animated:YES];
//    [self.externalDelegate scrollViewDidEndDecelerating:scrollView];
//}


-(EGRIDVIEW_SCROLLDIRECTION) getScrollDirection : (CGPoint) startPoint endPoint:(CGPoint) endPoint
{
    EGRIDVIEW_SCROLLDIRECTION direction = eScrollNone;
    
    EGRIDVIEW_SCROLLDIRECTION xDirection;
    EGRIDVIEW_SCROLLDIRECTION yDirection;
    
    int xDirectionOffset = startPoint.x - endPoint.x;
    if(xDirectionOffset > 0)
        xDirection = eScrollLeft;
    else
        xDirection = eScrollRight;
    
    int yDirectionOffset = startPoint.y - endPoint.y;
    if(yDirectionOffset > 0)
        yDirection = eScrollTop;
    else
        yDirection = eScrollBottom;
    
    if(abs(xDirectionOffset) > abs(yDirectionOffset))
        direction = xDirection;
    else
        direction = yDirection;
    
    return direction;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    mPreviousTouchPoint = scrollView.contentOffset;
    [self.externalDelegate scrollViewWillBeginDragging:scrollView];
}

//- (void)scrollViewDidScroll:(UIScrollView *)sender
//{
////    CGPoint offset = sender.contentOffset;
////    
////    //Cool... Restricting diagonal scrolling
////    EGRIDVIEW_SCROLLDIRECTION mSwipeDirection = [self getScrollDirection:mPreviousTouchPoint endPoint:sender.contentOffset];
////    switch (mSwipeDirection) {
////        case eScrollLeft:
////            sender.contentOffset = CGPointMake(offset.x, mPreviousTouchPoint.y);
////            break;
////            
////        case eScrollRight:
////            sender.contentOffset = CGPointMake(offset.x, mPreviousTouchPoint.y);
////            break;
////            
////        case eScrollTop:
////            sender.contentOffset = CGPointMake(mPreviousTouchPoint.x, offset.y);
////            break;
////            
////        case eScrollBottom:
////            sender.contentOffset = CGPointMake(mPreviousTouchPoint.x, offset.y);
////            break;
////            
////        default:
////            break;
////    }
//    
//    [self.externalDelegate scrollViewDidScroll:sender];
//}
@end
