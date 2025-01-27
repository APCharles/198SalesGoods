//
//  AppDelegate.m
//  198SalesGoods
//
//  Created by BST on 2017/7/5.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "AppDelegate.h"
#import "SalesTabController.h"
#import "UserInfoModel.h"
#import "UMShareHelper.h"
#import <MeiQiaSDK/MQManager.h>
#import "UserInfoModel.h"
#import "PayManager.h"
#import "WXApi.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[SalesTabController alloc] init];
    
    [self.window makeKeyAndVisible];

    //第三方平台设置
    [[UMShareHelper defaultUMShareHelper]setUMInfo];
    self.isFromGoodsDetail = NO;
    
#pragma mark  美恰
        //#error 请填写您的美洽 AppKey
    [MQManager initWithAppkey:@"721da388d89414cfec14cc76cd5be321" completion:^(NSString *clientId, NSError *error) {
        if (!error) {
                //            NSLog(@"美洽 SDK：初始化成功");
            [self MQLogin];
        }
    }];
    return YES;
}

-(void)MQLogin{
    //创建自定义信息
    UserInfoModel *userInfoModel = [UserInfoModel objectWithKeyValues:[[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoModel]];
    if (userInfoModel) {
        [MQManager setClientOnlineWithCustomizedId:[NSString stringWithFormat:@"%d",userInfoModel.base_id.intValue] success:^(MQClientOnlineResult result, MQAgent *agent, NSArray<MQMessage *> *messages) {
        } failure:^(NSError *error) {
        } receiveMessageDelegate:nil];
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

#pragma mark - <openURL: sourceApplication:>
//#define __IPHONE_10_0    100000
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 100000
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响。
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#endif

#pragma mark - <openURL: sourceApplication:>
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    [WXApi handleOpenURL:url delegate:[PayManager defaultManager]];
    if (!result) {
        // 其他如支付等SDK的回调
        //调用其他SDK
        [[PayManager defaultManager] parseApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    [WXApi handleOpenURL:url delegate:[PayManager defaultManager]];
    if (!result) {
        // 其他如支付等SDK的回调
        [[PayManager defaultManager] parseApplication:application openURL:url sourceApplication:nil annotation:nil];
    }
    return result;
}
#pragma mark </openURL: sourceApplication:>
#pragma mark </openURL: sourceApplication:>

/**
 *	@brief	判断用户是否登录
 *
 */
-(BOOL)checkUserLogin{
    UserInfoModel *userInfoModel = [UserInfoModel objectWithKeyValues:[[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoModel]];
    if (userInfoModel && userInfoModel.base_id) {
        return YES;
    }else{
        return NO;
    }
}
@end
