//
//  PayManager.m
//  Cooking
//
//  Created by yidianjicai on 14-9-24.
//  Copyright © 2016年 gogotown. All rights reserved.
//

#import "PayManager.h"
#import "NSObject+SBJson.h"


@implementation PayManager
@synthesize sucessBlock = _sucessBlock;
@synthesize failedBlock = _failedBlock;

+ (instancetype)defaultManager
{
    static dispatch_once_t once;
    static PayManager *__single__;
    dispatch_once(&once, ^{
        __single__ = [PayManager new];
    });
    return __single__;
}

- (void)parseApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给SDK
    if ([url.host isEqualToString:@"safepay"]) {
    }
    
    [WXApi handleOpenURL:url delegate:self];
}

/**
 *  微信支付
 */
- (void)WXPayWithPayInfo:(NSMutableDictionary *)payInfoDic byController:(UIViewController *)controller{
//    NSString *appId = payInfoDic[@"data"][@"weixinPay"][@"appId"];
//    NSString *partnerId = payInfoDic[@"data"][@"weixinPay"][@"partnerId"];
//    NSString *prepayId = payInfoDic[@"data"][@"weixinPay"][@"prepayId"];
//    NSString *nonceStr = payInfoDic[@"data"][@"weixinPay"][@"nonceStr"];
//    NSNumber *timeStamp = payInfoDic[@"data"][@"weixinPay"][@"timeStamp"];
//    NSString *sign = payInfoDic[@"data"][@"weixinPay"][@"sign"];
//    NSString *packageValue = payInfoDic[@"data"][@"weixinPay"][@"packageValue"];
    
    NSString *appId = payInfoDic[@"appid"];
    NSString *partnerId = [payInfoDic[@"partnerid"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *prepayId = payInfoDic[@"prepayid"];
    NSString *nonceStr = payInfoDic[@"noncestr"];
    NSNumber *timeStamp = payInfoDic[@"timestamp"];
    NSString *sign = payInfoDic[@"sign"];
    NSString *packageValue = payInfoDic[@"packagevalue"];
    
    //调起微信支付
    PayReq* req = [[PayReq alloc] init];
    req.openID      = appId;
    req.partnerId   = partnerId;
    req.prepayId    = prepayId;
    req.nonceStr    = nonceStr;
    req.timeStamp   = [timeStamp intValue];
    
    req.package     = packageValue;
    req.sign        = sign;
    
    [WXApi sendReq:req];
}

#pragma mark - UPPayPluginResult
- (void)UPPayPluginResult:(NSString *)result
{
    NSString *sucess = @"success";
//    NSString *cancel = @"cancel";
    // 银联支付结果回调
    NSLog(@"reslut = %@",result);
    
    if ([result isEqualToString:sucess]) {
        if (_sucessBlock) {
            _sucessBlock();
        }
    }else{
        if (_failedBlock) {
            _failedBlock(result);
        }
    }
}

/**
 *  wx回调
 */
-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //微信支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                if (_sucessBlock) {
                    _sucessBlock();
                }
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                if (_failedBlock) {
                    _failedBlock(strMsg);
                }
                break;
        }
    }
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
}

@end
