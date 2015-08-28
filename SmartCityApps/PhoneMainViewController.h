//
//  PhoneMainViewController.h
//  SmartCityApps
//
//  Created by Lee Ming Yeoh on 8/28/15.
//  Copyright (c) 2015 Appster-Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface PhoneMainViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
    IBOutlet UITableView *myTableView;
    NSMutableArray *myDataRecords;
    IBOutlet UILabel *lblNoMsg;
}
@end
