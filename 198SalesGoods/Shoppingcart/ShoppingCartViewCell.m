//
//  ShoppingCartViewCell.m
//  198SalesGoods
//
//  Created by BST on 2017/8/29.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "ShoppingCartViewCell.h"
#import "SmallButton.h"
#import "UIView+Additions.h"
#import "ShoppingCartViewController.h"
@interface ShoppingCartViewCell ()

/** icon  */
@property(strong,nonatomic) UIImageView  *iconView;

/** title  */
@property(strong,nonatomic) UILabel *titleLale;

/** title  */
@property(strong,nonatomic) UILabel *martPLable;
/** title  */
@property(strong,nonatomic) UILabel *priceLable;

@property(strong,nonatomic) UILabel *numLable;

/** 加按钮  */
@property(strong,nonatomic) SmallButton *jiaBtn;

/** 加按钮  */
@property(strong,nonatomic) SmallButton *jianBtn;


/**  商品数量  */
@property(assign,nonatomic) NSInteger num;

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
        
        [self addSubview:self.iconView];
        [self addSubview:self.titleLale];
        [self addSubview:self.martPLable];
        [self addSubview:self.priceLable];
        [self addSubview:self.jianBtn];
        [self addSubview:self.jiaBtn];
        [self addSubview:self.numLable];
        
    }
    
    return self;
}


- (void)setData:(NSDictionary *)data{
    
    _data = data;
    self.num = [data[@"num"] integerValue];

    [self.iconView sd_setImageWithURL:[NSURL URLWithString:data[@"img"]]];
    
    self.titleLale.text = data[@"name"];
    self.titleLale.size = [self.titleLale.text sizeWithFont:[UIFont systemFontOfSize:13] maxSize:MAXSIZE];
    self.titleLale.x = CGRectGetMaxX(self.iconView.frame) + 8;
    self.titleLale.y = self.iconView.y;
    
    
    self.priceLable.text = [NSString stringWithFormat:@"单价：¥%@",data[@"price"]] ;
    
    self.priceLable.size = [self.priceLable.text sizeWithFont: [UIFont fontWithName:@"Helvetica-Bold" size:13] maxSize:MAXSIZE];
    self.priceLable.x =  self.titleLale.x;
    self.priceLable.y = CGRectGetMaxY(self.titleLale.frame) + 20;
    
    
    self.jianBtn.x = CGRectGetMaxX(self.iconView.frame) + 30;
    self.jianBtn.y =  CGRectGetMaxY(self.priceLable.frame) + 20;
    
    self.numLable.text = [NSString stringWithFormat:@"%@",data[@"num"]];
    self.numLable.textAlignment = NSTextAlignmentCenter;
    
    self.numLable.x = CGRectGetMaxX(self.jianBtn.frame) + 5;
    self.numLable.y = self.jianBtn.y + self.jianBtn.height * 0.5 - self.numLable.height * 0.5;
    
    self.jiaBtn.x = CGRectGetMaxX(self.numLable.frame) + 5;
    self.jiaBtn.y =  self.jianBtn.y;
    
    
    self.martPLable.text = [NSString stringWithFormat:@"小记：¥%ld",[data[@"num"] integerValue] * [data[@"price"] integerValue]];
    self.martPLable.size = [self.priceLable.text sizeWithFont: [UIFont fontWithName:@"Helvetica-Bold" size:13] maxSize:MAXSIZE];
    self.martPLable.x =  mainScreenWidth - self.martPLable.width - 20;
    
    self.martPLable.y = CGRectGetMaxY(self.jiaBtn.frame) + 20;
   
    
}


- (void)jianBtnClick:(UIButton *)sender{
    
    if (self.num > 0) {
        sender.userInteractionEnabled = YES;
    }
   
    self.num --;
    
    ShoppingCartViewController *shop = (ShoppingCartViewController *)[self viewController];
    
   
    NSDictionary *dic = [[NSDictionary alloc] init];
    NetService *netService = [[NetService alloc] init];
    [netService serviceWithGetjsonURL:[NSString stringWithFormat:@"http://wx.dianpuj.com/index.php/Wap/Order/cart_num_ios/id/%@/type/2/num%ld",_data[@"id"],(long)self.num] params:dic success:^(id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            if (self.num == 0) {
                
                sender.userInteractionEnabled = NO;
            }
           
            self.numLable.text = [NSString stringWithFormat:@"%ld",(long)self.num];
             self.martPLable.text = [NSString stringWithFormat:@"小记：¥%ld",self.num * [_data[@"price"] integerValue]];
            
           
                
                [self.del jianClick:_data];
            
        
       }
        
    } failure:^(NSError *error) {
        
        
        
       [shop showProgressHUDString:@"服务器数据异常"];
        
    }];
    

    
}
- (void)jiaBtnClick:(UIButton *)sender{
    
    if (self.num > 0) {
        self.jianBtn.userInteractionEnabled = YES;
    }
    sender.userInteractionEnabled = YES;
    
    self.num ++;
    
    ShoppingCartViewController *shop = (ShoppingCartViewController *)[self viewController];
    
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    NetService *netService = [[NetService alloc] init];
    [netService serviceWithGetjsonURL:[NSString stringWithFormat:@"http://wx.dianpuj.com/index.php/Wap/Order/cart_num_ios/id/%@/type/1/num%ld",_data[@"id"],(long)self.num] params:dic success:^(id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
             self.numLable.text = [NSString stringWithFormat:@"%ld",(long)self.num];
             self.martPLable.text = [NSString stringWithFormat:@"小记：¥%ld",self.num * [_data[@"price"] integerValue]];
            
        
                
                [self.del jiaClick:_data];
            
        }
        
        
    } failure:^(NSError *error) {
        
        
        
        [shop showProgressHUDString:@"服务器数据异常"];
        
        
    }];

}
- (UIImageView *)iconView{
    
    if (!_iconView) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.x = 15;
        iconView.y = 10;
        iconView.width = 80;
        iconView.height = 80;
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
        userName.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
        userName.textColor = [UIColor redColor];
        
        
        _martPLable = userName;
    }
    
    return _martPLable;
}

- (UILabel *)priceLable{
    
    if (!_priceLable) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font =  [UIFont fontWithName:@"Helvetica-Bold" size:13];
        userName.textColor = [UIColor redColor];
        
        
        _priceLable = userName;
    }
    
    return _priceLable;
}

- (UILabel *)numLable{
    
    if (!_numLable) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:11];
        userName.textColor = BLACKTEXTCOLOR;
        userName.size = CGSizeMake(60, 40);
        userName.textAlignment = NSTextAlignmentCenter;
        
        _numLable = userName;

    }
    
    return _numLable;
}

- (SmallButton *)jiaBtn{
    
    if (!_jiaBtn) {
        
        
        SmallButton *jiaBtn = [[SmallButton alloc] init];
        [jiaBtn setBackgroundImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
        jiaBtn.size = CGSizeMake(24, 24);
        
        [jiaBtn addTarget:self action:@selector(jiaBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _jiaBtn = jiaBtn;
    }
    
    return _jiaBtn;
}
- (SmallButton *)jianBtn{
    
    if (!_jianBtn) {
        
        
        SmallButton *jiaBtn = [[SmallButton alloc] init];
        [jiaBtn setBackgroundImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
        jiaBtn.size = CGSizeMake(24, 24);
        
        [jiaBtn addTarget:self action:@selector(jianBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _jianBtn = jiaBtn;
    }
    
    return _jianBtn;
}

@end
