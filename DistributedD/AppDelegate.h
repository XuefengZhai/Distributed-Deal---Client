//
//  AppDelegate.h
//  DistributedD
//
//  Created by XZhai on 3/28/14.
//  Copyright (c) 2014 XZhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ApigeeiOSSDK/Apigee.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) NSManagedObjectContext* managedObjectContext;

// Minghao
- (void)sendMyselfAPushNotification:(NSString *)message completionHandler:(ApigeeDataClientCompletionHandler)completionHandler;
- (void)sendPushNotificationToAllDevices:(NSString *)message
                       completionHandler:(ApigeeDataClientCompletionHandler)completionHandler;

@end
