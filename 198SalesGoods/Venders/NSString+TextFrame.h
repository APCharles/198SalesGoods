//
//  NSString+TextFrame.h
//  PanDaDriver
//
//  Created by BST on 16/9/6.
//  Copyright © 2016年 BST. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (TextFrame)
/**
 *  返回字符串的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 *
 *  
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
