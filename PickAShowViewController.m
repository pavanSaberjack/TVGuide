//
//  PickAShowViewController.m
//  TVGuideDemo
//
//  Created by pavan on 2/3/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import "PickAShowViewController.h"

// Custom Collection view
#import "CustomCollectionView.h"
#import "CustomLayout.h"
#import "CustomCell.h"
#import "CustomTableView.h"


static NSString *const CollectionViewCellIdentifier  = @"CollectionCellIdentifier";
CGFloat const CellHeight = 60.0f;

NSString *const KeyPathForCollectionView = @"self.collectionView.contentOffset";
NSString *const KeyPathForTableView = @"self.channelTableView.contentOffset";

@interface PickAShowViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) IBOutlet CustomTableView *channelTableView;
@property (nonatomic, weak) IBOutlet CustomCollectionView *collectionView;
@property (nonatomic, weak) IBOutlet CustomLayout *customLayout;


@property (nonatomic, strong) id currentViewUpdating;
@end

@implementation PickAShowViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self addObserver:self forKeyPath:KeyPathForCollectionView options:NSKeyValueObservingOptionNew context:NULL];
//    [self addObserver:self forKeyPath:KeyPathForTableView options:NSKeyValueObservingOptionNew context:NULL];
    
    self.currentViewUpdating = self.collectionView;
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.25f alpha:1.0f];
    [self.collectionView registerClass:[CustomCell class] forCellWithReuseIdentifier:CollectionViewCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:KeyPathForCollectionView] && [self.currentViewUpdating isEqual:self.collectionView])
    {
        CGPoint point = [change[@"new"] CGPointValue];
        [self.channelTableView setContentOffset:CGPointMake(self.channelTableView.contentOffset.x, point.y)];
    }
    else if ([keyPath isEqualToString:KeyPathForTableView] && [self.currentViewUpdating isEqual:self.channelTableView])
    {
        CGPoint point = [change[@"new"] CGPointValue];
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x, point.y)];
    }
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ChannelCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.textLabel setText:@"hello"];
    
    return cell;
}


#pragma mark - UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 20;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    return cell;
}


#pragma mark - UIScrollViewDelegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[CustomCollectionView class]] && self.currentViewUpdating == self.collectionView)
    {
        [self.channelTableView setContentOffset:CGPointMake(self.channelTableView.contentOffset.x, scrollView.contentOffset.y)];
    }
    else if ([scrollView isKindOfClass:[CustomTableView class]] && self.currentViewUpdating == self.channelTableView)
    {
        NSLog(@"collection view content X : %f", self.collectionView.contentOffset.x);
        
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x, scrollView.contentOffset.y)];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[CustomCollectionView class]]) {
        self.currentViewUpdating = self.collectionView;
    }
    else if ([scrollView isKindOfClass:[CustomTableView class]])
    {
        self.currentViewUpdating = self.channelTableView;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

@end
