//
//  MineTermViewCell.h
//  198SalesGoods
//
//  Created by BST on 2017/8/14.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineItem.h"
@interface MineTermViewCell : UITableViewCell


+ (instancetype) cellWithTableView:(UITableView *)tableview;

/** item  */
@property(strong,nonatomic) MineItem *item;


/**  UIImageView *topLineView  */
@property(strong,nonatomic)   UIImageView *topLineView;

/**  UIImageView *topLineView  */
@property(strong,nonatomic)   UIImageView *bottomLineView;
@end
