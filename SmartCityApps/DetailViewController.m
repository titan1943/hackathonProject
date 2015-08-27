//
//  DetailViewController.m
//  SmartCityApps
//
//  Created by Titan Lai on 8/27/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import "DetailViewController.h"
#import "Chart.h"
#import "BEMSimpleLineGraphView.h"

@interface DetailViewController () <BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource>

@property (strong, nonatomic) NSMutableArray *arrayOfValues;
@property (strong, nonatomic) NSMutableArray *arrayOfDates;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.arrayOfValues = [[NSMutableArray alloc] init];
    
    [self.arrayOfValues addObject:@(8)];
    [self.arrayOfValues addObject:@(5)];
    [self.arrayOfValues addObject:@(3)];
    [self.arrayOfValues addObject:@(15)];
    [self.arrayOfValues addObject:@(20)];
    [self.arrayOfValues addObject:@(8)];

    
    self.arrayOfDates = [NSMutableArray new];
    
    [self.arrayOfDates addObject:@"Jan"];
    [self.arrayOfDates addObject:@"Feb"];
    [self.arrayOfDates addObject:@"Mar"];
    [self.arrayOfDates addObject:@"Apr"];
    [self.arrayOfDates addObject:@"Jun"];
    [self.arrayOfDates addObject:@"Jul"];

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectChart:) name:@"SelectChart" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notification selector

- (void)SelectChart:(NSNotification *)notification {
//    NSLog(@"Chart selected!");
    
    Chart *chart = notification.object;
    
    self.title = chart.chartTitle;
    
    [self createChart];
}

- (void)createChart {
    
    BEMSimpleLineGraphView *myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 350)];
    myGraph.delegate = self;
    myGraph.dataSource = self;
    
    myGraph.enableBezierCurve = YES;
    
    [self.view addSubview:myGraph];
    
    

}


#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return (int)[self.arrayOfValues count];
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [[self.arrayOfValues objectAtIndex:index] floatValue];
}


#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 0;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    NSString *label = [self.arrayOfDates objectAtIndex:index];
    return [label stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
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
