//
//  VerifyView.h
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/31.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyView : UIView<UITextFieldDelegate>
{
    UIView *_mobileView;
    
    UIView *_codeView;
    UIButton *_getCodeBtn;
    
    UIButton *_doneBtn;
    
}
@property(strong , nonatomic)void (^onClickGetCodeCallBack)(NSString *mobile);
@property(strong , nonatomic)void (^onClickDoneCallBack)(NSString *mobile,NSString *code);

@property (nonatomic , strong)UITextField *mobileTextField;
@property (nonatomic , strong)UITextField *codeTextField;

@end
