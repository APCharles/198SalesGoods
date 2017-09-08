//
//  MineInfoViewCell.h
//  198SalesGoods
//
//  Created by BST on 2017/8/14.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineInfoViewCellDelegate <NSObject>

@optional

- (void)gotoScoreDetail;

- (void)gotoshoppingCart;

@end
@interface MineInfoViewCell : UITableViewCell
+ (instancetype) cellWithTableView:(UITableView *)tableview;


/** data  */
@property(strong,nonatomic) NSDictionary *data;

@property(retain,nonatomic) id <MineInfoViewCellDelegate> del;
@end
