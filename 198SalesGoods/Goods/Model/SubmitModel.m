//
//  SubmitModel.m
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/31.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "SubmitModel.h"

@implementation SubmitModel
- (NSDictionary *)objectClassInArray
{
    return @{@"Provinces":[ProvinceModel class],@"rows":[GoodsDetailInfoModel class]};
}
@end
