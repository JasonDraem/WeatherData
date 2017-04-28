//
//  XXYNetData.m
//  WeatherData
//
//  Created by Jason_Xu on 16/8/27.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "XXYRequestManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation XXYRequestManager
{
    AFHTTPSessionManager *_afSessionManager;
}
/**
 *  单例
 *
 *  @return <#return value description#>
 */

static XXYRequestManager *_shareInstance = nil;

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[XXYRequestManager alloc] init];
    });
    return _shareInstance;
}
/**
 *  <#Description#>
 *
 *  @param baseUrl <#baseUrl description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)init{
    self = [super init];
    if (self) {
        _afSessionManager = [AFHTTPSessionManager manager];
        _afSessionManager.securityPolicy = [self customSecurityPolicy];
        _afSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        _afSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _afSessionManager.requestSerializer.timeoutInterval = kTimeoutInterval;
        _afSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"multipart/form-data",@"text/xml", nil];
        [_afSessionManager.requestSerializer setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}
/**
 *  安全校验
 *
 *  @return <#return value description#>
 */
- (AFSecurityPolicy*)customSecurityPolicy{
    // /先导入证书
//    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"CA" ofType:@"cer"];//证书的路径
//    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    return securityPolicy;
}
/**
 *  get请求
 *
 *  @param urlStr  <#urlStr description#>
 *  @param params  <#params description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)get:(NSString *)urlStr
     params:(id)params
    success:(SuccessBlock)success
       fail:(FailedBlock)fail{
    [_afSessionManager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        if (success) {
            success(responseObject, error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}
/**
 *  post请求
 *
 *  @param urlStr  <#urlStr description#>
 *  @param params  <#params description#>
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)post:(NSString *)urlStr
      params:(id)params
     success:(SuccessBlock)success
        fail:(FailedBlock)fail{
    [_afSessionManager POST:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}


@end
