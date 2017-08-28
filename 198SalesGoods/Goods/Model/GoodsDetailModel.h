//
//  GoodsDetailModel.h
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/22.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "BaseModel.h"
#import "GoodsDetailInfoModel.h"
#import "ColorModel.h"
#import "SpecModel.h"
#import "SizeModel.h"

@interface GoodsDetailModel : BaseModel

@property(nonatomic,copy) NSString *mobile;

@property(nonatomic,strong) GoodsDetailInfoModel *row;

@property(nonatomic,copy) NSNumber *cart_num;

@property(nonatomic,strong) NSMutableArray *cols;

@property(nonatomic,copy) NSString *image_color;

@property(nonatomic,strong) NSMutableArray *recommend;

@property(nonatomic,strong) NSMutableArray *specs;

@property(nonatomic,strong) NSMutableArray *szs;

@end
