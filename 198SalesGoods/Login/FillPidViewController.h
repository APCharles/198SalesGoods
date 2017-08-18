//
//  FillPidViewController.h
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/16.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "BaseViewController.h"
#import "UserModel.h"

@interface FillPidViewController : UIViewController<UITextFieldDelegate>
{
    UIView *_pidView;
    UITextField *_pidTextField;
}

@property (nonatomic , strong)UserModel *userModel;
@end
