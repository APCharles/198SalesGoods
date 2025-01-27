//
//  OrderHeaderView.m
//  198SalesGoods
//
//  Created by BST on 2017/8/18.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "OrderHeaderView.h"

@interface OrderHeaderView  ()

/**  UIView * _redLine ;  */
@property(strong,nonatomic)  UIView * redLine ;

@end
@implementation OrderHeaderView

-(void)setItems:(NSArray *)items
{
    _items = items;
    
        //先清空当前视图上的所有子视图
    for (UIView * view in self.subviews) {
        [view removeFromSuperview];
    }
    
        //添加按钮
    CGFloat itemWidth = mainScreenWidth/items.count;
    CGFloat itemHeight = self.frame.size.height-10;
    
    for (int i = 0; i< items.count;i++ ) {
        UIButton * buton = [[UIButton alloc]init];
        buton.frame = CGRectMake(i*itemWidth, 4, itemWidth, itemHeight);
        [buton setTitle:items[i] forState:UIControlStateNormal];
        [buton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [buton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [buton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        buton.titleLabel.font = [UIFont systemFontOfSize:14];
        buton.tag = 100+i;
        [self addSubview:buton];
        
        if (i == 0) {
            buton.selected = YES;
        }
    }
    
        //加红线
    _redLine = [[UIView alloc]init];
    _redLine.frame = CGRectMake(0, self.frame.size.height-2, itemWidth, 2);
    _redLine.backgroundColor = [UIColor redColor];
    [self addSubview:_redLine];
    
    UIImageView *dividlin = [[UIImageView alloc] init];
    dividlin.image = [UIImage imageNamed:@"img_line"];
    dividlin.x = 0;
    dividlin.y = self.frame.size.height-1;
    dividlin.width = mainScreenWidth;
    dividlin.height = 1;
    [self addSubview:dividlin];
    
}
-(void)buttonClick:(UIButton*)button
{
        //获取点击的是第几个button
    NSInteger index = button.tag - 100;
    [self setSelectAtIndex:index];
    
        //2、把事件传递出去
    if (self.itemClickAtIndex) {
        _itemClickAtIndex(index);
    }
}
-(void)setSelectAtIndex:(NSInteger)index
{
        //1、先调整自身的视图显示
    for (int i = 0; i < self.items.count; i++) {
        UIButton * bt = [self viewWithTag:i+100];
        
        if (bt.tag-100 == index) {
            bt.selected = YES;
            
        }else{
            bt.selected = NO;
        }
    }
        //调整红线的位置
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = _redLine.frame;
        rect.origin.x = index*rect.size.width;
        _redLine.frame = rect;
    }];
}


@end
