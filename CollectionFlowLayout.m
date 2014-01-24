//
//  CollectionFlowLayout.m
//  TVGuideDemo
//
//  Created by pavan on 1/23/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import "CollectionFlowLayout.h"

@implementation CollectionFlowLayout

- (id) init {
    self = [super init];
    if (self) {
        self.layoutMode = FlowLayoutMode_Even;
    }
    return self;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray* arr = [super layoutAttributesForElementsInRect:rect];
    
    // THIS CODE SEPARATES INTO ROWS
    NSMutableArray* rows = [NSMutableArray array];
    NSMutableArray* currentRow = nil;
    NSInteger currentIndex = 0;
    BOOL nextIsNewRow = YES;
    for (UICollectionViewLayoutAttributes* atts in arr) {
        if (nextIsNewRow) {
            nextIsNewRow = NO;
            if (currentRow) {
                [rows addObject:currentRow];
            }
            currentRow = [NSMutableArray array];
        }
        
        if (arr.count > currentIndex+1) {
            UICollectionViewLayoutAttributes* nextAtts = arr[currentIndex+1];
            if (nextAtts.frame.origin.y > atts.frame.origin.y) {
                nextIsNewRow = YES;
            }
        }
        
        [currentRow addObject:atts];
        currentIndex++;
    }
    
    if (self.layoutMode == FlowLayoutMode_Even) {
        for (NSMutableArray* thisRow in rows) {
            NSInteger rowWidth = [self getWidthOfRow:thisRow];
            CGFloat perItemWidthDifference = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - rowWidth) / thisRow.count;
            
            NSInteger currentXOffset = self.sectionInset.left;
            for (UICollectionViewLayoutAttributes* attrs in thisRow) {
                CGRect f = attrs.frame;
                f.origin.x = currentXOffset;
                f.size.width = f.size.width + perItemWidthDifference;
                attrs.frame = f;
                
                currentXOffset +=  attrs.frame.size.width + 2;
            }
        }
    } else if (self.layoutMode == FlowLayoutMode_Centered) {
        for (NSMutableArray* thisRow in rows) {
            NSInteger rowWidth = [self getWidthOfRow:thisRow];
            NSInteger margin = (self.collectionView.frame.size.width - rowWidth) / 2;
            NSInteger currentXOffset = margin;
            for (UICollectionViewLayoutAttributes* attrs in thisRow) {
                CGRect f = attrs.frame;
                f.origin.x = currentXOffset;
                attrs.frame = f;
                
                currentXOffset +=  attrs.frame.size.width + 2;
            }
        }
    }
    
    return arr;
}

#pragma mark - Helpers

- (NSInteger) getWidthOfRow:(NSMutableArray*) row {
    NSInteger widthTotal = 0;
    for (UICollectionViewLayoutAttributes* attrs in row) {
        widthTotal += attrs.frame.size.width;
    }
    
    widthTotal += (row.count - 1) * 2;
    
    return widthTotal;
}

@end
