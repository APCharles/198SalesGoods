//
//  EditAddressViewCell.h
//  198SalesGoods
//
//  Created by BST on 2017/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditAddressViewCell : UITableViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableview;

/** data  */
@property(strong,nonatomic) NSDictionary *data;

/** textfiled  */
@property(strong,nonatomic) UITextField *filed;

/**  UIImageView *topLineView  */
@property(strong,nonatomic)   UIImageView *topLineView;

/**  UIImageView *topLineView  */
@property(strong,nonatomic)   UIImageView *bottomLineView;


/** address */
@property(strong,nonatomic)UILabel *addressLabel;
@end
