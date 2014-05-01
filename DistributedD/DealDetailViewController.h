//
//  DealDetailViewController.h
//  DistributedD
//
//  Created by XZhai on 4/30/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DS_DDDeal.h"

@interface DealDetailViewController : UIViewController{
    
     IBOutlet UILabel *nameLabel;
     IBOutlet UILabel *descLabel;
     IBOutlet UILabel *sdateLabel;
     IBOutlet UILabel *edateLabel;
     IBOutlet UILabel *typeLabel;
     IBOutlet UILabel *priceLabel;
     IBOutlet UILabel *anLabel;
     IBOutlet UIButton *Redeem;
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic, retain) IBOutlet UILabel *sdateLabel;
@property (nonatomic, retain) IBOutlet UILabel *edateLabel;
@property (nonatomic, retain) IBOutlet UILabel *typeLabel;
@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UILabel *anLabel;
@property (nonatomic, retain) IBOutlet UIButton *Redeem;


- (IBAction)redeem:(id)sender;


@end
