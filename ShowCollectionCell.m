//
//  ShowCollectionCell.m
//  TVGuideDemo
//
//  Created by pavan on 1/24/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import "ShowCollectionCell.h"

@implementation ShowCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self addShowLabel];
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.showLabel setFrame:self.bounds];
}

#pragma mark - UI creation methods
- (void)addShowLabel
{
    [self addSubview:({
        UILabel *showLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [showLabel setText:@"asdfdsafsadf"];
        self.showLabel = showLabel;
        showLabel;
    })];
    
}

@end
