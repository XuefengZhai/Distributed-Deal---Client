//
//  SignUp.m
//  DistributedD
//
//  Created by XZhai on 4/5/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import "SignUp.h"

@interface SignUp ()


@end

@implementation SignUp

@synthesize email,name,age,psw;
@synthesize submmit;
@synthesize gender;

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

- (IBAction)emailTextField_DidEndOnExit:(id)sender {
    [self.name becomeFirstResponder];
}

- (IBAction)nameTextField_DidEndOnExit:(id)sender {
    [self.age becomeFirstResponder];
}

- (IBAction)ageTextField_DidEndOnExit:(id)sender {
    [self.psw becomeFirstResponder];
}

- (IBAction)pswTextField_DidEndOnExit:(id)sender {
    [self.gender becomeFirstResponder];
}

- (IBAction)submmitButton:(id)sender {
    NSString *urlBaseString = @"http://www.twitter.com/";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlBaseString]];
    
    [request setHTTPMethod:@"GET"];
    
    NSHTTPURLResponse *response = nil;
    
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    if ([response statusCode] == 200)
    {
        NSLog(@"!!!!!!!!!");
        NSLog(@"SubmittButtonPressed");
        [self performSegueWithIdentifier:@"signUp" sender:self]; //Change the seque identifier
        
        
    }
    else
    {
        NSLog(@"Seccess!");
    }

}




@end
