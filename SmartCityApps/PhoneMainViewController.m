//
//  PhoneMainViewController.m
//  SmartCityApps
//
//  Created by Lee Ming Yeoh on 8/28/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import "PhoneMainViewController.h"

#import "LayoutSettings.h"
#import "CustomIssueTableViewCell.h"

#import "CoreConnection.h"

#import "SmartCityAppDelegate.h"

#import "CustomIssueTableViewCell.h"

#import "EmergencyObj.h"

#import "ConstantFunction.h"

#define kColorLightBlue [UIColor colorWithRed:95.0f/255.0f green:188.0f/255.0f blue:225.0f/255.0f alpha:1]

@interface PhoneMainViewController ()

@end

@implementation PhoneMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"Emergency Log"];

    
    [self.navigationController.navigationBar setBarTintColor:kColorLightBlue];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self setUpRefreshButton];
    
}

-(void)setUpRefreshButton
{
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(addButton:)];
    [addItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = addItem;
    

}

-(void)addButton:(id)sender
{
    [self LoadIssueData];
}

-(void)viewDidAppear:(BOOL)animated
{
    DLog(@"View Did APpear");
    [self LoadIssueData];
}

-(void)LoadIssueData
{
    
    if (!HUD) {
        HUD = [ConstantFunction initCustomHUD:self.view withDelegate:nil];
    }
    
    if (HUD) {
        [HUD show:YES];
    }
    
    [[SmartCityAppDelegate appDelegate].myCoreConnection getIssueListing:^(BOOL success, NSArray *array)
     {
         if (success)
         {
             
             DLog(@"Success or Fail : %d", success);
             DLog(@"Trace Jobs Object Json Data : %@", array);
             
             myDataRecords = [[NSMutableArray alloc]initWithArray:array];
             
             if (HUD)
             {
                 [HUD hide:YES];
             }
             
             [myTableView reloadData];
         }
         else
         {
             UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:@"Opps!" message:@"Try Again~" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil] ;
                                         
             [myAlertView show];
         }
         
     }];
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initializeViewController {
    
    
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]) self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view setBackgroundColor:kColorLightBlue];
    
}


-(void)setTitle:(NSString *)title
{
    self.navigationItem.titleView = [LayoutSettings customNavigationTitle:title upperCase:NO];
}



#pragma mark - tableview methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Count: %lu", (unsigned long)[myDataRecords count]);
    //    return [self.datarecords count];
    
    
    if (myDataRecords.count == 0)
    {
        [lblNoMsg setHidden:NO];
    }else{
        [lblNoMsg setHidden:YES];
    }
    
    return [myDataRecords count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *categoryTableIdentifier =@"CustomIssueTableViewCell";
    CustomIssueTableViewCell *cell = (CustomIssueTableViewCell*)[tableView dequeueReusableCellWithIdentifier:categoryTableIdentifier];
    
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomIssueTableViewCell" owner:self options:nil];
        
        cell = (CustomIssueTableViewCell *)[nib objectAtIndex:0];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    EmergencyObj *myEmergencyObj = [myDataRecords objectAtIndex:indexPath.row];
    
    NSString *myLocalStr = [NSString stringWithFormat:@"%@ %@", myEmergencyObj.myArea,myEmergencyObj.myLocation];
    
    [cell.myLocation setText:myLocalStr];
    
    
    if ([myEmergencyObj.myCategory isEqualToString:@"FloodWarning"])
    {
         [cell.myCautionType setText:@"Low Risk"];
         [cell.mylblAdvise setText:@"Low Risk, Unlikely to be flooded"];
    }
    else if ([myEmergencyObj.myCategory isEqualToString:@"FloodWarningTwo"])
    {
         [cell.myCautionType setText:@"Attention!"];
         [cell.mylblAdvise setText:@"Flood might occurs if the water level continue raise."];
    }
    else if ([myEmergencyObj.myCategory isEqualToString:@"FloodWarningThree"])
    {
         [cell.myCautionType setText:@"At Risk!"];
         [cell.mylblAdvise setText:@"Critical water level do take action now!"];
    }
    
    
    
    [UIView animateWithDuration:1.0
                          delay:0.0f
                        options:UIViewAnimationCurveEaseInOut | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                     animations:^{
                         
                         [cell.mylblAdvise setAlpha:0.0f];
                         
                         
                     }
                     completion:^(BOOL fin)
     {
         [cell.mylblAdvise setAlpha:1.0f];
         
     }];
    
    [UIView commitAnimations];
    
    [cell.myCautionType setText:myEmergencyObj.myCategory];
    
    
    if ([myEmergencyObj.myCategory isEqualToString:@"FireWarning"])
    {
        [cell.myIconImgVIew setImage:[UIImage imageNamed:@"fireWarning"]];
    
    }
    else
    {
        [cell.myIconImgVIew setImage:[UIImage imageNamed:@"floodwarning"]];
    }

    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did selected %d", indexPath.row);
    
}


@end
