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
    NSMutableArray *dealname;
    NSMutableArray *dealdesc;
    NSMutableArray *dealsdate;
    NSMutableArray *dealedate;
    
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
    
    
    
    NSString *urlFinal = @"http://ec2-54-86-125-98.compute-1.amazonaws.com:8000/seehotdeals";
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlFinal]];
    
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse *response = nil;
    
    NSData *responseData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString* responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"responseString%@",responseString);
    
    
    NSLog(@"ResponseCode:%d",[response statusCode]);
    
    
    dealname = [[NSMutableArray alloc] init];
    dealdesc = [[NSMutableArray alloc] init];
    dealsdate =[[NSMutableArray alloc] init];
    dealedate =[[NSMutableArray alloc] init];
    if ([response statusCode] == 200)
    {
        NSLog(@"!!!!!!!!!");
        NSLog(@"ButtonPressed");
        NSLog(@"%@",urlFinal);
        
        NSArray *array = [responseString componentsSeparatedByString:@","];
        NSLog(@"array:%@",array);
        
        NSString *dealnameS;
        NSString *dealdescS;
        NSString *dealsdateS;
        NSString *dealedateS;

        
        for(int i=0;i<[array count];i++){
            
            dealnameS =[array objectAtIndex:i];
            NSLog(@"dealnameS:%@",dealnameS);

            [dealname addObject:dealnameS];
            i++;
            
            dealdescS =[array objectAtIndex:i];
            [dealdesc addObject:dealdescS];
            i++;
            
            dealsdateS =[array objectAtIndex:i];
            [dealsdate addObject:dealsdateS];
            i++;
            
            dealedateS =[array objectAtIndex:i];
            [dealedate addObject:dealedateS];
        }
        
        NSLog(@"namearray:%@",dealname);
        NSLog(@"descarray:%@",dealdesc);
        NSLog(@"sdatearray:%@",dealsdate);
        NSLog(@"edatearray:%@",dealedate);
        
        
    }

    
    
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
