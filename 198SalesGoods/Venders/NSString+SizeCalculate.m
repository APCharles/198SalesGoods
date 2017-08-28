//
//  NSString+SizeCalculate.m
//  Yidian
//
//  Created by yidianjicai-iOS on 17/8/22.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "NSString+SizeCalculate.h"

@implementation NSString (SizeCalculate)

- (CGFloat)sc_calculateWidthInFontSize:(CGFloat)fontSize withStableHeight:(CGFloat)stableHeight
{
    CGFloat result = 0.0f;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize resultSize = [self boundingRectWithSize:CGSizeMake(MAXFLOAT , stableHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    result = resultSize.width;
    
    return result;
}

- (CGFloat)sc_calculateHeightInFontSize:(CGFloat)fontSize withStableWidth:(CGFloat)stableWidth
{
    CGFloat result = 0.0f;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize resultSize = [self boundingRectWithSize:CGSizeMake(stableWidth , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    result = resultSize.height;
    
    return result;
}

@end
