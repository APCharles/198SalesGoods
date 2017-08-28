//
//  RegisterViewController.m
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "RegisterViewController.h"
#import "MBProgressHUD.h"
#import "ResModel.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"注册"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = LIGHTWHITE;
    UIButton*leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [leftButton setImage:[UIImage imageNamed:@"icon_fanhui"]forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(onClickBack)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem= leftItem;
    
    UIButton*rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,30,30)];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(onClickDone)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
    [self inStallController];
}

#pragma mark 完成注册
-(void)onClickDone{
    [_mobileTextField resignFirstResponder];
    [_verifyTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_nameTextField  resignFirstResponder];
    [_addressTextField resignFirstResponder];
    [_pidTextField resignFirstResponder];
    
    if ([self checkText]) {
        NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
        [paramDic setObject:_mobileTextField.text forKey:@"mobile"];
        [paramDic setObject:_passwordTextField.text forKey:@"password"];
        [paramDic setObject:_verifyTextField.text forKey:@"verify_code"];
        if (_addressTextField.text.length) {
            [paramDic setObject:_addressTextField.text forKey:@"address"];
        }
        [paramDic setObject:_pidTextField.text.length?_pidTextField.text:@"0" forKey:@"pid"];
        [paramDic setObject:_nameTextField.text forKey:@"name"];
        [paramDic setObject:@"1" forKey:@"ios"];
        __weak typeof(self)weakSelf = self;
         NetService *netService = [[NetService alloc] init];
        [netService serviceWithPostURL:[NSString stringWithFormat:@"%@Member/registr_ios",API_URL] params:paramDic success:^(id responseObject) {
            ResModel *resModel = [ResModel objectWithKeyValues:responseObject];
            if (resModel.success.intValue == 1) {
                [weakSelf showSynProgressHUDString:resModel.message time:1 completion:^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
            }else{
                [weakSelf showProgressHUDString:resModel.message];
            }
        } failure:^(NSError *error) {
            [weakSelf showProgressHUDString:@"服务器数据异常"];
        }];
    }
}

-(BOOL)checkText{
    BOOL result = YES;
    NSString *msg = @"";
    if (_mobileTextField.text.length == 0) {
        msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"请输入手机号"];
    }
    if (_mobileTextField.text.length) {
        if (![[_mobileTextField.text substringWithRange:NSMakeRange(0,1)] isEqualToString:@"1"]) {
            msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"手机号码输入不正确,请重新输入"];
        }
    }
    if (_mobileTextField.text.length != 11) {
        msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"手机号码输入不正确,请重新输入"];
    }
    if (!_verifyTextField.text.length) {
        msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"请输入验证码"];
    }
    if (!_passwordTextField.text.length) {
        msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"请设置密码"];
    }
    if (_passwordTextField.text.length<6) {
        msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"输入密码不能少于6位字符"];
    }
    if (_passwordTextField.text.length>20) {
        msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"输入密码不能多于20位字符"];
    }
    if (!_nameTextField.text.length) {
        msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"请设置用户名"];
    }
    if (msg.length > 0) {
        [self showProgressHUDString:msg];
        result = NO;
    }
    return result;
}

-(void)inStallController{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, StateNaviBarHeight, mainScreenWidth, mainScreenHeight-StateNaviBarHeight)];
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mainScrollView];
    
    _mobileView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, mainScreenWidth-20, 55)];
    _mobileView.backgroundColor = [UIColor whiteColor];
    _mobileView.layer.cornerRadius = 3;
    _mobileView.layer.masksToBounds = YES;
    _mobileView.layer.borderWidth = 0.5;
    _mobileView.layer.borderColor = [[UIcolortool colorWithHexString:@"e4e4e4"]CGColor];
    [_mainScrollView addSubview:_mobileView];
    _mobileTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, _mobileView.width-20, _mobileView.height)];
    _mobileTextField.font = [UIFont systemFontOfSize:15];
    _mobileTextField.placeholder = @"请输入手机号码";
    _mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_mobileTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    _mobileTextField.delegate = self;
    [_mobileView addSubview:_mobileTextField];
    
    _verifyView = [[UIView alloc]initWithFrame:CGRectMake(10, _mobileView.y+_mobileView.height+10, mainScreenWidth-20, 55)];
    _verifyView.backgroundColor = [UIColor whiteColor];
    _verifyView.layer.cornerRadius = 3;
    _verifyView.layer.masksToBounds = YES;
    _verifyView.layer.borderWidth = 0.5;
    _verifyView.layer.borderColor = [[UIcolortool colorWithHexString:@"e4e4e4"]CGColor];
    [_mainScrollView addSubview:_verifyView];
    _verifyBtn = [[UIButton alloc]initWithFrame:CGRectMake(_verifyView.width-80, 0, 80, _verifyView.height)];
    [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verifyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_verifyBtn setTitleColor:[UIcolortool colorWithHexString:@"e21111"] forState:UIControlStateNormal];
    [_verifyBtn addTarget:self action:@selector(onClickGetCode) forControlEvents:UIControlEventTouchUpInside];
    [_verifyView addSubview:_verifyBtn];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(_verifyBtn.x-0.5, 0, 0.5, _verifyBtn.height)];
    line.backgroundColor = [UIcolortool colorWithHexString:@"e4e4e4"];
    [_verifyView addSubview:line];
    _verifyTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, _verifyBtn.x-10, _mobileView.height)];
    _verifyTextField.font = [UIFont systemFontOfSize:15];
    _verifyTextField.placeholder = @"请输入验证码";
    _verifyTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_verifyTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    _verifyTextField.delegate = self;
    [_verifyView addSubview:_verifyTextField];
    
    _passwordView = [[UIView alloc]initWithFrame:CGRectMake(10, _verifyView.y+_verifyView.height+10, mainScreenWidth-20, 55)];
    _passwordView.backgroundColor = [UIColor whiteColor];
    _passwordView.layer.cornerRadius = 3;
    _passwordView.layer.masksToBounds = YES;
    _passwordView.layer.borderWidth = 0.5;
    _passwordView.layer.borderColor = [[UIcolortool colorWithHexString:@"e4e4e4"]CGColor];
    [_mainScrollView addSubview:_passwordView];
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, _passwordView.width-20, _passwordView.height)];
    _passwordTextField.font = [UIFont systemFontOfSize:15];
    _passwordTextField.placeholder = @"请设置密码";
    _passwordTextField.returnKeyType = UIReturnKeyDone;
    [_passwordTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_passwordTextField setSecureTextEntry:YES];
    _passwordTextField.delegate = self;
    [_passwordView addSubview:_passwordTextField];
    
    _nameView = [[UIView alloc]initWithFrame:CGRectMake(10, _passwordView.y+_passwordView.height+10, mainScreenWidth-20, 55)];
    _nameView.backgroundColor = [UIColor whiteColor];
    _nameView.layer.cornerRadius = 3;
    _nameView.layer.masksToBounds = YES;
    _nameView.layer.borderWidth = 0.5;
    _nameView.layer.borderColor = [[UIcolortool colorWithHexString:@"e4e4e4"]CGColor];
    [_mainScrollView addSubview:_nameView];
    _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, _nameView.width-20, _nameView.height)];
    _nameTextField.font = [UIFont systemFontOfSize:15];
    _nameTextField.placeholder = @"请设置昵称";
    _nameTextField.returnKeyType = UIReturnKeyDone;
    [_nameTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    _nameTextField.delegate = self;
    [_nameView addSubview:_nameTextField];

    _addressView = [[UIView alloc]initWithFrame:CGRectMake(10, _nameView.y+_nameView.height+10, mainScreenWidth-20, 55)];
    _addressView.backgroundColor = [UIColor whiteColor];
    _addressView.layer.cornerRadius = 3;
    _addressView.layer.masksToBounds = YES;
    _addressView.layer.borderWidth = 0.5;
    _addressView.layer.borderColor = [[UIcolortool colorWithHexString:@"e4e4e4"]CGColor];
    [_mainScrollView addSubview:_addressView];
    _addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, _addressView.width-20, _addressView.height)];
    _addressTextField.font = [UIFont systemFontOfSize:15];
    _addressTextField.placeholder = @"请输入地址（非必填）";
    _addressTextField.returnKeyType = UIReturnKeyDone;
    [_addressTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    _addressTextField.delegate = self;
    [_addressView addSubview:_addressTextField];
    
    _pidView = [[UIView alloc]initWithFrame:CGRectMake(10, _addressView.y+_addressView.height+10, mainScreenWidth-20, 55)];
    _pidView.backgroundColor = [UIColor whiteColor];
    _pidView.layer.cornerRadius = 3;
    _pidView.layer.masksToBounds = YES;
    _pidView.layer.borderWidth = 0.5;
    _pidView.layer.borderColor = [[UIcolortool colorWithHexString:@"e4e4e4"]CGColor];
    [_mainScrollView addSubview:_pidView];
    _pidTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, _pidView.width-20, _pidView.height)];
    _pidTextField.font = [UIFont systemFontOfSize:15];
    _pidTextField.placeholder = @"请输入推荐码（非必填）";
    _pidTextField.returnKeyType = UIReturnKeyDone;
    [_pidTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    _pidTextField.delegate = self;
    [_pidView addSubview:_pidTextField];
    
    _mainScrollView.contentSize = CGSizeMake(0, _pidView.y+_pidView.height+20);
}

#pragma mark 获取验证码
-(void)onClickGetCode{
    [_mobileTextField resignFirstResponder];
    [_verifyTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_nameTextField  resignFirstResponder];
    [_addressTextField resignFirstResponder];
    [_pidTextField resignFirstResponder];
    
    if ([self checkMobile]) {
        NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
        [paramDic setObject:_mobileTextField.text forKey:@"mobile"];
        __weak typeof(self)weakSelf = self;
         NetService *netService = [[NetService alloc] init];
        [netService serviceWithPostURL:[NSString stringWithFormat:@"%@Member/send_juhesms",API_URL] params:paramDic success:^(id responseObject) {
            if (!timer) {
                _verifyBtn.userInteractionEnabled = NO;
                timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loadtime) userInfo:nil repeats:YES];
                _totalTime = 61;
            }
        } failure:^(NSError *error) {
            [weakSelf releaseTimer];
            [weakSelf showProgressHUDString:@"服务器数据异常"];
        }];
    }
}

-(void)loadtime{
    _totalTime = _totalTime-1;
    if (_totalTime == 0) {
        [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self releaseTimer];
        _verifyBtn.userInteractionEnabled = YES;
        return;
    }
    NSString *time = [NSString stringWithFormat:@"%d秒",_totalTime];
    [_verifyBtn setTitle:time forState:UIControlStateNormal];
}

-(void)releaseTimer{
    if (timer) {
        [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _verifyBtn.userInteractionEnabled = YES;
        [timer invalidate];
        timer = nil;
    }
}

-(BOOL)checkMobile{
    BOOL result = YES;
    NSString *msg = @"";
    if (_mobileTextField.text.length == 0) {
        msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"请输入手机号"];
    }
    if (_mobileTextField.text.length) {
        if (![[_mobileTextField.text substringWithRange:NSMakeRange(0,1)] isEqualToString:@"1"]) {
            msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"手机号码输入不正确,请重新输入"];
        }
    }
    if (_mobileTextField.text.length != 11) {
        msg = (msg.length > 0) ? msg : [msg stringByAppendingString:@"手机号码输入不正确,请重新输入"];
    }
    if (msg.length > 0) {
        [self showProgressHUDString:msg];
        result = NO;
    }
    return result;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_mobileTextField resignFirstResponder];
    [_verifyTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_nameTextField  resignFirstResponder];
    [_addressTextField resignFirstResponder];
    [_pidTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_mobileTextField resignFirstResponder];
    [_verifyTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_nameTextField  resignFirstResponder];
    [_addressTextField resignFirstResponder];
    [_pidTextField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [_mainScrollView setContentOffset:CGPointMake(0,0) animated:YES];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == _mobileTextField) {
        [_mainScrollView setContentOffset:CGPointMake(0,_mobileView.y-10) animated:YES];
    }
    if (textField == _verifyTextField) {
        [_mainScrollView setContentOffset:CGPointMake(0,_verifyView.y-10) animated:YES];
    }
    if (textField == _passwordTextField) {
        [_mainScrollView setContentOffset:CGPointMake(0,_passwordTextField.y-10) animated:YES];
    }
    if (textField == _nameTextField) {
        [_mainScrollView setContentOffset:CGPointMake(0,_nameView.y-10) animated:YES];
    }
    if (textField == _addressTextField) {
        [_mainScrollView setContentOffset:CGPointMake(0,_addressView.y-10) animated:YES];
    }
    if (textField == _pidTextField) {
        [_mainScrollView setContentOffset:CGPointMake(0,_pidView.y-10) animated:YES];
    }
    return YES;
}

#pragma mark 返回
-(void)onClickBack{
    [self.navigationController popViewControllerAnimated:YES];
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

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self releaseTimer];
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
