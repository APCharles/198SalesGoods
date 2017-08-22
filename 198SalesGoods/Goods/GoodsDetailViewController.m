//
//  GoodsDetailViewController.m
//  198SalesGoods
//
//  Created by yidianjicai-iOS on 17/8/18.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "NSString+SizeCalculate.h"

@interface GoodsDetailViewController ()

@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestGoodsDetaiData];
}

-(void)requestGoodsDetaiData{
    
    NetService *netService = [[NetService alloc] init];
    __weak typeof(self)weakSelf = self;
    [netService serviceWithGetjsonURL:[self.data objectForKey:@"detail_url"] params:nil success:^(id responseObject) {
        _goodsDetailModel = [GoodsDetailModel objectWithKeyValues:responseObject];
        [weakSelf inStallController];
    } failure:^(NSError *error) {
        
    }];
}

-(void)inStallController{
    [self setBarName:_goodsDetailModel.row.title];
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, StateNaviBarHeight, mainScreenWidth, mainScreenHeight-StateNaviBarHeight-TabBarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    if (!_buyBtn) {
        _buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(mainScreenWidth/2, mainScreenHeight-TabBarHeight, mainScreenWidth/2, TabBarHeight)];
        _buyBtn.backgroundColor = [UIcolortool colorWithHexString:@"e21111"];
        [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyBtn addTarget:self action:@selector(onClickBuy) forControlEvents:UIControlEventTouchUpInside];
        _buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:_buyBtn];
    }
    if (!_addToShopCartBtn) {
        _addToShopCartBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, mainScreenHeight-TabBarHeight, mainScreenWidth/2, TabBarHeight)];
        _addToShopCartBtn.backgroundColor = [UIcolortool colorWithHexString:@"FFCF56"];
        [_addToShopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_addToShopCartBtn addTarget:self action:@selector(onClickAddToShopCart) forControlEvents:UIControlEventTouchUpInside];
        _addToShopCartBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:_addToShopCartBtn];
    }
    if (!_headerView) {
        _headerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, StateNaviBarHeight, mainScreenWidth, mainScreenHeight-TabBarHeight)];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    if (!_shopCartView) {
        _shopCartView = [[UIView alloc]initWithFrame:CGRectMake(mainScreenWidth-10-60, _addToShopCartBtn.y-10-60, 60, 60)];
        _shopCartView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_shopCartView];
        
        _shopCartBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        [_shopCartBtn setImage:[UIImage imageNamed:@"gouwuche_white"] forState:UIControlStateNormal];
        [_shopCartBtn addTarget:self action:@selector(onClickGoToShopCart) forControlEvents:UIControlEventTouchUpInside];
        _shopCartBtn.backgroundColor = [UIcolortool colorWithHexString:@"FFCF56"];
        _shopCartBtn.layer.cornerRadius = _shopCartBtn.width/2;
        _shopCartBtn.layer.masksToBounds = YES;
        _shopCartBtn.layer.borderWidth = 1;
        _shopCartBtn.layer.borderColor = [[UIColor whiteColor]CGColor];
        [_shopCartView addSubview:_shopCartBtn];
        
        _shopCartCount = [[UILabel alloc]initWithFrame:CGRectMake(_shopCartBtn.x+_shopCartBtn.width-10, _shopCartBtn.y-3, 20, 20)];
        _shopCartCount.layer.cornerRadius = 10;
        _shopCartCount.layer.masksToBounds = YES;
        _shopCartCount.layer.borderWidth = 1;
        _shopCartCount.layer.borderColor = [[UIColor whiteColor]CGColor];
        _shopCartCount.textAlignment = NSTextAlignmentCenter;
        _shopCartCount.backgroundColor = [UIcolortool colorWithHexString:@"e21111"];
        _shopCartCount.textColor = [UIColor whiteColor];
        _shopCartCount.font = [UIFont systemFontOfSize:10];
        [_shopCartView addSubview:_shopCartCount];
    }
    _shopCartCount.text = [NSString stringWithFormat:@"%d",_goodsDetailModel.cart_num.intValue];
    _shopCartCount.hidden = _goodsDetailModel.cart_num.intValue>0?NO:YES;
    
    for (UIView *view in _headerView.subviews) {
        [view removeFromSuperview];
    }
    UIImageView *headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 200*(mainScreenWidth/320))];
    [headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APPIP,_goodsDetailModel.row.image]]];
    for (int i = 0; i<_goodsDetailModel.cols.count; i++) {
        ColorModel *color = [_goodsDetailModel.cols objectAtIndex:i];
        if (color.selected.intValue == 1) {
            for (int j = 0; j<_goodsDetailModel.specs.count; j++) {
                SpecModel *spec = [_goodsDetailModel.specs objectAtIndex:j];
                if ([spec.color isEqualToString:color.color]) {
                    [headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APPIP,spec.image]]];
                    break;
                }
            }
            break;
        }
    }
    [_headerView addSubview:headerImg];
    
    UILabel *goodsName = [[UILabel alloc]initWithFrame:CGRectMake(10, headerImg.y+headerImg.height, mainScreenWidth-20, 40)];
    goodsName.textColor = [UIColor darkGrayColor];
    goodsName.numberOfLines = 0;
    goodsName.font = [UIFont systemFontOfSize:16];
    goodsName.text = _goodsDetailModel.row.title;
    [_headerView addSubview:goodsName];
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(10, goodsName.y+goodsName.height+5, 100, 20)];
    price.textColor = [UIcolortool colorWithHexString:@"e21111"];
    price.font = [UIFont systemFontOfSize:14];
    price.text = [NSString stringWithFormat:@"¥%@",_goodsDetailModel.row.price];
    CGSize size1;
    size1.width = [price.text sc_calculateWidthInFontSize:14 withStableHeight:20];
    price.width = size1.width;
    [_headerView addSubview:price];
    
    UILabel *market_price = [[UILabel alloc]initWithFrame:CGRectMake(price.x+price.width+10, price.y, 100, 20)];
    market_price.textColor = [UIcolortool colorWithHexString:@"7e7e7e"];
    market_price.font = [UIFont systemFontOfSize:14];
    market_price.text = [NSString stringWithFormat:@"¥%@",_goodsDetailModel.row.price_market];
    CGSize size2;
    size2.width = [market_price.text sc_calculateWidthInFontSize:14 withStableHeight:20];
    market_price.width = size2.width;
    [_headerView addSubview:market_price];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(market_price.x, market_price.y+market_price.height/2, market_price.width, 0.5)];
    line.backgroundColor = [UIcolortool colorWithHexString:@"7e7e7e"];
    [_headerView addSubview:line];
    
    UILabel *countLab = [[UILabel alloc]initWithFrame:CGRectMake(10, market_price.y+market_price.height+10, (mainScreenWidth-20)/3, 20)];
    countLab.font = [UIFont systemFontOfSize:13];
    countLab.textColor = [UIColor darkGrayColor];
    countLab.text = _goodsDetailModel.row.number.length?[NSString stringWithFormat:@"库存:%@",_goodsDetailModel.row.number]:@"库存:";
    for (int i = 0; i<_goodsDetailModel.cols.count; i++) {
        ColorModel *color = [_goodsDetailModel.cols objectAtIndex:i];
        if (color.selected.intValue == 1) {
            for (int j = 0; j<_goodsDetailModel.szs.count; j++) {
                SizeModel *size = [_goodsDetailModel.szs objectAtIndex:j];
                if (size.selected.intValue == 1) {
                    for (int k = 0; k<_goodsDetailModel.specs.count; k++) {
                        SpecModel *spec = [_goodsDetailModel.specs objectAtIndex:k];
                        if ([spec.color isEqualToString:color.color] && spec.size.intValue == size.size.intValue) {
                            countLab.text = [NSString stringWithFormat:@"库存:%d",spec.num.intValue];
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
    }
    [_headerView addSubview:countLab];
    
    UILabel *sell_count = [[UILabel alloc]initWithFrame:CGRectMake(countLab.x+countLab.width, countLab.y, countLab.width, countLab.height)];
    sell_count.font = [UIFont systemFontOfSize:13];
    sell_count.textColor = [UIColor darkGrayColor];
    sell_count.text = _goodsDetailModel.row.sell_count.length?[NSString stringWithFormat:@"销量:%@",_goodsDetailModel.row.sell_count]:@"销量:";
    sell_count.textAlignment = NSTextAlignmentCenter;
    [_headerView addSubview:sell_count];
    
    UILabel *shipping = [[UILabel alloc]initWithFrame:CGRectMake(sell_count.x+sell_count.width, sell_count.y, sell_count.width, sell_count.height)];
    shipping.font = [UIFont systemFontOfSize:13];
    shipping.textColor = [UIColor darkGrayColor];
    shipping.textAlignment = NSTextAlignmentRight;
    shipping.text = @"全国包邮";
    [_headerView addSubview:shipping];
    
    for (int i = 0; i<_goodsDetailModel.cols.count; i++) {
        ColorModel *color = [_goodsDetailModel.cols objectAtIndex:i];
        UIButton *colorBtn = [[UIButton alloc]initWithFrame:CGRectMake(10+50*i, shipping.y+shipping.height+10, 40, 30)];
        [colorBtn setTitle:color.color forState:UIControlStateNormal];
        colorBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        colorBtn.layer.cornerRadius = 3;
        colorBtn.layer.masksToBounds = YES;
        colorBtn.layer.borderWidth = 1;
        if (color.selected.intValue == 1) {
            [colorBtn setTitleColor:[UIcolortool colorWithHexString:@"e21111"] forState:UIControlStateNormal];
            colorBtn.layer.borderColor = [[UIcolortool colorWithHexString:@"e21111"]CGColor];
        }else{
            [colorBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            colorBtn.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        }
        [colorBtn addTarget:self action:@selector(onClickColorBtn:) forControlEvents:UIControlEventTouchUpInside];
        colorBtn.tag = 1000-i;
        [_headerView addSubview:colorBtn];
    }
    
    for (int j = 0; j<_goodsDetailModel.szs.count; j++) {
        SizeModel *size = [_goodsDetailModel.szs objectAtIndex:j];
        UIButton *sizeBtn = [[UIButton alloc]initWithFrame:CGRectMake(10+50*j, shipping.y+shipping.height+10+40, 40, 30)];
        [sizeBtn setTitle:[NSString stringWithFormat:@"%d",size.size.intValue] forState:UIControlStateNormal];
        sizeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        sizeBtn.layer.cornerRadius = 3;
        sizeBtn.layer.masksToBounds = YES;
        sizeBtn.layer.borderWidth = 1;
        if (size.selected.intValue == 1) {
            [sizeBtn setTitleColor:[UIcolortool colorWithHexString:@"e21111"] forState:UIControlStateNormal];
            sizeBtn.layer.borderColor = [[UIcolortool colorWithHexString:@"e21111"]CGColor];
        }else{
            [sizeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            sizeBtn.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        }
        [sizeBtn addTarget:self action:@selector(onClickSizeBtn:) forControlEvents:UIControlEventTouchUpInside];
        sizeBtn.tag = 2000-j;
        [_headerView addSubview:sizeBtn];
        
        _headerView.height = sizeBtn.y+sizeBtn.height+10;
    }
    UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, _headerView.height-0.5, mainScreenWidth, 0.5)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [_headerView addSubview:line1];
    _tableView.tableHeaderView = _headerView;
    
    if (!_imgArr) {
        _imgArr = [[NSArray alloc]init];
        _imgArr = [_goodsDetailModel.row.image_icon componentsSeparatedByString:@","];
    }
    if (_recArr) {
        _recArr = [[NSMutableArray alloc]init];
        [_recArr addObjectsFromArray:_goodsDetailModel.recommend];
    }
    [_tableView reloadData];
}

-(void)onClickColorBtn:(id)sender{
    UIButton *btn = (UIButton *)sender;
    for (int i = 0; i<_goodsDetailModel.cols.count; i++) {
        ColorModel *color = [_goodsDetailModel.cols objectAtIndex:i];
        color.selected = [NSNumber numberWithInt:0];
    }
    ColorModel *color = [_goodsDetailModel.cols objectAtIndex:1000-btn.tag];
    color.selected = [NSNumber numberWithInt:1];
    [self inStallController];
}

-(void)onClickSizeBtn:(id)sender{
    UIButton *btn = (UIButton *)sender;
    for (int i = 0; i<_goodsDetailModel.szs.count; i++) {
        SizeModel *size = [_goodsDetailModel.szs objectAtIndex:i];
        size.selected = [NSNumber numberWithInt:0];
    }
    SizeModel *size = [_goodsDetailModel.szs objectAtIndex:2000-btn.tag];
    size.selected = [NSNumber numberWithInt:1];
    [self inStallController];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view.width, view.height)];
    title.text = @"图文详情";
    title.font = [UIFont systemFontOfSize:15];
    title.textColor = [UIcolortool colorWithHexString:@"333333"];
    title.textAlignment = NSTextAlignmentCenter;
    [view addSubview:title];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  _imgArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView *view in cell.contentView.subviews) {
        if (view.tag == 3000) {
            [view removeFromSuperview];
        }
    }
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 200*(mainScreenWidth/320))];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APPIP,[_imgArr objectAtIndex:indexPath.row]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageView.width = image.size.width;
        imageView.height = image.size.height;
        imageView.width = mainScreenWidth;
        imageView.height = imageView.height/(image.size.width/mainScreenWidth);
    }];
    
    imageView.tag = 3000;
    [cell.contentView addSubview:imageView];
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, mainScreenWidth, 200*(mainScreenWidth/320))];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",APPIP,[_imgArr objectAtIndex:indexPath.row]]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageView.width = image.size.width;
        imageView.height = image.size.height;
        imageView.width = mainScreenWidth;
        imageView.height = imageView.height/(image.size.width/mainScreenWidth);
    }];
    return imageView.height;
}

#pragma mark 立即购买
-(void)onClickBuy{
    
}

#pragma mark 加入购物车
-(void)onClickAddToShopCart{
    
}

#pragma mark 进入购物车
-(void)onClickGoToShopCart{
    ApplicationDelegate.isFromGoodsDetail = YES;
    [self.navigationController popToRootViewControllerAnimated:YES];
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
