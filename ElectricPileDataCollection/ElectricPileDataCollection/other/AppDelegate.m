//
//  AppDelegate.m
//  ElectricPileDataCollection
//
//  Created by 陈行 on 16/4/7.
//  Copyright © 2016年 陈行. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomTabbar.h"
#import "RootViewController.h"
#import "SDImageCache.h"
#import "SQLiteManager.h"
@interface AppDelegate ()

@property(nonatomic,strong)CustomTabbar * tabbar;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //    NSLog(@"%@",[[NSBundle mainBundle] resourcePath]);
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //设置图片内存缓存为20M
    [[SDImageCache sharedImageCache] setMaxCacheAge:1024*1024*20];
    //检查数据库版本
    [self checkDatabaseVersion];
    //检查是否已经登录过
    UITabBarController * tbc = [UITabBarController new];
    [self createTabbarWithTbc:tbc];
    self.window.rootViewController = tbc;
    return YES;
}

- (void)createTabbarWithTbc:(UITabBarController *)tbc{
    NSArray * tabbarArray=[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Tabbar.plist" ofType:nil]];
    NSMutableArray * itemArray=[[NSMutableArray alloc]init];
    NSMutableArray * viewCons=[[NSMutableArray alloc]init];
    for (NSDictionary * dict in tabbarArray) {
        CustomTabbarItem * item = [CustomTabbarItem tabbarItemWithDict:dict];
        [itemArray addObject:item];
        
        RootViewController * con= [[NSClassFromString([NSString stringWithString:item.controller]) alloc]init];
        
        UINavigationController * nav=[[UINavigationController alloc]initWithRootViewController:con];
        [viewCons addObject:nav];
    }
    tbc.viewControllers=viewCons;
    
    CustomTabbar * tabbar=[CustomTabbar tabbarWithTabbarItemArray:itemArray andTabbarController:tbc];
    tabbar.selectedColor=[UIColor blueColor];
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
    view.backgroundColor=[UIColor grayColor];
    [tabbar addSubview:view];
    
    [tbc.view addSubview:tabbar];
    tabbar.frame=CGRectMake(0, HEIGHT-49, WIDTH, 49);
    [tbc.view bringSubviewToFront:tabbar];
    self.tabbar=tabbar;
}

/**
 *  检查数据库版本
 */
- (void)checkDatabaseVersion{
    [SQLiteManager checkAndUpdateDatabaseVersion];
}

+ (CustomTabbar *)customTabbar{
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    return appDelegate.tabbar;
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
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
