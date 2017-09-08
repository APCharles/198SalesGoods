//
//  CustomerViewCell.h
//  198SalesGoods
//
//  Created by BST on 2017/9/8.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerViewCell : UITableViewCell
+ (instancetype) cellWithTableView:(UITableView *)tableview;
/** data  */
@property(strong,nonatomic) NSDictionary *data;

/**  UIImageView *topLineView  */
@property(strong,nonatomic)   UIImageView *topLineView;

/**  UIImageView *topLineView  */
@property(strong,nonatomic)   UIImageView *bottomLineView;

@end
