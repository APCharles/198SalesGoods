//
//  AppDelegate.h
//  198SalesGoods
//
//  Created by BST on 2017/7/5.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, assign) BOOL isFromGoodsDetail;

/**
 *	@brief	判断用户是否登录
*/
-(BOOL)checkUserLogin;
@end

