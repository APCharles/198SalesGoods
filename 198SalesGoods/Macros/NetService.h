
#import <Foundation/Foundation.h>

@interface NetService : NSObject

- (void)serviceWithPostURL:(NSString *)url
                       params:(NSDictionary *)param
                     success:(void (^)(id responseObject))successBlock
                      failure:(void (^)(NSError *error))failureBlock;

- (void)serviceWithGetURL:(NSString *)url
                       params:(NSDictionary *)param
                      success:(void (^)(id responseObject))successBlock
                      failure:(void (^)(NSError *error))failureBlock;

- (void)serviceWithGetjsonURL:(NSString *)url
                   params:(NSDictionary *)param
                  success:(void (^)(id responseObject))successBlock
                  failure:(void (^)(NSError *error))failureBlock;

@end
