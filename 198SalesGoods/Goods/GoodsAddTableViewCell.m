    //
    //  GoodsListViewCell.m
    //  198SalesGoods
    //
    //  Created by BST on 2017/8/17.
    //  Copyright © 2017年 AP. All rights reserved.
    //

#import "GoodsAddTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SBJsonParser.h"
@interface GoodsAddTableViewCell ()

/** icon  */
@property(strong,nonatomic) UIImageView  *iconView;

/** title  */
@property(strong,nonatomic) UILabel *titleLale;

/** title  */
@property(strong,nonatomic) UILabel *martPLable;
/** title  */
@property(strong,nonatomic) UILabel *priceLable;

@end
@implementation GoodsAddTableViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableview{
    
    static NSString *ID = @"GoodsAddTableViewCell";
    GoodsAddTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[GoodsAddTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    if (self) {
        
        [self addSubview:self.iconView];
        [self addSubview:self.titleLale];
//        [self addSubview:self.martPLable];
//        [self addSubview:self.priceLable];
        
    }
    
    return self;
}

- (void)setData:(NSDictionary *)data{
    
    _data = data;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APPIP,data[@"image"]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    _titleLale.text = [data objectForKey:@"title"];
    _titleLale.size = [_titleLale.text sizeWithFont:[UIFont systemFontOfSize:13] maxSize:MAXSIZE];
    _titleLale.y = CGRectGetMaxY(_iconView.frame) + 25;
    _titleLale.x = mainScreenWidth * 0.5 - _titleLale.width * 0.5;
    
    
    
    _priceLable.text = [NSString stringWithFormat:@"¥：%@",[data objectForKey:@"price"]] ;
    
    _priceLable.size = [_martPLable.text sizeWithFont:[UIFont systemFontOfSize:12] maxSize:MAXSIZE];
    
    _priceLable.x = mainScreenWidth - 15 - _priceLable.width;
    
    _priceLable.y = 250 - _priceLable.height - 5;
    
    
    
    
    _martPLable.text = [NSString stringWithFormat:@"¥：%@",[data objectForKey:@"price_market"]] ;
    
    _martPLable.size = [_martPLable.text sizeWithFont:[UIFont systemFontOfSize:11] maxSize:MAXSIZE];
    
    _martPLable.x = mainScreenWidth - 15 - _priceLable.width - 20 - _martPLable.width;
    _martPLable.y =_priceLable.y  +_priceLable.height * 0.5 - _martPLable.height * 0.5;
    
    UILabel *divi = [[UILabel alloc ] init];
    divi.width = _martPLable.width;
    divi.height = 0.5;
    divi.x = 0;
    divi.y = _martPLable.height * 0.5 -divi.height * 0.5;
    divi.backgroundColor = GRAYETEXTCOLOR;
    
    [_martPLable addSubview:divi];
    
    
    
    
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

