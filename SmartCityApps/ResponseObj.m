//
//  ResponseObj.m
//  RedVelvet
//
//  Created by Lee Ming Yeoh on 8/15/15.
//  Copyright (c) 2015 YeohLeeMing. All rights reserved.
//

#import "ResponseObj.h"
#import "NSDictionary+Utilities.h"

#define kFlag @"flag"
#define kFlagMessage @"message"
#define kDataTag @"data"

@implementation ResponseObj


-(id)initWithDictonary:(NSDictionary*)dictData
{
    self = [super init];
    
    if (self) {
        
        id strFlag = [dictData objectForKeyIgnoreNull:kFlag];
        
        if ([strFlag boolValue] == true)
        {
            self.flag        = YES;
        }else
        {
             self.flag        = NO;
        }
        
        
        self.flagMessage = [dictData objectForKeyIgnoreNull:kFlagMessage];
        
        self.dataContainer = [dictData objectForKeyIgnoreNull:kDataTag];
        
    }
    
    
    return self;
}
@end
