//
//  PayManager.h
//  Cooking
//
//  Created by yidianjicai-iOS on 16/11/24.
//  Copyright © 2016年 gogotown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

typedef enum {
    /**
     *  无支付方式
     */
    GOPay_Type_None = 0,
    /**
     *  货到付款
     */
    GOPay_Type_Cash = 4,
    /**
     *  支付宝支付
     */
    GOPay_Type_Alipay = 1,
    /**
     *  银联支付
     */
    GOPay_Type_UMPay = 2,
    /**
     *  微信支付
     */
    GOPay_Type_WXPay = 3,
}GOPay_Type;


typedef void(^paySucess)();
typedef void(^payFailed)(NSString *errorInfo);

@interface PayManager : NSObject < WXApiDelegate>

@property (nonatomic , copy) paySucess sucessBlock;
@property (nonatomic , copy) payFailed failedBlock;

+ (instancetype)defaultManager;

/**
 *  从支付的app中跳回,在appdelegate中的openurl中调用
 */
- (void)parseApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;

/**
 *  微信支付
 */
- (void)WXPayWithPayInfo:(NSMutableDictionary*)payInfoDic byController:(UIViewController*)controller;


@end
