//
//  GoodsDetailViewController.h
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/18.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "BaseViewController.h"

typedef enum {
    GoodsDetailBuy,
    GoodsDetailFree,
}GoodsDetailType;

@interface GoodsDetailViewController : BaseViewController


@property (assign) GoodsDetailType goodsDetailType;
@property (nonatomic,strong)NSDictionary*data;
@end
