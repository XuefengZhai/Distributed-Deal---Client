//
//  DealDetailViewController.h
//  DistributedD
//
//  Created by XZhai on 4/30/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealDetailViewController : UIViewController{
    
     IBOutlet UILabel *nameLabel;
     IBOutlet UILabel *descLabel;
     IBOutlet UILabel *sdateLabel;
     IBOutlet UILabel *edateLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;
@property (nonatomic, retain) IBOutlet UILabel *sdateLabel;
@property (nonatomic, retain) IBOutlet UILabel *edateLabel;


@end
