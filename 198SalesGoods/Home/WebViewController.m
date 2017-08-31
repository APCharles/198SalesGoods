//
//  WebViewController.m
//  198SalesGoods
//
//  Created by 安鹏 on 2017/8/30.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "WebViewController.h"
#import "GoodsViewController.h"
@interface WebViewController ()<UIWebViewDelegate>

    
    @property(strong,nonatomic)UIWebView *infoWebView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    [self.view addSubview:self.infoWebView];
    
    NSURLRequest *request =
    [NSURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10];
    [self.infoWebView loadRequest:request];
}

    - (void)back{
        
        if ([self.infoWebView canGoBack]) {
            [self.infoWebView goBack];
        } else {
          
            [super back];
        }

    }
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    

    NSString *title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self setBarName:title];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString *str = request.URL.absoluteString;
    NSArray *paths =[str componentsSeparatedByString:@"?"];
    NSString *me = [[paths firstObject] stringByReplacingOccurrencesOfString:@"_" withString:@"?"];

        //返回
    
    if ([me isEqualToString:@"http://wx.dianpuj.com/wap/home/index"]) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    
    }
    if ([me isEqualToString:@"http://wx.dianpuj.com/index.php/Wap/Home/index.html"]) {
        
      [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
        //我的
    if ([me isEqualToString:@"http://wx.dianpuj.com/index.php/Wap/Member/card.html"]) {
        
        
       
        
        [self.tabBarController setSelectedIndex:3];
        [self.navigationController popViewControllerAnimated:YES];
    
        
    }
        //购物车
    if ([me isEqualToString:@"http://wx.dianpuj.com/index.php/Wap/Order/cart.html"]) {
        
        [self.tabBarController setSelectedIndex:2];
        [self.navigationController popViewControllerAnimated:YES];
//        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
        //点击购买
    if ([me isEqualToString:@"http://wx.dianpuj.com/index.php/Wap/Product/card.html"]) {
        GoodsViewController *goods = [[GoodsViewController alloc] init];
        goods.isShow = NO;
        goods.isBack = YES;
        [self.navigationController pushViewController:goods animated:YES];
    }
    
    
//    NSRange range = [str rangeOfString:@"apmg://"];
//    if (range.location != NSNotFound) {
//        
//        NSString  *method = [str substringFromIndex:range.location + range.length];
//        SEL sel = NSSelectorFromString(method);
//        [self performSelector:sel];
//    }
//    
    return YES;
}
- (UIWebView *)infoWebView{
    
    if (!_infoWebView) {
        
        UIWebView *infoWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationBarView.frame), mainScreenWidth, mainScreenHeight - self.navigationBarView.height)];
        
        infoWebView.backgroundColor = [UIColor whiteColor];
        
        infoWebView.keyboardDisplayRequiresUserAction = YES;
            //设置某些数据变为链接形式，这个枚举可以设置如电话号，地址，邮箱等转化为链接
        infoWebView.dataDetectorTypes = UIDataDetectorTypeLink;
            //设置是否缩放到适合屏幕大小
        infoWebView.scalesPageToFit = YES;
            //        infoWebView.paginationMode = UIWebPaginationModeTopToBottom;
        infoWebView.delegate = self;
        _infoWebView = infoWebView;
    }
    
    return _infoWebView;
}


@end
