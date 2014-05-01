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
    NSArray *typeArray;
    NSArray *priceArray;
    NSArray *naArray;
    NSNumber *selectedDeal;
    NSString *displayname;
}

@end

@implementation DealDetailViewController
@synthesize nameLabel;
@synthesize descLabel;
@synthesize sdateLabel;
@synthesize edateLabel;
@synthesize typeLabel;
@synthesize priceLabel;
@synthesize anLabel;

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
    typeArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"selecteddealtype"];
    priceArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"selecteddealprice"];
    naArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"selecteddealna"];

    
    
    NSLog(@"names:%@",nameArray);
    NSLog(@"desc:%@",descArray);
    NSLog(@"sdate:%@",startdateArray);
    NSLog(@"edate:%@",enddateArray);
    NSLog(@"%@",selectedDeal);
    
    NSInteger sdInteger = [selectedDeal integerValue];
    
     displayname = [[NSString alloc] initWithFormat:@"%@", [nameArray objectAtIndex:sdInteger]];
    NSString *displaydesc = [[NSString alloc] initWithFormat:@"%@", [descArray objectAtIndex:sdInteger]];
    NSString *displaysdate = [[NSString alloc] initWithFormat:@"%@", [startdateArray objectAtIndex:sdInteger]];
    NSString *displayedate = [[NSString alloc] initWithFormat:@"%@", [enddateArray objectAtIndex:sdInteger]];
    NSString *displayprice = [[NSString alloc] initWithFormat:@"%@", [priceArray objectAtIndex:sdInteger]];
    NSString *displayna = [[NSString alloc] initWithFormat:@"%@", [naArray objectAtIndex:sdInteger]];
    NSString *displaytype = [[NSString alloc] initWithFormat:@"%@", [typeArray objectAtIndex:sdInteger]];

    
    
    
    [nameLabel setText:displayname];
    [descLabel setText:displaydesc];
    [sdateLabel setText:displaysdate];
    [edateLabel setText:displayedate];
    [priceLabel setText:displayprice];
    [anLabel setText:displayna];
    [typeLabel setText:displaytype];



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

- (IBAction)redeem:(id)sender {
    
    
    NSManagedObjectContext *managedObjectContext = ((AppDelegate*)([[UIApplication sharedApplication] delegate])).managedObjectContext;
    
    // Get all the deals, and find the max id
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"DS_DDDeal" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [managedObjectContext executeFetchRequest:request error:nil];
    
    for(DS_DDDeal *deal in array){
        if([[deal title]isEqualToString:displayname]){
            [managedObjectContext deleteObject:deal];
            
            UIAlertView *wrongAlert = [[UIAlertView alloc] initWithTitle:@"Sucess" message:[NSString stringWithFormat:@"Deal Redeemed"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [wrongAlert show];
            
        }
    }

}
@end
