//
//  ShoppingCartViewController.m
//  198SalesGoods
//
//  Created by BST on 2017/8/8.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartViewCell.h"
@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 商品列表  */
@property(strong,nonatomic) UITableView *goodsListTableview;


/** shuju  */
@property(strong,nonatomic) NSArray *listArr;
@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftBtn.hidden = YES;
    [self setBarName:@"购物车"];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self requestGoodsList];
}
- (void)requestGoodsList{
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    NetService *netService = [[NetService alloc] init];
     NSString *url = [NSString stringWithFormat:@"http://wx.dianpuj.com/index.php/wap/order/cart_ios/id/%@",[UserData shareInstance].user_Model.base_id];
    [netService serviceWithGetjsonURL:url params:dic success:^(id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject objectForKey:@"rows"] isKindOfClass:[NSArray class]]) {
                
                _listArr = [responseObject objectForKey:@"rows"];
            }
        }
        
        [_goodsListTableview reloadData];
        
        
        
    } failure:^(NSError *error) {
        [self showProgressHUDString:@"服务器数据异常"];
        
    }];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        return 0;
    }else{
        
        return 30;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 250 ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShoppingCartViewCell *cell = [ShoppingCartViewCell cellWithTableView:tableView];
    
    cell.data = _listArr[indexPath.row];
    return cell;
    
}


- (UITableView *)goodsListTableview{
    
    if (!_goodsListTableview) {
        
        UITableView *goodsListTableview = [[UITableView alloc] init];
        goodsListTableview.x = 0;
        goodsListTableview.y = CGRectGetMaxY(self.navigationBarView.frame);
        goodsListTableview.width = mainScreenWidth;
        goodsListTableview.height = mainScreenHeight - self.navigationBarView.height - self.tabBarController.tabBar.height;
        goodsListTableview.delegate = self;
        goodsListTableview.dataSource = self;
        goodsListTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        goodsListTableview.backgroundColor = [UIColor clearColor];
        
            //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resgn:)];
            //        tap.numberOfTapsRequired = 1;
            //        [myTableview addGestureRecognizer:tap];
        _goodsListTableview = goodsListTableview;
    }
    
    return _goodsListTableview;
}


@end
