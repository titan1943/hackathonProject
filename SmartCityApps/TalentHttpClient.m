//
//  TalentHttpClient.m
//  RedVelvet
//
//  Created by Titan Lai on 7/25/15.
//  Copyright (c) 2015 YeohLeeMing. All rights reserved.
//

#import "TalentHttpClient.h"

//static NSString * const talentBaseAPI = @"http://leeming.dlinkddns.com/api/"; //base URL
static NSString * const talentBaseAPI = @"http://yul.enfonius.com/api/"; //base URL


@implementation TalentHttpClient

+ (TalentHttpClient *)sharedClient {
    
    static TalentHttpClient *sharedHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:talentBaseAPI]];
    });
    
    return sharedHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [self.requestSerializer clearAuthorizationHeader];
//        [self.requestSerializer setAuthorizationHeaderFieldWithUsername:@"admin" password:@"1234"];
    }
    
    return self;
}



@end
