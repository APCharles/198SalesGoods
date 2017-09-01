//
//  SubmitCell.h
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/9/1.
//  Copyright © 2017年 AP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailInfoModel.h"

@interface SubmitCell : UITableViewCell
{
    UIImageView *_goodsImg;
    UILabel *_goodsName;
    UILabel *_goodsSpec;
    UILabel *_gooodsPrice;
}

-(void)loadCellWithData:(GoodsDetailInfoModel *)goodsDetailInfoModel;

@end
