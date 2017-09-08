
    //
//  QrcodeViewcontroller.m
//  198SalesGoods
//
//  Created by BST on 2017/9/8.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "QrcodeViewcontroller.h"
#import "SBJsonParser.h"
@interface QrcodeViewcontroller ()


@property(strong,nonatomic)UIImageView *QRcodeView;

@end
@implementation QrcodeViewcontroller

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setBarName:@"我的二维码"];
        // Do any additional setup after loading the view.
    [self.view addSubview:self.QRcodeView];
    
    NSDictionary *dic = [[NSDictionary alloc] init];
    NetService *netService = [[NetService alloc] init];
    [netService serviceWithGetURL:[NSString stringWithFormat:@"http://wx.dianpuj.com/index.php/Wap/Member/wxqrcode_ios/id/%@",[UserData shareInstance].user_Model.base_id] params:dic success:^(id responseObject) {
        
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
      
      
        
          str=[str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
        
        str =  [str substringFromIndex:1];
        
        str = [str substringToIndex:str.length - 1];
        
        
       
        [self.QRcodeView sd_setImageWithURL:[NSURL URLWithString:str]];
        
      
        
    } failure:^(NSError *error) {
        
        
        
        [self showProgressHUDString:@"服务器数据异常"];
        
        
    }];

    
}



- (UIImageView *)QRcodeView{
    
    if (!_QRcodeView) {
        
        UIImageView *QRcodeView = [[UIImageView alloc] init];
        QRcodeView.x = 30 ;
        QRcodeView.y = CGRectGetMaxY(self.navigationBarView.frame) + 40;
        QRcodeView.width = mainScreenWidth - 60;
        QRcodeView.height = mainScreenWidth - 60 ;
            //        /QRcodeView.backgroundColor = [UIColor redColor];
        _QRcodeView = QRcodeView;
    }
    
    return _QRcodeView;
}


@end
