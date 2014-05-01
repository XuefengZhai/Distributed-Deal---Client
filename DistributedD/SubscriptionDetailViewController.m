//
//  SubscriptionDetailViewController.m
//  DistributedD
//
//  Created by XZhai on 4/29/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import "SubscriptionDetailViewController.h"

@interface SubscriptionDetailViewController (){
    NSMutableArray *bizNameArray;
    NSMutableArray *bizDescArray;
    NSMutableArray *bizIpArray;

}

@end

@implementation SubscriptionDetailViewController
@synthesize tableView;

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
    
    bizNameArray = [[NSMutableArray alloc] init];
    bizDescArray =[[NSMutableArray alloc] init];
    bizIpArray =[[NSMutableArray alloc] init];
    
    
    NSManagedObjectContext *managedObjectContext = ((AppDelegate*)([[UIApplication sharedApplication] delegate])).managedObjectContext;
    
    // Get all the deals, and find the max id
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"DS_DDBusiness" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [managedObjectContext executeFetchRequest:request error:nil];
    
    for(DS_DDBusiness *biz in array){
        if([[biz subscribe]isEqualToString:@"1"]){
        [bizNameArray addObject:biz.name];
        [bizDescArray addObject:biz.desc];
        [bizIpArray addObject:biz.ip];
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [bizNameArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [bizNameArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [bizDescArray objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //[cell accessoryView ce]
    
    return cell;
}

//跳转！！！！！
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSLog(@"row:%i",row);
    
    
    
    NSString *selectedSubscribeBizName= [bizNameArray objectAtIndex:row];
    NSString *selectedSubscribeBizDesc = [bizDescArray objectAtIndex:row];
    NSString *selectedSubscribeBizIP =[bizIpArray objectAtIndex:row];
    
    
    [[NSUserDefaults standardUserDefaults] setValue:selectedSubscribeBizName forKey:@"selectedSubscribeBizName"];
    [[NSUserDefaults standardUserDefaults] setValue:selectedSubscribeBizDesc forKey:@"selectedSubscribeBizDesc"];
    [[NSUserDefaults standardUserDefaults] setValue:selectedSubscribeBizIP forKey:@"selectedSubscribeBizIP"];
    [self performSegueWithIdentifier:@"subscriptionBDetail" sender:self]; //Change the seque identifier
}

- (void)viewWillAppear:(BOOL)animated
{
	NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
	
	[[self tableView] reloadData];
	
	NSLog(@"<<< Leaving %s >>>", __PRETTY_FUNCTION__);
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
