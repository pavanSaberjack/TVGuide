//
//  ShowCollectionCell.m
//  TVGuideDemo
//
//  Created by pavan on 1/24/14.
//  Copyright (c) 2014 pavan_saberjack. All rights reserved.
//

#import "ShowCollectionCell.h"

const CGFloat version;

#define IOS_VERSION [[UIDevice currentDevice].systemVersion floatValue]

@interface ShowCollectionCell()
@property (nonatomic, readwrite) CGFloat textWidth;
@end

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

#pragma mark - Public methods
- (void)configureWithData:(id)data
{
    [self.showLabel setText:@"asdfsadfadsf"];
    [self updateTheLabelWidth];
}

- (void)updateTheContentsForRect:(CGRect)parentVisibleRect
{
    CGRect frame = CGRectIntersection(self.frame, parentVisibleRect);
    
    NSLog(@"Parent rect:  %@", [NSValue valueWithCGRect:frame]);
    
    if (!CGRectEqualToRect(frame, CGRectNull))
    {
        // get the exact origin for label
        CGFloat minWidth = [self getMinimumWidthOfText];
        
        if (frame.size.width > minWidth) {
            CGFloat x = frame.origin.x - self.frame.origin.x;
            CGRect newFrame = frame;
            newFrame.origin.x = x;
            
            [self.showLabel setFrame:newFrame];
        }
        else
        {
            
        }
    }
}

#pragma mark - Private methods
- (void)updateTheLabelWidth
{
    if (IOS_VERSION < 7.0) {
        NSString *str = self.showLabel.text;
        CGSize labelStr = [str sizeWithFont:self.showLabel.font constrainedToSize:self.showLabel.frame.size lineBreakMode:NSLineBreakByCharWrapping];
        
        self.textWidth = labelStr.width;
        
//        [self.showLabel setFrame:CGRectMake(self.showLabel.frame.origin.x,
//                                            self.showLabel.frame.origin.y,
//                                            labelStr.width,
//                                            self.showLabel.frame.size.height)];
    }
    else
    {
        NSString *str = self.showLabel.text == nil ? @"": self.showLabel.text;
        UIFont *font = self.showLabel.font;
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              font, NSFontAttributeName,
                                              nil];
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str attributes:attributesDictionary];
        CGRect rect = [string boundingRectWithSize:self.showLabel.frame.size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil];
        
        self.textWidth = rect.size.width;
        
//        [self.showLabel setFrame:CGRectMake(self.showLabel.frame.origin.x,
//                                            self.showLabel.frame.origin.y,
//                                            rect.size.width,
//                                            self.showLabel.frame.size.height)];
    }
}

- (CGFloat)getMinimumWidthOfText
{
    return self.textWidth;
}

#pragma mark - UI creation methods
- (void)addShowLabel
{
    [self addSubview:({
        UILabel *showLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [showLabel setText:@""];
        self.showLabel = showLabel;
        showLabel;
    })];
    
}

@end
