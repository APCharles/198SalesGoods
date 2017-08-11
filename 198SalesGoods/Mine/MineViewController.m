//
//  MineViewController.m
//  198SalesGoods
//
//  Created by BST on 2017/8/8.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()


/** topview  */
@property(strong,nonatomic) UIView *topView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
  
}


- (UIView *)topView{
    
    if (!_topView) {
        
        
        UIView *topView = [[UIView alloc] init];
        topView.x = 0;
        topView.y = -22;
        topView.width  = mainScreenWidth;
        topView.height = 250;
        _topView = topView;
    }
    
    return _topView;
}

@end
