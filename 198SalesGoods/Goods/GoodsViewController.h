//
//  GoodsViewController.h
//  198SalesGoods
//
//  Created by BST on 2017/8/8.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface GoodsViewController : BaseViewController


    /** url */
    @property(strong,nonatomic)NSString *url;

    @property(assign,nonatomic)BOOL isShow;
    
    @property(assign,nonatomic)BOOL isBack;
@end
