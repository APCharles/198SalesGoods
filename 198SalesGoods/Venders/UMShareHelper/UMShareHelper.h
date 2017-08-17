//
//  UMShareHelper.h
//  sharetest
//
//  Created by yidianjicai-iOS on 16/11/10.
//  Copyright © 2016年 dkxtx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

#define UMAppKey @"5993c846a40fa35cb5000d59"

#define WXAppId @"wxa2af916683765e86"
#define WXAppSecret @"379571814a5c0be5ad55e8c7e75ef99b"
#define DefaultUrl @""
#define DefaultShareImageName @"icon_logo"

@interface UMShareHelper : NSObject


+ (UMShareHelper *)defaultUMShareHelper;
- (void)setUMInfo;


//第三方登录
- (void)applyByController:(UIViewController *)controller snsAccountWithUMSocialSnsType:(UMSocialPlatformType)platformType success:(void (^)(UMSocialUserInfoResponse *response))success failed:(void (^)(NSError *error))failed;

//分享
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType byController:(UIViewController *)controller withText:(NSString *)text Title:(NSString *)title Descr:(NSString *)descr ThumImage:(NSString *)thumImage Url:(NSString *)url success:(void (^)(id data))success failed:(void (^)(NSError *error))failed;
@end
