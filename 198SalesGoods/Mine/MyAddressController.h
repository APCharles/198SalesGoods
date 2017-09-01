//
//  MyAddressController.h
//  198SalesGoods
//
//  Created by BST on 2017/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//


#import "BaseViewController.h"
@interface MyAddressController : BaseViewController

@property(strong , nonatomic)void (^onClickAddressCallBack)(NSDictionary *address);

- (void)requestAddress;
@end
