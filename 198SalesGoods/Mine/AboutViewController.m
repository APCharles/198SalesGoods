//
//  AboutViewController.m
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/9/18.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "AboutViewController.h"
#import "NSString+SizeCalculate.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBarName:@"关于我们"];
    [self installController];
}

-(void)installController{
    UIImage *img = [UIImage imageNamed:@"icon_img"];
    UIImageView *appicon = [[UIImageView alloc]initWithFrame:CGRectMake((mainScreenWidth-img.size.width)/2, StateNaviBarHeight+10, img.size.width, img.size.height)];
    appicon.image = img;
    appicon.layer.cornerRadius = 5;
    appicon.layer.masksToBounds = YES;
    [self.view addSubview:appicon];
    
    UILabel *version = [[UILabel alloc]initWithFrame:CGRectMake(0, appicon.y+appicon.height+5, mainScreenWidth, 20)];
    version.textColor = [UIcolortool colorWithHexString:@"333333"];
    version.textAlignment = NSTextAlignmentCenter;
    version.numberOfLines = 0;
    version.font = [UIFont systemFontOfSize:14];
    version.text = @"V1.0.0";
    [self.view addSubview:version];
    
    UILabel *notice = [[UILabel alloc]initWithFrame:CGRectMake(10, mainScreenHeight-10-20, mainScreenWidth-20, 20)];
    notice.textColor = [UIcolortool colorWithHexString:@"7e7e7e"];
    notice.font = [UIFont systemFontOfSize:12];
    notice.text = @"Copyright © 2016年 四川店铺佳网络科技有限公司";
    notice.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:notice];
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(10, version.y+version.height+10, mainScreenWidth-20,20)];
    text.textColor = [UIcolortool colorWithHexString:@"333333"];
    text.numberOfLines = 0;
    text.font = [UIFont systemFontOfSize:14];
    text.text = @"四川店铺佳网络科技有限公司，成立于2016年7月，注册资本2000万元，是一家从事抗菌鞋开发销售的公司，主要从事UY抗菌鞋产品的销售。\n旗下的UY抗菌鞋参品牌纯天然绿色无污染的抗菌方式，经过上万次的实验，才达到了现在如此优异的抗菌效果。并且物理抗菌的材料技术应用在2017中国（上海）国际发明创新展览会获得银奖。\n公司本着“倡导绿色抗菌”的理念，建立健全了严苛的质量标准检验体系，委托国家纺织品服装饰产品质量监督检验中心（广州）特地对抗菌效果进行检测，以远远高于国家标准的检测结果确保抗菌效果。";
    [self.view addSubview:text];
    
    CGSize size;
    size.height = [text.text sc_calculateHeightInFontSize:14 withStableWidth:mainScreenWidth-20];
    text.height = size.height;
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
