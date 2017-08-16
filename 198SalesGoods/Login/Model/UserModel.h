//
//  UserModel.h
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/16.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "BaseModel.h"
#import "ResModel.h"
#import "UserInfoModel.h"

@interface UserModel : BaseModel

@property(nonatomic,strong) ResModel *res;

@property(nonatomic,strong) UserInfoModel *user_info;


+(instancetype)shareInstance;

@end
