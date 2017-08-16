
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
@interface MyAddressController ()


/** add address  */
@property(strong,nonatomic) UIButton *addAddress;

/** array  */
@property(strong,nonatomic) NSArray *addressArr;
@end

@implementation MyAddressController

- (void)viewDidLoad {
     [super viewDidLoad];

    
    [self setBarName:@"我的地址"];

    
    [self.view addSubview:self.addAddress];
    
    [self requestAddress];
    
    
}

- (void)requestAddress{
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    [NetService serviceWithGetURL:[NSString stringWithFormat:@"http://wx.dianpuj.com/index.php/Wap/order/myaddress/mid/%@",[UserData shareInstance].user_Model.base_id] params:dic success:^(id responseObject) {
       
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        str = [str substringFromIndex:5];
        SBJsonParser *json = [[SBJsonParser alloc] init];
        NSDictionary *dic = [json objectWithString:str];
        
        _addressArr = dic[@"addbooks"];
        
        
        
        
    } failure:^(NSError *error) {
        
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
@end
