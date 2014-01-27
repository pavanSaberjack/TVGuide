//
//  ShowCell.m
//  TVGuideDemo
//
//  Created by pavan on 1/23/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import "ShowCell.h"
#import "CollectionFlowLayout.h"

//Custom Cell
#import "ShowCollectionCell.h"

// Custom collectin view
#import "CustomCollectionView.h"

@interface ShowCell() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>
{
    CollectionFlowLayout* _flowLayout;
}
@end

@implementation ShowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _flowLayout = [[CollectionFlowLayout alloc] init];
        _flowLayout.layoutMode = FlowLayoutMode_Centered;
        _flowLayout.minimumLineSpacing = 2.0f;
        _flowLayout.minimumInteritemSpacing = 2.0f;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f);
        _flowLayout.itemSize = CGSizeMake(75.0f, 75.0f);
        
        _collectionView.collectionViewLayout = _flowLayout;
        
        [_collectionView registerClass:[ShowCollectionCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    }
    return self;
}

- (void)awakeFromNib
{
    [_collectionView setDelegate:self];
    [_collectionView registerClass:[ShowCollectionCell class] forCellWithReuseIdentifier:@"CollectionCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:NO animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Public methods
- (void)addScrollingDelegates
{
    self.collectionView.delegate = self;
    self.collectionView.userInteractionEnabled = YES;
}

- (void)removeScrollingDelegates
{
    self.collectionView.delegate = nil;
    self.collectionView.userInteractionEnabled = NO;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize cellSize;
    
    int rand = arc4random() % 4;
    if (rand == 0) rand = 1;
    cellSize = CGSizeMake( 80 * rand, 75);
    
    return cellSize;
}

#pragma mark UICollectionViewDelegate methods

#pragma mark UICollectionViewDataSource methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CollectionCell";
    
    ShowCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setBackgroundColor:[UIColor blueColor]];
    [cell configureWithData:nil];
    return cell;
}

#pragma mark - UIScrollViewDelegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGRect scrollVisibleRect = CGRectZero;
    scrollVisibleRect.origin = scrollView.contentOffset;
    scrollVisibleRect.size = scrollView.frame.size;
    
    NSArray *visibleShows = [self.collectionView visibleCells];
    
    for (ShowCollectionCell *cell in visibleShows)
    {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        
        CGRect cellRect =  cell.frame;//[self.collectionView rectForRowAtIndexPath:indexPath];
        cellRect = [self.collectionView convertRect:cellRect toView:self.collectionView.superview];
        BOOL completelyVisible = CGRectContainsRect(self.collectionView.frame, cellRect);
        
        NSLog(@"asdfsdfsdf");
    }
    
    
    
    
//    // get the visible cells for collection cells
//    NSArray *visibleShows = [self.collectionView visibleCells];
//    for (ShowCollectionCell *cell in visibleShows) {
//        [cell updateTheContentsForRect:scrollVisibleRect];
//    }
    
    if ([self.delegate respondsToSelector:@selector(showCell:collectionViewDidScroll:)]) {
        [self.delegate showCell:self collectionViewDidScroll:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if([self.delegate respondsToSelector:@selector(showCell:collectionViewDidScrollBegin:)])
    {
        [self.delegate showCell:self collectionViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"Content Offset x = %f", scrollView.contentOffset.x);
    
    int page = scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame);
    
    if ((scrollView.contentOffset.x > page*CGRectGetWidth(scrollView.frame)) && (scrollView.contentOffset.x < (page + 1)*CGRectGetWidth(scrollView.frame)))
    {
        if(scrollView.contentOffset.x < (page + 0.5)*CGRectGetWidth(scrollView.frame))
        {
            [scrollView setContentOffset:CGPointMake(page*CGRectGetWidth(scrollView.frame), 0) animated:YES];
            
            if([self.delegate respondsToSelector:@selector(showCell:collectionViewDidScrollDeaccelerate:)])
            {
                [self.delegate showCell:self collectionViewDidScrollDeaccelerate:scrollView];
            }
        }
        else
        {
            [scrollView setContentOffset:CGPointMake((page + 1)*CGRectGetWidth(scrollView.frame), 0) animated:YES];
            
            if([self.delegate respondsToSelector:@selector(showCell:collectionViewDidScrollDeaccelerate:)])
            {
                [self.delegate showCell:self collectionViewDidScrollDeaccelerate:scrollView];
            }
        }
    }
    
    // did end scroll delegate called
    if([self.delegate respondsToSelector:@selector(showCell:collectionViewDidEndScroll:)])
    {
        [self.delegate showCell:self collectionViewDidEndScroll:scrollView];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"Content Offset x = %f", scrollView.contentOffset.x);
    
    int page = scrollView.contentOffset.x/CGRectGetWidth(scrollView.frame);
    
    if ((scrollView.contentOffset.x > page*CGRectGetWidth(scrollView.frame)) && (scrollView.contentOffset.x < (page + 1)*CGRectGetWidth(scrollView.frame)))
    {
        if(scrollView.contentOffset.x < (page + 0.5)*CGRectGetWidth(scrollView.frame))
        {
            [scrollView setContentOffset:CGPointMake(page*CGRectGetWidth(scrollView.frame), 0) animated:YES];
        }
        else
        {
            [scrollView setContentOffset:CGPointMake((page + 1)*CGRectGetWidth(scrollView.frame), 0) animated:YES];
        }
    }
    
    // did end scroll delegate called
    if([self.delegate respondsToSelector:@selector(showCell:collectionViewDidEndScroll:)])
    {
        [self.delegate showCell:self collectionViewDidEndScroll:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // did end scroll delegate called
    if([self.delegate respondsToSelector:@selector(showCell:collectionViewDidEndScrollAnimation:)])
    {
        [self.delegate showCell:self collectionViewDidEndScrollAnimation:scrollView];
    }
}

@end
