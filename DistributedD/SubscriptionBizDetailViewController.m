//
//  SubscriptionBizDetailViewController.m
//  DistributedD
//
//  Created by XZhai on 4/30/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import "SubscriptionBizDetailViewController.h"

@interface SubscriptionBizDetailViewController ()



@end

@implementation SubscriptionBizDetailViewController

@synthesize nameLabel;
@synthesize descLabel;
@synthesize bizname;
@synthesize bizdesc;
@synthesize bizip;
@synthesize unsubscribe;


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
    bizname = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedSubscribeBizName"];
    bizdesc = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedSubscribeBizDesc"];
    bizip = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedSubscribeBizIP"];
    
    [nameLabel setText:bizname];
    [descLabel setText:bizdesc];
    
    NSLog(@"IP: %@",bizip);
    
    NSLog(@"Starting...");
	socket = [[AsyncSocket alloc] initWithDelegate:self];
    
    
    //delete later!!!!!!
    bizip = @"128.237.216.25";
    NSError *error = nil;
	if (![socket connectToHost:bizip onPort:8001 error:&error])
	{
		NSLog(@"Unable to connect to due to invalid configuration: %@", error);
	}
	else
	{
		NSLog(@"Connecting...");
	}

    
    // Do any additional setup after loading the view.
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

- (IBAction)unsubscribe:(id)sender {
    
    NSLog(@"The bizname is:%@",bizname);
    NSLog(@"The bizdesc is:%@",bizdesc);
    NSLog(@"The bizip is:%@",bizip);
    
    NSString* userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSLog(@"The userName is:%@",userName);
    
    NSString* userAge = [[NSUserDefaults standardUserDefaults] objectForKey:@"userAge"];
    NSLog(@"The userAge is:%@",userAge);
    
    NSString* userGender = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGender"];
    NSLog(@"The userGender is:%@",userGender);
    
    NSString* userEmail = [[NSUserDefaults standardUserDefaults] objectForKey:@"userEmail"];
    NSLog(@"The userEmail is:%@",userEmail);

    NSLog(@"Button is working...");
    NSString *requestStr = [NSString stringWithFormat:@"unsubscribe,%@",
                            userEmail];
    NSLog(@"sbscribeString:::%@",requestStr);
    NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
    [socket writeData:requestData withTimeout:-1.0 tag:0];
    NSLog(@"Sent...");
    if (socket.isConnected) {
        NSLog(@"==============");
    }
    
    
    NSManagedObjectContext *managedObjectContext = ((AppDelegate*)([[UIApplication sharedApplication] delegate])).managedObjectContext;
    
    // Get all the deals, and find the max id
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"DS_DDBusiness" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [managedObjectContext executeFetchRequest:request error:nil];
    
    for(DS_DDBusiness *biz in array){
        if([[biz name]isEqualToString:bizname] && [[biz subscribe]isEqualToString:@"1"]){
            [managedObjectContext deleteObject:biz];
            
            UIAlertView *wrongAlert = [[UIAlertView alloc] initWithTitle:@"Sucess" message:[NSString stringWithFormat:@"Business unsubscribed"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [wrongAlert show];

        }
    }

    [self startRead];

    
    
}

-(void)startRead {
	//[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startRead) userInfo:nil repeats:YES];
	[socket readDataWithTimeout:-1 tag:0];
}


- (void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
	NSLog(@"socket:didConnectToHost:%@ port:%hu", host, port);
    
    
    
    
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
	NSLog(@"socket:didWriteDataWithTag:");
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
	NSLog(@"socket:didReadData:withTag:");
	
	NSString *response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    //    NSArray *array = [response componentsSeparatedByString:@", "];
    //    NSLog(@"array:%@",array);
    NSLog(@"Respose::%@",response);
    
    if ([response isEqualToString:@"OK"]) {
        UIAlertView *wrongAlert = [[UIAlertView alloc] initWithTitle:@"Success" message:[NSString stringWithFormat:@"Businiss Unsubscribed"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [wrongAlert show];
        
    }


    
}

- (void)socketDidDisconnect:(AsyncSocket *)sock withError:(NSError *)err
{
	NSLog(@"socketDidDisconnect:withError: \"%@\"", err);
}



@end
