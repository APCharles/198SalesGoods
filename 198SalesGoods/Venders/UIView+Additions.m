//
//  UIView+Additions.m
//  CXBZ
//
//  Created by poxiao on 15/11/20.
//  Copyright © 2015年 poxiao. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)
- (CGFloat)leftX
{
    return self.frame.origin.x;
}
- (void)setLeftX:(CGFloat)leftX
{
    self.frame = CGRectMake(leftX, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)rightX
{
    return self.frame.origin.x + self.bounds.size.width;
}
- (void)setRightX:(CGFloat)rightX
{
    self.frame = CGRectMake(rightX-self.bounds.size.width, self.frame.origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)topY
{
    return self.frame.origin.y;
}
- (void)setTopY:(CGFloat)topY
{
    self.frame = CGRectMake(self.frame.origin.x, topY, self.bounds.size.width, self.bounds.size.height);
}

- (CGFloat)centerY
{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)bottomY
{
    return self.frame.origin.y + self.bounds.size.height;
}
- (void)setBottomY:(CGFloat)bottomY
{
    self.frame = CGRectMake(self.frame.origin.x, bottomY-self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
}


- (CGFloat)width
{
    return self.bounds.size.width;
}
- (void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.bounds.size.height);
}

- (CGFloat)height
{
    return self.bounds.size.height;
}
- (void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, height);
}


- (CGPoint)origin
{
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin
{
    self.frame = CGRectMake(origin.x, origin.y, self.bounds.size.width, self.bounds.size.height);
}

- (CGSize)size
{
    return self.bounds.size;
}
- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

- (UIImage *)imageRep
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)occupySuperview
{
    if ( self.superview ) {
        self.frame = self.superview.bounds;
    }
}

- (void)moveToCenterOfSuperview
{
    if ( self.superview ) {
        CGRect frm = CGRectMake((self.superview.bounds.size.width - self.bounds.size.width) / 2.0,
                                (self.superview.bounds.size.height - self.bounds.size.height) / 2.0,
                                self.bounds.size.width,
                                self.bounds.size.height);
        self.frame = frm;
    }
}

- (void)moveToVerticalCenterOfSuperview
{
    if ( self.superview ) {
        CGRect frm = CGRectMake(self.frame.origin.x,
                                (self.superview.bounds.size.height - self.bounds.size.height) / 2.0,
                                self.bounds.size.width,
                                self.bounds.size.height);
        self.frame = frm;
    }
}

- (void)moveToHorizontalCenterOfSuperview
{
    if ( self.superview ) {
        CGRect frm = CGRectMake((self.superview.bounds.size.width - self.bounds.size.width) / 2.0,
                                self.frame.origin.y,
                                self.bounds.size.width,
                                self.bounds.size.height);
        self.frame = frm;
    }
}

- (NSArray *)superviewArray
{
    NSMutableArray *superviews = [[NSMutableArray alloc] init];
    
    UIView *view = self;
    while ( view.superview ) {
        [superviews addObject:view.superview];
        view = view.superview;
    }
    
    if ( [superviews count] > 0 ) {
        return superviews;
    }
    
    return nil;
}

- (NSArray *)subviewArrayWithClass:(Class)cls
{
    NSMutableArray *subviews = [[NSMutableArray alloc] init];
    
    for ( int i=0; i<[self.subviews count]; ++i ) {
        UIView *child = [self.subviews objectAtIndex:i];
        if ( [child isKindOfClass:cls] ) {
            [subviews addObject:child];
        }
    }
    
    if ( [subviews count] > 0 ) {
        return subviews;
    }
    
    return nil;
}

- (UIView *)descendantOrSelfWithClass:(Class)cls
{
    if ( [self isKindOfClass:cls] ) {
        return self;
    }
    
    for ( UIView *child in self.subviews ) {
        UIView *it = [child descendantOrSelfWithClass:cls];
        if ( it ) {
            return it;
        }
    }
    
    return nil;
}

- (UIView *)ancestorOrSelfWithClass:(Class)cls
{
    if ( [self isKindOfClass:cls] ) {
        return self;
    } else if ( self.superview ) {
        return [self.superview ancestorOrSelfWithClass:cls];
    }
    return nil;
}

- (UIViewController *)viewController
{
    for ( UIView *next=self; next; next=next.superview ) {
        UIResponder *nextResponder = [next nextResponder];
        if (nextResponder && [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UIView *)rootView
{
    UIView *view = self;
    while ( view.superview ) {
        view = view.superview;
    }
    return view;
}

- (void)bringToFront
{
    [self.superview bringSubviewToFront:self];
}

- (void)sendToBack
{
    [self.superview sendSubviewToBack:self];
}

- (BOOL)isInFront
{
    return ( [self.superview.subviews lastObject] == self );
}

- (BOOL)isAtBack
{
    NSArray *array = self.superview.subviews;
    if ( [array count] > 0 ) {
        return ( [array objectAtIndex:0] == self );
    }
    return NO;
}

- (void)showBorderWithRedColor
{
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1.0;
}

- (void)showBorderWithGreenColor
{
    self.layer.borderColor = [UIColor greenColor].CGColor;
    self.layer.borderWidth = 1.0;
}

- (void)showBorderWithBlueColor
{
    self.layer.borderColor = [UIColor blueColor].CGColor;
    self.layer.borderWidth = 1.0;
}

- (void)showBorderWithBrownColor
{
    self.layer.borderColor = [UIColor brownColor].CGColor;
    self.layer.borderWidth = 1.0;
}

- (void)showBorderWithPurpleColor
{
    self.layer.borderColor = [UIColor purpleColor].CGColor;
    self.layer.borderWidth = 1.0;
}

- (void)showBorderWithColor:(UIColor *)color{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 2.0;
}
- (void)showBorderWithColor:(UIColor *)color lineWidth:(CGFloat)width{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}


+ (void)showBorder:(UIView *)view level:(NSInteger)level
{
    static NSArray *Colors = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        Colors = [[NSArray alloc] initWithObjects:
                  [UIColor redColor],
                  [UIColor greenColor],
                  [UIColor blueColor],
                  [UIColor brownColor],
                  [UIColor purpleColor], nil];
    });
    
    UIColor *color = [Colors objectAtIndex:(level%5)];
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = 1.0;
    
    for ( int i=0; i<[view.subviews count]; ++i ) {
        UIView *subview = [view.subviews objectAtIndex:i];
        [self showBorder:subview level:(level+1)];
    }
}

+ (void)dumpView:(UIView *)view level:(NSInteger)level
{
    NSMutableString *space = [[NSMutableString alloc] init];
    for ( int i=0; i<level; ++i ) {
        [space appendString:@"|_"];
    }
    
    NSLog(@"%@%ld:%@ subview:%lu frame:%@",
          space,
          (long)level,
          NSStringFromClass([view class]),
          (unsigned long)[view.subviews count],
          NSStringFromCGRect(view.frame));
    
    
    for ( int i=0; i<[view.subviews count]; ++i ) {
        UIView *child = [view.subviews objectAtIndex:i];
        [self dumpView:child level:(level+1)];
    }
}
@end
