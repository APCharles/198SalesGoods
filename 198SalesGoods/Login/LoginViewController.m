//
//  LoginViewController.m
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/14.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "FindPassWordViewController.h"
#import "MBProgressHUD.h"
#import "UserModel.h"
#import "UMShareHelper.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"登录"];
    
    self.view.backgroundColor = LIGHTWHITE;
    
    UIButton*leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [leftButton setImage:[UIImage imageNamed:@"icon_fanhui"]forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(onClickBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setTitle:@"注册" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(onClickRegister)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    [self inStallController];
}

-(void)inStallController{
    UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(15, StateNaviBarHeight+15, mainScreenWidth-30, 110)];
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.layer.cornerRadius = 5;
    mainView.layer.masksToBounds = YES;
    mainView.layer.borderWidth = 0.5;
    mainView.layer.borderColor = [[UIcolortool colorWithHexString:@"e4e4e4"]CGColor];;
    [self.view addSubview:mainView];
    
    _mobileTextField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, mainView.width-30, mainView.height/2)];
    _mobileTextField.font = [UIFont systemFontOfSize:15];
    _mobileTextField.placeholder = @"请输入手机号码";
    _mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_mobileTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    _mobileTextField.delegate = self;
    [mainView addSubview:_mobileTextField];
    
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(15, mainView.height/2, mainView.width-30, mainView.height/2)];
    _passwordTextField.font = [UIFont systemFontOfSize:15];
    _passwordTextField.placeholder = @"请输入登录密码";
    _passwordTextField.returnKeyType = UIReturnKeyJoin;
    [_passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_passwordTextField setSecureTextEntry:YES];
    _passwordTextField.delegate = self;
    [mainView addSubview:_passwordTextField];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, mainView.height/2-0.5, mainView.width, 0.5)];
    line.backgroundColor = [UIcolortool colorWithHexString:@"e4e4e4"];
    [mainView addSubview:line];
    
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, mainView.y+mainView.height+30, mainScreenWidth-30, 45)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIcolortool colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    loginBtn.backgroundColor = [UIcolortool colorWithHexString:@"e21111"];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn addTarget:self action:@selector(onClickLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton *forgetBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth-100, loginBtn.y+loginBtn.height+15, 100, 30)];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIcolortool colorWithHexString:@"7e7e7e"] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [forgetBtn addTarget:self action:@selector(onClickForgetPassWord) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    UIImage *wechat = [UIImage imageNamed:@"login_wechat"];
    UIButton *wechatBtn = [[UIButton alloc]initWithFrame:CGRectMake((mainScreenWidth-wechat.size.width)/2, mainScreenHeight-20-wechat.size.height, wechat.size.width, wechat.size.height)];
    [wechatBtn setImage:wechat forState:UIControlStateNormal];
    [wechatBtn addTarget:self action:@selector(onClickWeChatLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wechatBtn];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_mobileTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _passwordTextField) {
        [self onClickLogin];
    }
    return YES;
}

#pragma mark 返回
-(void)onClickBack{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 注册
-(void)onClickRegister{
    NSLog(@"注册");
    RegisterViewController *registerViewController = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

#pragma mark 微信登录
-(void)onClickWeChatLogin{
    NSLog(@"微信登录");
    __weak typeof(self)weakSelf = self;
    [[UMShareHelper defaultUMShareHelper]applyByController:self snsAccountWithUMSocialSnsType:UMSocialPlatformType_WechatSession success:^(UMSocialUserInfoResponse *response) {
        [weakSelf showProgressHUDString:@"登录成功"];
    } failed:^(NSError *error) {
        [weakSelf showProgressHUDString:@"登录失败"];
    }];
}

#pragma mark 登录
-(void)onClickLogin{
    NSLog(@"登录");
    [_mobileTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    if ([self checkText]) {
        NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
        [paramDic setObject:_mobileTextField.text forKey:@"mobile"];
        [paramDic setObject:_passwordTextField.text forKey:@"password"];
        __weak typeof(self)weakSelf = self;
        [NetService serviceWithPostURL:[NSString stringWithFormat:@"%@Member/sigin_ios",API_URL] params:paramDic success:^(id responseObject) {
            UserModel *userModel = [UserModel objectWithKeyValues:responseObject];
            [weakSelf doDealWithUserModel:userModel];
        } failure:^(NSError *error) {
            
        }];
    }
}

-(BOOL)checkText{
    BOOL result = YES;
    NSString *msg = @"";
    if (_mobileTextField.text.length == 0) {
        msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"请输入用户名"];
    }
    if (_mobileTextField.text.length) {
        if (![[_mobileTextField.text substringWithRange:NSMakeRange(0,1)] isEqualToString:@"1"]) {
            msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"手机号码输入不正确,请重新输入"];
        }
    }
    if (_mobileTextField.text.length != 11) {
        msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"手机号码输入不正确,请重新输入"];
    }
    if (_passwordTextField.text.length == 0) {
        msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"请输入密码"];
    }
    if (msg.length > 0) {
        [self showProgressHUDString:msg];
        result = NO;
    }
    return result;
}

#pragma mark 忘记密码
-(void)onClickForgetPassWord{
    NSLog(@"忘记密码");
    FindPassWordViewController *findPassWordViewController = [[FindPassWordViewController alloc]init];
    [self.navigationController pushViewController:findPassWordViewController animated:YES];
}

-(void)doDealWithUserModel:(UserModel *)userModel{
    if (userModel.user_info.pid.intValue>0) {
        [[NSUserDefaults standardUserDefaults]setObject:[userModel.user_info keyValues] forKey:kUserInfoModel];
        [[NSUserDefaults standardUserDefaults]synchronize];
        __weak typeof(self)weakSelf = self;
        [self showSynProgressHUDString:userModel.res.message time:1 completion:^{
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
    }else{
        
    }
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
