//
//  OrderListTableViewCell.h
//  198SalesGoods
//
//  Created by BST on 2017/8/18.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderListTableViewCellDelegate <NSObject>

@optional

-(void)payForBtnClick:(UIButton *)sender;

-(void)deleteBtnClick:(UIButton *)sender;

@end
@interface OrderListTableViewCell : UITableViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableview;

/** data  */
@property(strong,nonatomic) NSDictionary *data;

/** idx  */
@property(assign,nonatomic) NSInteger idx;

/** cell高度  */
@property(retain,nonatomic) id <OrderListTableViewCellDelegate> del;

@property(strong,nonatomic) UIButton *deleteBtn;

@property(strong,nonatomic) UIButton *payforBtn;
@end
