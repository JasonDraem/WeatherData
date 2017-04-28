//
//  XXYNetData.h
//  WeatherData
//
//  Created by Jason_Xu on 16/8/27.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "urlHeader.h"

#import "XXYCache.h"
#import "UIView+Common.h"
#import "NSString+Common.h"

typedef void(^SuccessBlock)(id responseObjc, NSError *error);
typedef void(^FailedBlock)(NSError *error);
typedef void(^BackReasultBlock)(id, NSError *error);

@interface XXYRequestManager : NSObject
/**
 *  单例af
 *
 *  @return <#return value description#>
 */
+ (instancetype)shareInstance;
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
        fail:(FailedBlock)fail;
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
       fail:(FailedBlock)fail;
@end
