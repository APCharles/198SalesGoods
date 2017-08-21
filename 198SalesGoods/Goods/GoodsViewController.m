//
//  GoodsViewController.m
//  198SalesGoods
//
//  Created by BST on 2017/8/8.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "GoodsViewController.h"
#import "GoodsListViewCell.h"
#import "GoodsDetailViewController.h"

@interface GoodsViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 商品列表  */
@property(strong,nonatomic) UITableView *goodsListTableview;


/** shuju  */
@property(strong,nonatomic) NSArray *listArr;
@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setBarName:@"商品列表"];
    
    self.leftBtn.hidden = YES;
    
  [self.view addSubview:self.goodsListTableview];
    
//    [self requestGoodsList];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [self requestGoodsList];
}

- (void)requestGoodsList{
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    NetService *netService = [[NetService alloc] init];
    [netService serviceWithGetjsonURL:@"http://wx.dianpuj.com/index.php/Wap/Product/index_ios" params:dic success:^(id responseObject) {
        
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _listArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
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
    
    GoodsListViewCell *cell = [GoodsListViewCell cellWithTableView:tableView];
    
    cell.data = _listArr[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *data = [_listArr objectAtIndex:indexPath.row];
    NSLog(@"点击某一个商品");
    GoodsDetailViewController *goodsDetailViewController = [[GoodsDetailViewController alloc]init];
    if ([[data objectForKey:@"level"] intValue] == 1) {
        goodsDetailViewController.goodsDetailType = GoodsDetailBuy;
    }else if ([[data objectForKey:@"level"] intValue] == 0){
        goodsDetailViewController.goodsDetailType = GoodsDetailFree;
    }
    goodsDetailViewController.data = data;
    [self.navigationController pushViewController:goodsDetailViewController animated:YES];
    
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
