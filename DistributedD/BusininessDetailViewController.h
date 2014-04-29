//
//  BusininessDetailViewController.h
//  DistributedD
//
//  Created by XZhai on 4/25/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
#import "DS_DDBusiness.h"

@interface BusininessDetailViewController : UIViewController<AsyncSocketDelegate>{
    AsyncSocket *socket;
    AsyncSocket *socketServer;
    NSString *bizname;
    NSString *bizip;
    NSString *bizdesc;
    IBOutlet UILabel *nameLabel;
    
     IBOutlet UILabel *descLabel;
     IBOutlet UIButton *read;
    
     IBOutlet UIButton *send;
     IBOutlet UIButton *subscribe;
}
@property (nonatomic, retain) IBOutlet UIButton *read;
@property (nonatomic, retain) IBOutlet UIButton *send;
@property (nonatomic, retain) NSString *bizname;
@property (nonatomic, retain) NSString *bizip;
@property (nonatomic, retain) NSString *bizdesc;
@property (nonatomic, retain) IBOutlet UIButton *subscribe;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *descLabel;

-(void)startRead;
- (IBAction)read:(id)sender;
- (IBAction)send:(id)sender;
- (IBAction)subscribe:(id)sender;


@end

