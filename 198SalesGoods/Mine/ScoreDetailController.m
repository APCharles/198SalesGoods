
    //
//  ScoreDetailController.m
//  198SalesGoods
//
//  Created by BST on 2017/9/8.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "ScoreDetailController.h"
#import "SBJsonParser.h"
#import "ScoreDetailViewCell.h"
@interface ScoreDetailController ()<UITableViewDelegate,UITableViewDataSource>
/** dataArr  */
@property(strong,nonatomic) NSArray *dataArr;

/** tableview  */
@property(strong,nonatomic) UITableView *orderView;
@end

@implementation ScoreDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setBarName:@"积分明细"];
   
    [self requestDetail];
}

- (void)requestDetail{
    
    NSDictionary *dic  =[[NSDictionary alloc] init];
    NetService *service = [[NetService alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"http://wx.dianpuj.com/index.php/Wap/Member/mx_ios/id/%@",[UserData shareInstance].user_Model.base_id];
    
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
    
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerview =[[ UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, 40)];
    headerview.backgroundColor = [UIColor whiteColor];
    UILabel *title = [[UILabel alloc] init];
    title.text = @"积分明细";
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    title.textColor = BLACKTEXTCOLOR;
    title.size = [title.text sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:14] maxSize:MAXSIZE];
    title.x =  15;
    title.y = 20 - title.height * 0.5;
    [headerview addSubview:title];
    
     UIImageView *topLineView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 39.5, mainScreenWidth, 0.5)];
    topLineView.image = [UIImage imageNamed:@"img_line"];
    [headerview addSubview:topLineView];

    return headerview;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScoreDetailViewCell *cell = [ScoreDetailViewCell cellWithTableView:tableView];
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
            //myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        myTableview.backgroundColor = [UIColor clearColor];
        
            //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resgn:)];
            //        tap.numberOfTapsRequired = 1;
            //        [myTableview addGestureRecognizer:tap];
        _orderView = myTableview;
    }
    
    return _orderView;
}



@end
