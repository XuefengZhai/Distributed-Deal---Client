//
//  HotDealsViewController.m
//  DistributedD
//
//  Created by XZhai on 4/30/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import "HotDealsViewController.h"

@interface HotDealsViewController ()

@end

@implementation HotDealsViewController{
    NSArray *dealname;
    NSArray *dealdesc;
    NSArray *dealsdate;
    NSArray *dealedate;
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
    
    
    dealname = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", nil];
    dealdesc =[NSArray arrayWithObjects:@"Hello", @"Bye", @"Ahha", @"Noo",nil];
    dealsdate = [NSArray arrayWithObjects:@"1-1", @"2-2", @"3-3", @"4-4",nil];
    dealedate =[NSArray arrayWithObjects:@"5-1", @"6-2", @"7-3", @"8-4",nil];
    
    [[NSUserDefaults standardUserDefaults] setValue:dealname forKey:@"selectdealname"];
    [[NSUserDefaults standardUserDefaults] setValue:dealdesc forKey:@"selectdealdesc"];
    [[NSUserDefaults standardUserDefaults] setValue:dealsdate forKey:@"selectdealsdate"];
    [[NSUserDefaults standardUserDefaults] setValue:dealedate forKey:@"selectdealedate"];

    
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
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:indexPath.row] forKey:@"selecteddeal"];
    [self performSegueWithIdentifier:@"hotdealdetail" sender:self]; //Change the seque identifier
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
