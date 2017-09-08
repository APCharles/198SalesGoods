//
//  ScoreDetailViewCell.m
//  198SalesGoods
//
//  Created by BST on 2017/9/8.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "ScoreDetailViewCell.h"

@interface ScoreDetailViewCell ()
/** title  */
@property(strong,nonatomic) UILabel *titleLale;

/** title  */
@property(strong,nonatomic) UILabel *martPLable;
/** title  */
@property(strong,nonatomic) UILabel *priceLable;

@property(strong,nonatomic) UILabel *numLable;
@end
@implementation ScoreDetailViewCell

+ (instancetype) cellWithTableView:(UITableView *)tableview{
    
    static NSString *ID = @"ScoreDetailViewCell";
    ScoreDetailViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[ScoreDetailViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    if (self) {
        _bottomLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 70-0.5, mainScreenWidth, 0.5)];
        _bottomLineView.image = [UIImage imageNamed:@"img_line"];
        [self.contentView addSubview:_bottomLineView];
        [self addSubview:self.titleLale];
        [self addSubview:self.numLable];
        [self addSubview:self.priceLable];
    }
    
    return self;
}

- (void)setData:(NSDictionary *)data{
    
    _data = data;
    self.titleLale.text = data[@"event"];
    self.titleLale.size = [self.titleLale.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:MAXSIZE];
    self.titleLale.x = 15;
    self.titleLale.y = 15;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[data[@"datetime"] integerValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    self.priceLable.text = confromTimespStr ;
    
    self.priceLable.size = [self.priceLable.text sizeWithFont:[UIFont systemFontOfSize:12] maxSize:MAXSIZE];
    self.priceLable.x =  self.titleLale.x;
    self.priceLable.y = CGRectGetMaxY(self.titleLale.frame) + 10;
    
    
    NSString *score = data[@"score"];
    if ([score containsString:@"-"]) {
        self.numLable.text = [NSString stringWithFormat:@"%@",data[@"score"]];
    }else{
        self.numLable.text = [NSString stringWithFormat:@"+%@",data[@"score"]];
    }
    
   self.numLable.size = [self.numLable.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:MAXSIZE];
    
    self.numLable.x = mainScreenWidth - 15 - self.numLable.width;
    self.numLable.y =  35 - self.numLable.height * 0.5;
    
    
}
- (UILabel *)titleLale{
    
    if (!_titleLale) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:14];
        userName.textColor = BLACKTEXTCOLOR;
        
        
        _titleLale = userName;
    }
    
    return _titleLale;
}


- (UILabel *)priceLable{
    
    if (!_priceLable) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font =  [UIFont systemFontOfSize:12];
        userName.textColor = GRAYETEXTCOLOR;
        
        
        _priceLable = userName;
    }
    
    return _priceLable;
}

- (UILabel *)numLable{
    
    if (!_numLable) {
        
        UILabel *userName = [[UILabel alloc] init];
        userName.font = [UIFont systemFontOfSize:14];
        userName.textColor = BLACKTEXTCOLOR;
        userName.size = CGSizeMake(60, 40);
        userName.textAlignment = NSTextAlignmentCenter;
        
        _numLable = userName;
        
    }
    
    return _numLable;
}



@end
