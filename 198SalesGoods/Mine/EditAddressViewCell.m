//
//  EditAddressViewCell.m
//  198SalesGoods
//
//  Created by BST on 2017/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "EditAddressViewCell.h"

@interface EditAddressViewCell ()

/** icONview  */
@property(strong,nonatomic) UIImageView *iconView;




@end
@implementation EditAddressViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableview{
    
    static NSString *ID = @"EditAddressViewCell";
    EditAddressViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[EditAddressViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
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
        [self addSubview:self.filed];
        [self addSubview:self.addressLabel];
    }
    
    return self;
}

- (void)setData:(NSDictionary *)data{
    
    _data = data;
    self.iconView.image = [UIImage imageNamed:[data objectForKey:@"image"]];
    if ([Tools isBlankString:[data objectForKey:@"plaeHolder"]]) {
        
        self.addressLabel.hidden = NO;
        self.filed.hidden = YES;
    }else{
        self.addressLabel.hidden = YES;
        self.filed.hidden = NO;
        self.filed.placeholder = [data objectForKey:@"plaeHolder"];
        
        self.filed.height = [self.filed.placeholder sizeWithFont:[UIFont systemFontOfSize:14] maxSize:MAXSIZE].height;
        self.filed.x = CGRectGetMaxX(self.iconView.frame) + 10;
        self.filed.width = 250;
        self.filed.y = 25 - self.filed.height * 0.5;
            //设置颜色要先设置文字
        [self.filed setValue:GRAYETEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
        
    }
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


- (UITextField *)filed{
    
    if (!_filed) {
        
        UITextField *filed = [[UITextField alloc] init];
        filed.font = [UIFont systemFontOfSize:14];
        filed.textColor = [UIColor blackColor];
        
        _filed = filed;
    }
    
    return _filed;
}


- (UILabel *)addressLabel{
    
    if (!_addressLabel) {
        
        UILabel *addressLabel = [[UILabel alloc ] init];
        addressLabel.font = [UIFont systemFontOfSize:14];
        addressLabel.textColor = GRAYETEXTCOLOR;
        addressLabel.text = @"请选择地址";
        addressLabel.height = [addressLabel.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:MAXSIZE].height;
        addressLabel.width = 250;
        addressLabel.x = CGRectGetMaxX(self.iconView.frame) + 10;
        addressLabel.y = 25 - addressLabel.height * 0.5;
        _addressLabel = addressLabel;
    }
    
    return _addressLabel;
}
@end
