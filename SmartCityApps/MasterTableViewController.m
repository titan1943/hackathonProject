//
//  MasterTableViewController.m
//  SmartCityApps
//
//  Created by Titan Lai on 8/27/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import "MasterTableViewController.h"
#import "DetailViewController.h"
#import "Chart.h"

@interface MasterTableViewController ()

@property (strong, nonatomic) NSMutableArray *ChartArray;

@end

@implementation MasterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor blackColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 
    self.ChartArray = [[NSMutableArray alloc] init];
    
    Chart *chart1 = [[Chart alloc] init];
    chart1.chartName = @"Bar Chart";
    chart1.chartType = BarChart;
    
    [self.ChartArray addObject:chart1];
    
    Chart *chart2 = [[Chart alloc] init];
    chart2.chartName = @"Pie Chart";
    chart2.chartType = CircleChart;
    
    [self.ChartArray addObject:chart2];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Chart 1";
    
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"Chart 2";
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {


    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectChart" object:nil];
}


@end
