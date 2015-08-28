//
//  EmergencyObj.h
//  SmartCityApps
//
//  Created by Lee Ming Yeoh on 8/28/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EmergencyObj : NSObject


@property (nonatomic , assign) int myid;
@property (nonatomic , strong) NSString * myCategory;
@property (nonatomic , strong) NSString * myLocation;
@property (nonatomic , strong) NSString * myArea;
@property (nonatomic , strong) NSString * mySensorId;
@property (nonatomic , strong) NSString * myTriggerDate;

-(id)initWithDictionary:(NSDictionary*)dataDict;

@end
