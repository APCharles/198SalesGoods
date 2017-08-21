//
//  OrderHeaderView.h
//  198SalesGoods
//
//  Created by BST on 2017/8/18.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface OrderHeaderView : UIView

@property (nonatomic,strong) NSArray * items;


    //内部选中某一个模块，传递给外部
@property (nonatomic,copy) void(^itemClickAtIndex)(NSInteger index);

    //由外部决定选中哪一个模块
-(void)setSelectAtIndex:(NSInteger)index;
@end
