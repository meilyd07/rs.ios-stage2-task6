//
//  AppDelegate.m
//  WorkWithUITask6
//
//  Created by Hanna Rybakova on 6/18/20.
//  Copyright © 2020 Hanna Rybakova. All rights reserved.
//

#import "AppDelegate.h"
#import "IconViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    IconViewController *viewC = [IconViewController new];
    window.rootViewController = viewC;
    self.window = window;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
