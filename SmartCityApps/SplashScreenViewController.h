//
//  SplashScreenViewController.h
//  SmartCityApps
//
//  Created by Lee Ming Yeoh on 8/27/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ANIM_IMAGE_TOTAL 64
#define ANIM_TIME_INTERVAL 1.0f/80.0f


@interface SplashScreenViewController : UIViewController
{
    bool myRestartFlag;
    
    IBOutlet UIActivityIndicatorView *myLoadingIndicator;
    
    int currentFrame;
}

@property (strong, nonatomic) NSTimer *bgTimer;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isRestart:(bool)restartflag;



@end
