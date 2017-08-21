//
//  MyOrderViewController.m
//  198SalesGoods
//
//  Created by BST on 2017/8/18.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "MyOrderViewController.h"
#import "OrderHeaderView.h"
#import "OrderListTableViewCell.h"
#import "SBJsonParser.h"
@interface MyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

/** orderHeaderView  */
@property(strong,nonatomic) OrderHeaderView *orderHeaderView;


/** dataArr  */
@property(strong,nonatomic) NSArray *dataArr;


/** tableview  */
@property(strong,nonatomic) UITableView *orderView;


/** idx  */
@property(assign,nonatomic) NSInteger idx;
@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBarName:@"订单中心"];
    __weak typeof(self) weakSelf = self;
    OrderHeaderView *headView = [[OrderHeaderView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationBarView.frame), self.view.bounds.size.width, 40)];
    headView.items = @[@"未付款",@"待发货",@"已发货",@"已完成",@"已关闭"];
    
    headView.itemClickAtIndex = ^(NSInteger index){
        [weakSelf requestOrderTypeWithType:index];
        
        NSLog(@"--%ld",(long)index);
    };
    [self.
     view addSubview:headView];
    
    _orderHeaderView = headView;
     [self requestOrderTypeWithType:0];
    [self.view addSubview:self.orderView];
}

- (void)requestOrderTypeWithType:(NSInteger )idx{
    
    _idx = idx;
    NSString *url = [NSString stringWithFormat:@"http://wx.dianpuj.com/index.php/Wap/Order/myorder_ios/id/%@",[UserData shareInstance].user_Model.base_id];
    if (idx == 0) {
        url = [NSString stringWithFormat:@"%@/%@",url,@"is_pay/1"];
    }else if (idx == 1) {
        url = [NSString stringWithFormat:@"%@/%@",url,@"delivery/2"];
    }else if (idx == 2) {
        url = [NSString stringWithFormat:@"%@/%@",url,@"delivery/1"];
    }else if (idx == 3) {
        url = [NSString stringWithFormat:@"%@/%@",url,@"state/1"];
    }else if (idx == 4) {
        url = [NSString stringWithFormat:@"%@/%@",url,@"state/2"];
    }
    
    NSDictionary *dic  =[[NSDictionary alloc] init];
    NetService *service = [[NetService alloc] init];
    
    [service serviceWithGetURL:url params:dic success:^(id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        str = [str substringFromIndex:5];
        SBJsonParser *json = [[SBJsonParser alloc] init];
        NSDictionary *dic = [json objectWithString:str];

        if ([dic isKindOfClass:[NSDictionary class]]) {
            _dataArr = [dic objectForKey:@"title"];
            
        }
        [self.orderView reloadData];
        
    } failure:^(NSError *error) {
        
        [self showProgressHUDString:@"服务器数据异常"];
    }];
   
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 220;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = DCBGColor;
//    headerView.frame = CGRectMake(0, 0, mainScreenWidth, 30);
//    
//    return headerView;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderListTableViewCell *cell = [OrderListTableViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.idx = _idx;
    cell.data = _dataArr[indexPath.row];
    
    
    return cell;
    
}
- (UITableView *)orderView{
    
    if (!_orderView) {
        
        UITableView *myTableview = [[UITableView alloc] init];
        myTableview.x = 0;
        myTableview.y = CGRectGetMaxY(self.orderHeaderView.frame);
        myTableview.width = mainScreenWidth;
        myTableview.height = mainScreenHeight - self.navigationBarView.height - self.orderHeaderView.height;
        myTableview.delegate = self;
        myTableview.dataSource = self;
        myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        myTableview.backgroundColor = [UIColor clearColor];
        
            //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resgn:)];
            //        tap.numberOfTapsRequired = 1;
            //        [myTableview addGestureRecognizer:tap];
        _orderView = myTableview;
    }
    
    return _orderView;
}


@end
