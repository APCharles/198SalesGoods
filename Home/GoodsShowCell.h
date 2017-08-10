//
//  GoodsShowCell.h
//  198SalesGoods
//
//  Created by BST on 2017/8/10.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsShowCell : UITableViewCell


/** 图片  */
@property(strong,nonatomic) UIImageView *iconView;

+ (instancetype) cellWithTableView:(UITableView *)tableview;
@end
