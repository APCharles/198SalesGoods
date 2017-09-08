
    //
//  CustomerViewCell.m
//  198SalesGoods
//
//  Created by BST on 2017/9/8.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "CustomerViewCell.h"
#import "Tools.h"
@interface CustomerViewCell ()
/** icon  */
@property(strong,nonatomic) UIImageView  *iconView;

/** title  */
@property(strong,nonatomic) UILabel *titleLale;

/** title  */
@property(strong,nonatomic) UILabel *martPLable;
/** title  */
@property(strong,nonatomic) UILabel *priceLable;

@property(strong,nonatomic) UILabel *numLable;
@end
@implementation CustomerViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableview{
    
    static NSString *ID = @"CustomerViewCell";
    CustomerViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[CustomerViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    if (self) {
        
        _topLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 0.5)];
        _topLineView.image = [UIImage imageNamed:@"img_line"];
            //[self.contentView addSubview:_topLineView];
        
        _bottomLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100-0.5, mainScreenWidth, 0.5)];
        _bottomLineView.image = [UIImage imageNamed:@"img_line"];
        [self.contentView addSubview:_bottomLineView];

        
        [self addSubview:self.iconView];
        [self addSubview:self.titleLale];
        [self addSubview:self.martPLable];
        [self addSubview:self.priceLable];
   
        [self addSubview:self.numLable];
        
    }
    
    return self;
}

- (void)setData:(NSDictionary *)data{
    
    _data = data;
    

    [self.iconView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data[@"headimgurl"]]]];
    
    self.titleLale.text = [NSString stringWithFormat:@"%@",data[@"name"]];
    self.titleLale.size = [self.titleLale.text sizeWithFont:[UIFont systemFontOfSize:13] maxSize:MAXSIZE];
    self.titleLale.x = CGRectGetMaxX(self.iconView.frame) + 15;
    self.titleLale.y = self.iconView.y;
    
    
    if (  [[NSString stringWithFormat:@"%@",data[@"cate"] ] isEqualToString:@"69"]) {
        
        self.priceLable.text = @"身份：会员";
    }else{
        self.priceLable.text = @"身份：游客";
        
    }
    
    
    
    self.priceLable.size = [self.priceLable.text sizeWithFont: [UIFont fontWithName:@"Helvetica-Bold" size:13] maxSize:MAXSIZE];
    self.priceLable.x =  self.titleLale.x;
    self.priceLable.y = CGRectGetMaxY(self.titleLale.frame) + 15;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[data[@"datetime"] integerValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];

    
    self.numLable.text = confromTimespStr;
  
    self.numLable.size = [self.numLable.text sizeWithFont:[UIFont systemFontOfSize:13] maxSize:MAXSIZE];
    self.numLable.x = CGRectGetMaxX(self.iconView.frame) + 5;
    self.numLable.y = CGRectGetMaxY(self.priceLable.frame) + 15;
    
       
 
    
    
}


- (UIImageView *)iconView{
    
    if (!_iconView) {
        
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.x = 25;
        iconView.y = 15;
        iconView.width = 60;
        iconView.height = 60;
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

@end
