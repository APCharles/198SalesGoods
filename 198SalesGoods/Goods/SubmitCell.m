//
//  SubmitCell.m
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/9/1.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "SubmitCell.h"

@implementation SubmitCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SubmitCell" owner:self options:nil] lastObject];
    }
    return self;
}


-(void)loadCellWithData:(GoodsDetailInfoModel *)goodsDetailInfoModel{
    self.width = mainScreenWidth;
    self.contentView.width = mainScreenWidth;
    self.height = 100.0f;
    self.contentView.height = 100.0f;
    if (!_goodsImg) {
        _goodsImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.height-20, self.height-20)];
        _goodsImg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_goodsImg];
    }
    if (!_goodsName) {
        _goodsName = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImg.x+_goodsImg.width+5, _goodsImg.y, mainScreenWidth-10-_goodsImg.x+_goodsImg.width+5, _goodsImg.height/2)];
        _goodsName.font = [UIFont systemFontOfSize:14];
        _goodsName.textColor = [UIcolortool colorWithHexString:@"333333"];
        _goodsName.numberOfLines = 0;
        [self.contentView addSubview:_goodsName];
    }
    if (!_goodsSpec) {
        _goodsSpec = [[UILabel alloc]initWithFrame:CGRectMake(_goodsImg.x+_goodsImg.width+5, _goodsName.y+_goodsName.height, mainScreenWidth-10-_goodsImg.x+_goodsImg.width+5, 20)];
        _goodsSpec.font = [UIFont systemFontOfSize:14];
        _goodsSpec.textColor = [UIcolortool colorWithHexString:@"333333"];
        [self.contentView addSubview:_goodsSpec];
    }
    if (!_gooodsPrice) {
        _gooodsPrice = [[UILabel alloc]initWithFrame:CGRectMake(_goodsSpec.x, _goodsSpec.y+_goodsSpec.height, mainScreenWidth-10-_goodsSpec.x, 20)];
        _gooodsPrice.font = [UIFont systemFontOfSize:16];
        _gooodsPrice.textColor = [UIcolortool colorWithHexString:@"e21111"];
        _gooodsPrice.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_gooodsPrice];
    }
    
    [_goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APPIP,goodsDetailInfoModel.image]]];
    _goodsName.text = goodsDetailInfoModel.title;
    _goodsSpec.text = goodsDetailInfoModel.specifi.length?goodsDetailInfoModel.specifi:@"";
    _gooodsPrice.text = [NSString stringWithFormat:@"合计:￥%.2f",goodsDetailInfoModel.price.floatValue];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
