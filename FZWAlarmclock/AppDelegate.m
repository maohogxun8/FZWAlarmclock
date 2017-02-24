//
//  AppDelegate.m
//  FZWAlarmclock
//
//  Created by IOS2 on 17/2/22.
//  Copyright © 2017年 IOS2. All rights reserved.
//

#import "AppDelegate.h"
#import "NotifiFormForegroundAleart.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


#pragma mark 通知代理

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    NSLog(@"收到本地通知");
    [application setApplicationIconBadgeNumber:0];
    
    if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"在前台");
        NotifiFormForegroundAleart *aler = [[NSBundle mainBundle]loadNibNamed:@"NotifiFormForegroundAleart" owner:self options:nil].firstObject;
        [aler showAleartNotificationConfigWithModels:notification.alertTitle subTitle:nil bodyContent:notification.alertBody badgeNumber:0 soundNamed:notification.soundName];
//        return;
    }else if (application.applicationState == UIApplicationStateInactive)
    {
    }else if(application.applicationState == UIApplicationStateBackground){
        /**
         *  不会执行该代码
         */
        NSLog(@"在后台");
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
