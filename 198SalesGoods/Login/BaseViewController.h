//
//  BaseViewController.h
//  198SalesGoods
//
//  Created by BST on 2017/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


/** topView  */
@property(strong,nonatomic) UIView *navigationBarView;

- (void)back;

- (void)setBarName:(NSString *)barName;
@end
