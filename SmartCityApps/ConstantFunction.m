//
//  ConstantFunction.m
//  SmartCityApps
//
//  Created by Lee Ming Yeoh on 8/28/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import "ConstantFunction.h"

@implementation ConstantFunction


#pragma mark - HUD

+(MBProgressHUD*)initCustomHUD:(UIView*)view withDelegate:(id<MBProgressHUDDelegate>)dg
{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    
    
    HUD.delegate = dg;
    
    [view addSubview:HUD];
    [HUD setAnimationType:MBProgressHUDAnimationFade];
    
    HUD.mode = MBProgressHUDModeIndeterminate;
    
    HUD.labelText = NSLocalizedString(@"Loading", @"loading textfor HUD");
    
    return HUD;
    
}


@end
