//
//  GoodsShowCell.m
//  198SalesGoods
//
//  Created by BST on 2017/8/10.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "GoodsShowCell.h"

@interface GoodsShowCell ()



@end
@implementation GoodsShowCell

+ (instancetype) cellWithTableView:(UITableView *)tableview{
    
    static NSString *ID = @"GoodsShowCell";
    GoodsShowCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[GoodsShowCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    if (self) {
        
        [self addSubview:self.iconView];
    }
    
    return self;
}


- (UIImageView *)iconView{
    if (!_iconView) {
        
        UIImageView *icon = [[UIImageView alloc] init];
        icon.size = CGSizeMake(mainScreenWidth  , 100);
        icon.y = 0;
        icon.x = 0;
        
        _iconView = icon;
    }
    
    return _iconView;
}

@end
