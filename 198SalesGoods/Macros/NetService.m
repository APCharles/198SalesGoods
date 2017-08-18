
#import "NetService.h"
#import "AFNetworking.h"
#import "BaseViewController.h"

@implementation NetService

+ (void)serviceWithPostURL:(NSString *)url
                    params:(NSDictionary *)param
                   success:(void (^)(id responseObject))successBlock
                   failure:(void (^)(NSError *error))failureBlock {

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    NSString *url = [Login_URL stringByAppendingFormat:@"%@", methedName];
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    
}

+ (void)serviceWithGetURL:(NSString *)url
                   params:(NSDictionary *)param
                  success:(void (^)(id responseObject))successBlock
                  failure:(void (^)(NSError *error))failureBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//      manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //    NSString *url = [Login_URL stringByAppendingFormat:@"%@", methedName];
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
         successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          failureBlock(error);
    }] ;
    
}



+ (void)serviceWithGetjsonURL:(NSString *)url
                       params:(NSDictionary *)param
                      success:(void (^)(id responseObject))successBlock
                      failure:(void (^)(NSError *error))failureBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    url = [url  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:url parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
        
        
    }] ;

    
}


@end
