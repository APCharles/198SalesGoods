//
//  EditAddressController.h
//  198SalesGoods
//
//  Created by BST on 2017/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "BaseViewController.h"

@interface EditAddressController : BaseViewController

/** 是否是编辑  */
@property(assign,nonatomic) BOOL isEdit;


- (instancetype)initWithData:(NSDictionary *)dic;

@end
