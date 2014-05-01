//
//  SubscriptionBizDetailViewController.h
//  DistributedD
//
//  Created by XZhai on 4/30/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
#import "AppDelegate.h"
#import "DS_DDBusiness.h"
#import "SubscriptionDetailViewController.h"


@interface SubscriptionBizDetailViewController : UIViewController<AsyncSocketDelegate>{
    AsyncSocket *socket;
    NSString *bizname;
    NSString *bizdesc;
    NSString *bizip;
     IBOutlet UILabel *nameLabel;
    
     IBOutlet UILabel *descLabel;
     IBOutlet UIButton *unsubscribe;
}
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic, retain) IBOutlet UIButton *unsubscribe;
@property (nonatomic, retain) NSString *bizname;
@property (nonatomic, retain) NSString *bizdesc;
@property (nonatomic, retain) NSString *bizip;

- (IBAction)unsubscribe:(id)sender;

@end
