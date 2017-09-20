//
//  SubmitViewController.m
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/31.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "SubmitViewController.h"
#import "MyAddressController.h"
#import "SubmitCell.h"
#import "WXApi.h"

@interface SubmitViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArr;
    
    UIView *_headerView;
    UILabel *_name;
    UILabel *_address;
    UIButton *_addressBtn;
    
    UIView *_footerView;
    UILabel *_shippingPrice;
    UITextField *_noticeTextField;
    UILabel *_totalPrice;
    
    UIButton *_submitBtn;
}

@end

@implementation SubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBarName:@"结算"];
    [self installController];
    [self loadData];
}

-(void)loadData{
    _dataArr = [[NSMutableArray alloc]init];
    if (self.submitModel.rows.count) {
        [_dataArr addObjectsFromArray:self.submitModel.rows];
    }else{
        [_dataArr addObject:self.submitModel.row];
    }
    [self configCurrentView];
    [_tableView reloadData];
}

-(void)installController{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,StateNaviBarHeight, mainScreenWidth, mainScreenHeight-StateNaviBarHeight-TabBarHeight)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, mainScreenHeight-TabBarHeight, mainScreenWidth, TabBarHeight)];
    _submitBtn.backgroundColor = [UIcolortool colorWithHexString:@"e21111"];
    _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn addTarget:self action:@selector(onClickSubmit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_submitBtn];
    
    [self installTableHeaderView];
    [self installTableFooterView];
}

-(void)onClickSubmit{
    NSMutableDictionary *payInfoDic = [NSMutableDictionary new];
    NSString *appId = payInfoDic[@"appid"];
    NSString *partnerId = [payInfoDic[@"partnerid"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *prepayId = payInfoDic[@"prepayid"];
    NSString *nonceStr = payInfoDic[@"noncestr"];
    NSNumber *timeStamp = payInfoDic[@"timestamp"];
    NSString *sign = payInfoDic[@"sign"];
    NSString *packageValue = payInfoDic[@"packagevalue"];
    
    //调起微信支付
    PayReq* req = [[PayReq alloc] init];
    req.openID      = appId;
    req.partnerId   = partnerId;
    req.prepayId    = prepayId;
    req.nonceStr    = nonceStr;
    req.timeStamp   = [timeStamp intValue];
    
    req.package     = packageValue;
    req.sign        = sign;
    
    [WXApi sendReq:req];
}

-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //微信支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //    [alert show];
}

-(void)installTableHeaderView{
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 100)];
    _headerView.backgroundColor = [UIColor whiteColor];
    UIImage *lineImg = [UIImage imageNamed:@"icon_my_address_line"];
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100-lineImg.size.height, mainScreenWidth, lineImg.size.height)];
    [line setBackgroundColor:[UIColor colorWithPatternImage:lineImg]];
    [_headerView addSubview:line];
    
    _name = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, mainScreenWidth-20, 20)];
    _name.textColor = [UIcolortool colorWithHexString:@"333333"];
    _name.font = [UIFont systemFontOfSize:14];
    [_headerView addSubview:_name];
    
    _address = [[UILabel alloc]initWithFrame:CGRectMake(10, _name.y+_name.height+5, mainScreenWidth-20, line.y-5-(_name.y+_name.height+5))];
    _address.textColor = [UIcolortool colorWithHexString:@"333333"];
    _address.font = [UIFont systemFontOfSize:14];
    _address.numberOfLines = 0;
    [_headerView addSubview:_address];
    
    _addressBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, _headerView.width, _headerView.height)];
    _addressBtn.backgroundColor = [UIColor clearColor];
    [_addressBtn setTitleColor:[UIcolortool colorWithHexString:@"e21111"] forState:UIControlStateNormal];
    _addressBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_addressBtn addTarget:self action:@selector(onClickSelectAddress) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_addressBtn];
    
    _tableView.tableHeaderView = _headerView;
}

-(void)onClickSelectAddress{
    MyAddressController *add = [[MyAddressController alloc] init];
    __weak typeof(self)weakSelf = self;
    [add setOnClickAddressCallBack:^(NSDictionary *address) {
        _selectedAddr = address;
        [weakSelf configCurrentView];
    }];
    [self.navigationController pushViewController:add animated:YES];
}

-(void)configCurrentView{
    if (_selectedAddr) {
        [_addressBtn setTitle:@"" forState:UIControlStateNormal];
        _name.text = [NSString stringWithFormat:@"%@  %@",[_selectedAddr objectForKey:@"name"],[_selectedAddr objectForKey:@"tel"]];
        _address.text = [NSString stringWithFormat:@"%@%@%@",[_selectedAddr objectForKey:@"sheng"],[_selectedAddr objectForKey:@"shi"],[_selectedAddr objectForKey:@"address"]];
    }else{
        [_addressBtn setTitle:@"+添加地址" forState:UIControlStateNormal];
    }
    float totalPrice = 0;
    for (int i = 0; i<_dataArr.count; i++) {
        GoodsDetailInfoModel *goods = [_dataArr objectAtIndex:i];
        totalPrice = totalPrice+goods.price.floatValue;
    }
    _totalPrice.text = [NSString stringWithFormat:@"￥%.2f",totalPrice];
}

-(void)installTableFooterView{
    _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 150)];
    _footerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 0.5)];
    line.backgroundColor = [UIcolortool colorWithHexString:@"e4e4e4"];
    [_footerView addSubview:line];
    
    UILabel *shippingtitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, mainScreenWidth/2-10, 50)];
    shippingtitle.textColor = [UIcolortool colorWithHexString:@"333333"];
    shippingtitle.font = [UIFont systemFontOfSize:14];
    shippingtitle.text = @"配送方式";
    [_footerView addSubview:shippingtitle];
    
    _shippingPrice = [[UILabel alloc]initWithFrame:CGRectMake(mainScreenWidth/2, 0, mainScreenWidth/2-10, 50)];
    _shippingPrice.textColor = [UIcolortool colorWithHexString:@"e21111"];
    _shippingPrice.font = [UIFont systemFontOfSize:14];
    _shippingPrice.text = @"快递(免邮)";
    _shippingPrice.textAlignment = NSTextAlignmentRight;
    [_footerView addSubview:_shippingPrice];
    
    UIImageView *line0 = [[UIImageView alloc]initWithFrame:CGRectMake(0, _shippingPrice.y+_shippingPrice.height, mainScreenWidth, 0.5)];
    line0.backgroundColor = [UIcolortool colorWithHexString:@"e4e4e4"];
    [_footerView addSubview:line0];
    
    UILabel *noticetitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, mainScreenWidth/2-10, 50)];
    noticetitle.textColor = [UIcolortool colorWithHexString:@"333333"];
    noticetitle.font = [UIFont systemFontOfSize:14];
    noticetitle.text = @"买家留言";
    [_footerView addSubview:noticetitle];
    
    _noticeTextField = [[UITextField alloc]initWithFrame:CGRectMake(70, 50, mainScreenWidth-10-70, 50)];
    _noticeTextField.textColor = [UIcolortool colorWithHexString:@"333333"];
    _noticeTextField.font = [UIFont systemFontOfSize:14];
    _noticeTextField.placeholder = @"选填,可填写您和卖家达成一致的要求";
    _noticeTextField.delegate = self;
    _noticeTextField.returnKeyType = UIReturnKeyDone;
    [_footerView addSubview:_noticeTextField];
    
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, _noticeTextField.y+_noticeTextField.height, mainScreenWidth, 0.5)];
    line1.backgroundColor = [UIcolortool colorWithHexString:@"e4e4e4"];
    [_footerView addSubview:line1];
    
    UILabel *totalPriceTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, mainScreenWidth/2-10, 50)];
    totalPriceTitle.textColor = [UIcolortool colorWithHexString:@"333333"];
    totalPriceTitle.font = [UIFont systemFontOfSize:14];
    totalPriceTitle.text = @"合计:";
    [_footerView addSubview:totalPriceTitle];
    
    _totalPrice = [[UILabel alloc]initWithFrame:CGRectMake(mainScreenWidth/2, 100, mainScreenWidth/2-10, 50)];
    _totalPrice.textColor = [UIcolortool colorWithHexString:@"e21111"];
    _totalPrice.font = [UIFont systemFontOfSize:14];
    _totalPrice.textAlignment = NSTextAlignmentRight;
    [_footerView addSubview:_totalPrice];
    
    _tableView.tableFooterView = _footerView;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_noticeTextField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [_tableView setContentOffset:CGPointMake(0, _footerView.y)animated:YES];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [_tableView setContentOffset:CGPointMake(0, 0)animated:YES];
    return YES;
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"SubmitCell";
    SubmitCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[SubmitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell loadCellWithData:[_dataArr objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
