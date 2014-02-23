//
//  MmonAppDelegate.m
//  MusicMonsters
//
//  Created by 大崎 瑶 on 2014/02/22.
//  Copyright (c) 2014年 大崎 瑶. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>
#import <Parse/Parse.h>
#import "MmonAppDelegate.h"

@implementation MmonAppDelegate

NSString *current;
NSMutableArray *items;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"Wbbolmeb1lTkAziWfgV3Gcg6LV8Y4AkRBUeIlaEx"
                  clientKey:@"CJC3C1nvwesOwmNB5aZPuRdn7wsQwNmTBBWC7f23"];

    NSLog(@"App Started");
    
    [application unregisterForRemoteNotifications];
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound|
     UIRemoteNotificationTypeNewsstandContentAvailability];

    self.items = [[NSMutableArray alloc] init];
    self.current = @"";
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
//    [PFPush storeDeviceToken:newDeviceToken];
//    [PFPush subscribeToChannelInBackground: @""];

    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    [currentInstallation saveInBackground];

    NSLog(@"newDeviceToken: %@", newDeviceToken);
}

// デバイストークンの取得に失敗
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog( @"deviceToken Error : %@", [NSString stringWithFormat:@"%@", error] );
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler
{
    NSLog(@"didReceiveRemoteNotification");
    
    //[PFPush handlePush: userInfo];

    MPMusicPlayerController *player = [MPMusicPlayerController iPodMusicPlayer];
    MPMediaItem *nowPlayingItem = [player nowPlayingItem];
    //NSString *artist = [nowPlayingItem valueForProperty:MPMediaItemPropertyArtist];
    NSString *title  = [nowPlayingItem valueForProperty:MPMediaItemPropertyTitle];
    
    if (![self.current isEqualToString:title]) {
        self.current = title;
        [self.items addObject:title];
    }
    NSLog(@"push: %@", title);
    
    handler(UIBackgroundFetchResultNewData);
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

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"applicationDidBecomeActive" object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
