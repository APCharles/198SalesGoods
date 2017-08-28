//
//  NSString+SizeCalculate.h
//  Yidian
//
//  Created by yidianjicai-iOS on 17/8/22.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SizeCalculate)

/**
 *  根据 fontSize大小 ，固定高度，计算文本宽度
 */
- (CGFloat)sc_calculateWidthInFontSize:(CGFloat)fontSize withStableHeight:(CGFloat)stableHeight;

/**
 *  根据 fontSize大小 ，固定宽度，计算文本高度
 */
- (CGFloat)sc_calculateHeightInFontSize:(CGFloat)fontSize withStableWidth:(CGFloat)stableWidth;

@end
