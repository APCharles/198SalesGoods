//
//  GoodsDetailModel.m
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/22.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "GoodsDetailModel.h"

@implementation GoodsDetailModel
- (NSDictionary *)objectClassInArray
{
    return @{@"cols":[ColorModel class],@"recommend":[GoodsDetailInfoModel class],@"specs":[SpecModel class],@"szs":[SizeModel class]};
}
@end
