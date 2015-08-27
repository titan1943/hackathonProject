//
//  Chart.h
//  SmartCityApps
//
//  Created by Titan Lai on 8/27/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, ChartType) {
    BarChart,
    CircleChart,
    PieChart
};

@interface Chart : NSObject

@property (strong, nonatomic) NSString *chartName;
@property (nonatomic) ChartType chartType;

@end
