//
//  AddressViewCell.h
//  198SalesGoods
//
//  Created by BST on 2017/8/17.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol AddressViewCellDelegate <NSObject>

@optional

- (void)editAddress:(UIButton *)sender;

- (void)deleteAddress:(UIButton *)sender;

@end

@interface AddressViewCell : UITableViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableview;

/**  UIImageView *topLineView  */
@property(strong,nonatomic)   UIImageView *topLineView;

/**  UIImageView *topLineView  */
@property(strong,nonatomic)   UIImageView *bottomLineView;


/** data  */
@property(strong,nonatomic) NSDictionary *data;

@property(assign,nonatomic) id <AddressViewCellDelegate> delegate;

/** shanchu  */
@property(strong,nonatomic) UIButton *deleteBtn;

/** button  */
@property(strong,nonatomic) UIButton *editBtn;
@end
