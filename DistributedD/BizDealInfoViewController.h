//
//  BizDealInfoViewController.h
//  DistributedD
//
//  Created by XZhai on 4/29/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BizDealInfoViewController : UIViewController{
    
     IBOutlet UILabel *nameLabel;
     IBOutlet UILabel *descLabel;
     IBOutlet UILabel *sDateLabel;
     IBOutlet UILabel *eDateLabel;
     IBOutlet UILabel *typeLable;
     IBOutlet UILabel *priceLable;
     IBOutlet UILabel *anLable;
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic, retain) IBOutlet UILabel *sDateLabel;
@property (nonatomic, retain) IBOutlet UILabel *eDateLabel;
@property (nonatomic, retain) IBOutlet UILabel *typeLable;
@property (nonatomic, retain) IBOutlet UILabel *priceLable;
@property (nonatomic, retain) IBOutlet UILabel *anLable;
- (IBAction)addDeal:(id)sender;





@end
