//
//  DealViewController.m
//  DistributedD
//
//  Created by XZhai on 4/29/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import "DealViewController.h"

@interface DealViewController ()

@end

@implementation DealViewController
{
    NSMutableArray *dealname;
    NSMutableArray *dealdesc;
    NSMutableArray *dealsdate;
    NSMutableArray *dealedate;
    NSMutableArray *dealprice;
    NSMutableArray *dealna;
    NSMutableArray *dealtype;

}

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
    
    
    dealname= [[NSMutableArray alloc] init];
    dealdesc= [[NSMutableArray alloc] init];
    dealsdate= [[NSMutableArray alloc] init];
    dealedate= [[NSMutableArray alloc] init];
    dealprice= [[NSMutableArray alloc] init];
    dealna= [[NSMutableArray alloc] init];
    dealtype= [[NSMutableArray alloc] init];

    
    NSManagedObjectContext *managedObjectContext = ((AppDelegate*)([[UIApplication sharedApplication] delegate])).managedObjectContext;
    
    // Get all the deals, and find the max id
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"DS_DDDeal" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [managedObjectContext executeFetchRequest:request error:nil];
    
    for(DS_DDDeal *deal in array){
        [dealname addObject:deal.title];
        [dealtype addObject:deal.type];
        [dealprice addObject:deal.price];
        [dealsdate addObject:deal.start_date];
        [dealedate addObject:deal.end_date];
        [dealna addObject:deal.max_cust];
        [dealdesc addObject:deal.description];
    }
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dealname count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [dealname objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [dealdesc objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //[cell accessoryView ce]
    
    return cell;
}

//跳转！！！！！
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSLog(@"row:%i",row);
    
    [[NSUserDefaults standardUserDefaults] setValue:dealname forKey:@"selectdealname"];
    [[NSUserDefaults standardUserDefaults] setValue:dealdesc forKey:@"selectdealdesc"];
    [[NSUserDefaults standardUserDefaults] setValue:dealsdate forKey:@"selectdealsdate"];
    [[NSUserDefaults standardUserDefaults] setValue:dealedate forKey:@"selectdealedate"];
    
    [[NSUserDefaults standardUserDefaults] setValue:dealtype forKey:@"selecteddealtype"];
    [[NSUserDefaults standardUserDefaults] setValue:dealprice forKey:@"selecteddealprice"];
    [[NSUserDefaults standardUserDefaults] setValue:dealna forKey:@"selecteddealna"];
    
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:indexPath.row] forKey:@"selecteddeal"];
    [self performSegueWithIdentifier:@"dealdetail" sender:self]; //Change the seque identifier
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
