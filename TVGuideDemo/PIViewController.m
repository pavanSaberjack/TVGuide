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

#import "PickAShowViewController.h"

@interface PIViewController ()

@end

@implementation PIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self addTableContainerView];
    
    [self performSelector:@selector(shows) withObject:nil afterDelay:2.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Private methods
- (void)shows
{
    [self presentViewController:({
        PickAShowViewController *pickShow = [[PickAShowViewController alloc] initWithNibName:@"PickAShowViewController" bundle:nil];
        pickShow;
    }) animated:YES completion:nil];
}

- (void)addTableContainerView
{
    [self.view addSubview:({
        TableContainerView *tableContainer = [[TableContainerView alloc] initWithFrame:self.view.bounds];
        [tableContainer setBackgroundColor:[UIColor redColor]];
        tableContainer;
    })];
}
@end
