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
    chart1.chartTitle = @"Water Sensor Chart";
    chart1.chartType = WaterChart;
    
    [self.ChartArray addObject:chart1];
    
    Chart *chart2 = [[Chart alloc] init];
    chart2.chartTitle = @"Fire Sensor Chart";
    chart2.chartType = FireChart;
    
    [self.ChartArray addObject:chart2];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:170.0f/255.0f green:220.0f/255.0f blue:240.0f/255.0f alpha:1];
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.455 green:0.259 blue:0.784 alpha:1.0];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

}

- (void)viewDidAppear:(BOOL)animated {
    
    self.title = @"Type Of Chart";

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
    
    Chart *chart = self.ChartArray[indexPath.row];
    
    cell.textLabel.text = chart.chartTitle;

    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Chart *chart = self.ChartArray[indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectChart" object:chart];
}


@end
