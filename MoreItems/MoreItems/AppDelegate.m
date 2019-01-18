//
//  AppDelegate.m
//  MoreItems
//
//  Created by FaceBook on 2019/1/18.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    self.window.rootViewController = nv;
    return YES;
}




@end
