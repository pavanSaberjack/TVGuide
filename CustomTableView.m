//
//  CustomTableView.m
//  TVGuideDemo
//
//  Created by pavan on 2/4/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import "CustomTableView.h"

@interface CustomTableView () <UITableViewDelegate>
@property (nonatomic, strong) id<UITableViewDelegate>externalDelegate;
@end

@implementation CustomTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    super.delegate = self;
    self.externalDelegate = delegate;
}

- (id<UITableViewDelegate>)delegate
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

#pragma mark - Delegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.externalDelegate tableView:self heightForRowAtIndexPath:indexPath];
}

#pragma mark - scroll view delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.externalDelegate scrollViewDidScroll:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.externalDelegate scrollViewWillBeginDragging:scrollView];
}

@end
