//
//  FindPassWordViewController.h
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindPassWordViewController : UIViewController<UITextFieldDelegate>
{
    UIScrollView *_mainScrollView;
    
    UIView *_mobileView;
    UITextField *_mobileTextField;
    
    UIView *_verifyView;
    UITextField *_verifyTextField;
    UIButton *_verifyBtn;
    
    UIView *_passwordView;
    UITextField *_passwordTextField;

    UIView *_passwordView1;
    UITextField *_passwordTextField1;
    
    NSTimer * timer;
    int _totalTime;
}
@end
