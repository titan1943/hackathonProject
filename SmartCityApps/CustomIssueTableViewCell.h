//
//  CustomIssueTableViewCell.h
//  SmartCityApps
//
//  Created by Lee Ming Yeoh on 8/28/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomIssueTableViewCell : UITableViewCell

@property (nonatomic , strong) IBOutlet UIImageView *myIconImgVIew;
@property (nonatomic , strong) IBOutlet UILabel     *myArea;
@property (nonatomic , strong) IBOutlet UILabel     *myLocation;

@end
