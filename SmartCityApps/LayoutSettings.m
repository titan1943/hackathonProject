//
//  LayoutSettings.m
//  SmartCityApps
//
//  Created by Lee Ming Yeoh on 8/28/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import "LayoutSettings.h"

#define kFontGothamRoundedMedium @"GothamRounded-Medium"
#define kNavigationTitleTopMargin 0

@implementation LayoutSettings

+(UIView *)customNavigationTitle:(NSString*)title upperCase:(bool)flag
{
    UILabel * label = [LayoutSettings customNavigationLabel:title upperCase:flag];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, label.frame.origin.x+label.frame.size.width, label.frame.size.height)];
    [view setBackgroundColor:[UIColor purpleColor]];
    [view addSubview:label];
    
    return view;
}


+(UILabel *)customNavigationLabel:(NSString*)title upperCase:(bool)flag
{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1000, 0)];
    [label setTextColor:[UIColor whiteColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:kFontGothamRoundedMedium size:18.0f]];
    [label setAdjustsFontSizeToFitWidth:YES];
    //[label setMinimumFontSize:9];
    label.numberOfLines = 1;
    if (flag) {
        [label setText: [title uppercaseString]] ;
    }
    else
        [label setText:title];
    [label sizeToFit];
    CGRect labelFrame = label.frame;
    DLog(@"header width = %f",labelFrame.size.width);
    labelFrame.origin.y += kNavigationTitleTopMargin;
    //labelFrame.size.height += 8;
    [label setFrame:labelFrame];
    return label;
}

@end
