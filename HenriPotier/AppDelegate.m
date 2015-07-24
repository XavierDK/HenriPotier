//
//  AppDelegate.m
//  HenriPotier
//
//  Created by Xavier De Koninck on 16/07/2015.
//  Copyright (c) 2015 XavierDeKoninck. All rights reserved.
//

#import "AppDelegate.h"
#import <OpenSans/UIFont+OpenSans.h>
#import <MagicalRecord/MagicalRecord.h>

@interface AppDelegate ()

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont openSansFontOfSize:17.f],
      NSFontAttributeName,
      [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f],
      NSForegroundColorAttributeName, nil]];
    
    [UINavigationBar appearance].tintColor = [UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
     setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor colorWithRed:51.f/255.f green:51.f/255.f blue:51.f/255.f alpha:1.f],
       NSFontAttributeName:[UIFont openSansSemiBoldFontOfSize:17.f]
       }
     forState:UIControlStateNormal];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    [MagicalRecord cleanUp];
}

@end
