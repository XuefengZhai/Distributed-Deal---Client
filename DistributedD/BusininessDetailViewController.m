//  BusininessDetailViewController.m
//  DistributedD
//
//  Created by XZhai on 4/25/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import "BusininessDetailViewController.h"
#import "AsyncSocket.h"

@interface BusininessDetailViewController (){
}

@end

@implementation BusininessDetailViewController

@synthesize read;
@synthesize send;
@synthesize bizip;
@synthesize bizname;
@synthesize bizdesc;
@synthesize nameLabel;
@synthesize descLabel;
@synthesize subscribe;
@synthesize deal;


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
    bizname = [[NSUserDefaults standardUserDefaults] objectForKey:@"biztitle"];
    NSLog(@"The Biz Title is:%@",bizname);
    
    bizip = [[NSUserDefaults standardUserDefaults] objectForKey:@"bizip"];
    NSLog(@"The Biz IP is:%@",bizip);

    bizdesc = [[NSUserDefaults standardUserDefaults] objectForKey:@"bizdesc"];
    NSLog(@"The Biz Desc is:%@",bizdesc);
    
    [nameLabel setText:bizname];
    [descLabel setText:bizdesc];

    
    
    //128.237.213.52
    //127.0.0.1
    
    //delete later!!!! just to set ip!!!!
    bizip=@"128.237.216.25";
    
    
    NSLog(@"Starting...");
	socket = [[AsyncSocket alloc] initWithDelegate:self];
    
    
    NSError *error = nil;
	if (![socket connectToHost:bizip onPort:8001 error:&error])
	{
		NSLog(@"Unable to connect to due to invalid configuration: %@", error);
	}
	else
	{
		NSLog(@"Connecting...");
	}

}

- (IBAction)read:(id)sender {
    [self startRead];
}

- (IBAction)send:(id)sender {
    NSLog(@"Button is working...");
    NSString *requestStr = @"teststring!!!!!!!";
    NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
    [socket writeData:requestData withTimeout:-1.0 tag:0];
    NSLog(@"Sent...");
    if (socket.isConnected) {
        NSLog(@"==============");
    }
    
    [self startRead];

}

- (IBAction)subscribe:(id)sender {
    
    NSString* userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSLog(@"The userName is:%@",userName);
    
    NSString* userAge = [[NSUserDefaults standardUserDefaults] objectForKey:@"userAge"];
    NSLog(@"The userAge is:%@",userAge);
    
    NSString* userGender = [[NSUserDefaults standardUserDefaults] objectForKey:@"userGender"];
    NSLog(@"The userGender is:%@",userGender);
    
    NSString* userEmail = [[NSUserDefaults standardUserDefaults] objectForKey:@"userEmail"];
    NSLog(@"The userEmail is:%@",userEmail);


    NSLog(@"Button is working...");
    NSString *requestStr = [NSString stringWithFormat:@"subscribe,%@,%@,1,%@,%@,1",
                            userAge, userEmail, userGender, userName];
    NSLog(@"sbscribeString:::%@",requestStr);
    NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
    [socket writeData:requestData withTimeout:-1.0 tag:0];
    NSLog(@"Sent...");
    if (socket.isConnected) {
        NSLog(@"==============");
    }
    
    [self startRead];
    
    NSManagedObjectContext *managedObjectContext = ((AppDelegate*)([[UIApplication sharedApplication] delegate])).managedObjectContext;
    
    // Get all the deals, and find the max id
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"DS_DDBusiness" inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSArray *array = [managedObjectContext executeFetchRequest:request error:nil];
    
    int flag =0;
    for(DS_DDBusiness *biz in array){
        if ([[biz name] isEqualToString:bizname]&&[[biz subscribe] isEqualToString:@"1"]) {
            flag = 1;
            break;
        }
    }
    
    if(flag ==1){
        UIAlertView *wrongAlert = [[UIAlertView alloc] initWithTitle:@"Fail" message:[NSString stringWithFormat:@"Business already subscribed"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [wrongAlert show];

    }
    
    else{
    NSNumber *max_id = 0;
    for(DS_DDBusiness *biz in array){
        if(max_id < biz.b_id){
            max_id = biz.b_id;
        }
    }
    
    NSLog(@"Biz retrieved");
    // Insert and populate new object
    DS_DDBusiness *newBiz= [managedObjectContext insertNewObjectForEntityForName:@"DS_DDBusiness"];
    
    [newBiz setB_id:[NSNumber numberWithInt:([max_id integerValue] + 1)]];
    [newBiz setName:bizname];
    [newBiz setDesc:bizdesc];
    [newBiz setIp:bizip];
    [newBiz setSubscribe:@"1"];
    
    NSLog(@"bizsetname: %@",newBiz.name);
    NSLog(@"bizsetdesc: %@",newBiz.desc);
    NSLog(@"bizsetip: %@",newBiz.ip);
    
    NSError *executeError = nil;
    if(![managedObjectContext saveToPersistentStore:&executeError]) {
        NSLog(@"Failed to save to data store");
    }
    
    NSLog(@"New biz subscribe");
        

        
    }

}

- (IBAction)deal:(id)sender {
    
    NSLog(@"Button is working...");
    NSString *requestStr = [NSString stringWithFormat:@"alldeals"];
    NSLog(@"sbscribeString:::%@",requestStr);
    NSData *requestData = [requestStr dataUsingEncoding:NSUTF8StringEncoding];
    [socket writeData:requestData withTimeout:-1.0 tag:0];
    NSLog(@"Sent...");
    if (socket.isConnected) {
        NSLog(@"==============");
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
        UIAlertView *wrongAlert = [[UIAlertView alloc] initWithTitle:@"Success" message:[NSString stringWithFormat:@"Businiss Subscribed"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [wrongAlert show];

    }
//    else if(response == (id)[NSNull null] || response.length == 0  ){
//        UIAlertView *wrongAlert = [[UIAlertView alloc] initWithTitle:@"Fail" message:[NSString stringWithFormat:@"Businiss can't subscribe"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        
//        [wrongAlert show];
//
//        
//    }
    else{
        NSLog(@"inelse!!!!!!!!!!!");
        NSArray *array = [response componentsSeparatedByString:@","];
        
        NSMutableArray *alldealnames= [[NSMutableArray alloc] init];
        NSMutableArray *alldealdesc=[[NSMutableArray alloc] init];
        NSMutableArray *alldealstartdate=[[NSMutableArray alloc] init];
        NSMutableArray *alldealenddate=[[NSMutableArray alloc] init];
        NSMutableArray *alldealid =[[NSMutableArray alloc] init];
        NSMutableArray *alldealprice =[[NSMutableArray alloc] init];
        NSMutableArray *alldealmax =[[NSMutableArray alloc] init];
        NSMutableArray *alldealtype =[[NSMutableArray alloc] init];
        
        
        for(int i=0;i<array.count;i++)
        {
            [alldealid addObject:[array objectAtIndex:i]];
            i++;
            [alldealnames addObject:[array objectAtIndex:i]];
            i++;
            [alldealdesc addObject:[array objectAtIndex:i]];
            i++;
            [alldealtype addObject:[array objectAtIndex:i]];
            i++;
            [alldealmax addObject:[array objectAtIndex:i]];
            i++;
            [alldealstartdate addObject:[array objectAtIndex:i]];
            i++;
            [alldealenddate addObject:[array objectAtIndex:i]];
            i++;
            [alldealprice addObject:[array objectAtIndex:i]];
        }
        
        NSLog(@"alldealidarray:%@",alldealid);
        NSLog(@"alldealnames:%@",alldealnames);
        NSLog(@"alldealdesc:%@",alldealdesc);
        NSLog(@"alldealtype:%@",alldealtype);
        NSLog(@"alldealmax:%@",alldealmax);
        NSLog(@"alldealstartdate:%@",alldealstartdate);
        NSLog(@"alldealenddate:%@",alldealenddate);
        NSLog(@"alldealprice:%@",alldealprice);
        
        
        [[NSUserDefaults standardUserDefaults] setValue:alldealid forKey:@"alldealid"];
        [[NSUserDefaults standardUserDefaults] setValue:alldealnames forKey:@"alldealnames"];
        [[NSUserDefaults standardUserDefaults] setValue:alldealdesc forKey:@"alldealdesc"];
        [[NSUserDefaults standardUserDefaults] setValue:alldealtype forKey:@"alldealtype"];
        [[NSUserDefaults standardUserDefaults] setValue:alldealmax forKey:@"alldealmax"];
        [[NSUserDefaults standardUserDefaults] setValue:alldealstartdate forKey:@"alldealstartdate"];
        [[NSUserDefaults standardUserDefaults] setValue:alldealenddate forKey:@"alldealenddate"];
        [[NSUserDefaults standardUserDefaults] setValue:alldealprice forKey:@"alldealprice"];

    }
    
}

- (void)socketDidDisconnect:(AsyncSocket *)sock withError:(NSError *)err
{
	NSLog(@"socketDidDisconnect:withError: \"%@\"", err);
}










@end
