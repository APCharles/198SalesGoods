//
//  ToolsCollectionViewCell.m
//  198SalesGoods
//
//  Created by BST on 2017/8/10.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "ToolsCollectionViewCell.h"

@interface ToolsCollectionViewCell ()

/** iconview  */
@property(strong,nonatomic) UIImageView *iconView;


/** title  */
@property(strong,nonatomic) UILabel *titleLabel;

@end
@implementation ToolsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.iconView];
        [self addSubview:self.titleLabel];
        
    }
    
    return self;
}
- (void)setData:(NSDictionary *)data{
    
    self.iconView.image = [UIImage imageNamed:[data objectForKey:@"image"]];
    
    self.titleLabel.text = [data objectForKey:@"title"];
    self.titleLabel.size = [self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:13] maxSize:MAXSIZE];
    self.titleLabel.y = CGRectGetMaxY(self.iconView.frame) + 4;
    self.titleLabel.x = mainScreenWidth /4 * 0.5 - self.titleLabel.width * 0.5;
    
    
}

- (UIImageView *)iconView{
    if (!_iconView) {
        
        UIImageView *icon = [[UIImageView alloc] init];
        icon.size = CGSizeMake(32, 32);
        icon.y = 10;
        icon.x = mainScreenWidth /4 * 0.5 - icon.width * 0.5;
        
        _iconView = icon;
    }
    
    return _iconView;
}

- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textColor = [UIColor blackColor];
        _titleLabel = titleLabel;
    }
    
    return _titleLabel;
    
    
}

@end
