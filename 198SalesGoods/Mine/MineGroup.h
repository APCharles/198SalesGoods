//
//  MineGroup.h
//  PanDaDriver
//
//  Created by BST on 16/9/6.
//  Copyright © 2016年 BST. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineGroup : NSObject


    //头部标题
@property(copy, nonatomic) NSString *headerTitle;

    //尾部标题

@property(copy, nonatomic) NSString *footerTitle;


    //存SettingItems的所有模型

@property (strong, nonatomic) NSArray *items;
@end
