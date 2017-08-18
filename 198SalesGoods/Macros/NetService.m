
#import "NetService.h"
#import "AFNetworking.h"
#import "BaseViewController.h"

#import "MBProgressHUD.h"
@implementation NetService

- (void)serviceWithPostURL:(NSString *)url
                    params:(NSDictionary *)param
                   success:(void (^)(id responseObject))successBlock
                   failure:(void (^)(NSError *error))failureBlock {
      [self popShow];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    NSString *url = [Login_URL stringByAppendingFormat:@"%@", methedName];
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
       [self popCancle];
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD  hideHUD];
        [self popCancle];
    }];
    
}

- (void)serviceWithGetURL:(NSString *)url
                   params:(NSDictionary *)param
                  success:(void (^)(id responseObject))successBlock
                  failure:(void (^)(NSError *error))failureBlock{
    [self popShow];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//      manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //    NSString *url = [Login_URL stringByAppendingFormat:@"%@", methedName];
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
       [self popCancle];
         successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD  hideHUD];
         [self popCancle];
    }] ;
    
}



- (void)serviceWithGetjsonURL:(NSString *)url
                       params:(NSDictionary *)param
                      success:(void (^)(id responseObject))successBlock
                      failure:(void (^)(NSError *error))failureBlock{
    
    [self popShow];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    url = [url  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
       [self popCancle];
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
         [self popCancle];
        
    }] ;

    
}

MBProgressHUD *hudProgress;
UIView *lastView;

-(void)popShow{
    [self popCancle];
    UIWindow *window =  [UIApplication sharedApplication].keyWindow;
    if (lastView) {
        [lastView removeFromSuperview];
        lastView = nil;
    }
    lastView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, window.frame.size.height)];
    lastView.center = CGPointMake(mainScreenWidth/2, window.frame.size.height/2);
    lastView.backgroundColor = [UIColor grayColor];
    lastView.alpha = 0.4;
    [window addSubview:lastView];
    [window bringSubviewToFront:lastView];
    
    if (hudProgress==nil)
        {
        hudProgress = [[MBProgressHUD alloc] initWithView:lastView];
        hudProgress.yOffset -= 57;
        }
    hudProgress.mode =MBProgressHUDModeIndeterminate;
    hudProgress.labelText = @"正在加载中";
    [hudProgress show:YES];
    [window addSubview:hudProgress];
    [window bringSubviewToFront:hudProgress];
}

-(void)popCancle{
    if (lastView) {
        [lastView removeFromSuperview];
        lastView = nil;
    }
    if ( hudProgress != nil){
        [hudProgress removeFromSuperview];
        hudProgress = nil;
    }
}





@end
