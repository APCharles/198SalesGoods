//
//  FillPidViewController.m
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/16.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "FillPidViewController.h"

@interface FillPidViewController ()

@end

@implementation FillPidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"推荐码"];
    
    self.view.backgroundColor = LIGHTWHITE;
    
    UIButton*leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [leftButton setImage:[UIImage imageNamed:@"icon_fanhui"]forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(onClickBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;

    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setTitle:@"跳过" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(onClickStep)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    [self installController];
}

-(void)installController{
    _pidView = [[UIView alloc]initWithFrame:CGRectMake(10, StateNaviBarHeight+10, mainScreenWidth-20, 55)];
    _pidView.backgroundColor = [UIColor whiteColor];
    _pidView.layer.cornerRadius = 3;
    _pidView.layer.masksToBounds = YES;
    _pidView.layer.borderWidth = 0.5;
    _pidView.layer.borderColor = [[UIcolortool colorWithHexString:@"e4e4e4"]CGColor];
    [self.view addSubview:_pidView];
    _pidTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, _pidView.width-20, _pidView.height)];
    _pidTextField.font = [UIFont systemFontOfSize:15];
    _pidTextField.placeholder = @"请输入推荐码";
    _pidTextField.returnKeyType = UIReturnKeyDone;
    [_pidTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    _pidTextField.delegate = self;
    [_pidView addSubview:_pidTextField];
    
    UIButton *doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, _pidView.y+_pidView.height+30, mainScreenWidth-30, 45)];
    [doneBtn setTitle:@"提交" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIcolortool colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    doneBtn.backgroundColor = [UIcolortool colorWithHexString:@"e21111"];
    doneBtn.layer.cornerRadius = 5;
    doneBtn.layer.masksToBounds = YES;
    [doneBtn addTarget:self action:@selector(onClickDone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_pidTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_pidTextField resignFirstResponder];
    return YES;
}

-(void)onClickDone{
    [_pidTextField resignFirstResponder];
    if ([self checkText]) {
        NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
        [paramDic setObject:_pidTextField.text forKey:@"pid"];
        __weak typeof(self)weakSelf = self;
        [NetService serviceWithPostURL:[NSString stringWithFormat:@"%@Member/mypid",API_URL] params:paramDic success:^(id responseObject) {
            ResModel *resModel = [ResModel objectWithKeyValues:responseObject];
            if (resModel.success.intValue == 1) {
                [weakSelf showSynProgressHUDString:resModel.message time:1 completion:^{
                    weakSelf.userModel.user_info.pid = [NSNumber numberWithInt:_pidTextField.text.intValue];
                    [[NSUserDefaults standardUserDefaults]setObject:[weakSelf.userModel.user_info keyValues] forKey:kUserInfoModel];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
                }];
            }else{
                [weakSelf showProgressHUDString:resModel.message];
            }
        } failure:^(NSError *error) {
            
        }];
    }
}

-(BOOL)checkText{
    BOOL result = YES;
    NSString *msg = @"";
    if (_pidTextField.text.length == 0) {
        msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"请输入推荐码"];
    }
    if (msg.length > 0) {
        [self showProgressHUDString:msg];
        result = NO;
    }
    return result;
}

- (void)showProgressHUDString:(NSString *)content{
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    MBProgressHUD *mbProgressHUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    [mbProgressHUD setMode:MBProgressHUDModeText];
    [mbProgressHUD setLabelText:content];
    [mbProgressHUD hide:YES afterDelay:1];
    [self.view addSubview:mbProgressHUD];
}

- (void)showSynProgressHUDString:(NSString *)content time:(float)atime completion:(void (^)())completion{
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


-(void)onClickStep{
    [[NSUserDefaults standardUserDefaults]setObject:[self.userModel.user_info keyValues] forKey:kUserInfoModel];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)onClickBack{
    [[NSUserDefaults standardUserDefaults]setObject:[self.userModel.user_info keyValues] forKey:kUserInfoModel];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
