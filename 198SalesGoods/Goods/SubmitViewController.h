//
//  SubmitViewController.h
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/31.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "BaseViewController.h"
#import "SubmitModel.h"

typedef enum {
    SubmitTypeBuy,
    SubmitTypeGift,
}SubmitType;

@interface SubmitViewController : BaseViewController
@property (nonatomic , strong)SubmitModel *submitModel;

@property (nonatomic , strong)NSDictionary *selectedAddr;

@property (assign) SubmitType submitType;


@end
