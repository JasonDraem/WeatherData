//
//  XXYRequestManager+CityListProxy.m
//  WeatherData
//
//  Created by Jason_Xu on 16/8/27.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "XXYRequestManager+CityListProxy.h"
#import "CityModel.h"
@implementation XXYRequestManager (CityListProxy)
+ (void)getCityListWithSessionId:(NSString *)sessionId backReasult:(BackReasultBlock)result{
    NSMutableString *urlStr = [[NSMutableString alloc] init];
    [urlStr appendFormat:@"%@", kBaseUrl];
    [urlStr appendFormat:@"%@", kAllCityPro];
    [urlStr appendFormat:@"%@", sessionId];
    NSLog(@"++++++++++++++>:%@", urlStr);
    //如有缓存 则从缓存读取数据
    NSData *cacheData = [XXYCache objectForKey:MD5Hash(urlStr)];
    if (cacheData) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:cacheData options:NSJSONReadingMutableContainers error:nil];
        CityModel *allCityModel = [[CityModel alloc] initWithDictionary:dict error:nil];
        result(allCityModel.result, nil);
    }
    //
    [[XXYRequestManager shareInstance] get:urlStr params:nil success:^(NSData *responseObjc, NSError *error) {
        //把数据放进缓存
        [XXYCache setObject:responseObjc forKey:MD5Hash(urlStr)];
        //
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObjc options:NSJSONReadingMutableContainers error:&error];
        CityModel *allCityModel = [[CityModel alloc] initWithDictionary:dict error:&error];
        result(allCityModel.result, nil);
    } fail:^(NSError *error) {
        result(nil, error);
    }];
}
@end
