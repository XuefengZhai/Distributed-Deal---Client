//
//  SignUp.h
//  DistributedD
//
//  Created by XZhai on 4/5/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUp : UIViewController

{
    IBOutlet UITextField *email;
    IBOutlet UITextField *name;
    IBOutlet UITextField *age;
    IBOutlet UITextField *psw;
    IBOutlet UIButton *submmit;
    IBOutlet UISegmentedControl *gender;

}
@property (nonatomic,retain) IBOutlet UITextField *email;
@property (nonatomic,retain) IBOutlet UITextField *name;
@property (nonatomic,retain) IBOutlet UITextField *age;
@property (nonatomic,retain) IBOutlet UITextField *psw;
@property (nonatomic,retain) IBOutlet UIButton *submmit;
@property (nonatomic,retain) IBOutlet UISegmentedControl *gender;

- (IBAction)emailTextField_DidEndOnExit:(id)sender;
- (IBAction)nameTextField_DidEndOnExit:(id)sender;
- (IBAction)ageTextField_DidEndOnExit:(id)sender;
- (IBAction)pswTextField_DidEndOnExit:(id)sender;
- (IBAction)submmitButton:(id)sender;

@end
