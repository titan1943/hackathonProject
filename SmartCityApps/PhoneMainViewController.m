//
//  PhoneMainViewController.m
//  SmartCityApps
//
//  Created by Lee Ming Yeoh on 8/28/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import "PhoneMainViewController.h"

#import "LayoutSettings.h"

@interface PhoneMainViewController ()

@end

@implementation PhoneMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Emergency Log"];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor purpleColor]];
    [self.navigationController.navigationBar setTranslucent:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeViewController {
    
    
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]) self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view setBackgroundColor:[UIColor purpleColor]];
    
}


-(void)setTitle:(NSString *)title
{
    self.navigationItem.titleView = [LayoutSettings customNavigationTitle:title upperCase:NO];
}

@end
