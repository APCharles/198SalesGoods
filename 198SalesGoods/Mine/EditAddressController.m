//
//  EditAddressController.m
//  198SalesGoods
//
//  Created by BST on 2017/8/15.
//  Copyright © 2017年 AP. All rights reserved.
//

#import "EditAddressController.h"
#import "EditAddressViewCell.h"
#import "AddressPickerView.h"
@interface EditAddressController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,AddressPickerViewDelegate>

/** dizhi  */
@property(strong,nonatomic) UITableView *addressTableview;

/** shuju  */
@property(strong,nonatomic) NSArray *infoArr;


/** pickerV iew */
@property(strong,nonatomic)AddressPickerView *pickerView;

/** 地址 */
@property(strong,nonatomic)NSString *address;

/** 保存按钮  */
@property(strong,nonatomic) UIButton *saveBtn;


/** citYDta  */
@property(strong,nonatomic) NSDictionary *cityDic;


/** data  */
@property(strong,nonatomic) NSDictionary *data;
@end

@implementation EditAddressController

- (instancetype)initWithData:(NSDictionary *)dic{
    
    if (self == [super init]) {
        
        
        _data = dic;
   
    
    }
  
    
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setBarName:@"编辑收货地址"];
    
    [self.view addSubview:self.addressTableview];
    
    [self.view addSubview:self.pickerView];
    
    [self.view addSubview:self.saveBtn];
    

    
    
   
}



- (void)saveBtnclick:(UIButton *)sender{
    
    UITextField *nameFiled = (UITextField *)[self.view viewWithTag:100];
    UITextField *mobileFiled = (UITextField *)[self.view viewWithTag:101];
   
    UITextField *addressFiled = (UITextField *)[self.view viewWithTag:103];
    if (nameFiled.text.length == 0) {
        
        [self showProgressHUDString:@"请输入姓名"];
        return;
    }else if (mobileFiled.text.length == 0){
        
         [self showProgressHUDString:@"请输入手机号码"];
        return;
    }else if ( ![self isMobileWithStr:mobileFiled.text]){
        
        [self showProgressHUDString:@"请输入正确的手机号码" ];
        return;
    }else if ( _address.length == 0){
        
        [self showProgressHUDString:@"请选择地址"];
        return;
    }else if ( addressFiled.text.length == 0){
        
        [self showProgressHUDString:@"请输入详细地址"];
        return;
    }
    
    NSString *ProvinceID;
    NSString *CityID;
    if ([_data count] > 0) {
        ProvinceID = [_data objectForKey:@"province"];
        CityID = [_data objectForKey:@"city"];
    }
    if ([_cityDic count]> 0) {
        ProvinceID = [_cityDic objectForKey:@"ProvinceID"];
        CityID = [_cityDic objectForKey:@"CityID"];

    }
    NSDictionary *dic = @{@"name":nameFiled.text,
                          @"tel":mobileFiled.text,
                          @"province":ProvinceID,
                          @"city":CityID,
                          @"address":addressFiled.text
                          };
    
    [NetService serviceWithPostURL:@"wx.dianpuj.com/index.php/Wap/Member/addr_update" params:dic success:^(id responseObject) {
        
        NSLog(@"----");
    } failure:^(NSError *error) {
        
        
    }];

}

- (BOOL)isMobileWithStr:(NSString *)str{

    if (str.length==0) {
        return NO;
    }
    NSString *tmpRegex = @"^(0?1[3-9]\\d{9})?$";
    NSPredicate *tmpTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", tmpRegex];
    return [tmpTest evaluateWithObject:str];
    

    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50 ;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditAddressViewCell *cell = [EditAddressViewCell cellWithTableView:tableView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.data =  self.infoArr[indexPath.row];
    
    cell.filed.tag = indexPath.row + 100;
    
    
    cell.filed.delegate = self;
    
     [cell.filed addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    if ( indexPath.row == 1) {
        
        cell.filed.keyboardType = UIKeyboardTypePhonePad;
    }
    if (indexPath.row == 3) {
        cell.bottomLineView.hidden = NO;
        
    }else{
        cell.bottomLineView.hidden = YES;
    }
    
    if (indexPath.row == 2) {
        
        if (![Tools isBlankString:_address]) {
            
            cell.addressLabel.text = _address;
            cell.addressLabel.textColor = [UIColor blackColor];
            
        }
    }
    
    if ([_data count] > 0) {
        
        if (indexPath.row == 0) {
            cell.filed.text = [_data objectForKey:@"name"];
        }else if (indexPath.row == 1){
            cell.filed.text = [_data objectForKey:@"tel"];
            
        }
        else if (indexPath.row == 2){
            
            cell.addressLabel.text = [NSString stringWithFormat:@"%@ %@",_data[@"sheng"],_data[@"shi"]];
            
            _address = [NSString stringWithFormat:@"%@ %@",_data[@"sheng"],_data[@"shi"]];
            cell.addressLabel.textColor = [UIColor blackColor];
        }else if (indexPath.row == 3){
            
            cell.filed.text = [_data objectForKey:@"address"];
            
        }
        
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 2) {
        [self.view endEditing:YES];
        [self.pickerView show];
        
    }
}


#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClick{
    NSLog(@"点击了取消按钮");
    [self.pickerView hide];

}

- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSDictionary *)cityDic{
    
    _data = nil;
    
    [self.pickerView hide];
    _address = [NSString stringWithFormat:@"%@ %@",province,cityDic[@"CityName"]];
    

    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
    [_addressTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"%@%@",province,cityDic[@"CityName"]);
    
    _cityDic = cityDic;
}


#pragma mark uitextfielddelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [self.pickerView hide];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidChange:(UITextField *)textField{
    
    NSString *toBeString = textField.text;
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        
        _data = nil;
        if (textField.tag == 100) {
            if (toBeString.length > 20) {
                textField.text = [toBeString substringToIndex:20];
            }
        }else if (textField.tag == 101){
            
            if (toBeString.length > 11) {
                textField.text = [toBeString substringToIndex:11];
            }
        }else if (textField.tag == 102){
            
            if (toBeString.length > 6) {
                textField.text = [toBeString substringToIndex:6];
            }
        }else if (textField.tag == 104){
            
            if (toBeString.length > 30) {
                textField.text = [toBeString substringToIndex:30];
            }
        }
        
    }
}

- (UITableView *)addressTableview{
    
    if (!_addressTableview) {
        
        UITableView *myTableview = [[UITableView alloc] init];
        myTableview.x = 0;
        myTableview.y = CGRectGetMaxY(self.navigationBarView.frame);
        myTableview.width = mainScreenWidth;
        myTableview.height = mainScreenHeight - self.navigationBarView.height;
        myTableview.delegate = self;
        myTableview.dataSource = self;
        myTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        myTableview.backgroundColor = [UIColor clearColor];
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resgn:)];
//        tap.numberOfTapsRequired = 1;
//        [myTableview addGestureRecognizer:tap];
        _addressTableview = myTableview;
    }
    
    return _addressTableview;
}



- (NSArray *)infoArr{
    
    if (!_infoArr) {
        
        NSArray *infoArr = [[NSArray alloc] init];
        infoArr = @[@{@"image":@"通讯录",@"plaeHolder":@"填写收货人姓名"},
                    @{@"image":@"电话",@"plaeHolder":@"填写手机号码"},
                
                    @{@"image":@"定位",@"plaeHolder":@""},
                    @{@"image":@"详细地址",@"plaeHolder":@"填写详细地址"}
                    ];
        _infoArr = infoArr;
    }
    
    return _infoArr;
}

- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc]initWithFrame:CGRectMake(0, mainScreenHeight , mainScreenWidth, 300)];
        _pickerView.delegate = self;
            // 关闭默认支持打开上次的结果
            //        _pickerView.isAutoOpenLast = NO;
    }
    return _pickerView;
}


- (UIButton *)saveBtn{
    
    if (!_saveBtn) {
        
        UIButton *addAddress= [[UIButton alloc] init];
        [addAddress setTitle:@"保存" forState:UIControlStateNormal];
        [addAddress setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addAddress.titleLabel.font = [UIFont systemFontOfSize:14];
        
        addAddress.backgroundColor = RGB(249, 80, 56);
        
        addAddress.width = mainScreenWidth ;
        
        addAddress.height = 45;
        
        addAddress.x = 0;
        
        addAddress.y = mainScreenHeight - addAddress.height;
        [addAddress addTarget:self action:@selector(saveBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _saveBtn = addAddress;
    }
    
    return _saveBtn;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
