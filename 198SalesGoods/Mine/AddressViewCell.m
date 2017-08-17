
    //
//  AddressViewCell.m
//  198SalesGoods
//
//  Created by BST on 2017/8/17.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "AddressViewCell.h"

@interface AddressViewCell ()


/** userLabel  */
@property(strong,nonatomic) UILabel *userName;

/** mobile  */
@property(strong,nonatomic) UILabel *mobileLabel;

/** adree  */
@property(strong,nonatomic) UILabel *addressLabel;





@end
@implementation AddressViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableview{
    
    static NSString *ID = @"AddressViewCell";
    AddressViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[AddressViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
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
        
        
        [self addSubview:self.userName];
        [self addSubview:self.mobileLabel];
        [self addSubview:self.addressLabel];
        
        [self addSubview:self.editBtn];
        [self addSubview:self.deleteBtn];
      
    }
    
    return self;
}

- (void)setData:(NSDictionary *)data{
    
    _data = data;
    _userName.text = [data objectForKey:@"name"];
    _userName.size = [_userName.text sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:15] maxSize:MAXSIZE];
    _userName.y = 15;
    
    _mobileLabel.text = [data objectForKey:@"tel"];
    _mobileLabel.size = [_mobileLabel.text sizeWithFont:[UIFont systemFontOfSize:13] maxSize:MAXSIZE];
    
    _mobileLabel.x = mainScreenWidth - 30 - _mobileLabel.width;
    _mobileLabel.y = 20;
    
    
    _addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",data[@"sheng"],data[@"shi"],data[@"address"]];
    
    _addressLabel.height = 50;
    _addressLabel.width = mainScreenWidth - 100;
    _addressLabel.x = _userName.x;
    _addressLabel.y = CGRectGetMaxY(self.userName.frame) + 10;
    
    _addressLabel.numberOfLines = 2;
    
    
}
- (void)deleteClick:(UIButton *)sender{
    
    [self.delegate deleteAddress:sender];
    
}
- (void)editClick:(UIButton *)sender{
    [self.delegate editAddress:sender];
    
}
- (UILabel *)userName{
    
    if (!_userName) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.textColor = [UIColor blackColor];
        userName.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        userName.x = 15;
        
        _userName = userName;
    }
    
    return _userName;
}
- (UILabel *)mobileLabel{
    
    if (!_mobileLabel) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.textColor = [UIColor blackColor];
        userName.font = [UIFont systemFontOfSize:13];
        
        
        _mobileLabel = userName;
    }
    
    return _mobileLabel;
}

- (UILabel *)addressLabel{
    
    if (!_addressLabel) {
        
        
        UILabel *addressLabel = [[UILabel alloc] init];
        addressLabel.font = [UIFont systemFontOfSize:12];
        addressLabel.textColor = GRAYETEXTCOLOR;
        
        _addressLabel = addressLabel;
    }
    return _addressLabel;
}

- (UIButton *)editBtn{
    
    if (!_editBtn) {
        
        UIButton *editBtn = [[UIButton alloc] init];
        [editBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        [editBtn setTitle:@"修改" forState:UIControlStateNormal];
        [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        editBtn.size = CGSizeMake(45, 20);
        editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        editBtn.y = 100 -  10 - editBtn.height;
        editBtn.x = mainScreenWidth - 15 - 90 - 10;
        [editBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
        _editBtn = editBtn;
    }
    
    return _editBtn;
}
- (UIButton *)deleteBtn{
    
    if (!_deleteBtn) {
        
        UIButton *editBtn = [[UIButton alloc] init];
        [editBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [editBtn setTitle:@"删除" forState:UIControlStateNormal];
        [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        editBtn.size = CGSizeMake(45, 20);
        editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        editBtn.x = mainScreenWidth - 15 - editBtn.width;
        editBtn.y = 100 -  10 - editBtn.height;
        [editBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn = editBtn;
    }
    
    return _deleteBtn;
}

@end
