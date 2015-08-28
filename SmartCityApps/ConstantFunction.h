//
//  ConstantFunction.h
//  SmartCityApps
//
//  Created by Lee Ming Yeoh on 8/28/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MBProgressHUD.h"

@interface ConstantFunction : NSObject

+(MBProgressHUD*)initCustomHUD:(UIView*)view withDelegate:(id<MBProgressHUDDelegate>)dg;


@end
