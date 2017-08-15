//
//  MineTermViewCell.m
//  198SalesGoods
//
//  Created by BST on 2017/8/14.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "MineTermViewCell.h"

@interface MineTermViewCell ()


/** 头衔  */
@property(strong,nonatomic) UIImageView *iconView;

/** 用户titleLable  */
@property(strong,nonatomic) UILabel *titleLable;

@end
@implementation MineTermViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableview{
    
    static NSString *ID = @"GoodsShowCell";
    MineTermViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[MineTermViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    if (self) {
       _topLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 0.5)];
        _topLineView.image = [UIImage imageNamed:@"img_line"];
        [self.contentView addSubview:_topLineView];
        
        _bottomLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50-0.5, mainScreenWidth, 0.5)];
        _topLineView.image = [UIImage imageNamed:@"img_line"];
        [self.contentView addSubview:_topLineView];
        [self addSubview:self.iconView];
        [self addSubview:self.titleLable];
        
    }
    
    return self;
}


- (void)setItem:(MineItem *)item{
    
    _item = item;
    if (item.iconName) {
        self.iconView.image = [UIImage imageNamed:item.iconName];
        
    }
    
    self.titleLable.text = item.textName;
    self.titleLable.size = [self.titleLable.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:MAXSIZE];
    self.titleLable.x = CGRectGetMaxX(self.iconView.frame) + 5;
    self.titleLable.y = 25 - self.titleLable.height * 0.5;
}

- (UIImageView *)iconView{
    
    if (!_iconView) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.x = 15;
        iconView.size = CGSizeMake(20, 20);
        iconView.y = 25 - iconView.height * 0.5;
        
        _iconView = iconView;
        
    }
    
    return _iconView;
}
- (UILabel *)titleLable{
    
    if (!_titleLable) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:14];
        userName.textColor = [UIColor blackColor];
        _titleLable = userName;
    }
    
    return _titleLable;
}


@end
