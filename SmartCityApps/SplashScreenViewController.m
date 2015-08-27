//
//  SplashScreenViewController.m
//  SmartCityApps
//
//  Created by Lee Ming Yeoh on 8/27/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "SmartCityAppDelegate.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isRestart:(bool)restartflag
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        
        myRestartFlag = restartflag;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [myLoadingIndicator startAnimating];
    
    
    //Update Timer
    self.bgTimer = [NSTimer scheduledTimerWithTimeInterval:ANIM_TIME_INTERVAL target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    
}

-(void)updateTimer
{
    currentFrame ++;
    if (currentFrame > ANIM_IMAGE_TOTAL)
    {
        currentFrame = 0;
        DLog(@"Splash Screen Finished");
        [self.bgTimer invalidate];
        self.bgTimer = nil;
        [self performSelector:@selector(finishSplash) withObject:nil afterDelay:1];
    }
}

- (void)finishSplash
{
    [[SmartCityAppDelegate appDelegate] setAndLoadMainPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
