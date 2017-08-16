//
//  UserData.m
//  198SalesGoods
//
//  Created by BST on 2017/8/16.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "UserData.h"

@implementation UserData

+(instancetype) shareInstance{
    static UserData* _instance = nil;
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    });
    
    return _instance ;
}

@end
