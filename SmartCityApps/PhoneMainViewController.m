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

-(void)viewDidAppear:(BOOL)animated
{
    DLog(@"View Did APpear");
    [self LoadIssueData];
}

-(void)LoadIssueData
{
    
    [[SmartCityAppDelegate appDelegate].myCoreConnection getIssueListing:^(BOOL success, NSArray *array)
     {
         if (success)
         {
             
             DLog(@"Success or Fail : %d", success);
             DLog(@"Trace Jobs Object Json Data : %@", array);
             
             myDataRecords = [[NSMutableArray alloc]initWithArray:array];
             
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
    
    [self.view setBackgroundColor:[UIColor purpleColor]];
    
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
    
    NSString *myLocalStr = [NSString stringWithFormat:@"%@ %@", myEmergencyObj.myLocation, myEmergencyObj.myArea];
    
    [cell.myLocation setText:myLocalStr];

    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"did selected %d", indexPath.row);
    
    }


@end
