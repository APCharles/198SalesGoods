//
//  VerifyView.m
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/31.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "VerifyView.h"

@implementation VerifyView

@synthesize onClickGetCodeCallBack = _onClickGetCodeCallBack;
@synthesize onClickDoneCallBack = _onClickDoneCallBack;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self loadVerifyView];
    }
    return self;
}

-(void)loadVerifyView{
    _mobileView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, self.width-20, 50)];
    _mobileView.backgroundColor = [UIColor whiteColor];
    _mobileView.layer.borderWidth = 0.5;
    _mobileView.layer.borderColor = [[UIcolortool colorWithHexString:@"e4e4e4"]CGColor];
    _mobileView.layer.cornerRadius = 3;
    _mobileView.layer.masksToBounds = YES;
    [self addSubview:_mobileView];
    
    _mobileTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, _mobileView.width-20, _mobileView.height)];
    _mobileTextField.font = [UIFont systemFontOfSize:15];
    _mobileTextField.placeholder = @"请输入手机号码";
    _mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_mobileTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    _mobileTextField.delegate = self;
    [_mobileView addSubview:_mobileTextField];
    
    _codeView = [[UIView alloc]initWithFrame:CGRectMake(10, _mobileView.y+_mobileView.height+5, _mobileView.width, _mobileView.height)];
    _codeView.backgroundColor = [UIColor whiteColor];
    _codeView.layer.borderWidth = 0.5;
    _codeView.layer.borderColor = [[UIcolortool colorWithHexString:@"e4e4e4"]CGColor];
    _codeView.layer.cornerRadius = 3;
    _codeView.layer.masksToBounds = YES;
    [self addSubview:_codeView];
    
    _getCodeBtn = [[UIButton alloc]initWithFrame:CGRectMake(_codeView.width-_codeView.height-20, 0, _codeView.height+20, _codeView.height)];
    [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_getCodeBtn setTitleColor:[UIcolortool colorWithHexString:@"e21111"] forState:UIControlStateNormal];
    [_getCodeBtn addTarget:self action:@selector(onClickGetCode) forControlEvents:UIControlEventTouchUpInside];
    [_codeView addSubview:_getCodeBtn];
    
    _codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, _getCodeBtn.x-10-10, _codeView.height)];
    _codeTextField.font = [UIFont systemFontOfSize:15];
    _codeTextField.placeholder = @"请输入验证码";
    _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_codeTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    _codeTextField.delegate = self;
    [_codeView addSubview:_codeTextField];
    
    _doneBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, _codeView.y+_codeView.height+5, self.width-20, 45)];
    _doneBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_doneBtn setTitle:@"提交" forState:UIControlStateNormal];
    _doneBtn.backgroundColor = [UIcolortool colorWithHexString:@"e21111"];
    _doneBtn.layer.cornerRadius = 3;
    _doneBtn.layer.masksToBounds = YES;
    [_doneBtn addTarget:self action:@selector(onClickDone) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_doneBtn];
    
    self.height = _doneBtn.y+_doneBtn.height+10;
}

-(void)onClickGetCode{
    [_mobileTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    if (_onClickGetCodeCallBack) {
        _onClickGetCodeCallBack(_mobileTextField.text);
    }
}

-(void)onClickDone{
    [_mobileTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    if (_onClickDoneCallBack) {
        _onClickDoneCallBack(_mobileTextField.text,_codeTextField.text);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_mobileTextField resignFirstResponder];
    [_codeTextField resignFirstResponder];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
