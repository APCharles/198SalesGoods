

    //
//  MineItem.m
//  198SalesGoods
//
//  Created by BST on 2017/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "MineItem.h"

@implementation MineItem
+ (instancetype)itemWithIconName:(NSString *)iconName text:(NSString *)textName{
    
    MineItem *items = [[MineItem alloc] init];
    items.iconName = iconName;
    items.textName = textName;
    
    return items;
}
@end
