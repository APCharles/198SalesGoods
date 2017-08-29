//
//  ShoppingCartViewCell.m
//  198SalesGoods
//
//  Created by BST on 2017/8/29.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "ShoppingCartViewCell.h"

@interface ShoppingCartViewCell ()

/** icon  */
@property(strong,nonatomic) UIImageView  *iconView;

/** title  */
@property(strong,nonatomic) UILabel *titleLale;

/** title  */
@property(strong,nonatomic) UILabel *martPLable;
/** title  */
@property(strong,nonatomic) UILabel *priceLable;
@end
@implementation ShoppingCartViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableview{
    
    static NSString *ID = @"ShoppingCartViewCell";
    ShoppingCartViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[ShoppingCartViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    if (self) {
        
//        [self addSubview:self.iconView];
//        [self addSubview:self.titleLale];
//        [self addSubview:self.martPLable];
//        [self addSubview:self.priceLable];
        
    }
    
    return self;
}
- (UIImageView *)iconView{
    
    if (!_iconView) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.x = 0;
        iconView.y = 0;
        iconView.width = mainScreenWidth;
        iconView.height = 200;
        _iconView = iconView;
    }
    
    return _iconView;
}

- (UILabel *)titleLale{
    
    if (!_titleLale) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:13];
        userName.textColor = [UIColor blackColor];
        
        
        _titleLale = userName;
    }
    
    return _titleLale;
}
- (UILabel *)martPLable{
    
    if (!_martPLable) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:11];
        userName.textColor = GRAYETEXTCOLOR;
        
        
        _martPLable = userName;
    }
    
    return _martPLable;
}

- (UILabel *)priceLable{
    
    if (!_priceLable) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:12];
        userName.textColor = [UIColor redColor];
        
        
        _priceLable = userName;
    }
    
    return _priceLable;
}

@end
