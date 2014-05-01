//
//  SubscriptionDetailViewController.h
//  DistributedD
//
//  Created by XZhai on 4/29/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DS_DDBusiness.h"

@interface SubscriptionDetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    
     IBOutlet UITableView *tableView;
}
@property (nonatomic,strong)UITableView *tableView;

@end
