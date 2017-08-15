//
//  MineItem.h
//  198SalesGoods
//
//  Created by BST on 2017/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SettingItemsOption)();
@interface MineItem : NSObject
//图标名称
@property(copy, nonatomic) NSString *iconName;

    //cell内容
@property(copy, nonatomic) NSString *textName;

    //子标题

@property(copy, nonatomic) NSString *subTitle;
    //block定义
@property(copy, nonatomic) SettingItemsOption option;

    //+ (instancetype)itemWithIconName:(NSString *)iconName text:(NSString *)textName destClass: (Class) controller;
+ (instancetype)itemWithIconName:(NSString *)iconName text:(NSString *)textName;


@end
