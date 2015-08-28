//
//  CustomDropShadowView.m
//  AirAsiaMobile
//
//  Created by LeeMing on 6/14/15.
//  Copyright (c) 2015 LeeMing. All rights reserved.
//

#import "CustomDropShadowView.h"
#import "LayoutSettings.h"

#define kColorGray_cccccc [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:204.0f/255.0f alpha:1]

@implementation CustomDropShadowView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        fromNib = NO;
        [self initDropShadow];
    }
    
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    fromNib = YES;
    
    [self initDropShadow];
    
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
}

-(void)initDropShadow
{
    self.clipsToBounds = NO;
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = UIScreen.mainScreen.scale;
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
    
    
    self.layer.shadowColor = kColorGray_cccccc.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.7;
    self.layer.shadowRadius = 3.0f;
    
    self.layer.borderColor = kColorGray_cccccc.CGColor;
    self.layer.borderWidth = 1.0f;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    if (fromNib) {
        self.layer.shadowPath = [[UIBezierPath bezierPathWithRect:self.bounds] CGPath];
    }
    
   
    
}
@end
