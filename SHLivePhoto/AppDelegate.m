//
//  AppDelegate.m
//  SHLivePhoto
//
//  Created by fankangpeng on 2020/6/5.
//  Copyright © 2020 sw_voip. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [NSClassFromString(@"ViewController") new];
    [self.window makeKeyWindow];
    [self.window makeKeyAndVisible];
    
    
    return YES;
}
@end
