//
//  ShoppingCartViewController.m
//  198SalesGoods
//
//  Created by BST on 2017/8/8.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCartViewCell.h"
@interface ShoppingCartViewController ()<UITableViewDelegate,UITableViewDataSource,ShoppingCartViewCellDelegate>
/** 商品列表  */
@property(strong,nonatomic) UITableView *goodsListTableview;


/** shuju  */
@property(strong,nonatomic) NSArray *listArr;

/** 界无安  */
@property(strong,nonatomic) UIView *jiesuanView;


/** <#注释#>  */
@property(strong,nonatomic) UILabel  *congigLabel;


/** 总计  */
@property(assign,nonatomic) NSInteger  totalPrice;
@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftBtn.hidden = YES;
    [self setBarName:@"购物车"];
    
    [self.view addSubview:self.goodsListTableview];
    
    [self.view addSubview:self.jiesuanView];
    
}

- (void)jianClick:(NSDictionary *)dic{
    
    NSString *price = dic[@"price"];
    _totalPrice -= [price integerValue];
    
    self.congigLabel.text = [NSString stringWithFormat:@"¥%ld",(long)_totalPrice];
    
}

- (void)jiaClick:(NSDictionary *)dic{
    NSString *price = dic[@"price"];
    _totalPrice += [price integerValue];
    
     self.congigLabel.text = [NSString stringWithFormat:@"¥%ld",(long)_totalPrice];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self requestGoodsList];
}
- (void)requestGoodsList{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    UserInfoModel *userInfoModel = [UserInfoModel objectWithKeyValues:[[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoModel]];
    [dic setObject:userInfoModel.base_id forKey:@"mid"];
    NetService *netService = [[NetService alloc] init];
     NSString *url = [NSString stringWithFormat:@"http://wx.dianpuj.com/index.php/Wap/Order/cart_ios"];
    [netService serviceWithGetjsonURL:url params:dic success:^(id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject objectForKey:@"rows"] isKindOfClass:[NSArray class]]) {
                
                _listArr = [responseObject objectForKey:@"rows"];
                
                for (int i = 0; i < _listArr.count ; i ++) {
                    NSDictionary *dic = _listArr[i];
                    _totalPrice += [dic[@"price"] integerValue] * [dic[@"num"] integerValue];
                }
                
                self.congigLabel.text = [NSString stringWithFormat:@"¥%ld",(long)_totalPrice];
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
    
    return 200 ;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShoppingCartViewCell *cell = [ShoppingCartViewCell cellWithTableView:tableView];
    cell.del = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.data = _listArr[indexPath.row];
    return cell;
    
}


- (UITableView *)goodsListTableview{
    
    if (!_goodsListTableview) {
        
        UITableView *goodsListTableview = [[UITableView alloc] init];
        goodsListTableview.x = 0;
        goodsListTableview.y = CGRectGetMaxY(self.navigationBarView.frame);
        goodsListTableview.width = mainScreenWidth;
        goodsListTableview.height = mainScreenHeight - self.navigationBarView.height - self.tabBarController.tabBar.height - self.jiesuanView.height;
        goodsListTableview.delegate = self;
        goodsListTableview.dataSource = self;
//        goodsListTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        goodsListTableview.backgroundColor = [UIColor clearColor];
        
            //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resgn:)];
            //        tap.numberOfTapsRequired = 1;
            //        [myTableview addGestureRecognizer:tap];
        _goodsListTableview = goodsListTableview;
    }
    
    return _goodsListTableview;
}

- (UIView *)jiesuanView{
    
    if (!_jiesuanView) {
        
        UIView *jiesuanView = [[UIView alloc] init];
        jiesuanView.width = mainScreenWidth;
        jiesuanView.height = 50;
        jiesuanView.x = 0;
        jiesuanView.y = mainScreenHeight - self.tabBarController.tabBar.height - jiesuanView.height;
        jiesuanView.backgroundColor = [UIColor whiteColor];
        
        UILabel *heji = [[UILabel alloc] init];
        heji.font = [UIFont systemFontOfSize:13];
        heji.textColor =[UIColor blackColor];
        heji.text = @"合计：";
        heji.size = [heji.text sizeWithFont:[UIFont systemFontOfSize:13] maxSize:MAXSIZE];
        heji.x = mainScreenWidth * 0.5 - heji.width - 20;
        heji.y = jiesuanView.height * 0.5 - heji.height * 0.5;
        [jiesuanView addSubview:heji];
        
        
        UILabel *congigLabel = [[UILabel alloc] init];
        congigLabel.font = [UIFont systemFontOfSize:13];
        congigLabel.textColor =[UIcolortool colorWithHexString:@"#f48831"];
        
        congigLabel.size = [@"¥13241356" sizeWithFont:[UIFont systemFontOfSize:13] maxSize:MAXSIZE];
        congigLabel.x = CGRectGetMaxX(heji.frame) +5;
        congigLabel.y = jiesuanView.height * 0.5 - congigLabel.height * 0.5;
        [jiesuanView addSubview:congigLabel];
        
        _congigLabel = congigLabel;
        
        UIButton *jiesuanBtn = [[UIButton alloc] init];
        [jiesuanBtn setTitle:@"结算" forState:UIControlStateNormal];
        jiesuanBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [jiesuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [jiesuanBtn setBackgroundColor:[UIcolortool colorWithHexString:@"#f48831"]];
        jiesuanBtn.size = CGSizeMake(100, 50);
        jiesuanBtn.x = mainScreenWidth - jiesuanBtn.width;
        jiesuanBtn.y = 0;
        [jiesuanBtn addTarget:self action:@selector(jiesuan:) forControlEvents:UIControlEventTouchUpInside];
        
        [jiesuanView addSubview:jiesuanBtn];
        
        _jiesuanView = jiesuanView;
        
    }
    
    return _jiesuanView;
}



- (void)jiesuan:(UIButton *)sender{
    
    NSLog(@"结算");
}
@end
