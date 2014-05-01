//
//  DealDetailViewController.m
//  DistributedD
//
//  Created by XZhai on 4/30/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import "DealDetailViewController.h"

@interface DealDetailViewController (){
    NSArray *nameArray;
    NSArray *descArray;
    NSArray *startdateArray;
    NSArray *enddateArray;
    NSNumber *selectedDeal;

}

@end

@implementation DealDetailViewController
@synthesize nameLabel;
@synthesize descLabel;
@synthesize sdateLabel;
@synthesize edateLabel;

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
    
    
    nameArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectdealname"];
    descArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectdealdesc"];
    startdateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectdealsdate"];
    enddateArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectdealedate"];
    selectedDeal = [[NSUserDefaults standardUserDefaults] objectForKey:@"selecteddeal"];
    
    NSLog(@"names:%@",nameArray);
    NSLog(@"desc:%@",descArray);
    NSLog(@"sdate:%@",startdateArray);
    NSLog(@"edate:%@",enddateArray);
    NSLog(@"%@",selectedDeal);
    
    NSInteger sdInteger = [selectedDeal integerValue];
    
    NSString *displayname = [[NSString alloc] initWithFormat:@"Name: %@", [nameArray objectAtIndex:sdInteger]];
    NSString *displaydesc = [[NSString alloc] initWithFormat:@"Description: %@", [descArray objectAtIndex:sdInteger]];
    NSString *displaysdate = [[NSString alloc] initWithFormat:@"Start Date: %@", [startdateArray objectAtIndex:sdInteger]];
    NSString *displayedate = [[NSString alloc] initWithFormat:@"End Date: %@", [enddateArray objectAtIndex:sdInteger]];
    
    
    [nameLabel setText:displayname];
    [descLabel setText:displaydesc];
    [sdateLabel setText:displaysdate];
    [edateLabel setText:displayedate];



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
