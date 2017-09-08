//
//  HomeViewController.m
//  198SalesGoods
//
//  Created by BST on 2017/8/8.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "HomeViewController.h"
#import "ToolsCollectionViewCell.h"
#import "GoodsViewController.h"
#import "GoodsShowCell.h"
#import "LoginViewController.h"
#import "WebViewController.h"
/* cell */
static NSString *const GoodsCountDownCellID = @"GoodsCountDownCell";
@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>

/** headerView  */
@property(strong,nonatomic) UIImageView *headerView;

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;



/** 并排数量的colleciton  */
@property(strong,nonatomic) NSMutableArray *toolArray;



/** tableview  */
@property(strong,nonatomic) UITableView *goodsTableview;
    
    /** tableview */
    @property(strong,nonatomic)NSDictionary *bannerDic;
    
    /**  */
    @property(strong,nonatomic)NSMutableArray *bannerArr;
@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![ApplicationDelegate checkUserLogin]) {
        [self onClickLogin];
    }
    
    [self requestHomeBanner];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self onClickLogin];
    self.navigationBarView.hidden = YES;
    self.leftBtn.hidden = YES;
    
    NSLog(@"做好会经常冲突的准备");
    
    _bannerArr = [NSMutableArray array];
    
    UIScrollView * myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, mainScreenHeight)];
    myScrollView.backgroundColor = LIGHTWHITE;
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
    
    [myScrollView addSubview:self.headerView];
    
    [myScrollView addSubview:self.collectionView];
    
    [myScrollView addSubview:self.goodsTableview];
}

    
- (void)requestHomeBanner{
    
    NSDictionary *dic  =[[NSDictionary alloc] init];
    NetService *service = [[NetService alloc] init];
    
    [service serviceWithGetjsonURL:@"http://wx.dianpuj.com/index.php/wap/home/index_ios" params:dic success:^(id responseObject) {
     
        
        _bannerDic = (NSDictionary *)responseObject;
        [_bannerArr addObject:[_bannerDic objectForKey:@"index_man"]];
        [_bannerArr addObject:[_bannerDic objectForKey:@"index_woman"]];
        [_bannerArr addObject:[_bannerDic objectForKey:@"index_receive"]];
        [_bannerArr addObject:[_bannerDic objectForKey:@"index_free"]];
         
        [_goodsTableview reloadData];
        
    } failure:^(NSError *error) {
        [self showProgressHUDString:@"服务器数据异常"];
    }];

}
-(void)onClickLogin{
    LoginViewController *loginViewController = [[LoginViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    [self.navigationController presentViewController:nav animated:YES completion:nil];

}


#pragma mark - tableviewdelegate  


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _bannerArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsShowCell *cell = [GoodsShowCell cellWithTableView:tableView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APPIP,_bannerArr[indexPath.row]]];
    [cell.iconView sd_setImageWithURL:url placeholderImage:nil];

    
    return cell;
    
    
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (indexPath.row == 0) {
        
        GoodsViewController *goods = [[GoodsViewController alloc] init];
        goods.url = @"http://wx.dianpuj.com/index.php/Wap/Product/index_ios/type=74";
        goods.hidesBottomBarWhenPushed = YES;
        goods.isShow = NO;
        [self.navigationController pushViewController:goods animated:YES];
        
        
    }else if (indexPath.row == 1){
        GoodsViewController *goods = [[GoodsViewController alloc] init];
        goods.url = @"http://wx.dianpuj.com/index.php/Wap/Product/index_ios/type=74";
        goods.hidesBottomBarWhenPushed = YES;
        goods.isShow = NO;
        [self.navigationController pushViewController:goods animated:YES];

        
    }else if (indexPath.row == 2){
        GoodsViewController *goods = [[GoodsViewController alloc] init];
        goods.url = @"http://wx.dianpuj.com/index.php/Wap/Product/index_ios/free_ios";
        goods.hidesBottomBarWhenPushed = YES;
        goods.isShow = NO;
        [self.navigationController pushViewController:goods animated:YES];
        
        
    }else if (indexPath.row == 3){
        GoodsViewController *goods = [[GoodsViewController alloc] init];
        goods.url = @"http://wx.dianpuj.com/index.php/Wap/Product/index_ios/lingqu_ios";
        goods.hidesBottomBarWhenPushed = YES;
        goods.isShow = NO;
        [self.navigationController pushViewController:goods animated:YES];
        
        
    }
}

#pragma mark - collectiondelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.toolArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ToolsCollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GoodsCountDownCellID forIndexPath:indexPath];
    cell.data = [_toolArray objectAtIndex:indexPath.row];
//    cell.product = self.products[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = [_toolArray objectAtIndex:indexPath.row];
    NSLog(@"---%@",[dic objectForKey:@"title"]);
    
    
    WebViewController *web = [[WebViewController alloc ] init];
        //活动详情
    if (indexPath.row == 0) {
//        web.url = [NSString stringWithFormat:@"%@%@",@"http://wx.dianpuj.com/index.php/Wap/activity/show/id/",[UserData shareInstance].user_Model.base_id];
        
        web.url = @"http://wx.dianpuj.com/index.php/Wap/activity/show/id/45";
        //xinshou教程
    }else if (indexPath.row == 1){
        
//        web.url = [NSString stringWithFormat:@"%@%@",@"http://wx.dianpuj.com/index.php/Wap/page/xinshou/id/",[UserData shareInstance].user_Model.base_id];
        
        web.url = @"http://wx.dianpuj.com/index.php/Wap/page/xinshou/id/92.html";
            //资料库
    }else if (indexPath.row == 2){
        
//        web.url = [NSString stringWithFormat:@"%@%@",@"http://wx.dianpuj.com/index.php/Wap/page/zlku/id/",[UserData shareInstance].user_Model.base_id];
        
           web.url = @"http://wx.dianpuj.com/index.php/Wap/page/zlku/id/129.html";
    }else if (indexPath.row == 3){
        
    }
 
    
    [self.navigationController pushViewController:web animated:YES];
}


#pragma mark - getter
- (UIImageView *)headerView{
    
    if (!_headerView) {
        
        UIImageView *headerView = [[UIImageView alloc] init];
        headerView.image = [UIImage imageNamed:@"home_good.gif"];
        headerView.y = -22;
        headerView.x = 0;
        headerView.width = mainScreenWidth;
        headerView.height = 205;
        
        _headerView = headerView;
    }
    
    return _headerView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(mainScreenWidth / 4, 75);
        layout.minimumInteritemSpacing = 0;
//        layout.minimumLineSpacing = 15;
//        layout.sectionInset = UIEdgeInsetsMake(15, 5, 0, 5);
    
        
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), mainScreenWidth,80);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        [_collectionView registerClass:[ToolsCollectionViewCell class] forCellWithReuseIdentifier:GoodsCountDownCellID];
        _collectionView.backgroundColor = [UIColor whiteColor];
   
    }
    return _collectionView;
}


- (UITableView *)goodsTableview{
    
    if (!_goodsTableview) {
        
        UITableView *goodsTableview = [[UITableView alloc] init];
        goodsTableview.x = 0;
        goodsTableview.y = CGRectGetMaxY(self.collectionView.frame);
        goodsTableview.width = mainScreenWidth;
        goodsTableview.height = mainScreenHeight - _headerView.height - _collectionView.height - self.tabBarController.tabBar.height + 20;
        goodsTableview.delegate = self;
        goodsTableview.dataSource = self;
        _goodsTableview = goodsTableview;
    }
    
    return _goodsTableview;
}

- (NSMutableArray *)toolArray{
    
    if (!_toolArray) {
        
        _toolArray = @[@{@"image":@"1111",@"title":@"活动详情"},
                       @{@"image":@"3333",@"title":@"新手教程"},
                       @{@"image":@"4444",@"title":@"资料库"},
                       @{@"image":@"2222",@"title":@"在线客服"}];
    }
    
    return _toolArray;
}

@end
