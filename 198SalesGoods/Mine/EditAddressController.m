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
@end

@implementation EditAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self setBarName:@"编辑收货地址"];
    
    [self.view addSubview:self.addressTableview];
    
    [self.view addSubview:self.pickerView];
    
    [self requestProvince];
}


- (void)requestProvince{
   
  
    
    NSString *provincepath = [[NSBundle mainBundle] pathForResource:@"Province.txt" ofType:nil];
    
    NSData *  provincedata = [NSData dataWithContentsOfFile:provincepath];
    NSString* provinceStr = [[NSString alloc] initWithData:provincedata encoding:NSUTF8StringEncoding];
    
    NSString *citypath = [[NSBundle mainBundle] pathForResource:@"city.txt" ofType:nil];
    
    NSData *  citydata = [NSData dataWithContentsOfFile:citypath];
    NSString* cityStr = [[NSString alloc] initWithData:citydata encoding:NSUTF8StringEncoding];
   

    NSDictionary *provinceDic = [Tools dictionaryWithJsonString:provinceStr];
    
    NSDictionary *cityDic = [Tools dictionaryWithJsonString:cityStr];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
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
    if (indexPath.row == 2 || indexPath.row == 1) {
        
        cell.filed.keyboardType = UIKeyboardTypePhonePad;
    }
    if (indexPath.row == 4) {
        cell.bottomLineView.hidden = NO;
        
    }else{
        cell.bottomLineView.hidden = YES;
    }
    
    if (indexPath.row == 3) {
        
        if (![Tools isBlankString:_address]) {
            
            cell.addressLabel.text = _address;
            cell.addressLabel.textColor = [UIColor blackColor];
            
        }
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {
        [self.pickerView show];
        
    }
}


#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClick{
    NSLog(@"点击了取消按钮");
    [self.pickerView hide];

}

- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSDictionary *)cityDic{
    
    
    [self.pickerView hide];
    _address = [NSString stringWithFormat:@"%@ %@",province,cityDic[@"CityName"]];
    

    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
    [_addressTableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    NSLog(@"%@%@",province,cityDic[@"CityName"]);
}


#pragma mark uitextfielddelegate
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
        _addressTableview = myTableview;
    }
    
    return _addressTableview;
}



- (NSArray *)infoArr{
    
    if (!_infoArr) {
        
        NSArray *infoArr = [[NSArray alloc] init];
        infoArr = @[@{@"image":@"通讯录",@"plaeHolder":@"填写收货人姓名"},
                    @{@"image":@"电话",@"plaeHolder":@"填写手机号码"},
                    @{@"image":@"邮编",@"plaeHolder":@"填写所在地邮政编码"},
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

@end
