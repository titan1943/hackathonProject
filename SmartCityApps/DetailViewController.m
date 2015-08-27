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

#define kColorLightBlue [UIColor colorWithRed:95.0f/255.0f green:188.0f/255.0f blue:225.0f/255.0f alpha:1]

@interface DetailViewController () <BEMSimpleLineGraphDelegate, BEMSimpleLineGraphDataSource>

@property (strong, nonatomic) BEMSimpleLineGraphView *myGraph;
@property (strong, nonatomic) NSMutableArray *arrayOfValues;
@property (strong, nonatomic) NSMutableArray *arrayOfDates;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIView *actionView;
@property (strong, nonatomic) IBOutlet UIView *graphView;

//labels
@property (strong, nonatomic) IBOutlet UILabel *currentValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *averageLabel;

//buttons
@property (strong, nonatomic) IBOutlet UIButton *followUpButton;
@property (strong, nonatomic) IBOutlet UIButton *setAlertLevel;


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
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = kColorLightBlue;
    
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
    
    self.myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.graphView.frame) - 20, CGRectGetHeight(self.graphView.frame))];
    self.myGraph.delegate = self;
    self.myGraph.dataSource = self;
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    
    self.myGraph.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    
    self.myGraph.widthLine = 3.0;
    self.myGraph.enableTouchReport = YES;
    self.myGraph.enablePopUpReport = YES;
    self.myGraph.enableBezierCurve = YES;
    self.myGraph.enableYAxisLabel = YES;
    self.myGraph.autoScaleYAxis = YES;
    self.myGraph.alwaysDisplayDots = NO;
    self.myGraph.enableReferenceXAxisLines = YES;
    self.myGraph.enableReferenceYAxisLines = YES;
    self.myGraph.enableReferenceAxisFrame = YES;
    self.myGraph.animationGraphStyle = BEMLineAnimationDraw;

    
    self.myGraph.colorBackgroundXaxis = kColorLightBlue;
    self.myGraph.colorBackgroundYaxis = kColorLightBlue;
    self.myGraph.colorTop = kColorLightBlue;
    self.myGraph.colorBottom = kColorLightBlue;
    self.view.tintColor = kColorLightBlue;
    self.myGraph.backgroundColor = kColorLightBlue;

    
    [self.view addSubview:self.myGraph];
    
    self.graphView.backgroundColor = kColorLightBlue;
    self.detailView.backgroundColor = kColorLightBlue;
    self.actionView.backgroundColor = kColorLightBlue;
//    self.view.layer.borderColor = [UIColor blackColor].CGColor;
//    self.view.layer.borderWidth = 1;
    
    
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

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    self.currentValueLabel.text = [NSString stringWithFormat:@"%@", [self.arrayOfValues objectAtIndex:index]];
    self.currentDateLabel.text = [NSString stringWithFormat:@"in %@", [self.arrayOfDates objectAtIndex:index]];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.currentValueLabel.alpha = 0.0;
        self.currentDateLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.currentValueLabel.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
        self.currentDateLabel.text = [NSString stringWithFormat:@"between %@ and %@", [self.arrayOfDates firstObject], [self.arrayOfDates lastObject]];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.currentValueLabel.alpha = 1.0;
            self.currentDateLabel.alpha = 1.0;
        } completion:nil];
    }];
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
    self.currentValueLabel.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
    self.currentDateLabel.text = [NSString stringWithFormat:@"between %@ and %@", [self.arrayOfDates firstObject], [self.arrayOfDates lastObject]];
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
