

    //
//  GoodsAddViewController.m
//  198SalesGoods
//
//  Created by BST on 2017/9/28.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "GoodsAddViewController.h"
#import "GoodsAddTableViewCell.h"
#import "GoodsViewController.h"
@interface GoodsAddViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 商品列表  */
@property(strong,nonatomic) UITableView *goodsListTableview;


/** shuju  */
@property(strong,nonatomic) NSArray *listArr;

/** dic  */
@property(strong,nonatomic) NSDictionary *dic;
@end

@implementation GoodsAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBarName:@"商品列表"];
    [self.view addSubview:self.goodsListTableview];
}

- (void)back{
    if (self.isBack) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [super back];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    if (!_isShow) {
        self.leftBtn.hidden = NO;
        _goodsListTableview.height = mainScreenHeight - self.navigationBarView.height;
    }else{
        self.leftBtn.hidden = YES;
        _goodsListTableview.height = mainScreenHeight - self.navigationBarView.height - self.tabBarController.tabBar.height;
    }
    [self requestGoodsList];
}

- (void)requestGoodsList{
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    NetService *netService = [[NetService alloc] init];

        

     NSString * url = @"http://wx.dianpuj.com/index.php/wap/product/index_ios";
        

    [netService serviceWithGetjsonURL: url params:dic success:^(id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            _dic = responseObject;
            [_goodsListTableview reloadData];
        }
        
        
        
        
        
    } failure:^(NSError *error) {
        [self showProgressHUDString:@"服务器数据异常"];
        
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
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
    
    GoodsAddTableViewCell *cell = [GoodsAddTableViewCell cellWithTableView:tableView];
    
    if ([_dic count] > 0) {
        if (indexPath.section == 0) {
            
            cell.data = [_dic objectForKey:@"image_man"];
            
            
        }else{
            cell.data = [_dic objectForKey:@"image_women"];
            
        }
        
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    NSLog(@"点击某一个商品");
    if (indexPath.section == 0) {
        
        GoodsViewController *goods = [[GoodsViewController alloc] init];
        goods.url = @"http://wx.dianpuj.com/index.php/wap/product/index_man_ios";
        goods.hidesBottomBarWhenPushed = YES;
        goods.isShow = NO;
        [self.navigationController pushViewController:goods animated:YES];
        
        
    }else if (indexPath.section == 1){
        GoodsViewController *goods = [[GoodsViewController alloc] init];
        goods.url = @"http://wx.dianpuj.com/index.php/wap/product/index_woman_ios";
        goods.hidesBottomBarWhenPushed = YES;
        goods.isShow = NO;
        [self.navigationController pushViewController:goods animated:YES];
        
        
    }
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
