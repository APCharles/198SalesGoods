//
//  GoodsDetailViewController.m
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/18.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "GoodsDetailViewController.h"

@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestGoodsDetaiData];
}

-(void)requestGoodsDetaiData{
    NSString *urlStr = self.goodsDetailType==GoodsDetailBuy?[NSString stringWithFormat:@"%@Product/show_shop_ios/id/%@",API_URL,[self.data objectForKey:@"id"]]:[NSString stringWithFormat:@"%@Product/show_ios/id/%@",API_URL,[self.data objectForKey:@"id"]];
    
    NetService *netService = [[NetService alloc] init];
    [netService serviceWithGetURL:urlStr params:nil success:^(id responseObject) {
        
        NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
        NSLog(@"%@",result);
    } failure:^(NSError *error) {
        
    }];
}

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
