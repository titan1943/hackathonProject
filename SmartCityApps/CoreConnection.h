//
//  CoreConnection.h
//  RedVelvet
//
//  Created by Lee Ming Yeoh on 8/13/15.
//  Copyright (c) 2015 YeohLeeMing. All rights reserved.
//

/* READ ME

This class is to centralized all connection related methods and allow developer easy for maintain
all complex related connection methods.

*/

//Main Class
#import <Foundation/Foundation.h>
#import "TalentHttpClient.h"

//Respond Indicator Object
#import "ResponseObj.h"

//Parsing Object
#import "JobObject.h"


typedef void (^GetJobsObjectCompletionHandler)(BOOL successFlag , NSArray*myJobArrys);

@interface CoreConnection : NSObject
{
    bool isFinishLoading;
}


@property (nonatomic , strong) TalentHttpClient *client;


-(void)getJobsListing:(GetJobsObjectCompletionHandler)handler;

@end
