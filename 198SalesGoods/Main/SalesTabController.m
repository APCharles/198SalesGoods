//
//  SalesTabController.m
//  198SalesGoods
//
//  Created by BST on 2017/7/26.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "SalesTabController.h"
#import "SalesTabBar.h"
#import "SalesNavgationController.h"
#import "GoodsViewController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "ShoppingCartViewController.h"
#import "GoodsViewController.h"
#import "GoodsAddViewController.h"
@interface SalesTabController ()<UITabBarControllerDelegate>

@end

@implementation SalesTabController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self setUpTabBar];
    
    [self addDcChildViewContorller];
   
}

#pragma mark - 更换系统tabbar
-(void)setUpTabBar
{
    SalesTabBar *tabBar = [[SalesTabBar alloc] init];
    tabBar.backgroundColor = [UIColor whiteColor];
        //KVC把系统换成自定义
    [self setValue:tabBar forKey:@"tabBar"];
}
#pragma mark - 添加子控制器
- (void)addDcChildViewContorller
{
    NSArray *childArray = @[
                            @{MallClassKey  : @"HomeViewController",
                              MallTitleKey  : @"首页",
                              MallImgKey    : @"tabr_01_up",
                              MallSelImgKey : @"tabr_01_down"},
                            
                            @{MallClassKey  : @"GoodsAddViewController",
                              MallTitleKey  : @"分类",
                              MallImgKey    : @"tabr_02_up",
                              MallSelImgKey : @"tabr_02_down"},
                            
                            @{MallClassKey  : @"ShoppingCartViewController",
                              MallTitleKey  : @"购物车",
                              MallImgKey    : @"tabr_04_up",
                              MallSelImgKey : @"tabr_04_down"},
                            
                            @{MallClassKey  : @"MineViewController",
                              MallTitleKey  : @"我的",
                              MallImgKey    : @"tabr_05_up",
                              MallSelImgKey : @"tabr_05_down"},
                            
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        vc.navigationItem.title = ([dict[MallTitleKey] isEqualToString:@"首页"] || [dict[MallTitleKey] isEqualToString:@"分类"]) ? nil : dict[MallTitleKey];
        SalesNavgationController *nav = [[SalesNavgationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        
        item.image = [UIImage imageNamed:dict[MallImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);//（当只有图片的时候）需要自动调整
        [self addChildViewController:nav];
        
    }];
}

#pragma mark - <UITabBarControllerDelegate>
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
        //点击tabBarItem动画
//     [self tabBarButtonClick:[self getTabBarButton]];
    if ([viewController isKindOfClass:[SalesNavgationController class]]){
        
        SalesNavgationController *sales = (SalesNavgationController *)viewController;
        
        for (UIViewController *vc in sales.viewControllers) {
            if ([vc isKindOfClass:[GoodsAddViewController class]]) {
                
                GoodsAddViewController *goods = (GoodsAddViewController *)vc;
                goods.isShow = YES;
                
            }
        }

        
    }
   
        
    
    
}
- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    
    return tabBarButton;
}
#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}



@end
