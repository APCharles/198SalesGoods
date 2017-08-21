    //
    //  MineViewController.m
    //  198SalesGoods
    //
    //  Created by BST on 2017/8/8.
    //  Copyright © 2017年 AP. All rights reserved.
    //

#import "MineViewController.h"
#import "MineInfoViewCell.h"
#import "MineTermViewCell.h"
#import "MineGroup.h"
#import "MineItem.h"
#import "MyAddressController.h"
#import "SmallButton.h"
#import "MyOrderViewController.h"
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>


/** topview  */
@property(strong,nonatomic) UIView *topView;


/** tableview  */
@property(strong,nonatomic) UITableView *myTableview;

/** array  */
@property(strong,nonatomic) NSMutableArray *groupArr;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DCBGColor;
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.topView];
    [self.view addSubview:self.myTableview];
    
    
}

#pragma mark - 点击设置
- (void)setbtnClick:(UIButton *)sender{
    
    NSLog(@"设置");
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 220;
    }else {
        return 50;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        return 0;
    }
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        MineInfoViewCell *cell = [MineInfoViewCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.data = @{@"data":@"123"};
        
        return cell;
        
    }else{
        
        MineTermViewCell *cell = [MineTermViewCell cellWithTableView:tableView];
        
        MineGroup *group = self.groupArr[indexPath.section - 1];
        cell.item = group.items[indexPath.row];
        
             cell.topLineView.hidden = NO;
        if (indexPath.section == 1) {
            
            if (indexPath.row == 2) {
           
                cell.bottomLineView.hidden = NO;
                
            }else{
                
               cell.bottomLineView.hidden = YES;
            }
        }else{
            
            if (indexPath.row == 1) {
            
                cell.bottomLineView.hidden = NO;
            }else{
                cell.bottomLineView.hidden = YES;

                
            }
        }
        
        return cell;
        
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            MyOrderViewController *order = [[MyOrderViewController alloc] init];
            [self.navigationController pushViewController:order animated:YES];
            
        }
    }
    if (indexPath.section == 2) {
        
        if (indexPath.row == 1) {
            
            MyAddressController *add = [[MyAddressController alloc] init];
            [self.navigationController pushViewController:add animated:YES];
        }
    }
}
#pragma mark - getter
- (UIView *)topView{
    
    if (!_topView) {
        
        
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = DCBGColor;
        topView.x = 0;
        topView.y = -22;
        topView.width  = mainScreenWidth;
        topView.height = 72;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"个人中心";
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.size = [titleLabel.text sizeWithFont:[UIFont systemFontOfSize:14] maxSize:MAXSIZE];
        titleLabel.x = mainScreenWidth * 0.5 - titleLabel.width * 0.5;
        titleLabel.y = 36 + titleLabel.height * 0.5;
        
        SmallButton *settingView = [[SmallButton alloc] init];
        settingView.size = CGSizeMake(20, 20);
        [settingView setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal] ;
        settingView.x = mainScreenWidth - 15 - settingView.width;
        settingView.y = 36 + settingView.height * 0.5;
        
        [settingView addTarget:self action:@selector(setbtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [topView addSubview:titleLabel];
        [topView addSubview:settingView];
        _topView = topView;
    }
    
    return _topView;
}


- (UITableView *)myTableview{
    
    if (!_myTableview) {
        
        UITableView *myTableview = [[UITableView alloc] init];
        myTableview.x = 0;
        myTableview.y = CGRectGetMaxY(self.topView.frame);
        myTableview.width = mainScreenWidth;
        myTableview.height = mainScreenHeight - self.topView.height;
        myTableview.delegate = self;
        myTableview.dataSource = self;
        myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        myTableview.backgroundColor = [UIColor clearColor];
        _myTableview = myTableview;
    }
    
    return _myTableview;
}

- (NSMutableArray *)groupArr{
    
    if (!_groupArr) {
        
        _groupArr = [[NSMutableArray alloc ] init];
        
        MineGroup *groupOne =  [[MineGroup alloc] init];
        MineItem *itemOne = [MineItem itemWithIconName:@"订单" text:@"我的订单"];
         MineItem *itemTwo = [MineItem itemWithIconName:@"积分" text:@"积分提现"];
         MineItem *itemThree = [MineItem itemWithIconName:@"客户" text:@"我的客户"];
        groupOne.items = @[itemOne, itemTwo,itemThree];
        
        MineGroup *groupTwo =  [[MineGroup alloc] init];
        MineItem *itemFour = [MineItem itemWithIconName:@"二维码" text:@"我的二维码"];
        MineItem *itemFive = [MineItem itemWithIconName:@"地址" text:@"地址管理"];
       
        groupTwo.items = @[itemFour, itemFive];
        
        [_groupArr addObject:groupOne];
        [_groupArr addObject:groupTwo];
    }
    
    return _groupArr;
}

@end
