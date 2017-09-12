//
//  OrderListTableViewCell.m
//  198SalesGoods
//
//  Created by BST on 2017/8/18.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "OrderListTableViewCell.h"

@interface OrderListTableViewCell()


/** iconView  */
@property(strong,nonatomic) UIImageView *iconView;


/** goodView  */
@property(strong,nonatomic) UIView *goodView;

/**   */
@property(strong,nonatomic)  UILabel *goodName;

/** headerView  */
@property(strong,nonatomic) UIView *headerView;

/** typeLabel  */
@property(strong,nonatomic) UILabel *typeLabel;

/** cooe  */
@property(strong,nonatomic) UILabel *colorLabel;

/** size  */
@property(strong,nonatomic) UILabel *sizeLabel;

/** price  */
@property(strong,nonatomic) UILabel *priceLabel;

/** marketLabel  */
@property(strong,nonatomic) UILabel *marketLabel;


/** bottomView  */
@property(strong,nonatomic) UIView *bottomView;


@end
@implementation OrderListTableViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableview{
    
    static NSString *ID = @"OrderListTableViewCell";
    OrderListTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[OrderListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    if (self) {
        
        [self addSubview:self.headerView];
        
        [self addSubview:self.goodView];
        [self.headerView addSubview:self.typeLabel];
        [self.goodView addSubview:self.iconView];
        [self.goodView addSubview:self.goodName];
        [self.goodView addSubview:self.colorLabel];
        [self.goodView addSubview:self.priceLabel];
        [self.goodView addSubview:self.marketLabel];
        [self addSubview:self.goodView];
//        [self.goodView addSubview:self.goodName];
        
        [self addSubview:self.deleteBtn];
        [self addSubview:self.payforBtn];
        
    }
    
    return self;
}

- (void)setData:(NSDictionary *)data{
    
    _data = data;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APPIP,data[@"image"]]] placeholderImage:nil];
    self.goodName.text = [data objectForKey:@"title"];
    
    NSString *color;
    if (![Tools isBlankString:[data objectForKey:@"specifi_one"]]) {
        
        if (![Tools isBlankString:[data objectForKey:@"specifi_two"]]) {
             color = [NSString stringWithFormat:@"颜色：%@；尺码：%@",[data objectForKey:@"specifi_one"],[data objectForKey:@"specifi_two"]];
        }else{
            color = [NSString stringWithFormat:@"颜色：%@",[data objectForKey:@"specifi_one"]];
            
        }
       
        
        
        
    }else{
        if (![Tools isBlankString:[data objectForKey:@"specifi_two"]]) {
            color = [NSString stringWithFormat:@"尺码：%@",[data objectForKey:@"specifi_two"]];
        }else{
            color = @"";
            
        }

        
    }
    
    self.colorLabel.text = color;
    self.colorLabel.size = [self.colorLabel.text sizeWithFont:[UIFont systemFontOfSize:12] maxSize:MAXSIZE];
    self.colorLabel.x = self.goodName.x;
    self.colorLabel.y = CGRectGetMaxY(self.goodName.frame) + 5;
    
    self.priceLabel.text = [NSString stringWithFormat:@"¥：%@",[data objectForKey:@"price"]] ;
    self.priceLabel.size = [self.priceLabel.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:MAXSIZE];
    self.priceLabel.x = mainScreenWidth - 15 - self.priceLabel.width;
    self.priceLabel.y = 15;
    
    
    _marketLabel.text = [NSString stringWithFormat:@"¥：%@",[data objectForKey:@"price_market"]] ;
    
    _marketLabel.size = [_marketLabel.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:MAXSIZE];
    
    _marketLabel.x = mainScreenWidth - 15 - _marketLabel.width;
 
    _marketLabel.y = CGRectGetMaxY(_priceLabel.frame) + 5;
    
    UILabel *divi = [[UILabel alloc ] init];
    divi.width = _marketLabel.width;
    divi.height = 0.5;
    divi.x = 0;
    divi.y = _marketLabel.height * 0.5 -divi.height * 0.5;
    divi.backgroundColor = GRAYETEXTCOLOR;
    
    [_marketLabel addSubview:divi];

    self.deleteBtn.x = mainScreenWidth - _deleteBtn.width - 15;
    self.deleteBtn.y = CGRectGetMaxY(self.goodView.frame) + 15;
    self.payforBtn.hidden = YES;
    if (_idx == 0) {
        
        self.typeLabel.text = @"待付款";
        self.payforBtn.hidden = NO;
        
        self.payforBtn.x = mainScreenWidth - _payforBtn.width - 15;
        self.payforBtn.y = CGRectGetMaxY(self.goodView.frame) + 15;
        
        self.deleteBtn.x = _payforBtn.x  - _deleteBtn.width - 15 ;
        self.deleteBtn.y = CGRectGetMaxY(self.goodView.frame) + 15;
        
    }else if (_idx == 1) {
        
        self.typeLabel.text = @"待发货";
        
    }else if (_idx == 2) {
        
        self.typeLabel.text = @"已发货";
        
    }else if (_idx == 3) {
        
        self.typeLabel.text = @"已完成 ";
        
    }else if (_idx == 4) {
        
        self.typeLabel.text = @"已关闭";
        
    }

    self.typeLabel.size = [self.typeLabel.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:MAXSIZE];
    self.typeLabel.x = mainScreenWidth - self.typeLabel.width - 15;
    self.typeLabel.y = 25 - self.typeLabel.height * 0.5;
    
}

- (void)deleteBtnClick:(UIButton *)sender{
    
    if ([self.del respondsToSelector:@selector(deleteBtnClick:)]) {
        
        [self.del deleteBtnClick:sender];
    }
    
}

- (void)payforOrder:(UIButton *)sender{
    if ([self.del respondsToSelector:@selector(payForBtnClick:)]) {
        
        [self.del payForBtnClick:sender];
    }
    
}

- (UIView *)headerView{
    
    if (!_headerView) {
        
        UIView *headerView = [[ UIView alloc] init];
        headerView.x = 0;
        headerView.width = mainScreenWidth;
        headerView.height = 50;
        headerView.y = 0;
        
        headerView.backgroundColor = [UIColor whiteColor];
        _headerView = headerView;
        
        
    }
    
    return _headerView;
}

- (UIView *)goodView{
    
    if (!_goodView) {
        
        UIView *headerView = [[ UIView alloc] init];
        headerView.x = 0;
        headerView.width = mainScreenWidth;
        headerView.height = 120;
        headerView.y = CGRectGetMaxY(self.headerView.frame);
        
        headerView.backgroundColor = DCBGColor;
        _goodView = headerView;

        
    }
    
    return _goodView;
}

- (UIView *)bottomView{
    
    if (!_bottomView) {
        
        UIView *headerView = [[ UIView alloc] init];
        headerView.x = 0;
        headerView.width = mainScreenWidth;
        headerView.height = 50;
        headerView.y = CGRectGetMaxY(self.goodView.frame);
        
        headerView.backgroundColor = [UIColor whiteColor];
        _bottomView = headerView;
        
        
    }
    
    return _bottomView;
}
- (UIImageView *)iconView{
    
    if (!_iconView) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.x = 15;
        iconView.y = 10;
        iconView.size = CGSizeMake(50, 50);
        
        _iconView = iconView;
        
        
        
        
    }
    
    return _iconView;
}

- (UILabel *)goodName{
    
    if (!_goodName) {
        
        UILabel *goodName = [[UILabel alloc] init];
        goodName.textColor = [UIColor blackColor];
        goodName.font = [UIFont systemFontOfSize:14];
        goodName.x = CGRectGetMaxX(self.iconView.frame) + 5;
        goodName.width = 200;
        goodName.height = 40;
        goodName.numberOfLines = 2;
        goodName.y = self.iconView.y;
        _goodName = goodName;
    }
    
    return _goodName;
}
- (UILabel *)typeLabel{
    
    if (!_typeLabel) {
        
        UILabel *goodName = [[UILabel alloc] init];
        goodName.textColor = [UIColor redColor];
        goodName.font = [UIFont systemFontOfSize:14];
      
        _typeLabel = goodName;
    }
    
    return _typeLabel;
}

- (UILabel *)colorLabel{
    
    if (!_colorLabel) {
        
        UILabel *goodName = [[UILabel alloc] init];
        goodName.textColor = GRAYETEXTCOLOR;
        goodName.font = [UIFont systemFontOfSize:12];
        
        _colorLabel = goodName;

        
    }
    
    return _colorLabel;
}

- (UILabel *)sizeLabel{
    
    if (!_sizeLabel) {
        UILabel *goodName = [[UILabel alloc] init];
        goodName.textColor = GRAYETEXTCOLOR;
        goodName.font = [UIFont systemFontOfSize:12];
        
        _sizeLabel = goodName;
        
    }
    
    return _sizeLabel;
}
- (UILabel *)priceLabel{
    
    if (!_priceLabel) {
        
        UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor =  [UIColor blackColor];
        priceLabel.font = [UIFont systemFontOfSize:12];
        _priceLabel = priceLabel;
    }
    
    return _priceLabel;
}

- (UILabel *)marketLabel{
    
    if (!_marketLabel) {
        
        UILabel *priceLabel = [[UILabel alloc] init];
        priceLabel.textColor = GRAYETEXTCOLOR;
        priceLabel.font = [UIFont systemFontOfSize:12];
        _marketLabel = priceLabel;

        
    }
    
    return _marketLabel;
}

- (UIButton *)deleteBtn{
    
    if (!_deleteBtn) {
        
        UIButton *canceBtn = [[UIButton alloc] init];
        [canceBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [canceBtn setTitleColor:GRAYETEXTCOLOR forState:UIControlStateNormal];
        canceBtn.size = CGSizeMake(67.5, 25);
        canceBtn.layer.masksToBounds = YES;
        canceBtn.layer.cornerRadius = 5;
        canceBtn.layer.borderColor = [UIcolortool colorWithHexString:@"#acacac"].CGColor;
        canceBtn.layer.borderWidth = 0.5;
        canceBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [canceBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn = canceBtn;
        
    }
    
    return _deleteBtn;
}
- (UIButton *)payforBtn{
    
    if (!_payforBtn) {
        
        UIButton *canceBtn = [[UIButton alloc] init];
        [canceBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [canceBtn setTitleColor:[UIcolortool colorWithHexString:@"#ff6137"] forState:UIControlStateNormal];
        canceBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        canceBtn.size = CGSizeMake(67.5, 25);
        canceBtn.layer.masksToBounds = YES;
        canceBtn.layer.cornerRadius = 5;
        canceBtn.layer.borderColor = [UIcolortool colorWithHexString:@"#ff6137"].CGColor;
        canceBtn.layer.borderWidth = 0.5;
        [canceBtn addTarget:self action:@selector(payforOrder:) forControlEvents:UIControlEventTouchUpInside];
        _payforBtn = canceBtn;
        
    }
    
    return _payforBtn;
}


@end
