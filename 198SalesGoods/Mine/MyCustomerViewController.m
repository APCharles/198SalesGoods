//
//  MyCustomerViewController.m
//  198SalesGoods
//
//  Created by BST on 2017/9/8.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "MyCustomerViewController.h"
#import "ScoreDetailViewCell.h"
#import "CustomerViewCell.h"
@interface MyCustomerViewController ()<UITableViewDelegate,UITableViewDataSource>
/** dataArr  */
@property(strong,nonatomic) NSArray *dataArr;

/** tableview  */
@property(strong,nonatomic) UITableView *orderView;
@end

@implementation MyCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self setBarName:@"我的客户"];
     [self requestDetail];
}
- (void)requestDetail{
    
    NSDictionary *dic  =[[NSDictionary alloc] init];
    NetService *service = [[NetService alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"http://wx.dianpuj.com/index.php/Wap/member/mytgr_ios/id/%@",[UserData shareInstance].user_Model.base_id];
    
    [service serviceWithGetjsonURL:url params:dic success:^(id responseObject) {
        
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject objectForKey:@"rows"] isKindOfClass:[NSArray class]]) {
                _dataArr = [responseObject objectForKey:@"rows"];
                [self.view addSubview:self.orderView];
            }else{
                
                
            }
            
            
        }
        [self.orderView reloadData];
        
    } failure:^(NSError *error) {
        
        [self showProgressHUDString:@"服务器数据异常"];
    }];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomerViewCell *cell = [CustomerViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.data = _dataArr[indexPath.row];
       
    return cell;
    
}


- (UITableView *)orderView{
    
    if (!_orderView) {
        
        UITableView *myTableview = [[UITableView alloc] init];
        myTableview.x = 0;
        myTableview.y = CGRectGetMaxY(self.navigationBarView.frame);
        myTableview.width = mainScreenWidth;
        myTableview.height = mainScreenHeight - self.navigationBarView.height;
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
