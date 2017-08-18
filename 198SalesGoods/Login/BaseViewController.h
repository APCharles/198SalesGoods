//
//  BaseViewController.h
//  198SalesGoods
//
//  Created by BST on 2017/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SmallButton.h"
@interface BaseViewController : UIViewController

/** SmallButton *leftBtn  */
@property(strong,nonatomic) SmallButton *leftBtn;

/** topView  */
@property(strong,nonatomic) UIView *navigationBarView;

- (void)back;

- (void)setBarName:(NSString *)barName;

- (void)showProgressHUDString:(NSString *)content;
/**
 *	@brief	同步提示对话框
 *
 *	@param 	content 	提示内容
 *	@param 	atime 	对话框显示时间
*/
- (void)showSynProgressHUDString:(NSString *)content time:(float)atime completion:(void (^)())completion;
@end
