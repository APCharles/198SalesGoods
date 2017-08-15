//
//  Tools.h
//  198SalesGoods
//
//  Created by BST on 2017/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

    //判断nsstring是否为空
+ (BOOL)isBlankString:(NSString *)string;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
@end
