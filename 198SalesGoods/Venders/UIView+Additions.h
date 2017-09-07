//
//  UIView+Additions.h
//  CXBZ
//
//  Created by poxiao on 15/11/20.
//  Copyright © 2015年 poxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

@property (nonatomic, assign) CGFloat leftX;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat rightX;

@property (nonatomic, assign) CGFloat topY;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat bottomY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

- (void)occupySuperview;
- (void)moveToCenterOfSuperview;
- (void)moveToVerticalCenterOfSuperview;
- (void)moveToHorizontalCenterOfSuperview;

- (UIImage *)imageRep;

- (NSArray *)superviewArray;
- (NSArray *)subviewArrayWithClass:(Class)cls;
- (UIView *)descendantOrSelfWithClass:(Class)cls;
- (UIView *)ancestorOrSelfWithClass:(Class)cls;

- (UIViewController *)viewController;
- (UIView *)rootView;
- (void)bringToFront;
- (void)sendToBack;
- (BOOL)isInFront;
- (BOOL)isAtBack;

- (void)showBorderWithRedColor;
- (void)showBorderWithGreenColor;
- (void)showBorderWithBlueColor;
- (void)showBorderWithBrownColor;
- (void)showBorderWithPurpleColor;
- (void)showBorderWithColor:(UIColor *)color;
- (void)showBorderWithColor:(UIColor *)color lineWidth:(CGFloat)width;

+ (void)showBorder:(UIView *)view level:(NSInteger)level;
+ (void)dumpView:(UIView *)view level:(NSInteger)level;

@end
