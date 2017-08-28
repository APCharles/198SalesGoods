//
//  GoodsDetailViewController.h
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/18.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "BaseViewController.h"
#import "GoodsDetailModel.h"


@interface GoodsDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    GoodsDetailModel *_goodsDetailModel;
    
    UITableView *_tableView;
    
    UIView *_headerView;
    UIButton *_addToShopCartBtn;
    UIButton *_buyBtn;
    UIView *_shopCartView;
    UIButton *_shopCartBtn;
    UILabel *_shopCartCount;
    
    NSArray *_imgArr;
    NSMutableArray *_recArr;
}

@property (nonatomic,strong)NSDictionary*data;
@end
