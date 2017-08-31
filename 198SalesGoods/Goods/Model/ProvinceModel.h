//
//  ProvinceModel.h
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/31.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "BaseModel.h"

@interface ProvinceModel : BaseModel

@property(nonatomic,copy) NSString *DateCreated;
@property(nonatomic,copy) NSString *DateUpdated;
@property(nonatomic,copy) NSNumber *ProvinceID;
@property(nonatomic,copy) NSString *ProvinceName;
@property(nonatomic,copy) NSNumber *state;

@end
