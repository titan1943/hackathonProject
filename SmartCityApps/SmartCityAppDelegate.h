//
//  AppDelegate.h
//  SmartCityApps
//
//  Created by Titan Lai on 8/27/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreConnection.h"

@interface SmartCityAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(void)setAndLoadMainPage;
+(SmartCityAppDelegate*) appDelegate;

@property (nonatomic , strong) CoreConnection *myCoreConnection;

 

@end

