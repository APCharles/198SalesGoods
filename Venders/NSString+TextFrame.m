//
//  NSString+TextFrame.m
//  PanDaDriver
//
//  Created by BST on 16/9/6.
//  Copyright © 2016年 BST. All rights reserved.
//

#import "NSString+TextFrame.h"

@implementation NSString (TextFrame)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
