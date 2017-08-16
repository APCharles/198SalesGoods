//
//  UMShareHelper.m
//  sharetest
//
//  Created by yidianjicai-iOS on 16/11/10.
//  Copyright © 2016年 dkxtx. All rights reserved.
//

#import "UMShareHelper.h"

static UMShareHelper* _umShareHelper;


@implementation UMShareHelper

+ (UMShareHelper *)defaultUMShareHelper
{
    if (!_umShareHelper) {
        _umShareHelper = [UMShareHelper new];
    }
    [_umShareHelper setUMInfo];
    return _umShareHelper;
}

-(void)setUMInfo{
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = YES;

    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMAppKey];
    // 获取友盟social版本号
    //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WXAppId appSecret:WXAppSecret redirectURL:DefaultUrl];
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager]removePlatformProviderWithPlatformType:UMSocialPlatformType_WechatFavorite];
    [[UMSocialManager defaultManager]removePlatformProviderWithPlatformType:UMSocialPlatformType_Qzone];
    
    [self defaultAllowSnsInfo];
}

- (void)defaultAllowSnsInfo {
    id wx = [[NSUserDefaults standardUserDefaults] objectForKey:@"allowWX"];
    id qq = [[NSUserDefaults standardUserDefaults] objectForKey:@"allowQQ"];
    id sina = [[NSUserDefaults standardUserDefaults] objectForKey:@"allowSINA"];
    if (!wx) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"allowWX"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (!qq) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"allowQQ"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (!sina) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"allowSINA"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType byController:(UIViewController *)controller withText:(NSString *)text Title:(NSString *)title Descr:(NSString *)descr ThumImage:(NSString *)thumImage Url:(NSString *)url success:(void (^)(id data))success failed:(void (^)(NSError *error))failed {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    [messageObject shareObject];
    //设置文本
    messageObject.text = text;
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:thumImage.length?thumImage:[UIImage imageNamed:DefaultShareImageName]];
    //设置网页地址
    shareObject.webpageUrl =url;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
            failed(error);
        }else{
            NSLog(@"response data is %@",data);
            success(data);
        }
    }];
}

- (void)applyByController:(UIViewController *)controller snsAccountWithUMSocialSnsType:(UMSocialPlatformType)platformType success:(void (^)(UMSocialUserInfoResponse *response))success failed:(void (^)(NSError *error))failed{
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:platformType completion:^(id result, NSError *error) {
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:controller completion:^(id result, NSError *error) {
            UMSocialUserInfoResponse *userinfo = result;
            NSLog(@"%@",userinfo);
            if (error) {
                failed(error);
            }else{
                success(userinfo);
            }
        }];
    }];
}

@end
