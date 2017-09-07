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
   self.leftBtn.hidden = YES;
    [self setBarName:@"商品列表"];
      [self.view addSubview:self.goodsListTableview];
    if (!_isShow) {
        self.leftBtn.hidden = NO;
        _goodsListTableview.height = mainScreenHeight - self.navigationBarView.height;
    }else{
    self.leftBtn.hidden = YES;
         _goodsListTableview.height = mainScreenHeight - self.navigationBarView.height - self.tabBarController.tabBar.height;
    }

    
//    [self requestGoodsList];
    
}

    - (void)back{
        if (self.isBack) {
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [super back];
        }
    }
- (void)viewWillAppear:(BOOL)animated{
    
    if (ApplicationDelegate.isFromGoodsDetail == YES) {
        ApplicationDelegate.isFromGoodsDetail = NO;
        [self.tabBarController setSelectedIndex:2];
    }
    [self requestGoodsList];
}

- (void)requestGoodsList{
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    NetService *netService = [[NetService alloc] init];
    if (self.url.length > 0) {
        
    }else{
        self.url = @"http://wx.dianpuj.com/index.php/Wap/Product/index_ios";
        
    }
    [netService serviceWithGetjsonURL: self.url params:dic success:^(id responseObject) {
        
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
- (void)requestManGoodsWithUrl:(NSString *)url{
        
        
        NSDictionary *dic = [[NSDictionary alloc] init];
        NetService *netService = [[NetService alloc] init];
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
    if ([[data objectForKey:@"price"] floatValue]>15) {
        GoodsDetailViewController *goodsDetailViewController = [[GoodsDetailViewController alloc]init];
        goodsDetailViewController.data = data;
        [self.navigationController pushViewController:goodsDetailViewController animated:YES];
    }else{
        
    }
}
- (UITableView *)goodsListTableview{
    
    if (!_goodsListTableview) {
        
        UITableView *goodsListTableview = [[UITableView alloc] init];
        goodsListTableview.x = 0;
        goodsListTableview.y = CGRectGetMaxY(self.navigationBarView.frame);
        goodsListTableview.width = mainScreenWidth;
        if (self.url.length > 0) {
            goodsListTableview.height = mainScreenHeight - self.navigationBarView.height ;
        }
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
