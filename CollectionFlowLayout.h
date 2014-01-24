//
//  CollectionFlowLayout.h
//  TVGuideDemo
//
//  Created by pavan on 1/23/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    FlowLayoutMode_Even,
    FlowLayoutMode_Centered
} FlowLayoutMode;

@interface CollectionFlowLayout : UICollectionViewFlowLayout

@property FlowLayoutMode layoutMode;

@end
