//
//  FindPassWordViewController.m
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "FindPassWordViewController.h"

@interface FindPassWordViewController ()

@end

@implementation FindPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"找回密码"];
    self.view.backgroundColor = LIGHTWHITE;
    UIButton*leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [leftButton setImage:[UIImage imageNamed:@"icon_fanhui"]forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(onClickBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
}

#pragma mark 返回
-(void)onClickBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
