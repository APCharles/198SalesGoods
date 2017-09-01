//
//  SubmitModel.h
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/31.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "BaseModel.h"
#import "ProvinceModel.h"
#import "GoodsDetailInfoModel.h"

@interface SubmitModel : BaseModel

@property(nonatomic,strong) NSMutableArray *Provinces;
@property(nonatomic,copy) NSNumber *addbooks;
@property(nonatomic,copy) NSNumber *attr;
@property(nonatomic,copy) NSNumber *code;
@property(nonatomic,strong) GoodsDetailInfoModel *row;
@property(nonatomic,copy) NSString *spec;
@property(nonatomic,strong) NSMutableArray *rows;


@end
