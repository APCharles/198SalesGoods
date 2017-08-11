//
//  HomeViewController.m
//  198SalesGoods
//
//  Created by BST on 2017/8/8.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "HomeViewController.h"
#import "ToolsCollectionViewCell.h"
#import "GoodsShowCell.h"
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
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    NSLog(@"fuck");
    
    
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


#pragma mark - tableviewdelegate  


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsShowCell *cell = [GoodsShowCell cellWithTableView:tableView];
    
  
    cell.iconView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0f];
    
    return cell;
    
    
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
        goodsTableview.height = 600;
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
