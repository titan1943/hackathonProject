//
//  CoreConnection.m
//  RedVelvet
//
//  Created by Lee Ming Yeoh on 8/13/15.
//  Copyright (c) 2015 YeohLeeMing. All rights reserved.
//
/*
 ********* Something to take note AFHTTPRequestOperationManager VS AFHTTPSessionManager ******
 
 AFHTTPRequestOperationManager uses NSOperation's under the hood, and it uses the older 
 NSURLConnection API from Apple. It works on iOS 6 and onwards. AFURLSessionManager makes use of 
 the newer NSURLSession API, which is only available on iOS 7. I would recommend that you use 
 AFURLSessionManager unless you need anything that you can only do with 
 AFHTTPRequestOperationManager such as using operations or iOS 6 support.
 
 ************************************************************************************************
 AFHTTPSessionManager           - Support iOS 7 and Above - Using Newer version of NSURLSession
 AFHTTPRequestOperationManager  - Support iOS 6 and Above  - Using Older version of NSURLSession
https://github.com/AFNetworking/AFNetworking/issues/1659
 */


#import "CoreConnection.h"
#import <AFHTTPRequestOperationManager.h>


#define kConnectionJobs @"jobs"

@implementation CoreConnection

#pragma mark - Initialization

-(id)init
{
    
    if (self = [super init]) {
        
        isFinishLoading = NO;
        
        [self configureAFnetworkingConnection];
        
    }
    
    return self;
}

-(void)configureAFnetworkingConnection
{
    _client = [TalentHttpClient sharedClient];
    
}

-(void)getJobsListing:(GetJobsObjectCompletionHandler)handler
{
    
    [_client GET:kConnectionJobs parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         
         DLog(@"Print Jobs Data: %@", responseObject);
         
         
         ResponseObj *myRespond = [[ResponseObj alloc]initWithDictonary:responseObject];
         
         DLog(@"Trace Return Status: %hhd", myRespond.flag);
         DLog(@"Trace Return Status: %@", myRespond.flagMessage);
         
         
         if (myRespond.flag == YES)
         {
             NSMutableArray *mutableDataArrays = [NSMutableArray new];
             
             for (NSDictionary *objectDict in myRespond.dataContainer) {
                 JobObject *myJobs = [[JobObject alloc]initWithDataDictionary:objectDict];
                 [mutableDataArrays addObject:myJobs];
             }
             
             NSArray *returnDataArray = [[NSArray alloc]initWithArray:mutableDataArrays];
             
             
             handler(YES, returnDataArray);
             
         }
         else
         {
              handler(NO, Nil);
         }
         
         
         
    
      
         
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error){
         DLog(@"Print Jobs Data: %@", error);
         
         
         
         
         
        }];

}
@end
