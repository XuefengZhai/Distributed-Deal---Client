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
    
    NSString *displayname;
    NSString *displaydesc;
    NSString *displaysdate;
    NSString *displaytype;
    NSString *displayprice;
    NSString *displayan;
    NSString *displayedate;
}


@end

@implementation BizDealInfoViewController

@synthesize nameLabel;
@synthesize descLabel;
@synthesize sDateLabel;
@synthesize eDateLabel;
@synthesize typeLable;
@synthesize priceLable;
@synthesize anLable;
@synthesize addDeal;

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
    
    displayname = [[NSString alloc] initWithFormat:@"%@", [nameArray objectAtIndex:sdInteger]];
    displaydesc = [[NSString alloc] initWithFormat:@"%@", [descArray objectAtIndex:sdInteger]];
    displaysdate = [[NSString alloc] initWithFormat:@"%@", [startdateArray objectAtIndex:sdInteger]];
    displayedate = [[NSString alloc] initWithFormat:@"%@", [enddateArray objectAtIndex:sdInteger]];
    
    displaytype = [[NSString alloc] initWithFormat:@"%@", [typeArray objectAtIndex:sdInteger]];
    displayprice = [[NSString alloc] initWithFormat:@"%@", [priceArray objectAtIndex:sdInteger]];
    displayan = [[NSString alloc] initWithFormat:@"%@", [maxArray objectAtIndex:sdInteger]];

    
    [nameLabel setText:displayname];
    [descLabel setText:displaydesc];
    [sDateLabel setText:displaysdate];
    [eDateLabel setText:displayedate];
    [typeLable setText:displaytype];
    [priceLable setText:displayprice];
    [anLable setText:displayan];
    
    
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

- (IBAction)addDeal:(id)sender {
    NSManagedObjectContext *managedObjectContext = ((AppDelegate*)([[UIApplication sharedApplication] delegate])).managedObjectContext;
    
    // Get all the deals, and find the max id
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"DS_DDDeal" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [managedObjectContext executeFetchRequest:request error:nil];
    
    int flag =0;
    for(DS_DDDeal *deal in array){
        if ([[deal title] isEqualToString:displayname]) {
            flag = 1;
            break;
        }
    }
    
    if(flag ==1){
        UIAlertView *wrongAlert = [[UIAlertView alloc] initWithTitle:@"Failed" message:[NSString stringWithFormat:@"Deal already added"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [wrongAlert show];
        
    }
    
    else{
        NSNumber *max_id = 0;
        for(DS_DDDeal *deal in array){
            if(max_id < deal.d_id){
                max_id = deal.d_id;
            }
        }
        
        NSLog(@"Deal retrieved");
        // Insert and populate new object
        DS_DDDeal *newDeal= [managedObjectContext insertNewObjectForEntityForName:@"DS_DDDeal"];
        
        [newDeal setD_id:[NSNumber numberWithInt:([max_id integerValue] + 1)]];
        [newDeal setTitle:displayname];
        [newDeal setType:displaytype];
        [newDeal setDesc:displaydesc];
        [newDeal setEnd_date:displayedate];
        [newDeal setStart_date:displaysdate];
        [newDeal setPrice:displayprice];
        [newDeal setMax_cust:displayan];
        
        
        NSError *executeError = nil;
        if(![managedObjectContext saveToPersistentStore:&executeError]) {
            NSLog(@"Failed to save to data store");
        }
        
        NSLog(@"New deal ad");
        
        UIAlertView *wrongAlert = [[UIAlertView alloc] initWithTitle:@"Sucess" message:[NSString stringWithFormat:@"Deal Added!"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [wrongAlert show];
        
        
    }

    
    
    
}
@end
