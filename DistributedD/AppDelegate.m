//
//  AppDelegate.m
//  DistributedD
//
//  Created by XZhai on 3/28/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import "AppDelegate.h"
#import <ApigeeiOSSDK/Apigee.h>
#import <AudioToolbox/AudioToolbox.h>

static NSString *kBundledSoundName = @"Aooga";
static NSString *kBundledSongFileType = @"aiff";
static NSString *kBundledSoundNameWithExt = @"Aooga.aiff";

static SystemSoundID nullSoundId = (SystemSoundID) NULL;
static SystemSoundID soundId = (SystemSoundID) NULL;

@implementation AppDelegate

@synthesize managedObjectContext;

ApigeeDataClient * dataClient;
// The following values must be changed to the organization, application, and notifier
// to match the names that you've created on the App Services platform. Be sure that
// the application you use allows Guest access (e.g., sandbox) - or that you have the device
// log in to App Services.
// Also ensure that you update the Bundle Identifier and Provisioning Profile in the project Build Settings.
// You will need to set the "Code Signing Identity" options for "Debug" to your Provisioning Profile.
NSString * orgName = @"minghaow";
NSString * appName = @"sandbox";
NSString * notifier = @"test2";
NSString * baseURL = @"https://api.usergrid.com";

- (void)playSound:(NSString*)soundName
{
    if ([soundName length] > 0) {
        if (nullSoundId == soundId) {
            // ignore the soundName parameter, we only know 1 kind of sound
            NSString* soundFilePath =
            [[NSBundle mainBundle] pathForResource:kBundledSoundName
                                            ofType:kBundledSongFileType];
            
            if (soundFilePath) {
                NSURL* soundURL = [NSURL fileURLWithPath:soundFilePath];
                
                if (soundURL) {
                    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL,
                                                     &soundId);
                    if (soundId == nullSoundId) {
                        NSLog(@"error: unable to load sound file");
                    }
                }
            }
        }
        
        if (soundId != nullSoundId) {
            AudioServicesPlaySystemSound(soundId);
        }
    }
}

- (void)handlePushNotification:(NSDictionary*)dictPushNotification
                forApplication:(UIApplication*)application
{
    // Received a push notification from the server
    NSLog(@"push received: %@", dictPushNotification);
    
    NSDictionary* payloadAPS = [dictPushNotification valueForKey:@"aps"];
    
    
    if (nil == payloadAPS) {
        NSLog(@"error: no aps payload found");
        return;
    }
    
    UIRemoteNotificationType enabledTypes =
    [application enabledRemoteNotificationTypes];
    
    NSString* alertText = [payloadAPS valueForKey:@"alert"];
    
    if(![alertText isEqualToString:@"You have a good deal near you!"]){

        
        NSArray *reqArray = [alertText componentsSeparatedByString:@","];
        
        
        
        // Get all the deals, and find the max id
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"DS_DDBusiness" inManagedObjectContext:managedObjectContext];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDescription];
        NSArray *array = [managedObjectContext executeFetchRequest:request error:nil];
        
        for(DS_DDBusiness *biz in array){
            if([[biz name]isEqualToString: [reqArray objectAtIndex:0]]){

                [biz setIp:[reqArray objectAtIndex:1]];
            
            }
        }

        
        alertText = @"A business changed its IP";
    }
    
    // enabled for sound?
    if (enabledTypes & UIRemoteNotificationTypeSound) {
        NSString* sound = [payloadAPS valueForKey:@"sound"];
        
        // play a sound even if we haven't been given a value
        if ([sound length] == 0) {
            sound = kBundledSoundName;
        }
        
        if ([sound length] > 0) {
            [self playSound:sound];
        }
    }
    
    // enabled for alerts?
    if (enabledTypes & UIRemoteNotificationTypeAlert) {
        // Only pop alert if applicationState is active (if not, the user already saw the alert)
        if (application.applicationState == UIApplicationStateActive) {
            if ([alertText length] > 0) {
                NSString* message = [NSString stringWithFormat:@"Text:\n%@",
                                     alertText];
                [self alert:message
                      title:@"Remote Notification"];
            }
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    UIRemoteNotificationType enabledTypes =
    [application enabledRemoteNotificationTypes];
    
    if (enabledTypes & (UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound)) {
        // Register for push notifications with Apple
        NSLog(@"registering for remote notifications");
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeSound];
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSError *error = nil;
    NSURL *modelURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"DS_DD1" ofType:@"momd"]];
    NSManagedObjectModel *managedObjectModel = [[[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL] mutableCopy];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    
    // Initialize the Core Data stack
    [managedObjectStore createPersistentStoreCoordinator];
    
    NSString *path = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"DD_Store.sqlite"];
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:path fromSeedDatabaseAtPath:nil withConfiguration:nil options:nil error:&error];
    if (! persistentStore) {
        RKLogError(@"Failed adding persistent store at path '%@': %@", path, error);
    }

    
    [managedObjectStore createManagedObjectContexts];
    
    // Set the default store shared instance
    [RKManagedObjectStore setDefaultStore:managedObjectStore];
    
    // Configure the object manager
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://ec2-54-86-125-98.compute-1.amazonaws.com"]];
    objectManager.managedObjectStore = managedObjectStore;
    
    [RKObjectManager setSharedManager:objectManager];
    
    RKEntityMapping *entityMapping = [RKEntityMapping mappingForEntityForName:@"DS_DDBusiness" inManagedObjectStore:managedObjectStore];
    [entityMapping addAttributeMappingsFromDictionary:@{
                                                        @"ID":              @"b_id",
                                                        @"Name":            @"name",
                                                        @"Description":            @"desc",
                                                        @"IP":            @"ip",
                                                        //@"street_no":       @"street_no",
                                                        //@"street_name":     @"street_addr",
                                                        //@"zip_code":        @"zip_code",
                                                        @"Lat":             @"lat",
                                                        @"Long":            @"longtd"}];
    entityMapping.identificationAttributes = @[@"b_id"];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:entityMapping pathPattern:@"/getallbiz" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    managedObjectContext = managedObjectStore.mainQueueManagedObjectContext;
    //[RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class]forMIMEType:@"text/html"];
    
    // Push notification initilization
    NSLog(@"setting up app services connection");
    
    // Connect and login to App Services
    ApigeeClient *apigeeClient =
    [[ApigeeClient alloc] initWithOrganizationId:orgName
                                   applicationId:appName
                                         baseURL:baseURL];
    dataClient = [apigeeClient dataClient];
    [dataClient setLogging:true]; //comment out to remove debug output from the console window
    
    if (launchOptions != nil) {
        NSDictionary* userInfo =
        [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (userInfo) {
            [self handlePushNotification:userInfo
                          forApplication:application];
        }
    }
    
    // It's not necessary to explicitly login to App Services if the Guest role allows access
    //    NSLog(@"Logging in user");
    //    [usergridClient logInUser: userName password: password];
    
    NSLog(@"done launching");
    
    return YES;
}

// Invoked as a callback from calling registerForRemoteNotificationTypes.
// newDeviceToken is a token received from registering with Apple APNs.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    // Register device token with App Services (will create the Device entity if it doesn't exist)
    NSLog(@"registering token with app services");
    ApigeeClientResponse *response = [dataClient setDevicePushToken: newDeviceToken
                                                        forNotifier: notifier];
    
    // You could use this if you log in as an app services user to associate the Device to your User
    //    if (response.transactionState == kUGClientResponseSuccess) {
    //        response = [self connectEntities: @"users" connectorID: @"me" type: @"devices" connecteeID: deviceId];
    //    }
    
    if ( ! [response completedSuccessfully]) {
        [self alert: response.rawResponse title: @"Error"];
    }
}

// Invoked as a callback from calling registerForRemoteNotificationTypes if registration
// failed.
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    [self alert: error.localizedDescription title: @"Error"];
}

- (void)sendMyselfAPushNotification:(NSString *)message
                  completionHandler:(ApigeeDataClientCompletionHandler)completionHandler
{
    // send to a single device -- our own device
    NSString *deviceId = [ApigeeDataClient getUniqueDeviceID];
    ApigeeAPSDestination* destination =
    [ApigeeAPSDestination destinationSingleDevice:deviceId];
    NSString *div = @"======================!!!!!!!!!!=================";
    NSLog(div);
    NSLog(deviceId);
    
    // set our APS payload
    ApigeeAPSPayload* apsPayload = [[ApigeeAPSPayload alloc] init];
    apsPayload.sound = kBundledSoundNameWithExt;
    apsPayload.alertText = message;
    
    // Example of what a custom payload might look like -- remember that
    // APNS payloads are limited to a maximum of 256 bytes (for the entire
    // payload -- including the 'aps' part)
    NSMutableDictionary* customPayload = [[NSMutableDictionary alloc] init];
    [customPayload setValue:@"72" forKey:@"degrees"];
    [customPayload setValue:@"3" forKey:@"newOrders"];
    
    __weak AppDelegate* weakSelf = self;
    
    // send the push notification
    [dataClient pushAlert:apsPayload
            customPayload:customPayload
              destination:destination
            usingNotifier:notifier
        completionHandler:^(ApigeeClientResponse *response) {
            if ( ! [response completedSuccessfully]) {
                [weakSelf alert:response.rawResponse
                          title: @"Error"];
            }
            
            if (completionHandler) {
                completionHandler(response);
            }
        }];
}

- (void)sendPushNotificationToAllDevices:(NSString *)message
                       completionHandler:(ApigeeDataClientCompletionHandler)completionHandler
{
    // send to all devices
    ApigeeAPSDestination* destination =
    [ApigeeAPSDestination destinationAllDevices];
    
    // set our APS payload
    ApigeeAPSPayload* apsPayload = [[ApigeeAPSPayload alloc] init];
    apsPayload.sound = kBundledSoundNameWithExt;
    apsPayload.alertText = message;
    apsPayload.badgeValue = [NSNumber numberWithInt:3];
    
    __weak AppDelegate* weakSelf = self;
    
    // send the push notification
    [dataClient pushAlert:apsPayload
              destination:destination
            usingNotifier:notifier
        completionHandler:^(ApigeeClientResponse *response) {
            if ( ! [response completedSuccessfully]) {
                [weakSelf alert:response.rawResponse
                          title: @"Error"];
            }
            
            if (completionHandler) {
                completionHandler(response);
            }
        }];
}

// Invoked when a notification arrives for this device.
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self handlePushNotification:userInfo forApplication:application];
}

- (void)alert:(NSString *)message title:(NSString *)title
{
    NSLog(@"displaying alert. title: %@, message: %@", title, message);
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle: title
                              message: message
                              delegate: self
                              cancelButtonTitle: @"OK"
                              otherButtonTitles: nil];
    [alertView show];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
