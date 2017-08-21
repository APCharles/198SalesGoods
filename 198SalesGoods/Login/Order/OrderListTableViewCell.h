//
//  OrderListTableViewCell.h
//  198SalesGoods
//
//  Created by BST on 2017/8/18.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListTableViewCell : UITableViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableview;

/** data  */
@property(strong,nonatomic) NSDictionary *data;

/** idx  */
@property(assign,nonatomic) NSInteger idx;
@end
