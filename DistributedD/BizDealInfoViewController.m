//
//  BizDealInfoViewController.m
//  DistributedD
//
//  Created by XZhai on 4/29/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import "BizDealInfoViewController.h"

@interface BizDealInfoViewController ()

@end

@interface BizDealInfoViewController (){
    NSArray *nameArray;
    NSArray *descArray;
    NSArray *startdateArray;
    NSArray *enddateArray;
    NSArray *typeArray;
    NSArray *priceArray;
    NSArray *maxArray;
    NSArray *idArray;
    NSNumber *selectedDeal;
    
}


@end

@implementation BizDealInfoViewController

@synthesize nameLabel;
@synthesize descLabel;
@synthesize sDateLabel;
@synthesize eDateLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Helllllo!!!!!!");
    
    nameArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"alldealnames"];
    descArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"alldealdesc"];
    startdateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"alldealstartdate"];
    enddateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"alldealenddate"];
    idArray =[[NSUserDefaults standardUserDefaults] objectForKey:@"alldealid"];
    
    priceArray =[[NSUserDefaults standardUserDefaults] objectForKey:@"alldealprice"];
    maxArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"alldealmax"];
    typeArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"alldealtype"];
    
    selectedDeal = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedalldeals"];
    
    
    NSInteger sdInteger = [selectedDeal integerValue];
    
    NSString *displayname = [[NSString alloc] initWithFormat:@"Name: %@", [nameArray objectAtIndex:sdInteger]];
    NSString *displaydesc = [[NSString alloc] initWithFormat:@"Description: %@", [descArray objectAtIndex:sdInteger]];
    NSString *displaysdate = [[NSString alloc] initWithFormat:@"Start Date: %@", [startdateArray objectAtIndex:sdInteger]];
    NSString *displayedate = [[NSString alloc] initWithFormat:@"End Date: %@", [enddateArray objectAtIndex:sdInteger]];

    
    [nameLabel setText:displayname];
    [descLabel setText:displaydesc];
    [sDateLabel setText:displaysdate];
    [eDateLabel setText:displayedate];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
