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
    
    
    bizip=@"128.237.210.143";
    
    
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
    
    NSString* userEmail = [[NSUserD#0	0x00004a21 in -[BusinessMapViewController loadBusinessesFromCloud] at /Users/SafenZhai/Desktop/DistributedD/BusinessMapViewController.m:236
efaults standardUserDefaults] objectForKey:@"userEmail"];
    NSLog(@"The userEmail is:%@",userEmail);


    NSLog(@"Button is working...");
    NSString *requestStr = [NSString stringWithFormat:@"subscribe,%@,%@,hellohello,%@,%@,1",
                            userAge, userEmail, userGender, userName];
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
}

- (void)socketDidDisconnect:(AsyncSocket *)sock withError:(NSError *)err
{
	NSLog(@"socketDidDisconnect:withError: \"%@\"", err);
}










@end
