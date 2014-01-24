//
//  TableContainerView.m
//  TVGuideDemo
//
//  Created by pavan on 1/23/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import "TableContainerView.h"
#import "ShowCell.h"

static NSString *cellIdentifier = @"CellIdentifier";

@interface TableContainerView() <UITableViewDelegate, UITableViewDataSource, ShowCellDelegate>
@property (nonatomic, weak) UITableView *tableShows;
@end

@implementation TableContainerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addTableShows];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark UICreation Methods
- (void)addTableShows
{
    [self addSubview:({
        UITableView *tableShows = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        [tableShows setDelegate:self];
        [tableShows setDataSource:self];
        
        self.tableShows = tableShows;
        
        [tableShows registerNib:[UINib nibWithNibName:@"ShowCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        
        tableShows;
    })];
}

#pragma mark UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShowCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setDelegate:self];
    
    if (!cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = (ShowCell *)[nib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

#pragma mark - ShowCellDelegate methods
- (void)showCell:(ShowCell *)cell collectionViewDidScroll:(UIScrollView *)scrollView
{
    NSUInteger index = 0;
    NSUInteger count = [self.tableShows.visibleCells count];
    NSArray *visibleCells = self.tableShows.visibleCells;
    NSIndexPath *path = [self.tableShows indexPathForCell:cell];
    
    
    for(index = 0; index <count; index++)
    {
        ShowCell *subCell = visibleCells[index];
        NSIndexPath *newPath = [self.tableShows indexPathForCell:subCell];
        if ([newPath row] != [path row])
        {
            [subCell removeScrollingDelegates]; // remove the scroll Delegate
            UICollectionView *collectionView = subCell.collectionView;
            [collectionView setContentOffset:scrollView.contentOffset animated:NO];
        }
    }
}

- (void)showCell:(ShowCell *)cell collectionViewDidEndScroll:(UIScrollView *)scrollView
{
    NSUInteger index = 0;
    NSUInteger count = [self.tableShows.visibleCells count];
    NSArray *visibleCells = self.tableShows.visibleCells;
    NSIndexPath *path = [self.tableShows indexPathForCell:cell];
    
    
    for(index = 0; index <count; index++)
    {
        ShowCell *subCell = visibleCells[index];
        NSIndexPath *newPath = [self.tableShows indexPathForCell:subCell];
        if ([newPath row] != [path row])
        {
            [subCell addScrollingDelegates];
        }
    }
}

- (void)showCell:(ShowCell *)cell collectionViewDidEndScrollAnimation:(UIScrollView *)scrollView
{
    NSUInteger index = 0;
    NSUInteger count = [self.tableShows.visibleCells count];
    NSArray *visibleCells = self.tableShows.visibleCells;
    NSIndexPath *path = [self.tableShows indexPathForCell:cell];
    
    
    for(index = 0; index <count; index++)
    {
        ShowCell *subCell = visibleCells[index];
        NSIndexPath *newPath = [self.tableShows indexPathForCell:subCell];
        if ([newPath row] != [path row])
        {
            [subCell addScrollingDelegates];
            
        }
    }
}

- (void)showCell:(ShowCell *)cell collectionViewDidScrollDeaccelerate:(UIScrollView *)scrollView
{
    NSUInteger index = 0;
    NSUInteger count = [self.tableShows.visibleCells count];
    NSArray *visibleCells = self.tableShows.visibleCells;
    NSIndexPath *path = [self.tableShows indexPathForCell:cell];
    
    
    for(index = 0; index <count; index++)
    {
        ShowCell *subCell = visibleCells[index];
        NSIndexPath *newPath = [self.tableShows indexPathForCell:subCell];
        if ([newPath row] != [path row])
        {
            [subCell removeScrollingDelegates]; // remove the scroll Delegate
            UICollectionView *collectionView = subCell.collectionView;
            [collectionView setContentOffset:scrollView.contentOffset animated:YES];
        }
    }
}


@end
