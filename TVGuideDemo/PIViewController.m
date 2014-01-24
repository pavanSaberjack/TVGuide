//
//  PIViewController.m
//  TVGuideDemo
//
//  Created by pavan on 1/23/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import "PIViewController.h"

// Custom Views
#import "TableContainerView.h"

@interface PIViewController ()

@end

@implementation PIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addTableContainerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Private methods
- (void)addTableContainerView
{
    [self.view addSubview:({
        TableContainerView *tableContainer = [[TableContainerView alloc] initWithFrame:self.view.bounds];
        [tableContainer setBackgroundColor:[UIColor redColor]];
        tableContainer;
    })];
}
@end
