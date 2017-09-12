
    //
//  MyAddressController.m
//  198SalesGoods
//
//  Created by BST on 2017/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//
#import "UserModel.h"
#import "MyAddressController.h"
#import "EditAddressController.h"
#import "SBJsonParser.h"
#import "AddressViewCell.h"
@interface MyAddressController ()<UITableViewDelegate,UITableViewDataSource,AddressViewCellDelegate>


/** add address  */
@property(strong,nonatomic) UIButton *addAddress;

/** array  */
@property(strong,nonatomic) NSArray *addressArr;


/** addressTable  */
@property(strong,nonatomic) UITableView *addressTableview;
@end

@implementation MyAddressController

@synthesize onClickAddressCallBack = _onClickAddressCallBack;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self requestAddress];
}

- (void)viewDidLoad {
     [super viewDidLoad];

    
    [self setBarName:@"我的地址"];
    
    UIScrollView * myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationBarView.frame), mainScreenWidth, mainScreenHeight - self.navigationBarView.height)];
    myScrollView.backgroundColor = DCBGColor;
    myScrollView.showsHorizontalScrollIndicator = NO;
    myScrollView.showsVerticalScrollIndicator = NO;
        //点击延迟
    myScrollView.delaysContentTouches = NO;
    if ([UIDevice currentDevice].systemVersion.intValue >= 8) {
        for (UIView *currentView in myScrollView.subviews) {
            if ([currentView isKindOfClass:[UIScrollView class]]) {
                ((UIScrollView *)currentView).delaysContentTouches = NO;
                break;
            }
        }
    }
    
    
    
    [myScrollView setContentSize:CGSizeMake(myScrollView.frame.size.width, myScrollView.frame.size.height)];
    
    [self.view addSubview:myScrollView];
    
    [myScrollView addSubview:self.addressTableview];
    
    [myScrollView addSubview:self.addAddress];
   
    [self requestAddress];
    
    
    
}


- (void)editAddress:(UIButton *)sender{
    EditAddressController *ed = [[EditAddressController alloc] initWithData:_addressArr[sender.tag - 200]];
    [self.navigationController pushViewController:ed animated:YES];
}

- (void)deleteAddress:(UIButton *)sender{
    
    NSDictionary *dic1 = _addressArr[sender.tag - 100];
    NSDictionary *dic = [[NSDictionary alloc] init];
    NetService *netService = [[NetService alloc] init];
    [netService serviceWithGetURL:[NSString stringWithFormat:@"http://wx.dianpuj.com/index.php/Wap/Member/addr_del_ios/id/%@", [NSString stringWithFormat:@"%@",dic1[@"id"]]] params:dic success:^(id responseObject) {
        
        [self  requestAddress];
        
    } failure:^(NSError *error) {
        [self showProgressHUDString:[error localizedDescription]];
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   return _addressArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *address = _addressArr[indexPath.row];
    if (_onClickAddressCallBack) {
        _onClickAddressCallBack(address);
        [self back];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressViewCell *cell = [AddressViewCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.data = _addressArr[indexPath.row];
    cell.deleteBtn.tag = indexPath.row + 100;
    cell.editBtn.tag = indexPath.row + 200;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)requestAddress{
    
    NSDictionary *dic = [[NSDictionary alloc] init];
     NetService *netService = [[NetService alloc] init];
    [netService serviceWithGetURL:[NSString stringWithFormat:@"http://wx.dianpuj.com/index.php/Wap/order/myaddress/mid/%@",[UserData shareInstance].user_Model.base_id] params:dic success:^(id responseObject) {
       
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        str = [str substringFromIndex:5];
        SBJsonParser *json = [[SBJsonParser alloc] init];
        NSDictionary *dic = [json objectWithString:str];
        
        _addressArr = dic[@"addbooks"];
        
        if (_addressArr.count > 0) {
            
          [_addressTableview reloadData];
            
            _addressTableview.height = 100 * _addressArr.count;
            _addAddress.y = CGRectGetMaxY(self.addressTableview.frame) + 30;
            
        }else{
            
            _addAddress.y = CGRectGetMaxY(self.navigationBarView.frame) + 30;
        }
        
        
    } failure:^(NSError *error) {
         [self showProgressHUDString:@"服务器数据异常"];
    }];
}

- (void)addAddBtnclick:(UIButton *)sender{
    
    EditAddressController *ed = [[EditAddressController alloc] init];
    [self.navigationController pushViewController:ed animated:YES];
}


- (UIButton *)addAddress{
    
    if (!_addAddress) {
        
        UIButton *addAddress= [[UIButton alloc] init];
        [addAddress setTitle:@"+添加新地址" forState:UIControlStateNormal];
        [addAddress setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addAddress.titleLabel.font = [UIFont systemFontOfSize:14];
        
        addAddress.backgroundColor = RGB(249, 80, 56);
        
        addAddress.width = mainScreenWidth - 30;
        
        addAddress.height = 45;
        
        addAddress.x = 15;
        
        addAddress.y = 135;
        [addAddress addTarget:self action:@selector(addAddBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _addAddress = addAddress;
    }
    
    return _addAddress;
}

- (UITableView *)addressTableview{
    
    if (!_addressTableview) {
        
        UITableView *myTableview = [[UITableView alloc] init];
        myTableview.x = 0;
        myTableview.y = 0;
        myTableview.width = mainScreenWidth;
        myTableview.height = 200;
        myTableview.delegate = self;
        myTableview.dataSource = self;
        myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        myTableview.backgroundColor = [UIColor clearColor];
        myTableview.scrollEnabled = NO;
        _addressTableview = myTableview;
    }
    
    return _addressTableview;
}
@end
