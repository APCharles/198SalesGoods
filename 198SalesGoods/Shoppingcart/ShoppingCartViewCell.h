//
//  ShoppingCartViewCell.h
//  198SalesGoods
//
//  Created by BST on 2017/8/29.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartViewCell : UITableViewCell
+ (instancetype) cellWithTableView:(UITableView *)tableview;
/** data  */
@property(strong,nonatomic) NSDictionary *data;
@end
