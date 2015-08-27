//
//  AppDelegate.m
//  SmartCityApps
//
//  Created by Titan Lai on 8/27/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import "SmartCityAppDelegate.h"
#import "SplashScreenViewController.h"
#import "MainViewController.h"
#import "MasterTableViewController.h"
#import "DetailViewController.h"

#import "PhoneMainViewController.h"

@interface SmartCityAppDelegate ()

@end

@implementation SmartCityAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //LeeMing Dev
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.window makeKeyAndVisible];
    
    //Trace Font
         NSString *family, *font;
         NSString * resultFont;
         NSString * resultString;
         for (family in [UIFont familyNames])
         {
         resultString = [NSString stringWithFormat:@"\nFamily: %@\n", family];
         resultFont = AppendString(resultFont, resultString);
    
    
         for (font in [UIFont fontNamesForFamilyName:family])
         {
         resultString = [NSString stringWithFormat:@"Font: %@\n", font];
         resultFont = AppendString(resultFont, resultString);
         }
         }
         DLog(@"\n==========\n%@\n==========\n",resultFont);
    
    
    SplashScreenViewController *mySplash = [[SplashScreenViewController alloc]initWithNibName:@"SplashScreenViewController" bundle:nil isRestart:NO];
    [self.window setRootViewController:mySplash];


    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+(SmartCityAppDelegate*) appDelegate
{
    return (SmartCityAppDelegate*)[[UIApplication sharedApplication] delegate];
}

#pragma mark - self define methods
-(void)setAndLoadMainPage
{
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
        
        MasterTableViewController *masterVC = [[MasterTableViewController alloc] initWithNibName:@"MasterTableViewController" bundle:nil];
        
        UINavigationController *navMaster = [[UINavigationController alloc] initWithRootViewController:masterVC];
        
        DetailViewController *detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        
        UINavigationController *navDetail = [[UINavigationController alloc] initWithRootViewController:detailVC];
        
        
        UISplitViewController *splitVC = [[UISplitViewController alloc] init];
        
        splitVC.viewControllers = @[navMaster, navDetail];
        
        
        
        [self.window setRootViewController:splitVC];
        
        
        
    }else
    {
 
        PhoneMainViewController *myPhoneMain = [[PhoneMainViewController alloc]initWithNibName:@"PhoneMainViewController" bundle:nil];
        
         UINavigationController *myNavigationController = [[UINavigationController alloc]initWithRootViewController:myPhoneMain];
        
        [myNavigationController.view setBackgroundColor:[UIColor purpleColor]];
        
        
        
        [self.window setRootViewController:myNavigationController];
        

    }
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    if (IS_IPAD)
    {
        return UIInterfaceOrientationLandscapeRight;
    }
    else
    {
        return UIInterfaceOrientationPortrait;
    }
 
}

- (BOOL)shouldAutorotate
{
    return NO;
}
@end
