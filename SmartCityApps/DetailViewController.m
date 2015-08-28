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

#import "M2XClient.h"
#import "M2XClient+HTTP.h"

#import "Generic.h"
#import "MBProgressHUD.h"

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
@property (strong, nonatomic) IBOutlet UILabel *highestValueLabel;

//buttons
@property (strong, nonatomic) IBOutlet UIButton *followUpButton;
@property (strong, nonatomic) IBOutlet UIButton *setAlertLevel;

//data
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic) float highestValue;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
// Testing Data
//    self.arrayOfValues = [[NSMutableArray alloc] init];
//    
//    [self.arrayOfValues addObject:@(8)];
//    [self.arrayOfValues addObject:@(5)];
//    [self.arrayOfValues addObject:@(3)];
//    [self.arrayOfValues addObject:@(15)];
//    [self.arrayOfValues addObject:@(20)];
//    [self.arrayOfValues addObject:@(8)];
//
//    
//    self.arrayOfDates = [NSMutableArray new];
//    
//    [self.arrayOfDates addObject:@"Jan"];
//    [self.arrayOfDates addObject:@"Feb"];
//    [self.arrayOfDates addObject:@"Mar"];
//    [self.arrayOfDates addObject:@"Apr"];
//    [self.arrayOfDates addObject:@"Jun"];
//    [self.arrayOfDates addObject:@"Jul"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SelectChart:) name:@"SelectChart" object:nil];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = kColorLightBlue;
    
    self.detailView.hidden = YES;
    self.actionView.hidden = YES;
    
    
    
}

-(void)loadAndConfigureConnection
{
    if (!m2x) {
        m2x = [[M2XClient alloc] initWithApiKey:@"10a5dc53bd65a22ec65c943e77bdb77c"];
    }
    
//    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
//    [dict setObject:@"1da670e96c843088ab8abcb1094c799d" forKey:@"devices"];
//    [dict setObject:@"temperature" forKey:@"streams"];
//    [dict setObject:@"100" forKey:@"limit"];

    
    NSString *str = [NSString stringWithFormat:@"/devices/%@/streams/%@/values", @"1da670e96c843088ab8abcb1094c799d", @"temperature"];
    
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{

        [m2x getWithPath:str parameters:nil completionHandler:^(M2XResponse *response) {
            
            
            [self mapDictionaryToObject:response.json[@"values"]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myGraph reloadGraph];

                [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            });
        }];
    });

   
}

- (void)mapDictionaryToObject:(NSArray *)array{
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dict in array) {
        Generic *data = [[Generic alloc] init];
        
        data.value = dict[@"value"];
        data.timestamp =[self convertDate:dict[@"timestamp"]];

        
        [self.dataArray addObject:data];
        
    }
}

- (NSString *)convertDate:(NSString *)dateString {
    
    
    NSString *date = [dateString substringWithRange:NSMakeRange(5, 5)];
    
    
    
    return date;
}

- (NSString*)getQRCodeDateType:(NSString*)std
{
    NSDate *date = [self convertStringToDate:std];
    
    
    NSDateFormatter *dateNewFormat = [[NSDateFormatter alloc]init];
    [dateNewFormat setDateFormat:@"EEE, d LLLL yyyy"];
    
    NSString *newDateString = [dateNewFormat stringFromDate:date];
    
    return newDateString;
}

- (NSDate*)convertStringToDate:(NSString*)dateString
{
    if (!dateString||dateString.length<10) {
        return nil;
    }
    
    dateString = [dateString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    dateString = [dateString stringByReplacingOccurrencesOfString:@"Z" withString:@" "];

    //DLog(@"date before convert = %@",dateString);
    
    
    NSDateFormatter *dateFormatter = [self dateDefaultFormatter];
    
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+8"]];
    
    
    
    //[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * date = [[NSDate alloc] init];
    date = [dateFormatter dateFromString:dateString];
    
    //DLog(@"date converted = %@",date);
    return date;
    
}

- (NSDateFormatter*)dateDefaultFormatter
{
    /*static dispatch_once_t pred = 0;
     __strong static NSDateFormatter* formatter = nil;
     dispatch_once(&pred, ^{
     
     });*/
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_GB"]];
    
    
    return formatter;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - notification selector

- (void)SelectChart:(NSNotification *)notification {
    
    Chart *chart = notification.object;
    
    self.title = chart.chartTitle;
    
    [self loadAndConfigureConnection];

    [self createChart];
}

- (void)createChart {
    
    self.myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(35, 35, CGRectGetWidth(self.graphView.frame) - 75, CGRectGetHeight(self.graphView.frame) - 35)];
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
    
    self.detailView.hidden = NO;
    self.actionView.hidden = NO;
    
    self.graphView.backgroundColor = kColorLightBlue;
    self.detailView.backgroundColor = kColorLightBlue;
    self.actionView.backgroundColor = kColorLightBlue;
//    self.view.layer.borderColor = [UIColor blackColor].CGColor;
//    self.view.layer.borderWidth = 1;
    
    self.followUpButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.followUpButton.layer.borderWidth = 2;
    self.followUpButton.layer.cornerRadius = 5;
    self.followUpButton.clipsToBounds = YES;
    
    self.setAlertLevel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.setAlertLevel.layer.borderWidth = 2;
    self.setAlertLevel.layer.cornerRadius = 5;
    self.setAlertLevel.clipsToBounds = YES;
    
//    NSMutableArray *arr = [self.dataArray valueForKey:@"value"];
    
//    NSNumber *asd1 = [arr valueForKeyPath:@"max"];
//    NSNumber *asd2 = [arr valueForKeyPath:@"max.float"];
//    NSNumber *asd3 = [arr valueForKeyPath:@"max.doubleValue"];

    self.highestValueLabel.text = @"";
}


#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
//    return (int)[self.arrayOfValues count];
    return (int)[self.dataArray count];

}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
//    return [[self.arrayOfValues objectAtIndex:index] floatValue];
    
    Generic *data = [self.dataArray objectAtIndex:index];
    
    if (self.highestValue < [data.value floatValue]) {
        self.highestValue = [data.value floatValue];
    }
    
    return [data.value floatValue];

}


#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 1;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
//    NSString *label = [self.arrayOfDates objectAtIndex:index];
//    return [label stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
    
    NSString *label = ((Generic *)[self.dataArray objectAtIndex:index]).timestamp;
    return [label stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
//    self.currentValueLabel.text = [NSString stringWithFormat:@"%@", [self.arrayOfValues objectAtIndex:index]];
//    self.currentDateLabel.text = [NSString stringWithFormat:@"in %@", [self.arrayOfDates objectAtIndex:index]];
    
    self.currentValueLabel.text = [NSString stringWithFormat:@"%@", ((Generic *)[self.dataArray objectAtIndex:index]).value];
    self.currentDateLabel.text = [NSString stringWithFormat:@"in %@", ((Generic *)[self.dataArray objectAtIndex:index]).timestamp];

    
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.currentValueLabel.alpha = 0.0;
        self.currentDateLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.currentValueLabel.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
        self.currentDateLabel.text = [NSString stringWithFormat:@"between %@ and %@", ((Generic *)[self.dataArray firstObject]).timestamp, ((Generic *)[self.dataArray lastObject]).timestamp];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.currentValueLabel.alpha = 1.0;
            self.currentDateLabel.alpha = 1.0;
        } completion:nil];
    }];
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
//    self.currentValueLabel.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
//    self.currentDateLabel.text = [NSString stringWithFormat:@"between %@ and %@", [self.arrayOfDates firstObject], [self.arrayOfDates lastObject]];
    
        self.currentValueLabel.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
        self.currentDateLabel.text = [NSString stringWithFormat:@"between %@ and %@", ((Generic *)[self.dataArray firstObject]).timestamp, ((Generic *)[self.dataArray lastObject]).timestamp];

    self.highestValueLabel.text = [NSString stringWithFormat:@"%.f", self.highestValue];
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
