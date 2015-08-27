//
//  TalentHttpClient.h
//  RedVelvet
//
//  Created by Titan Lai on 7/25/15.
//  Copyright (c) 2015 YeohLeeMing. All rights reserved.
//

#import "AFHTTPSessionManager.h"


@protocol talentHTTPClientDelegate;

@interface TalentHttpClient : AFHTTPSessionManager

@property (nonatomic, weak) id<talentHTTPClientDelegate> delegate;

+ (TalentHttpClient*)sharedClient;
- (instancetype)initWithBaseURL:(NSURL *)url;

@end

@protocol redVelvetHTTPClientDelegate <NSObject>

@optional

- (void)redVelvetHTTPClientDelegate:(TalentHttpClient *)client didUpdateData:(id)data;
- (void)redVelvetHTTPClientDelegate:(TalentHttpClient *)client didFailWithError:(NSError *)error;

@end

