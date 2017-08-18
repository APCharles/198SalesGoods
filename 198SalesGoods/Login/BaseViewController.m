//
//  BaseViewController.m
//  198SalesGoods
//
//  Created by BST on 2017/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

/** title  */
@property(strong,nonatomic) UILabel *titleLabel;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.view.backgroundColor = RGB(237, 237, 237);
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:self.navigationBarView];
    
    
   
}

- (void)resign:(UITapGestureRecognizer *)tap{
    
    [self.view endEditing:YES];
    
}
- (void)setBarName:(NSString *)barName{
    _titleLabel.text = barName;
    _titleLabel.size = [_titleLabel.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:MAXSIZE];
    _titleLabel.x = mainScreenWidth * 0.5 - _titleLabel.width * 0.5;
    _titleLabel.y = 32 - _titleLabel.height * 0.5 + 5;
    
}

#pragma mark - getter
- (UIView *)navigationBarView{
    
    if (!_navigationBarView) {
        
        
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = DCBGColor;
        topView.x = 0;
        topView.y = 0;
        topView.width  = mainScreenWidth;
        topView.height = 64;
        
        
        SmallButton *leftBtn = [[SmallButton alloc] init];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_fanhui"] forState:UIControlStateNormal];
        
        leftBtn.size = CGSizeMake(10, 19);
        leftBtn.x = 15;
        leftBtn.y = 32 - leftBtn.height * 0.5 + 8;
        [leftBtn addTarget:self action:@selector(back)forControlEvents:UIControlEventTouchUpInside];

        [topView addSubview:leftBtn];
        
        _leftBtn = leftBtn;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"我的地址";
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor blackColor];

        
        
        
        [topView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        _navigationBarView = topView;
    }
    
    return _navigationBarView;
}

- (void)showProgressHUDString:(NSString *)content{
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    MBProgressHUD *mbProgressHUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    [mbProgressHUD setMode:MBProgressHUDModeText];
    [mbProgressHUD setLabelText:content];
    [mbProgressHUD hide:YES afterDelay:1];
    [self.view addSubview:mbProgressHUD];
}

/**
 *	@brief	同步提示对话框
 *
 *	@param 	content 	提示内容
 *	@param 	atime 	对话框显示时间
 */
- (void)showSynProgressHUDString:(NSString *)content time:(float)atime completion:(void (^)())completion
{
    MBProgressHUD *mbProgressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [mbProgressHUD setMode:MBProgressHUDModeText];
    [mbProgressHUD setLabelText:content];
    [mbProgressHUD hide:YES afterDelay:atime];
    [self.view addSubview:mbProgressHUD];
    
    [mbProgressHUD setCompletionBlock:^{
        if (completion) {
            completion();
        }
    }];
}


- (void)back{
    
   [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
