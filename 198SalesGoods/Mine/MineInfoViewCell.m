//
//  MineInfoViewCell.m
//  198SalesGoods
//
//  Created by BST on 2017/8/14.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "MineInfoViewCell.h"

@interface MineInfoViewCell()

/** headerView  */
@property(strong,nonatomic) UIView *headerView;


/** 头衔  */
@property(strong,nonatomic) UIImageView *iconView;

/** 用户名  */
@property(strong,nonatomic) UILabel *userName;

/** 用户身份   */
@property(strong,nonatomic) UILabel *userID;

/** 推荐人  */
@property(strong,nonatomic) UILabel *userReferee;


/** 积分  */
@property(strong,nonatomic) UILabel *scoreLabel;

/** 购物中心    */
@property(strong,nonatomic) UILabel *centerLabel;

/** 分数  */
@property(strong,nonatomic) UILabel *scoreInfo;

/** shopping center  */
@property(strong,nonatomic) UILabel *shoppingCenter;
@end

@implementation MineInfoViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableview{
    
    static NSString *ID = @"MineInfoViewCell";
    MineInfoViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[MineInfoViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    if (self) {
        [self addSubview:self.headerView];
        [self addSubview:self.iconView];
        [self addSubview:self.userName];
        [self addSubview:self.userID];
        [self addSubview:self.userReferee];
        [self addSubview:self.scoreLabel];
        [self addSubview:self.scoreInfo];
        [self addSubview:self.centerLabel];
        [self addSubview:self.shoppingCenter];
        
        
        
    }
    
    return self;
}

- (void)setData:(NSDictionary *)data{
    
    _data = data;
    
    self.iconView.backgroundColor = [UIColor redColor];
    self.userName.text = @"鹏大爷";
    self.userName.size = [self.userName.text sizeWithFont:[UIFont systemFontOfSize:16] maxSize:MAXSIZE];
    self.userName.x = CGRectGetMaxX(self.iconView.frame) + 10;
    self.userName.y = self.iconView.y;
    
    
    self.userID.text = @"身份：专家";
    self.userID.size = [self.userID.text sizeWithFont:[UIFont systemFontOfSize:16] maxSize:MAXSIZE];
    self.userID.x = self.userName.x;
    self.userID.y = CGRectGetMaxY(self.userName.frame) + 15;
    
    self.userReferee.text = @"推荐人：专家";
    self.userReferee.size = [self.userReferee.text sizeWithFont:[UIFont systemFontOfSize:16] maxSize:MAXSIZE];
    self.userReferee.x = self.userName.x;
    self.userReferee.y = CGRectGetMaxY(self.userID.frame) + 15;
    
    
    self.scoreLabel.x = mainScreenWidth * 0.5 * 0.5 - self.scoreLabel.width * 0.5;
    self.scoreLabel.y = CGRectGetMaxY(self.headerView.frame) + 5;
    
    
    self.scoreInfo.text = @"10";
    self.scoreInfo.size = [self.scoreInfo.text sizeWithFont:[UIFont systemFontOfSize:14 ] maxSize:MAXSIZE];
    self.scoreInfo.x = self.scoreLabel.x + self.scoreLabel.width * 0.5 -  self.scoreInfo.width * 0.5;
    self.scoreInfo.y = CGRectGetMaxY(self.scoreLabel.frame ) + 10;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = LINECOLOR;
    lineLabel.width = 1;
    lineLabel.height = 50;
    lineLabel.x = mainScreenWidth * 0.5;
    lineLabel.y = CGRectGetMaxY(self.headerView.frame);
    
    [self addSubview:lineLabel];
    
    
    self.centerLabel.x = mainScreenWidth * 0.5 + mainScreenWidth * 0.5 * 0.5 - self.centerLabel.width * 0.5;
    self.centerLabel.y = self.scoreLabel.y;
    
    self.shoppingCenter.text = @"10";
    self.shoppingCenter.size = [self.shoppingCenter.text sizeWithFont:[UIFont systemFontOfSize:14 ] maxSize:MAXSIZE];
    self.shoppingCenter.x =   self.centerLabel.x + self.shoppingCenter.width * 0.5;
    self.shoppingCenter.y = CGRectGetMaxY(self.centerLabel.frame ) + 10;

    
}
- (UIImageView *)iconView{
    
    if (!_iconView) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.x = 15;
        iconView.size = CGSizeMake(80, 80);
        iconView.y = 60;
        
        _iconView = iconView;
        
    }
    
    return _iconView;
}

- (UILabel *)userName{
    
    if (!_userName) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:16];
        userName.textColor = [UIColor whiteColor];
        _userName = userName;
    }
    
    return _userName;
}
- (UILabel *)userID{
    
    if (!_userID) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:16];
        userName.textColor = [UIColor whiteColor];
        _userID = userName;
    }
    
    return _userID;
}

- (UILabel *)userReferee{
    
    if (!_userReferee) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:16];
        userName.textColor = [UIColor whiteColor];
        _userReferee = userName;
    }
    
    return _userReferee;
}

- (UILabel *)scoreLabel{
    
    if (!_scoreLabel) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:14];
        userName.textColor = [UIColor blackColor];
        userName.text = @"会员积分（明细）";
        userName.size = [userName.text sizeWithFont:[UIFont systemFontOfSize:14 ] maxSize:MAXSIZE];
        
        _scoreLabel = userName;
    }
    
    return _scoreLabel;
}

- (UILabel *)scoreInfo{
    
    if (!_scoreInfo) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:14];
        userName.textColor = [UIColor blackColor];
        _scoreInfo = userName;
    }
    
    return _scoreInfo;
}
- (UILabel *)centerLabel{
    
    if (!_centerLabel) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:14];
        userName.textColor = [UIColor blackColor];
        userName.text = @"购物中心";
        userName.size = [userName.text sizeWithFont:[UIFont systemFontOfSize:14 ] maxSize:MAXSIZE];
        _centerLabel = userName;
    }
    
    return _centerLabel;
}

- (UILabel *)shoppingCenter{
    
    if (!_shoppingCenter) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:14];
        userName.textColor = [UIColor blackColor];
        _shoppingCenter = userName;
    }
    
    return _shoppingCenter;
}
- (UIView *)headerView{
    
    if (!_headerView) {
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = RGB(232, 205, 171);
        
        headerView.width = mainScreenWidth;
        headerView.height = 170;
        headerView.x = 0;
        headerView.y = 0;
        
        
        _headerView = headerView;
    }
    
    return _headerView;
}

@end
