//
//  NSDictionary+NSDictionary.m
//  SmartCityApps
//
//  Created by Lee Ming Yeoh on 8/28/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import "NSDictionary+Utilities.h"

@implementation NSDictionary (Utilities)

-(id)objectForKeyIgnoreNull:(NSString*)key
{
    
    
    id result = [self objectForKey:key];
    
    if ([result isKindOfClass:[NSNull class]] ) {
        return nil;
    }
    
    return result;
}

@end
