//
//  UserInfoModel.h
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/16.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfoModel : BaseModel

@property(nonatomic,copy) NSNumber *activity;

@property(nonatomic,copy) NSString *address;

@property(nonatomic,copy) NSNumber *cate;//会员69，游客68

@property(nonatomic,copy) NSNumber *datetime;

@property(nonatomic,copy) NSString *headimgurl;

@property(nonatomic,copy) NSNumber *base_id;

@property(nonatomic,copy) NSString *jifen;

@property(nonatomic,copy) NSNumber *mobile;

@property(nonatomic,copy) NSString *name;

@property(nonatomic,copy) NSString *nickname;

@property(nonatomic,copy) NSNumber *number;

@property(nonatomic,copy) NSString *openid;

@property(nonatomic,copy) NSString *other_info;

@property(nonatomic,copy) NSNumber *password;

@property(nonatomic,copy) NSNumber *pid;//推荐码

@property(nonatomic,copy) NSString *ref_time;

@property(nonatomic,copy) NSNumber *state;

@property(nonatomic,copy) NSString *ticket;

@property(nonatomic,copy) NSNumber *type;

@property(nonatomic,copy) NSString *wx_info;


@end
