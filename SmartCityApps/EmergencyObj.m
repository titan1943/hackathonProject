//
//  EmergencyObj.m
//  SmartCityApps
//
//  Created by Lee Ming Yeoh on 8/28/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import "EmergencyObj.h"
#import "NSDictionary+Utilities.h"

@implementation EmergencyObj



-(id)initWithDictionary:(NSDictionary*)dataDict
{
    if (dataDict)
    {
        self = [super init];
        
        self.myid = [dataDict objectForKeyIgnoreNull:@"id"];
        self.myCategory = [dataDict objectForKeyIgnoreNull:@"category"];
        self.myLocation = [dataDict objectForKeyIgnoreNull:@"location"];
        self.myArea = [dataDict objectForKeyIgnoreNull:@"area"];
        self.mySensorId = [dataDict objectForKeyIgnoreNull:@"sensor_id"];
        self.myTriggerDate = [dataDict objectForKeyIgnoreNull:@"trigger_date"];
    }
    
    return self;
}
@end
