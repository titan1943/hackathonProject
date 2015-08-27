//
//  ResponseObj.h
//  RedVelvet
//
//  Created by Lee Ming Yeoh on 8/15/15.
//  Copyright (c) 2015 YeohLeeMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseObj : NSObject

@property (nonatomic , strong) NSString *flagMessage;

@property (nonatomic , assign) BOOL flag;

@property (nonatomic , assign) id dataContainer;

-(id)initWithDictonary:(NSDictionary*)dictData;

@end
