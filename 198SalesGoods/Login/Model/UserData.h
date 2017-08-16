//
//  UserData.h
//  198SalesGoods
//
//  Created by BST on 2017/8/16.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"
@interface UserData : NSObject

+(instancetype)shareInstance;

@property(nonatomic,strong) UserInfoModel *user_Model;

@end
