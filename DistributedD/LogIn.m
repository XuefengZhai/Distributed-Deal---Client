//  LogIn.m
//  DistributedD
//
//  Created by XZhai on 4/5/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import "LogIn.h"

@interface LogIn ()

@end

@implementation LogIn

@synthesize email,psw;
@synthesize signUp, signIn;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)View_TouchDown:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}// Hide keyboard when touch the screen

- (IBAction)TextField_DidEndOnExit:(id)sender {
    [sender resignFirstResponder];
}// Hide keyboard when touch the return

- (IBAction)emailTextField_DidEndOnExit:(id)sender {
     [self.psw becomeFirstResponder];
}

- (IBAction)pswTextField_DidEndOnExit:(id)sender {
    [sender resignFirstResponder];
    [self.signIn sendActionsForControlEvents:UIControlEventTouchUpInside];

}


- (IBAction)signInButton:(id)sender {
    
    NSString *urlBaseString = @"http://www.twitter.com/";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlBaseString]];

    [request setHTTPMethod:@"GET"];

    NSHTTPURLResponse *response = nil;

    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if ([response statusCode] == 200)
    {
        NSLog(@"!!!!!!!!!");
        NSLog(@"ButtonPressed");
        [self performSegueWithIdentifier:@"signIn" sender:self]; //Change the seque identifier


    }
    else
    {
        NSLog(@"Seccess!");
    }




    
    
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
