//
//  LayoutSettings.h
//  SmartCityApps
//
//  Created by Lee Ming Yeoh on 8/28/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LayoutSettings : NSObject

+(UIView *)customNavigationTitle:(NSString*)title upperCase:(bool)flag;
+(UILabel *)customNavigationLabel:(NSString*)title upperCase:(bool)flag;
@end
